{ The Named Binary Tag format is used by Minecraft for the various files it saves
data to. The format is designed to store data in a tree structure made up of
various tags. All tags have an ID and a name. The original known version was 19132
as introduced in Minecraft Beta 1.3, and since then has been updated to 19133 with Anvil,
with the addition of the Int Array tag. The NBT format dates all the way back to
Minecraft Indev with tags 0 to 10 in use. }
unit nbt;
{$mode objfpc}{$H+}
interface
	uses
	{$ifdef UNIX}
		cwstring,
	{$else}
		windows,
	{$endif UNIX}
		classes,
		sysutils;

	const
		NBTVersion1 = 19132;
		NBTVersion2 = 19133;
	
	type
	{$packenum 1}
		TNbtFlags = (
			nbtfNone = 0,
			nbtfGZipped,
			nbtfXMemCompress );
		
		TNbtID = (
			{ Used to mark the end of compound tags. This tag does not have a name, so
			it is only ever a single byte 0. }
			nbtEnd = 0,
			{ 1 byte / 8 bits, signed A signed integral type. Sometimes used for booleans.
			Full range of -(2^7) to (2^7 - 1)(-128 to 127) }
			nbtInt8,
			{ 2 bytes / 16 bits, signed, big endian A signed integral type. Full range of
			-(2^15) to (2^15 - 1) (-32,768 to 32,767) }
			nbtInt16,
			{ 4 bytes / 32 bits, signed, big endian A signed integral type. Full range of
			-(2^31) to (2^31 - 1) (-2,147,483,648 to 2,147,483,647) }
			nbtInt32,
			{ 8 bytes / 64 bits, signed, big endian A signed integral type. Full range of
			-(2^63) to (2^63 - 1) (-9,223,372,036,854,775,808 to 9,223,372,036,854,775,807) }
			nbtInt64,
			{ 4 bytes / 32 bits, signed, big endian, IEEE 754-2008, binary32 A signed
			floating point type. Precision varies throughout number line }
			nbtFloat32,
			{ 8 bytes / 64 bits, signed, big endian, IEEE 754-2008, binary64 A signed
			floating point type. Precision varies throughout number line }
			nbtFloat64,
			{ An array of bytes. Maximum number of elements ranges between (2^31 - 9) and
			(2^31 - 1) (2,147,483,639 and 2,147,483,647) }
			nbtByteArray,
			{ A UTF-8 string. It has a size, rather than being null terminated. }
			nbtString,
			{ A list of tag payloads, without repeated tag IDs or any tag names. The
			maximum number of list elements is (2^31 - 9), or 2,147,483,639. }
			nbtList,
			{ A list of fully formed tags, including their IDs, names, and payloads. No
			two tags may have the same name. Unlike lists, there is no hard limit to the
			amount of tags within a Compound (of course, there is always the implicit limit
			of virtual memory). }
			nbtCompound,
			{ An array of nbtInt32's payloads. Maximum number of elements ranges between
			(2^31 - 9) and (2^31 - 1) (2,147,483,639 and 2,147,483,647) }
			nbtIntArray );
	{$packenum default}
		
		{ A tag is an individual part of the data tree. There is no header to specify
		the version or any other information - only the level.dat file specifies the version. }
		TNamedBinaryTag = class abstract
		private
			FId: TNbtID;
			FName: utf8string;
		public
			constructor Create(AId: TNbtID; AName: utf8string);
			{ The first byte in a tag is the tag type (ID) }
			property ID: TNbtID read FId;
			{ the name as a string in UTF-8 format }
			property Name: utf8string read FName write FName;
		end;
		
		TNbtEnd = class(TNamedBinaryTag)
		public
			constructor Create;
		end;
		
		TNbtByte = class(TNamedBinaryTag)
		private
			FValue: shortint;
		public
			constructor Create(AName: utf8string; AValue: shortint = 0);
			property Value: shortint read FValue write FValue;
		end;
		
		TNbtShort = class(TNamedBinaryTag)
		private
			FValue: smallint;
		public
			constructor Create(AName: utf8string; AValue: smallint = 0);
			property Value: smallint read FValue write FValue;
		end;
		
		TNbtInt = class(TNamedBinaryTag)
		private
			FValue: longint;
		public
			constructor Create(AName: utf8string; AValue: longint = 0);
			property Value: longint read FValue write FValue;
		end;
		
		TNbtLong = class(TNamedBinaryTag)
		private
			FValue: int64;
		public
			constructor Create(AName: utf8string; AValue: int64 = 0);
			property Value: int64 read FValue write FValue;
		end;
		
		TNbtFloat = class(TNamedBinaryTag)
		private
			FValue: single;
		public
			constructor Create(AName: utf8string; AValue: single = 0.0);
			property Value: single read FValue write FValue;
		end;
		
		TNbtDouble = class(TNamedBinaryTag)
		private
			FValue: double;
		public
			constructor Create(AName: utf8string; AValue: double = 0.0);
			property Value: double read FValue write FValue;
		end;
		
		TNbtByteArray = class(TNamedBinaryTag)
		private
			FBytes: TBytes;
		public
			constructor Create(AName: utf8string);
			property Bytes: TBytes read FBytes write FBytes;
		end;
		
implementation
	constructor TNamedBinaryTag.Create(AId: TNbtID; AName: utf8string);
	begin
		FId := AId;
		FName := AName;
	end;
	
	constructor TNbtEnd.Create;
	begin
		inherited Create(nbtEnd, '');
	end;
	
	constructor TNbtByte.Create(AName: utf8string; AValue: shortint);
	begin
		inherited Create(nbtInt8, AName);
	end;
	
	constructor TNbtShort.Create(AName: utf8string; AValue: smallint);
	begin
		inherited Create(nbtInt16, AName);
	end;
	
	constructor TNbtInt.Create(AName: utf8string; AValue: longint);
	begin
		inherited Create(nbtInt32, AName);
	end;
	
	constructor TNbtLong.Create(AName: utf8string; AValue: int64);
	begin
		inherited Create(nbtInt64, AName);
	end;
	
	constructor TNbtFloat.Create(AName: utf8string; AValue: single);
	begin
		inherited Create(nbtFloat32, AName);
	end;
	
	constructor TNbtDouble.Create(AName: utf8string; AValue: double);
	begin
		inherited Create(nbtFloat64, AName);
	end;
end.
