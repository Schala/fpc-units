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
		
		PFileEntry = ^TFileEntry;
		TFileEntry = record
			offset: dword;
			filepath: string[32];
		end;
		
		TPACContainer = class
		private
			FMetadata: PMetadata;
			FFileEntries: array of PFileEntry;
			FFileBuffers: array of array of byte;
			FHandle: TFileStream;
		public
			constructor Create(const filename: string);
			constructor Unpack(const buffer: array of byte);
			destructor Destroy; override;
			procedure Add(const filename: string);
			function Pack: array of byte;
		end;
implementation
end.
