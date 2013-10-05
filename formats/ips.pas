unit ips;
interface
	const
		MAGIC = 'PATCH';
		EOFMARKER = 'EOF';
	
	type
		PIPSPatch = ^TIPSPatch;
		TIPSPatch = record
			id: string[5];
			offset: dword;
			size: word;
			rlesize: word;
		case boolean of
			false: (data: pointer);
			true: (value: byte);
		end;
implementation
end.
