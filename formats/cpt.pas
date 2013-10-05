unit cpt;
interface
	type
		PCPTContainer = ^TCPTContainer;
		TCPTContainer = record
			files: dword;
			offsets: array of dword;
			eofpos: dword;
			bufs: array of pointer;
		end;
implementation
end.
