unit cubeworld;
{$mode objfpc}{$H+}
interface
	uses
		zstream;

	type
		TFloatVector = packed record
			x, y, z: single;
		end;
		
		TIntegerVector = packed record
			x, y, z: longint;
		end;
		
		TLongVector = packed record
			x, y, z: int64;
		end;
		
		TCWAppearanceData = packed record
				not_used_1: byte;
				not_used_2: byte;
				hair_red: byte;
				hair_green: byte;
				hair_blue: byte;
				movement_flags: byte;
				entity_flags: byte;
				scale: double;
				bounding_radius: double;
				bounding_height: double;
				head_model: smallint;
				hair_model: smallint;
				hand_model: smallint;
				foot_model: smallint;
				body_model: smallint;
				back_model: smallint;
				shoulder_model: smallint;
				wing_model: smallint;
				head_scale: double;
				body_scale: double;
				hand_scale: double;
				foot_scale: double;
				shoulder_scale: double;
				weapon_scale: double;
				back_scale: double;
				unknown: double;
				wing_scale: double;
				body_pitch: double;
				arm_pitch: double;
				arm_roll: double;
				arm_yaw: double;
				feet_pitch: double;
				wing_pitch: double;
				back_pitch: double;
				body_offset: pointer;
				head_offset: pointer;
				hand_offset: pointer;
				foot_offset: pointer;
				back_offset: pointer;
				wing_offset: pointer;
		end;
		
		TCWItemData = packed record
			kinf
		end;
		
		TCWPacket = class abstract
		end;
		
		TCWEntityUpdate = class(TCWPacket)
		private type
			{ The actual format of the Entity data and bitfield is complicated. The bits
			are parsed in order from lowest to highest, and the data appears in the data
			block in that same order. }
			TEntityData = bitpacked record
				{ The entity's position (X,Y,Z) }
				position: TLongVector;
				{ The entity's orientation (Roll, Pitch, Yaw) }
				orientation: array[0..2] of single;
				{ The entity's velocity }
				velocity: TFloatVector;
				{ The entity's acceleration }
				acceleration: TFloatVector;
				{ The entity's secondary/extra velocity }
				extra_velocity: TFloatVector;
				{ The viewport's pitch (for player entity only?) }
				viewport_pitch: single;
				physics_flags: dword;
				{ 1 = hostile; 5 = pet mode }
				relation: byte;
				kind: dword;
				current_mode: byte;
				mode_start_time: dword;
				hit_counter: dword;
				last_hit_time: dword;
				appearance: TCWAppearanceData;
				entity_flags: array[0..1] of byte;
				evade_time: dword;
				stun_time: dword;
				slowed_time: dword;
				make_blue_time: dword;
				speed_up_time: dword;
				show_patch_time: single;
				class_type: byte;
				specialization: byte;
				charged_mp: single;
				{ not used }
				unused1: array[0..2] of dword;
				{ not used }
				unused2: array[0..2] of dword;
				ray_hit: TFloatVector;
				hp: single;
				mp: single;
				block_power: single;
				{ (Max HP, Shoot Speed, Damage, Armor, Resist) }
				multipliers: array[0..4] of single;
				{ not used }
				unused3: byte;
				{ not used }
				unused4: byte;
				level: dword;
				current_xp: dword;
				{ ?Entity ID of owner? }
				parent_owner: qword;
				{ not used? }
				unused5: array[0..1] of dword;
				power_base: byte;
				{ not used? }
				unused6: dword;
				{ not used? }
				unused7: array[0..2] of dword;
				{ The entity's spawn position (X,Y,Z) }
				spawn_position: TLongVector;
				{ not used? }
				unused8: array[0..2] of dword;
				{ not used }
				unused9: byte;
				consumable: TCWConsumable;
			end;
		private var
			FPacketID: dword;
			FSize: dword;
			FEntityID: qword;
			FEntityMask: qword;
		public
			property PacketID: dword read FPacketID;
			{ Size of the compressed area, in bytes }
			property Size: dword read FSize;
			property EntityID: qword read FEntityID;
			property EntityMask: qword read FEntityMask;
		end;
implementation
end.
