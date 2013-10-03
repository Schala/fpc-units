unit blp;
{$mode objfpc}{$H+}
interface
	uses
		Classes;
		
	const
		IDV0 = 'BLP0';
		IDV1 = 'BLP1';
		IDV2 = 'BLP2';
	
	type
		PBLP1Header = ^TBLP1Header;
		TBLP1Header = record
			compression: dword;
			flags: dword;
			width: dword;
			height: dword;
			image_type: dword;
			image_subtype: dword;
		end;
		
		PBLP2Header = ^TBLP2Header;
		TBLP2Header = record
			compression: dword;
			encoding: byte;
			alpha_depth: byte;
			alpha_encoding: byte;
			has_mips: boolean;
			width: dword;
			height: dword;
		end;
		
		PBLPJpeg = ^TBLPJpeg;
		TBLPJpeg = record
			header_length: dword;
			header: pbyte;
			mipmap: array[0..15] of pbyte;
		end;
		
		PMipmapEntry = ^TMipmapEntry;
		TMipmapEntry = record
			indexes: pbyte;
			alphas: pbyte;
		end;
		
		PIndexAlpha = ^TIndexAlpha;
		TIndexAlpha = record
			palette: array[0..255] of pbyte;
			mipmap: array[0..15] of PMipmapEntry;
		end;
		
		TBLPImage = class
		private
			FId: string[4];
			FHeader1: PBLP1Header;
			FHeader2: PBLP2Header;
			FJpeg: PBLPJpeg;
			FIndexAlpha: PIndexAlpha;
			FHandle: TFileStream;
		public
			constructor Create(const filename: string);
			constructor Unpack(const buffer: pointer);
			destructor Destroy; override;
			function Pack: pointer;
		end;
implementation
end.
