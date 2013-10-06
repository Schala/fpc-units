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
			metadata: PFileMetadata;
		end;
implementation
end.
