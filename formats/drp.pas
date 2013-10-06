{ The drp file, which begins with the ASCII letters "drp" and almost always
contains visual or audio resources. }
unit drp;
interface
	const
		{ The first three bytes spell out "drp" in ASCII. }
		MAGIC = 'drp';
		{ nested drp file }
		T_DRP = 1;
		{ generic mesh }
		T_MESH = 2;
		{ information about slicing, mirroring, etc., in tim textures }
		T_TIMINFO = 3;
		{ any except battle anims }
		T_TIM = 4;
		{ music instruments }
		T_MINST = 5;
		{ Type 7 is potentially a problem. It's used only a handful of times, but in
		an entirely inconsistent manner: two files marked as type 7 are recognizably
		tbt lumps, one is a TIM texture (despite ~TIMs having their own code) and the
		other 16 are inscrutable—one may be an executable. So the only way to tell
		what's actually in a type 7 file is to open it and check. }
		T_07 = 7;
		{ Probably relates to graphics somehow. }
		T_0A = 10;
		{ model pack }
		T_MDL = 11;
		{ Probably relates to graphics somehow. }
		T_0C = 12;
		{ May relate to meshes. }
		T_10 = 16;
		T_12 = 18;
		{ model for lens light effects? }
		T_15 = 21;
		{ music sequence }
		T_MSEQ = 22;
		{ model animation (cpt pack) }
		T_ANIM = 25;
		{ Associated with things that cause damage, e.g. attack animations,
		offensive Elements. }
		T_1A = 26;
		{ LZSS compressed data }
		T_LZSS = 37;
	
	type
		PFileEntry = ^TFileEntry;
		{ Each subfile in the lump has a 12-byte header of its own. }
		TFileEntry = record
			{ a four-letter ASCII version of what appears to be the name of the file.
			If the chosen name is less than four characters long, it will be padded
			with 00 bytes. }
			name: string[4];
			{ the file type indicator }
			kind: byte;
			{ a little-endian equal to 16 times the length of the file }
			size: dword;
			{ The data for the file begins immediately after the end of the header and
			runs until the header for the next file in the lump (that is, the address
			pointed to by the next pointer), or to the end of the drp if it is the last
			file. }
			buffer: pointer;
		end;
		
		PDynamicResourcePack = ^TDynamicResourcePack;
		{ A drp file contains a 12-byte header, a series of internal file pointers,
		and then a glob of files, each with its own individual 12-byte header. }
		TDynamicResourcePack = record
			{ The first three bytes spell out "drp" in ASCII. }
			id: string[3];
			{ indicate the number of entries in the file, although unfortunately, not
			in an entirely straightforward manner (even when endianness is taken into
			consideration)—to get the number, perform the calculation yyxx / 64 }
			files: dword;
			{ After the header, the drp will provide num pointers to the beginnings of
			the files inside the lump. These pointers are 4 bytes each, little-endian
			(that is, with the byte order reversed from what the naive viewer will expect),
			and indicate an offset based on the beginning of the file. }
			entries: PFileEntry;
		end;
		
	function GetFileExt(ft: byte): string;
implementation
	function GetFileExt(ft: byte): string;
	begin
		case ft of
			T_DRP: GetFileExt := '.drp';
			T_MESH: GetFileExt := '.mesh';
			T_TIMINFO: GetFileExt := '.timinfo';
			T_TIM: GetFileExt := '.tim';
			T_MINST: GetFileExt := '.minst';
			T_MDL: GetFileExt := '.mdl';
			T_MSEQ: GetFileExt := '.mseq';
			T_ANIM: GetFileExt := '.anim';
			T_LZSS: GetFileExt := '.lzss';
		else
			GetFileExt := '.out';
		end;
	end;
end.
