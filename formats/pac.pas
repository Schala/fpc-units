unit pac;
interface
	type
		PFileMetadata = ^TFileMetadata;
		TFileMetadata = record
			offset: dword;
			filepath: string[32];
		end;
		
		PPACContainer = ^TPACContainer;
		TPACContainer = record
			files: dword;
			size: dword;
			metadata: array of TFileMetadata;
		end;
implementation
end.
