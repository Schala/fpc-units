{ A cpt file is a container used for other files. Unlike the drp format, it doesn't
give any information about what those files are, leaving us to guess. }
unit cpt;
{$modeswitch result}
interface
	const
		F_NoEOFPtr = 1;
	
	type
		PCPTContainer = ^TCPTContainer;
		{ A cpt begins with a four-byte little-endian giving the number of subfiles it
		contains, followed by a series of four-byte pointers indicating the beginning of
		each subfile relative to the beginning of the cpt. A true cpt has an end-of-file
		pointer as well, but the Chrono Cross CDs also include variations on the format
		which lack one. After that, the files are packed in one after the other. }
		TCPTContainer = record
			files: dword;
			offsets: pdword;
			flags: byte;
			eofpos: dword;
			bufs: ppointer;
		end;
	
	function NewCPT: PCPTContainer;
	procedure AddToCPT(var p: TCPTContainer; const filename: string);
	function PackCPT(const p: TCPTContainer, const name: string): file;
	function UnpackCPT(const buf: pointer): PCPTContainer;
implementation
	uses
		sysutils;
	
	function NewCPT: PCPTContainer;
	begin
		new(result);
		with result^ do begin
			files := 0;
			offsets := nil;
			bufs := nil;
		end;
	end;
	
	procedure AddToCPT(var p: TCPTContainer; const filename: string);
	var
		f: file;
	begin
		if fileexists(filepath) then begin
			assign(f, filename);
			reset(f, 1);
			inc(p.files);
			if p.files = 1 then begin
				p.offsets := getmem(sizeof(dword));
				p.offsets[0] := 4;
				p.bufs := getmem(sizeof(pointer));
				p.bufs[0] := getmem(filesize(f));
				blockread(f, p.bufs[0,0], filesize(f));
			else begin
				p.offsets := reallocmem(p.offsets, sizeof(dword) * p.files);
				p.offsets[p.files-1] := 4 + (p.files * 4);
				p.bufs := reallocmem(p.bufs, sizeof(pointer) * p.files);
				p.bufs[p.files-1] := getmem(filesize(f));
				blockread(f, p.bufs[p.files-1, 0], filesize(f));
			end;
			close(f);
	end;
	
	function PackCPT(const p: TCPTContainer, const name: string): file;
	var
		x, y: dword;
	begin
		assign(result, name);
		rewrite(
	end;
end.
