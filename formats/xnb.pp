unit xnb;
{$mode objfpc}{$H+}
interface
	uses
		Classes;
	type
		PXNBHeader = ^TXNBHeader;
		TXNBHeader = record
			id: array[0..2] of byte;
			target: byte; // w = Windows, m = Win Phone, x = Xbox 360
			version: byte; // 5 = XNA Game Studio 4.0
			flags: byte; // $01 = HiDef profile content, $80 = compressed
 			csize: dword; // total compressed size including header
 			dsize: word; // decompressed size, not including header
		end;
		
		PTypeReaderEntry = ^TTypeReaderEntry;
		TTypeReaderEntry = record
			name: string;
			version: longint;
		end;
		
		PSharedResource = ^TSharedResource;
		TSharedResource = record
			shared_res: pointer;
			data: array of byte;
		end;
	
		TXNBContainer = class
		private
			FHeader: PXNBHeader;
			FTypeReaderCount: longint;
			FTypeReaderEntries: array of PTypeReaderEntry;
			FSharedResCount: longint;
			FSharedResources: array of PSharedResource;
			FHandle: TFileStream;
		public
			constructor Create(const filename: string);
			destructor Destroy; override;
			function Read7BitEncodedInt: longint;
		end;
implementation
	function TXNBContainer.Read7BitEncodedInt: longint;
	var
		bits_read: longint = 0;
		value: longint;
	begin
		result := 0;
		repeat
			value := FHandle.ReadByte;
			result := result or (value and $7F) shl bits_read;
		until (value and $80) = 0;
	end;
end.
