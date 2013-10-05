{ IPS format was created a lot of time ago and so the specs for many people are
too restrictive for the modern needs. Well, let see these specs.

	* IPS files can patch every file not larger than 2^24-1 bits (2047 Mb)
	* Every patch should not be larger than 2^16-1 bits (7.99 Mb)
	* An IPS file can hold as many patches he can, assumed that the specified offset
	and the size of every single patch doesn't overflow the specified bounds. }
unit ips;
interface
	const
		{ The header show ever the same string: PATCH note that the string is not
		NULL terminated. }
		MAGIC = 'PATCH';
		{ A string (not NULL terminated) saying EOF }
		EOFMARKER = 'EOF';
	
	type
		PIPSPatch = ^TIPSPatch;
		{ It's the record of a single patch }
		TIPSPatch = record
			{ The header show ever the same string: PATCH note that the string is not
			NULL terminated. }
			id: string[5];
			{ The offset where the patch will be placed in the file to patch }
			offset: dword;
			{ The size of the data to put from the specified offset in the patching file.
			If when you read the size value of a record this field contains 0 you have a
			RLE encoded patch. }
			size: word;
			rlesize: word;
			{ Contains a number of Size bytes of data to be copied in the file to patch }
			data: pointer;
			{ This is the value to write RLESize times starting from Offset }
			value: byte;
			{ A string (not NULL terminated) saying EOF }
			eof_pos: string[3];
		end;
implementation
end.
