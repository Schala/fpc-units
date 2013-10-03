unit pac;
{$mode objfpc}{$H+}
interface
	uses
		Classes;
	type
		PMetadata = ^TMetadata;
		TMetadata = record
			file_num: dword
			size: dword;
		end;
		
		PPFileEntry = ^PFileEntry;
		PFileEntry = ^TFileEntry;
		TFileEntry = record
			offset: dword;
			filepath: string[32];
		end;
		
		TPACContainer = class
		private
			FMetadata: PMetadata;
			FFileEntries:  PPFileEntry;
			FFileBuffers: ppointer;
			FHandle: TFileStream;
		public
			constructor Create(const filename: string);
			constructor Unpack(const buffer: pointer);
			destructor Destroy; override;
			procedure Add(const filename: string);
			function Pack: pointer;
		end;
implementation
end.
