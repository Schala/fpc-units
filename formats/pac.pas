{ This PAC format is used in the PS2 game Legaia 2 Dual Saga and is simply multiple
files lumped together. The metadata is stored in little endian. The header starts
with 8 bytes that seem to be padding (always 0?), followed by the file count (4 bytes),
the PAC's total file size (4 bytes), and then a dictionary (36 bytes) of file pointers (4 bytes)
paired with a 32 byte filepath (POSIX directory separators). After that, the file
content are dumped in one after another. }
unit pac;
{$mode objfpc}{$H+}
interface
	uses
		classes;
	type
		TPACContainer = class
		private type
			TFileEntry = record
				offset: dword;
				path: string[32];
				buf: TMemoryStream;
			end;
		private var
			FSize: dword;
			FFiles: array of TFileEntry;
		public
			constructor Create; overload;
			constructor Create(AStream: TStream); overload;
			destructor Destroy; override;
			procedure Add(const filepath: string);
			function Pack: TMemoryStream;
			procedure ExtractAll;
			property Size: dword read FSize;
		end;

implementation
	uses
		strutils, sysutils;
	
	constructor TPACContainer.Create;
	begin
		FSize := 16;
		FFiles := nil;
	end;
	
	constructor TPACContainer.Create(AStream: TStream);
	var
		i, l: dword;
	begin
		AStream.seek(8, sofrombeginning);
		setlength(FFiles, leton(AStream.readdword));
		l := length(FFiles);
		FSize := leton(AStream.readdword);
		if FSize <> AStream.size then
			writeln('WARNING: PAC total size value does not equal stream size!');
		for i:=0 to l-1 do
			with FFiles[i] do begin
				offset := leton(AStream.readdword);
				setlength(path, 32);
				AStream.readbuffer(path[1], 32);
			{$ifdef WINDOWS}
				path := replacestr(path, '/', directoryseparator);
			{$endif WINDOWS}
			end;
		for i:=0 to l-1 do
			with FFiles[i] do begin
				buf := TMemoryStream.Create;
				AStream.seek(offset, sofrombeginning);
				if i = l-1 then
					buf.copyfrom(AStream, AStream.size - offset)
				else
					buf.copyfrom(AStream, FFiles[i+1].offset - offset);
			end;
	end;
	
	destructor TPACContainer.Destroy;
	var
		i: dword;
	begin
		if FFiles <> nil then
			for i:=0 to length(FFiles)-1 do
				with FFiles[i] do begin
					buf.free;
					setlength(path, 0);
				end;
		setlength(FFiles, 0);
		inherited Destroy;
	end;
	
	procedure TPACContainer.Add(const filepath: string);
	var
		f: TFileStream;
		i, l: dword;
	begin
		if fileexists(filepath) then begin
			f := TFileStream.Create(filepath, fmopenread);
			setlength(FFiles, length(FFiles)+1);
			l := length(FFiles);
			with FFiles[l-1] do begin
				buf := TMemoryStream.Create;
				buf.copyfrom(f, 0);
				f.free;
				path := filepath;
				setlength(path, 32);
			{$ifdef WINDOWS}
				path := replacestr(path, directoryseparator, '/');
			{$endif WINDOWS}
				offset := FSize+36;
				inc(FSize, buf.size+36);
			end;
			if l > 1 then
				for i:=0 to l-2 do
					inc(FFiles[i].offset, 36);
		end;
	end;
	
	function TPACContainer.Pack: TMemoryStream;
	var
		i, l: dword;
	begin
		l := length(FFiles);
		result := TMemoryStream.Create;
		result.writeqword(0);
		result.writedword(ntole(l));
		result.writedword(ntole(FSize));
		for i:=0 to l-1 do
			with FFiles[i] do begin
				result.writedword(ntole(offset));
				result.writebuffer(path, 32);
			end;
		for i:=0 to l-1 do
			result.copyfrom(FFiles[i].buf, 0);
	end;
	
	procedure TPACContainer.ExtractAll;
	var
		f: TFileStream;
		i, l: dword;
	begin
		l := length(FFiles);
		for i:=0 to l-1 do
			with FFiles[i] do begin
				f := TFileStream.Create(trimrightset(path, [#0]), fmcreate);
				f.copyfrom(buf, 0);
				f.free;
			end;
	end;
end.
