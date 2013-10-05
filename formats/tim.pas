unit tim;
interface
	const
		MAGIC = $10;
		TIM_VERSION = 0;
		BPP4 = $08;
		BPP8 = $09;
		BPP16 = $02;
	
	type
		PTIMImage = ^TTIMImage;
		TTIMImage = record
			id: byte;
			version: byte;
			flags: dword;
			clut_size: dword
			clutx: word;
			cluty: word;
			clut_colors: word;
			clut_palettes: word;
			img_size: dword;
			imgx: word;
			imgy: word;
			img_colors: word;
			img_palettes: word;
		end;
implementation
end.
