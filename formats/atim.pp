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
		
		PImage = ^TImage;
		TImage = record
			header: PImageHeader;
			pixel_offsets: array of byte;
		end;
		
		PATIMHeader = ^TATIMHeader;
		TATIMHeader = record
			objnum: dword;
			clut_offset: dword;
		end;
		
		TAlteredTIM = class
		private
			FHeader: PATIMHeader;
			FImageOffsets: array of dword;
			FCLUTHeader: PCLUTHeader;
			FRGBS: array of word;
			FImages: array of PImage;
			FHandle: TFileStream;
		public:
			constructor Create(const filename: string);
			constructor Unpack(const buffer: array of byte);
			destructor Destroy; override;
			function Pack: array of byte;
		end;
implementation
end.
