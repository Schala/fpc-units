{ The Named Binary Tag format is used by Minecraft for the various files it saves
data to. The format is designed to store data in a tree structure made up of
various tags. All tags have an ID and a name. The original known version was 19132
as introduced in Minecraft Beta 1.3, and since then has been updated to 19133 with Anvil,
with the addition of the Int Array tag. The NBT format dates all the way back to
Minecraft Indev with tags 0 to 10 in use. }
unit nbt;
{$modeswitch result}
interface
	const
		NBTVersion1 = 19132;
		NBTVersion2 = 19133;
		F_GZipped = 1;
		F_XMemCompress = 2;
		{ Used to mark the end of compound tags. This tag does not have a name, s
		it is only ever a single byte 0. }
		T_End = 0;
		{ 1 byte / 8 bits, signed A signed integral type. Sometimes used for booleans.
		Full range of -(2^7) to (2^7 - 1)(-128 to 127) }
		T_Int8 = 1;
		{ 2 bytes / 16 bits, signed, big endian A signed integral type. Full range of
		-(2^15) to (2^15 - 1) (-32,768 to 32,767) }
		T_Int16 = 2;
		{ 4 bytes / 32 bits, signed, big endian A signed integral type. Full range of
		-(2^31) to (2^31 - 1) (-2,147,483,648 to 2,147,483,647) }
		T_Int32 = 3;
		{ 8 bytes / 64 bits, signed, big endian A signed integral type. Full range of
		-(2^63) to (2^63 - 1) (-9,223,372,036,854,775,808 to 9,223,372,036,854,775,807) }
		T_Int64 = 4;
		{ 4 bytes / 32 bits, signed, big endian, IEEE 754-2008, binary32 A signed
		floating point type. Precision varies throughout number line }
		T_Float32 = 5;
		{ 8 bytes / 64 bits, signed, big endian, IEEE 754-2008, binary64 A signed
		floating point type. Precision varies throughout number line }
		T_Float64 = 6;
		{ An array of bytes. Maximum number of elements ranges between (2^31 - 9) and
		(2^31 - 1) (2,147,483,639 and 2,147,483,647) }
		T_ByteArray = 7;
		{ A UTF-8 string. It has a size, rather than being null terminated. }
		T_String = 8;
		{ A list of tag payloads, without repeated tag IDs or any tag names. The
		maximum number of list elements is (2^31 - 9), or 2,147,483,639. }
		T_List = 9;
		{ A list of fully formed tags, including their IDs, names, and payloads. No
		two tags may have the same name. Unlike lists, there is no hard limit to the
		amount of tags within a Compound (of course, there is always the implicit limit
		of virtual memory). }
		T_Object = 10;
		{ An array of T_Int32's payloads. Maximum number of elements ranges between
		(2^31 - 9) and (2^31 - 1) (2,147,483,639 and 2,147,483,647) }
		T_IntArray = 11;
	
	type
		PNamedBinaryTag = ^TNamedBinaryTag;
		{ A tag is an individual part of the data tree. There is no header to specify
		the version or any other information - only the level.dat file specifies the version. }
		TNamedBinaryTag = record
			{ The first byte in a tag is the tag type (ID) }
			id: shortint;
			{ two bytes for the length of the name }
			name_length: smallint;
			{ the name as a string in UTF-8 format }
			name: utf8string;
		case id of
			T_End: ();
			T_Int8: (i8: shortint);
			T_Int16: (i16: smallint);
			T_Int32: (i32: longint);
			T_Int64: (i64: int64);
			T_Float32: (f32: single);
			T_Float64: (f64: double);
			T_ByteArray:
				(byte_array_size: longint;
				 byte_array: pbyte);
			T_String:
				(string_size: smallint;
				 txt: utf8string);
			T_List:
				(tag_id: shortint;
				 list_size: longint;
				 list_tags: PNamedBinaryTag);
			T_Object:
				(obj_tags: PNamedBinaryTag;
				 end_tag: PNamedBinaryTag);
			T_IntArray:
				(int_array_size: longint;
				 int_array: plongint);
		end;
	
	function NewNBT: PNamedBinaryTag;
	function ReadEnd(const p: TNamedBinaryTag): PNamedBinaryTag;
	function ReadI8(const p: TNamedBinaryTag): shortint;
	function ReadI16(const p: TNamedBinaryTag): smallint;
	function ReadI32(const p: TNamedBinaryTag): longint;
	function ReadI64(const p: TNamedBinaryTag): int64;
	function ReadF32(const p: TNamedBinaryTag): single;
	function ReadF64(const p: TNamedBinaryTag): double;
	function ReadByteArray(const p: TNamedBinaryTag): PNamedBinaryTag;
	function ReadStr(const p: TNamedBinaryTag): utf8string;
	function ReadList(const p: TNamedBinaryTag): PNamedBinaryTag;
	function ReadObj(const p: TNamedBinaryTag): PNamedBinaryTag;
	function ReadIntArray(const p: TNamedBinaryTag): PNamedBinaryTag;
	procedure WriteEnd(var p: TNamedBinaryTag);
	procedure WriteI8(var p: TNamedBinaryTag; v: shortint; const n: utf8string);
	procedure WriteI16(var p: TNamedBinaryTag; v: smallint; const n: utf8string);
	procedure WriteI32(var p: TNamedBinaryTag; v: longint; const n: utf8string);
	procedure WriteI64(var p: TNamedBinaryTag; v: int64; const n: utf8string);
	procedure WriteF32(var p: TNamedBinaryTag; v: single; const n: utf8string);
	procedure WriteF64(var p: TNamedBinaryTag; v: double; const n: utf8string);
	procedure WriteByteArray(var p: TNamedBinaryTag; const v: pbyte; const n: utf8string);
	procedure WriteStr(var p: TNamedBinaryTag; const v: utf8string; const n: utf8string);
	procedure WriteList(var p: TNamedBinaryTag; v:
implementation
	uses
	{$ifdef UNIX}
		cwstring
	{$endif UNIX}
		;
end.
