{ A cpt file is a container used for other files. Unlike the drp format, it doesn't
give any information about what those files are, leaving us to guess. }
unit cpt;
interface
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
			eofpos: dword;
			bufs: ppointer;
		end;
implementation
end.
