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
		classes, fgl, sysutils;

	const
		NBTVersion1 = 19132;
		NBTVersion2 = 19133;
	
	type
	{$packenum 1}
		TNBTFlags = (
			nbtfNone = 0,
			nbtfGZipped,
			nbtfXMemCompress );
		
		TNbtId = (
			nbtEnd = 0,
			nbtInt8,
			nbtInt16,
			nbtInt32,
			nbtInt64,
			nbtFloat32,
			nbtFloat64,
			nbtByteArray,
			nbtString,
			nbtList,
			nbtCompound,
			nbtIntArray );
	{$packenum default}
	
		ENamedBinaryTag = class(exception)
		end;
	
		{ A tag is an individual part of the data tree. There is no header to specify
		the version or any other information - only the level.dat file specifies the version. }
		TNamedBinaryTag = class abstract
		private
			FId: TNbtId;
			FName: utf8string;
		public
			constructor Create(AId: TNbtId; AName: utf8string);
			{ The first byte in a tag is the tag type (ID) }
			property ID: TNbtId read FId;
			{ the name as a string in UTF-8 format }
			property Name: utf8string read FName write FName;
		end;
		
		TByteVector = specialize TFPGList<shortint>;
		TNBTVector = specialize TFPGList<TNamedBinaryTag>;
		TIntVector = specialize TFPGList<longint>;
		
		{ Used to mark the end of compound tags. This tag does not have a name, so
			it is only ever a single byte 0. }
		TNBTEnd = class(TNamedBinaryTag)
		public
			constructor Create;
		end;
		
		{ 1 byte / 8 bits, signed A signed integral type. Sometimes used for booleans.
			Full range of -(2^7) to (2^7 - 1)(-128 to 127) }
		TNBTByte = class(TNamedBinaryTag)
		private
			FValue: shortint;
		public
			constructor Create(const AName: utf8string; AValue: shortint = 0);
			property Value: shortint read FValue write FValue;
		end;
		
		{ 2 bytes / 16 bits, signed, big endian A signed integral type. Full range of
			-(2^15) to (2^15 - 1) (-32,768 to 32,767) }
		TNBTShort = class(TNamedBinaryTag)
		private
			FValue: smallint;
		public
			constructor Create(const AName: utf8string; AValue: smallint = 0);
			property Value: smallint read FValue write FValue;
		end;
		
		{ 4 bytes / 32 bits, signed, big endian A signed integral type. Full range of
			-(2^31) to (2^31 - 1) (-2,147,483,648 to 2,147,483,647) }
		TNBTInt = class(TNamedBinaryTag)
		private
			FValue: longint;
		public
			constructor Create(const AName: utf8string; AValue: longint = 0);
			property Value: longint read FValue write FValue;
		end;
		
		{ 8 bytes / 64 bits, signed, big endian A signed integral type. Full range of
			-(2^63) to (2^63 - 1) (-9,223,372,036,854,775,808 to 9,223,372,036,854,775,807) }
		TNBTLong = class(TNamedBinaryTag)
		private
			FValue: int64;
		public
			constructor Create(const AName: utf8string; AValue: int64 = 0);
			property Value: int64 read FValue write FValue;
		end;
		
		{ 4 bytes / 32 bits, signed, big endian, IEEE 754-2008, binary32 A signed
			floating point type. Precision varies throughout number line }
		TNBTFloat = class(TNamedBinaryTag)
		private
			FValue: single;
		public
			constructor Create(const AName: utf8string; AValue: single = 0.0);
			property Value: single read FValue write FValue;
		end;
		
		{ 8 bytes / 64 bits, signed, big endian, IEEE 754-2008, binary64 A signed
			floating point type. Precision varies throughout number line }
		TNBTDouble = class(TNamedBinaryTag)
		private
			FValue: double;
		public
			constructor Create(const AName: utf8string; AValue: double = 0.0);
			property Value: double read FValue write FValue;
		end;
		
		{ An array of bytes. Maximum number of elements ranges between (2^31 - 9) and
			(2^31 - 1) (2,147,483,639 and 2,147,483,647) }
		TNBTByteArray = class(TNamedBinaryTag)
		private
			FData: TByteVector;
		public
			constructor Create(const AName: utf8string; const AData: TByteVector = nil);
			destructor Destroy; override;
			procedure Push(v: shortint); overload;
			procedure Push(const a: TByteVector); overload;
			procedure Pop(i: longint); overload;
			procedure Pop(first, last: longint); overload;
			property Data: TByteVector read FData write FData;
		end;
		
		{ A UTF-8 string. It has a size, rather than being null terminated. }
		TNBTString = class(TNamedBinaryTag)
		private
			FData: utf8string;
		public
			constructor Create(const AName: utf8string; AData: utf8string = '');
			procedure Push(const s: utf8string);
			procedure Pop(const s: utf8string);
			property Data: utf8string read FData write FData;
		end;
		
		{ A list of tag payloads, without repeated tag IDs or any tag names. The
			maximum number of list elements is (2^31 - 9), or 2,147,483,639. }
		TNBTList = class(TNamedBinaryTag)
		private
			FTagId: TNbtId;
			FData: TNBTVector;
		public
			constructor Create(const AName: utf8string; ATagId: TNbtId; const AData: TNBTVector = nil);
			destructor Destroy; override;
			procedure Push(const o: TNamedBinaryTag); overload;
			procedure Push(const a: TNBTVector); overload;
			procedure Pop(i: longint); overload;
			procedure Pop(first, last: longint); overload;
			property TagID: TNbtId read FTagId;
			property Data: TNBTVector read FData write FData;
		end;
		
		{ A list of fully formed tags, including their IDs, names, and payloads. No
			two tags may have the same name. Unlike lists, there is no hard limit to the
			amount of tags within a Compound (of course, there is always the implicit limit
			of virtual memory). }
		TNBTObject = class(TNamedBinaryTag)
		private
			FData: TNBTVector;
		public
			constructor Create(const AName: utf8string; const AData: TNBTVector = nil); overload;
			constructor Create(AStream: TStream); overload;
			destructor Destroy; override;
			procedure Push(const o: TNamedBinaryTag); overload;
			procedure Push(const a: TNBTVector); overload;
			procedure Pop(i: longint); overload;
			procedure Pop(first, last: longint); overload;
			//function Pack(AFlag: TNBTFlags = nbtfGZipped): TStream;
			property Data: TNBTVector read FData write FData;
		end;
		
		{ An array of nbtInt32's payloads. Maximum number of elements ranges between
			(2^31 - 9) and (2^31 - 1) (2,147,483,639 and 2,147,483,647) }
		TNBTIntArray = class(TNamedBinaryTag)
		private
			FData: TIntVector;
		public
			constructor Create(const AName: utf8string; const AData: TIntVector = nil);
			destructor Destroy; override;
			procedure Push(v: longint); overload;
			procedure Push(const a: TIntVector); overload;
			procedure Pop(i: longint); overload;
			procedure Pop(first, last: longint); overload;
			property Data: TIntVector read FData write FData;
		end;
		
