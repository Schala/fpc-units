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
			halfx: word;
			halfy: word;
			pixel_offsets: array of byte;
		end;
		
		PAlteredTIM = ^TAlteredTIM;
		TAlteredTIM = record
			objnum: dword;
			clut_offset: dword;
			image_offsets: array of dword;
			clut_length: dword;
			clut_x: word;
			clut_y: word;
			clut_colors: word;
			clut_palettes: word;
			rgbs: array of word;
			images: array of TImage;
		end;
implementation
end.
