unit cpt;
{$mode objfpc}{$H+}
interface
	uses
		Classes;

	type
		PPFileEntry = ^PFileEntry;
		PFileEntry = ^TFileEntry
		TFileEntry = record
			offset: dword;
			path: string;
			buffer: pointer;
		end;
		
		TCPTContainer = class
		private
			FFileNum: dword;
			FEof: dword;
			FFiles: PPFileEntry;
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