implementation
	uses
		myutils, strutils;

	constructor TNamedBinaryTag.Create(AId: TNbtId; AName: utf8string);
	begin
		FId := AId;
		FName := AName;
	end;
	
	constructor TNBTEnd.Create;
	begin
		inherited Create(nbtEnd, '');
	end;
	
	constructor TNBTByte.Create(const AName: utf8string; AValue: shortint);
	begin
		inherited Create(nbtInt8, AName);
		FValue := AValue;
	end;
	
	constructor TNBTShort.Create(const AName: utf8string; AValue: smallint);
	begin
		inherited Create(nbtInt16, AName);
		FValue := AValue;
	end;
	
	constructor TNBTInt.Create(const AName: utf8string; AValue: longint);
	begin
		inherited Create(nbtInt32, AName);
		FValue := AValue;
	end;
	
	constructor TNBTLong.Create(const AName: utf8string; AValue: int64);
	begin
		inherited Create(nbtInt64, AName);
		FValue := AValue;
	end;
	
	constructor TNBTFloat.Create(const AName: utf8string; AValue: single);
	begin
		inherited Create(nbtFloat32, AName);
		FValue := AValue;
	end;
	
	constructor TNBTDouble.Create(const AName: utf8string; AValue: double);
	begin
		inherited Create(nbtFloat64, AName);
		FValue := AValue;
	end;
	
	constructor TNBTByteArray.Create(const AName: utf8string; const AData: TByteVector);
	begin
		inherited Create(nbtByteArray, AName);
		if AData = nil then
			FData := TByteVector.Create
		else
			FData := AData;
	end;
	
	destructor TNBTByteArray.Destroy;
	begin
		FData.free;
		inherited Destroy;
	end;
	
	procedure TNBTByteArray.Push(v: shortint);
	begin
		FData.add(v);
	end;
	
	procedure TNBTByteArray.Push(const a: TByteVector);
	var
		i: sizeuint;
	begin
		if a <> nil then
			for i:=0 to a.count-1 do
				FData.add(a.items[i])
		else
			raise ENamedBinaryTag.Create('Attempted to push nil data on to TNBTByteArray!');
	end;
	
	procedure TNBTByteArray.Pop(i: longint);
	begin
		FData.delete(i);
	end;
	
	procedure TNBTByteArray.Pop(first, last: longint);
	var
		i: sizeuint;
	begin
		for i:=first to last do
			FData.delete(i);
	end;
	
	constructor TNBTString.Create(const AName: utf8string; AData: utf8string);
	begin
		inherited Create(nbtString, AName);
		FData := AData;
	end;
	
	procedure TNBTString.Push(const s: utf8string);
	begin
		FData := FData + s;
	end;
	
	procedure TNBTString.Pop(const s: utf8string);
	begin
		FData := replacestr(FData, s, '');
	end;
	
	function CheckTagID(id: TNbtId; const a: TNBTVector): boolean;
	var
		i: longint;
	begin
		result := true;
		for i:=0 to a.count-1 do
			if a.items[i].ID <> id then
				exit(false);
	end;
	
	constructor TNBTList.Create(const AName: utf8string; ATagId: TNbtId; const AData: TNBTVector);
	begin
		inherited Create(nbtList, AName);
		FTagId := ATagId;
		if AData = nil then
			FData := TNBTVector.Create
		else
			if CheckTagID(ATagId, AData) then
				FData := AData
			else
				raise ENamedBinaryTag.Create('Tag IDs differ amongst data passed to TNBTList constructor!');
	end;
	
	destructor TNBTList.Destroy;
	var
		i: longint;
	begin
		if FData <> nil then
			for i:=0 to FData.count do
				FData.items[i].free;
		inherited Destroy;
	end;
	
	procedure TNBTList.Push(const o: TNamedBinaryTag);
	begin
		if o <> nil then
			if o.ID = FTagId then
				FData.add(o)
			else
				raise ENamedBinaryTag.Create('Tag IDs differ between added data and TNBTList!')
		else
			raise ENamedBinaryTag.Create('Attempted to push nil data on to TNBTList!');
	end;
	
	procedure TNBTList.Push(const a: TNBTVector);
	var
		i: longint;
	begin
		if a <> nil then
			if CheckTagID(FTagId, a) then
				for i:=0 to a.count-1 do
					FData.add(a.items[i])
			else
				raise ENamedBinaryTag.Create('Tag IDs differ amongst data pushed to TNBTList!')
		else
			raise ENamedBinaryTag.Create('Attempted to push nil data on to TNBTList!');
	end;
	
	procedure TNBTList.Pop(i: longint);
	begin
		FData.delete(i);
	end;
	
	procedure TNBTList.Pop(first, last: longint);
	var
		i: sizeuint;
	begin
		for i:=first to last do
			FData.delete(i);
	end;
	
	constructor TNBTObject.Create(const AName: utf8string; const AData: TNBTVector);
	begin
		inherited Create(nbtCompound, AName);
		if AData = nil then begin
			FData := TNBTVector.Create;
			FData.add(TNBTEnd.Create);
		end else begin
			FData := AData;
			FData.add(TNBTEnd.Create);
		end;
	end;
	
	constructor TNBTObject.Create(AStream: TStream);
	var
		idget, tag: TNbtId;
		nametemp: utf8string;
		i: longint;
	begin
		inherited Create(nbtCompound, '');
		while AStream.position <= AStream.size do begin
			idget := TNbtId(AStream.readbyte);
			case idget of
				nbtEnd: FData.add(TNBTEnd.Create);
				nbtInt8: begin
					setlength(nametemp, system.beton(AStream.readword));
					AStream.readbuffer(nametemp[1], length(nametemp));
					FData.add(TNBTByte.Create(nametemp));
					FData.(last as TNBTByte).value := shortint(AStream.readbyte);
				end;
				nbtInt16: begin
					setlength(nametemp, system.beton(AStream.readword));
					AStream.readbuffer(nametemp[1], length(nametemp));
					FData.add(TNBTShort.Create(nametemp));
					FData.last.value := system.beton(smallint(AStream.readword));
				end;
				nbtInt32: begin
					setlength(nametemp, system.beton(AStream.readword));
					AStream.readbuffer(nametemp[1], length(nametemp));
					FData.add(TNBTInt.Create(nametemp));
					FData.last.value := system.beton(longint(AStream.readdword));
				end;
				nbtInt64: begin
					setlength(nametemp, system.beton(AStream.readword));
					AStream.readbuffer(nametemp[1], length(nametemp));
					FData.add(TNBTLong.Create(nametemp));
					FData.last.value := system.beton(int64(AStream.readqword));
				end;
				nbtFloat32: begin
					setlength(nametemp, system.beton(AStream.readword));
					AStream.readbuffer(nametemp[1], length(nametemp));
					FData.add(TNBTFloat.Create(nametemp));
					AStream.readbuffer(FData.last.value, 4);
					FData.last.value := myutils.beton(FData.last.value);
				end;
				nbtFloat64: begin
					setlength(nametemp, system.beton(AStream.readword));
					AStream.readbuffer(nametemp[1], length(nametemp));
					FData.add(TNBTDouble.Create(nametemp));
					AStream.readbuffer(FData.last.value, 8);
					FData.last.value := myutils.beton(FData.last.value);
				end;
				nbtByteArray: begin
					setlength(nametemp, system.beton(AStream.readword));
					AStream.readbuffer(nametemp[1], length(nametemp));
					FData.add(TNBTByteArray.Create(nametemp));
					FData.last.data := TByteVector.Create;
					FData.last.data.capacity := system.beton(longint(AStream.readdword));
					for i:=0 to FData.last.data.capacity-1 do
						FData.last.data.items[i] := shortint(AStream.readbyte);
				end;
				nbtString: begin
					setlength(nametemp, system.beton(AStream.readword));
					AStream.readbuffer(nametemp[1], length(nametemp));
					FData.add(TNBTString.Create(nametemp));
					setlength(FData.last.data, system.beton(AStream.readword));
					AStream.readbuffer(FData.last.data[1], length(FData.last.data));
				nbtList: begin
					setlength(nametemp, system.beton(AStream.readword));
					AStream.readbuffer(nametemp[1], length(nametemp));
					tag := TNbtId(AStream.readbyte);
					FData.add(TNBTList.Create(nametemp, tag));
					FData.last.data.capacity := system.beton(AStream.readdword);
					for i:=0 to FData.last.data.capacity-1 do begin
						case FData.last.tagid of
							nbtInt8:
								FData.last.data.items[i] := TNBTByte.Create('', shortint(AStream.readbyte));
							nbtInt16:
								FData.last.data.items[i] := TNBTShort.Create('', system.beton(smallint(AStream.readword)));
							nbtInt32:
								FData.last.data.items[i] := TNBTInt.Create('', system.beton(longint(AStream.readdword)));
							nbtInt64:
								FData.last.data.items[i] := TNBTLong.Create('', system.beton(int64(AStream.readqword)));
							nbtFloat32: begin
								FData.last.data.items[i] := TNBTFloat.Create('');
								AStream.readbuffer(FData.last.data.items[i].value, 4);
								FData.last.data.items[i].value := myutils.beton(FData.last.data.items[i].value);
							end;
							nbtFloat64: begin
								FData.last.data.items[i] := TNBTDouble.Create('');
								AStream.readbuffer(FData.last.data.items[i].value, 8);
								FData.last.data.items[i].value := myutils.beton(FData.last.data.items[i].value);
							end;
							nbtString: begin
								FData.last.data.items[i] := TNBTString.Create('');
								setlength(FData.last.data.items[i].data, system.beton(AStream.readword));
								AStream.readbuffer(FData.last.data.items[i].data[1], length(FData.last.data.items[i].data));
							else
								raise ENamedBinaryTag.Create('God help us, it''s a listception...');
							end;
				end;
				nbtIntArray: begin
					setlength(nametemp, system.beton(AStream.readword));
					AStream.readbuffer(nametemp[1], length(nametemp));
					FData.add(TNBTIntArray.Create(nametemp));
					FData.last.data := TIntVector.Create;
					FData.last.data.capacity := system.beton(longint(AStream.readdword));
					for i:=0 to FData.last.data.capacity-1 do
						FData.last.data.items[i] := system.beton(longint(AStream.readdword));
				end;
				else
					raise ENamedBinaryTag.Create('God help us, it''s a listception...');
		end;
	end;
	
	destructor TNBTObject.Destroy;
	var
		i: longint;
	begin
		if FData <> nil then
			for i:=0 to FData.count-1 do
				FData.items[i].free;
		inherited Destroy;
	end;
	
	procedure TNBTObject.Push(const o: TNamedBinaryTag);
	begin
		if o <> nil then begin
			FData.add(o);
			FData.exchange(FData.count-1, FData.count-2);
		end else
			raise ENamedBinaryTag.Create('Attempted to push nil data on to TNBTObject!');
	end;
	
	procedure TNBTObject.Push(const a: TNBTVector);
	var
		i: longint;
	begin
		if a <> nil then begin
			for i:=0 to a.count-1 do
				FData.add(a.items[i]);
			FData.exchange(FData.count-1, FData.count-2);
		end else
			raise ENamedBinaryTag.Create('Attempted to push nil data on to TNBTObject!');
	end;
	
	procedure TNBTObject.Pop(i: longint);
	begin
		if i <> FData.count-1 then begin
			FData.delete(i);
			FData.move(FData.count-1, FData.count-2);
		end else
			raise ENamedBinaryTag.Create('Attempted to pop TNBTEnd!');
	end;
	
	procedure TNBTObject.Pop(first, last: longint);
	var
		i: sizeuint;
	begin
		for i:=first to last do
			if i <> FData.count-1 then
				FData.delete(i)
			else
				raise ENamedBinaryTag.Create('Attempted to pop TNBTEnd!');
		FData.move(FData.count-1, FData.count-2);
	end;
	
	constructor TNBTIntArray.Create(const AName: utf8string; const AData: TIntVector);
	begin
		inherited Create(nbtByteArray, AName);
		if AData = nil then
			FData := TIntVector.Create
		else
			FData := AData;
	end;
	
	destructor TNBTIntArray.Destroy;
	begin
		FData.free;
		inherited Destroy;
	end;
	
	procedure TNBTIntArray.Push(v: longint);
	begin
		FData.add(v);
	end;
	
	procedure TNBTIntArray.Push(const a: TIntVector);
	var
		i: sizeuint;
	begin
		if a <> nil then
			for i:=0 to a.count-1 do
				FData.add(a.items[i])
		else
			raise ENamedBinaryTag.Create('Attempted to push nil data on to TNBTIntArray!');
	end;
	
	procedure TNBTIntArray.Pop(i: longint);
	begin
		FData.delete(i);
	end;
	
	procedure TNBTIntArray.Pop(first, last: longint);
	var
		i: sizeuint;
	begin
		for i:=first to last do
			FData.delete(i);
	end;
	
end.
