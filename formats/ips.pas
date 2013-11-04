{ IPS format was created a lot of time ago and so the specs for many people are
too restrictive for the modern needs. Well, let see these specs.

	* IPS files can patch every file not larger than 2^24-1 bits (2047 Mb)
	* Every patch should not be larger than 2^16-1 bits (7.99 Mb)
	* An IPS file can hold as many patches he can, assumed that the specified offset
	and the size of every single patch doesn't overflow the specified bounds. }
unit ips;
{$mode objfpc}{$H+}
interface
	uses
		classes, sysutils;

	const
		{ The header show ever the same string: PATCH note that the string is not
		NULL terminated. }
		IPSMagic = 'PATCH';
		{ A string (not NULL terminated) saying EOF }
		EOFMarker = 'EOF';
	
	type
		EIPSRead = class(exception)
		end;
		
		TIPSPatch = class
		private type
			{ It's the record of a single patch }
			TEntry = record
				offset: dword;
				{ The size of the data to put from the specified offset in the patching file.
				If when you read the size value of a record this field contains 0 you have a
				RLE encoded patch. }
				rlesize: word;
				data: TMemoryStream;
				value: byte;
			end;
		private var
			FEntries: array of TEntry;
		public
			constructor Create; overload;
			constructor Create(AStream: TStream); overload;
			destructor Destroy; override;
			//procedure Add(AStream: TStream);
			//function Pack: TMemoryStream;
			procedure ExtractAll;
		end;

implementation
	uses
		strutils;

	constructor TIPSPatch.Create;
	begin
		FEntries := nil;
	end;
	
	constructor TIPSPatch.Create(AStream: TStream);
	var
		l, e: dword;
		ofs: array[0..2] of byte;
		id: string;
	begin
		AStream.seek(0, sofrombeginning);
		setlength(id, 5);
		AStream.readbuffer(id[1], 5);
		if id <> IPSMagic then
			raise EIPSRead.Create('File does not begin with IPSMagic ("PATCH")');
		e := AStream.size-3;
		AStream.seek(e, sofrombeginning);
		setlength(id, 3);
		AStream.readbuffer(id[1], 3);
		if id <> EOFMarker then
			raise EIPSRead.Create('File does not end with EOFMarker ("EOF")');
		AStream.seek(5, sofrombeginning);
		l := 1;
		while AStream.position <> e do begin
			setlength(FEntries, l);
			with FEntries[l-1] do begin
				AStream.readbuffer(ofs[0], 3);
				move(ofs, offset, 3);
				offset := beton(offset);
				data := TMemoryStream.Create;
				data.setsize(beton(AStream.readword));
				if data.size = 0 then begin
					rlesize := beton(AStream.readword);
					value := AStream.readbyte;
				end else begin
					writeln(data.size);
					data.copyfrom(AStream, data.size);
				end;
			end;
			inc(l);
		end;
	end;
	
	destructor TIPSPatch.Destroy;
	var
		i: dword;
	begin
		if FEntries <> nil then
			for i:=0 to length(FEntries)-1 do
				with FEntries[i] do
					if data <> nil then
						data.free;
		setlength(FEntries, 0);
		inherited Destroy;
	end;
	
	procedure TIPSPatch.ExtractAll;
	var
		f: TFileStream;
		i, l: dword;
		idxstr: string;
	begin
		l := length(FEntries);
		for i:=0 to l-1 do begin
			str(i, idxstr);
			f := TFileStream.Create(idxstr+'.dat', fmcreate);
			with FEntries[i] do
				if data.size = 0 then
					writeln('RLE record at index ', i)
				else
					if data <> nil then
						f.copyfrom(data, 0)
					else
						raise EIPSRead.Create('Patch index '+idxstr+' contains no data!');
			f.free;
		end;
	end;
end.
