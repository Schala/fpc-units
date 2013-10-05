{ The .TIM files used for battle model textures differ from the classic format. }
unit atim;
interface
	type
		PImage = ^TImage;
		TImage = record
			length: dword;
			x: word;
			y: word;
			colors: word;
			palettes: word;
			{ literally half the value of the image width }
			halfx: word;
			{ Curiously, unlike the width, the image height is reported literally. }
			halfy: word;
			{ Offsets into the CLUT. One byte (8 bits) is required for each pixel because
			the TIM header specifies 8 bits-per-pixel. }
			pixel_offsets: array of byte;
		end;
		
		PAlteredTIM = ^TAlteredTIM;
		{ Like the Classic TIM, the altered format ~TIMs consist of a HEADER, CLUT, and
		IMAGE data -- only the headers for each element are different. }
		TAlteredTIM = record
			{ Number of Objects in the file. The first object is the CLUT; all subsequent
			objects are texture ~IMAGEs. }
			objnum: dword;
			clut_offset: dword;
			image_offsets: array of dword;
			clut_length: dword;
			clut_x: word;
			clut_y: word;
			clut_colors: word;
			clut_palettes: word;
			{ RG BS are the red, green, blue, and special transparency values for each color
			in the CLUT. Note that these byte pairs are read as their constituent bits,
			so one nybble (half-byte) doesn't necessarily correspond to each color specification;
			one letter is used to represent each nybble for ease of labeling. For quick reference,
			the RG BS CLUT data in an Altered Format TIM typically occurs between addresses
			$1C and $21C.}
			rgbs: array of word;
			{ For quick reference, the image data in an Altered Format TIM usually follows
			address $22C }
			images: array of TImage;
		end;
implementation
end.
