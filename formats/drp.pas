{ The drp file, which begins with the ASCII letters "drp" and almost always
contains visual or audio resources. }
unit drp;
{$mode objfpc}{$H+}
interface
	uses
		classes, sysutils;

	const
		{ The first three bytes spell out "drp" in ASCII. }
		DRPMagic = 'drp'#0;
		DRPHeaderSize = 12;
		
	type
	{$packenum 1}
		TDRPFileType = (
			{ nested drp file }
			ftDRP = 1,
			{ generic mesh }
			ftMesh,
			{ information about slicing, mirroring, etc., in tim textures }
			ftTIMInfo,
			{ any except battle anims }
			ftTIM,
			{ music instruments }
			ftMInst,
			{ Type 7 is potentially a problem. It's used only a handful of times, but in
			an entirely inconsistent manner: two files marked as type 7 are recognizably
			tbt lumps, one is a TIM texture (despite ~TIMs having their own code) and the
			other 16 are inscrutable—one may be an executable. So the only way to tell
			what's actually in a type 7 file is to open it and check. }
			ft07 = 7,
			{ Probably relates to graphics somehow. }
			ft0A = 10,
			{ model pack }
			ftMDL,
			{ Probably relates to graphics somehow. }
			ft0C,
			{ May relate to meshes. }
			ft10 = 16,
			ft12 = 18,
			{ model for lens light effects? }
			ft15 = 21,
			{ music sequence }
			ftMSeq,
			{ model animation (cpt pack) }
			ftAnim = 25,
			{ Associated with things that cause damage, e.g. attack animations,
			offensive Elements. }
			ft1A,
			{ LZSS compressed data }
			ftLZSS = 37 );
		
		EDRPRead = class(exception)
		end;
		
		{ A drp file contains a 12-byte header, a series of internal file pointers,
		and then a glob of files, each with its own individual 12-byte header. }
		TDynamicResourcePack = class
		private type
			{ Each subfile in the lump has a 12-byte header of its own. }
			TFileEntry = record
				{ After the header, the drp will provide num pointers to the beginnings of
				the files inside the lump. These pointers are 4 bytes each, little-endian
				(that is, with the byte order reversed from what the naive viewer will expect),
				and indicate an offset based on the beginning of the file. }
				offset: dword;
				{ a four-letter ASCII version of what appears to be the name of the file.
				If the chosen name is less than four characters long, it will be padded
				with 00 bytes. }
				name: string[4];
				{ the file type indicator }
				kind: TDRPFileType;
				{ a little-endian equal to 16 times the length of the file }
				size: dword;
				{ The data for the file begins immediately after the end of the header and
				runs until the header for the next file in the lump (that is, the address
				pointed to by the next pointer), or to the end of the drp if it is the last
				file. }
				buf: TMemoryStream;
			end;
		private var
			{ After the header, the drp will provide num pointers to the beginnings of
			the files inside the lump. These pointers are 4 bytes each, little-endian
			(that is, with the byte order reversed from what the naive viewer will expect),
			and indicate an offset based on the beginning of the file. }
			FFiles: array of TFileEntry;
		public
			constructor Create(AStream: TStream);
			destructor Destroy; override;
			procedure ExtractAll;
		end;
		
	function GetFileExt(ft: TDRPFileType): string;
	
implementation
	uses
		strutils;

	constructor TDynamicResourcePack.Create(AStream: TStream);
	var
		i, l: dword;
		s: array[0..2] of byte;
		id: string;
	begin
		AStream.seek(0, sofrombeginning);
		setlength(id, 4);
		AStream.readbuffer(id[1], 4);
		if id <> DRPMagic then
			raise EDRPRead.Create('File does not begin with DRPMagic ("drp")');
		AStream.seek(8, sofrombeginning);
		setlength(FFiles, AStream.readdword div 64);
		l := length(FFiles);
		AStream.seek(DRPHeaderSize, sofrombeginning);
		for i:=0 to l-1 do
			FFiles[i].offset := leton(AStream.readdword);
		for i:=0 to l-1 do
			with FFiles[i] do begin
				AStream.seek(4, sofromcurrent);
				setlength(name, 4);
				AStream.readbuffer(name[1], 4);
				kind := TDRPFileType(AStream.readbyte);
				AStream.readbuffer(s[0], 3);
				move(s, size, 3);
				size := leton(size) div 16;
				buf := TMemoryStream.Create;
				AStream.seek(offset+DRPHeaderSize, sofrombeginning);
				buf.copyfrom(AStream, size);
			end;
	end;
	
	destructor TDynamicResourcePack.Destroy;
	var
		i: dword;
	begin
		if FFiles <> nil then
			for i:=0 to length(FFiles)-1 do
				with FFiles[i] do begin
					buf.free;
					setlength(name, 0);
				end;
		setlength(FFiles, 0);
		inherited Destroy;
	end;
	
	procedure TDynamicResourcePack.ExtractAll;
	var
		f: TFileStream;
		i, l: dword;
	begin
		l := length(FFiles);
		for i:=0 to l-1 do
			with FFiles[i] do begin
				f := TFileStream.Create(trimrightset(name, [#0])+GetFileExt(kind), fmcreate);
				f.copyfrom(buf, 0);
				f.free;
			end;
	end;

	function GetFileExt(ft: TDRPFileType): string;
	begin
		case ft of
			ftDRP: result := '.drp';
			ftMesh: result := '.mesh';
			ftTIMInfo: result := '.timinfo';
			ftTIM: result := '.tim';
			ftMInst: result := '.minst';
			ftMDL: result := '.mdl';
			ftMSeq: result := '.mseq';
			ftAnim: result := '.anim';
			ftLZSS: result := '.lzss';
		else
			result := '.dat';
		end;
	end;
end.
