{ The .TIM files used for battle model textures differ from the classic format. }
unit atim;
{$mode objfpc}{$H+}
interface
	type
		{ Like the Classic TIM, the altered format ~TIMs consist of a HEADER, CLUT, and
		IMAGE data -- only the headers for each element are different. }
		TAlteredTIM = class
		private type
			TImage = record;
				offset: dword;
				length: dword;
				width: word;
				height: word;
				colors: word;
				palettes: word;
				{ literally half the value of the image width }
				halfwidth: word;
				{ Curiously, unlike the width, the image height is reported literally. }
				halfheight: word;
				{ Offsets into the CLUT. One byte (8 bits) is required for each pixel because
				the TIM header specifies 8 bits-per-pixel. }
				pixel_offsets: array of byte;
			end;
		private var
			FCLUTOffset: dword;
			{ For quick reference, the image data in an Altered Format TIM usually follows
			address $22C }
			FImages: array of TImage;
			FCLUTLength: dword;
			FCLUTWidth: word;
			FCLUTHeight: word;
			FCLUTColors: word;
			FCLUTPalettes: word;
			{ RG BS are the red, green, blue, and special transparency values for each color
			in the CLUT. Note that these byte pairs are read as their constituent bits,
			so one nybble (half-byte) doesn't necessarily correspond to each color specification;
			one letter is used to represent each nybble for ease of labeling. For quick reference,
			the RG BS CLUT data in an Altered Format TIM typically occurs between addresses
			$1C and $21C.}
			FRgbs: array of word;
		public
			property CLUTOffset: dword read FCLUTOffset;
			property CLUTLength: dword read FCLUTLength;
			property CLUTWidth: word read FCLUTWidth;
			property CLUTHeight: word read FCLUTHeight;
			property CLUTColors: word read FCLUTColors;
			property CLUTPalettes: word read FCLUTPalettes;
		end;
implementation
end.
