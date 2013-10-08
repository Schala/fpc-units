{ A TIM file is a standard image file format for the Sony ~PlayStation. The file
structure closely mimics the way textures are managed in the frame buffer by the GPU.
TIM files are little endian-based. }
unit tim;
interface
	const
		{ The header starts with a 'tag' byte; this value is constant for all TIM files
		and must be $10. }
		TIMMagic = $10;
		{ denotes the version of the file format. At present, only version '0' TIM files
		are known to exist. }
		TIMVersion = 0;
		{ 4-bit (color indices) }
		BPP4 = $08;
		{ 8-bit (color indices) }
		BPP8 = $09;
		{ 16-bit (actual colors) }
		BPP16 = $02;
	
	type
		PTIMImage = ^TTIMImage;
		{ A TIM file is made up of three conceptual blocks; the header, the color
		lookup table (CLUT) and the image data. The CLUT block and the image data block
		have the same basic layout and are also treated the same way when loading a TIM
		file into the ~PlayStation frame buffer. Also, the CLUT block is optional and
		technically does not need to be present, even when the image data consists of
		color indices. Such image data is assumed to refer to some color lookup table,
		but not necessarily one stored in the same TIM file. In almost all cases though,
		the CLUT is included in the same TIM file as the image data using it and can thus
		be assumed to be applicable. }
		TTIMImage = record
			{ The header starts with a 'tag' byte; this value is constant for all TIM files
			and must be $10. }
			id: byte;
			{ denotes the version of the file format. At present, only version '0' TIM files
			are known to exist. }
			version: byte;
			{ contains specific flags denoting the basic properties of the TIM file. The BPP
			(Bits Per Pixel) value denotes the bit depth of the image data, The CLP (Color Lookup
			table Present) flag simply denotes whether the CLUT block is present in the TIM file.
			This flag is typically set when BPP is 00 or 01, and cleared otherwise. }
			flags: dword;
			{ the length, in bytes, of the entire CLUT block (including the header) The length
			of the CLUT data is always width × height × 2 bytes, precisely the amount of
			data needed to fill a rectangular area of width × height pixels in the frame buffer. }
			clut_size: dword;
			{ the x coordinate of the CLUT needs to be an even multiple of 16 }
			clutx: word;
			{ the y coordinate can be any value between 0-511 }
			cluty: word;
			clut_colors: word;
			clut_palettes: word;
			{ the length, in bytes, of the entire image block }
			img_size: dword;
			imgx: word;
			imgy: word;
			img_colors: word;
			img_palettes: word;
		end;
implementation
end.
