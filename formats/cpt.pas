{ A cpt file is a container used for other files. Unlike the drp format, it doesn't
give any information about what those files are, leaving us to guess. }
unit cpt;
{$mode objfpc}{$H+}
interface
	uses
		classes;
	
	const
		CPTEofPtrMarker = 8;
		CPTEofPtrNoMarker = 4;

	type
		{ A cpt begins with a four-byte little-endian giving the number of subfiles it
		contains, followed by a series of four-byte pointers indicating the beginning of
		each subfile relative to the beginning of the cpt. A true cpt has an end-of-file
		pointer as well, but the Chrono Cross CDs also include variations on the format
		which lack one. After that, the files are packed in one after the other. }
		TCPTContainer = class
		private type
			TFileEntry = record
				offset: dword;
				buf: TMemoryStream;
			end;
		private var
			FHasEOFMarker: boolean;
			FEofPos: dword;
			FFiles: array of TFileEntry;
		public
			constructor Create(AHasEOFMarker: boolean = false); overload;
			constructor Create(AStream: TStream; AHasEOFMarker: boolean = false); overload;
			destructor Destroy; override;
			procedure Add(const filename: string);
			function Pack: TMemoryStream;
			procedure ExtractAll;
			property HasEOFMarker: boolean read FHasEOFMarker;
			property EofPos: dword read FEofPos;
		end;

implementation
	uses
		sysutils;

	constructor TCPTContainer.Create(AHasEOFMarker: boolean);
	begin
		FHasEOFMarker := AHasEOFMarker;
		if FHasEOFMarker then
			FEofPos := CPTEofPtrMarker
		else
			FEofPos := CPTEofPtrNoMarker;
		FFiles := nil;
	end;
	
	constructor TCPTContainer.Create(AStream: TStream; AHasEOFMarker: boolean);
	var
		i, l: dword;
	begin
		FHasEOFMarker := AHasEOFMarker;
		setlength(FFiles, leton(AStream.readdword));
		l := length(FFiles);
		for i:=0 to l-1 do
			FFiles[i].offset := leton(AStream.readdword);
		if FHasEOFMarker then begin
			FEofPos := leton(AStream.readdword);
			if FEofPos <> AStream.size then
				writeln('WARNING: End-of-file marker does not equal stream size!');
		end else
			FEofPos := AStream.size;
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
	
	destructor TCPTContainer.Destroy;
	var
		i: dword;
	begin
		if FFiles <> nil then
			for i:=0 to length(FFiles)-1 do
				FFiles[i].buf.free;
		setlength(FFiles, 0);
		inherited Destroy;
	end;
	
	procedure TCPTContainer.Add(const filename: string);
	var
		f: TFileStream;
		i, l: dword;
	begin
		if fileexists(filename) then begin
			f := TFileStream.Create(filename, fmopenread);
			setlength(FFiles, length(FFiles)+1);
			l := length(FFiles);
			with FFiles[l-1] do begin
				buf := TMemoryStream.Create;
				buf.copyfrom(f, 0);
				f.free;
				offset := FEofPos+4;
				inc(FEofPos, buf.size+4);
			end;
			if l > 1 then
				for i:=0 to l-2 do
					inc(FFiles[i].offset, 4);
		end;
	end;
	
	function TCPTContainer.Pack: TMemoryStream;
	var
		i, l: dword;
	begin
		l := length(FFiles);
		result := TMemoryStream.Create;
		result.writedword(ntole(l));
		for i:=0 to l-1 do
			result.writedword(ntole(FFiles[i].offset));
		if FHasEOFMarker then
			result.writedword(ntole(FEofPos));
		for i:=0 to l-1 do
			result.copyfrom(FFiles[i].buf, 0);
	end;
	
	procedure TCPTContainer.ExtractAll;
	var
		f: TFileStream;
		i, l: dword;
		idxstr: string;
	begin
		l := length(FFiles);
		for i:=0 to l-1 do begin
			str(i, idxstr);
			f := TFileStream.Create(idxstr+'.out', fmcreate);
			f.copyfrom(FFiles[i].buf, 0);
			f.free;
		end;
	end;
end.
