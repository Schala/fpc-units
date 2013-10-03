unit atim;
{$mode objfpc}{$H+}
interface
	uses
		Classes;
	type
		PCLUTHeader = ^TCLUTHeader;
		TCLUTHeader = record
			length: dword;
			width: word;
			height: word;
			palette_colors: word;
			palette_num: word;
		end;
		
		PImageHeader = ^TImageHeader;
		TImageHeader = record
			length: dword;
			width: word;
			height: word;
			palette_colors: word;
			palette_num: word;
			halfwidth: word;
			halfheight: word;
		end;
		
		PPImage = ^PImage;
		PImage = ^TImage;
		TImage = record
			header: PImageHeader;
			pixel_offsets: pbyte;
		end;
		
		PATIMHeader = ^TATIMHeader;
		TATIMHeader = record
			objnum: dword;
			clut_offset: dword;
		end;
		
		TAlteredTIM = class
		private
			FHeader: PATIMHeader;
			FImageOffsets: pdword;
			FCLUTHeader: PCLUTHeader;
			FRGBS: pword;
			FImages: PPImage;
			FHandle: TFileStream;
		public:
			constructor Create(const filename: string);
			constructor Unpack(const buffer: pointer);
			destructor Destroy; override;
			function Pack: pointer;
		end;
implementation
end.
