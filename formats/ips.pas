unit ips;
{$mode objfpc}{$H+}
interface
	uses
		Classes;
	
	const
		MAGIC = 'PATCH';
		EOF = 'EOF';
	
	type
		TIPSPatch = class
		private
			FOffset: dword;
			FSize: word;
			FRleSize: word;
			FData: pointer;
			FValue: byte;
			FHandle: TFileStream;
			procedure SetData(buf: pointer);
		public:
			constructor Create(const filename: string);
			destructor Destroy; override;
			property Offset: dword read FOffset write FOffset;
			property Size: word read FSize;
			property RLESize: word read FRleSize;
			property Data: pointer read FData write SetData;
		end;
implementation
end.
