{$mode objfpc}{$h+}

unit FPReadTIM;

interface
	uses classes, fpimage;
	
	type
		TFPReaderTIM = class (TFPCustomImageReader)
		protected
			procedure InternalRead(Stream: TStream; Img: TFPCustomImage); override;
			function InternalCheck(Stream: TStream): boolean; override;
		public
			constructor Create; override;
			destructor Destroy; override;
		end;
{$ifopt d+}
		TTIMInfo = record
			magic, clutsize, imgsize: dword;
			colors, npals, imgw, imgh: word;
			bpp: byte;
			hasclut: boolean;
		end;
	
	var
		timinfo: TTIMInfo;
{$endif}
	
	function RGBA5551ToFPColor(RGBA: word): TFPColor;
	function RGBA5551ToDWord(RGBA: word): dword;

implementation
	function Scale5To8(c: byte): byte;
	begin
		result := (c shl 3) or (c shr 2);
	end;

	constructor TFPReaderTIM.Create;
	begin
		inherited create;
	end;
	
	destructor TFPReaderTIM.Destroy;
	begin
		inherited destroy;
	end;

	function RGBA5551ToFPColor(RGBA: word): TFPColor;
	begin
		RGBA := leton(RGBA);
		with result do
		begin
			red := swap(word(Scale5To8(RGBA and $1f)));
			green := swap(word(Scale5To8((RGBA shr 5) and $1f)));
			blue := swap(word(Scale5To8((RGBA shr 10) and $1f)));
			alpha := swap(word(not Scale5To8((RGBA shr 15) and $1f)));
		end;
	end;
	
	function RGBA5551ToDWord(RGBA: word): dword;
	var
		a, r, g, b: byte;
	begin
		RGBA := leton(RGBA);
		r := Scale5To8(RGBA and $1f);
		g := Scale5To8((RGBA shr 5) and $1f);
		b := Scale5To8((RGBA shr 10) and $1f);
		a := not Scale5To8((RGBA shr 15) and $1f);
		
		result := swap(word((a shl 24) or (r shl 16) or (g shl 8) or b));
	end;
	
	function TFPReaderTIM.InternalCheck(Stream: TStream): boolean;
	var
		magic: dword;
	begin
		magic := leton(Stream.readdword);
		result := (magic = $10);
{$ifopt d+}
		timinfo.magic := magic;
{$endif}
	end;
	
	procedure TFPReaderTIM.InternalRead(Stream: TStream; Img: TFPCustomImage);
	var
		flags, clutsize, imgsize: dword;
		colors, npals, i, w, h, x, y: word;
		hasCLUT: boolean;
		bpp, p: byte;
	begin
		flags := leton(Stream.readdword);
		hasCLUT := (flags and $8) <> 0;
		if (flags and $7) > 0 then bpp := (flags and $7)*8 else bpp := 4;
		
		if hasCLUT then
		begin
			clutsize := leton(Stream.readdword)-12;
			Stream.seek(4, socurrent);
			colors := leton(Stream.readword);
			npals := leton(Stream.readword);
			
			Img.usepalette := true;
			Img.palette.clear;
			
			for i := 0 to colors*npals-1 do
				Img.palette.add(RGBA5551ToFPColor(leton(Stream.readword)));
		end;
		
		imgsize := leton(Stream.readdword)-12;
		Stream.seek(4, socurrent);
		
		w := (leton(Stream.readword)*16) div bpp;
		
		h := leton(Stream.readword);
		Img.setsize(w, h);
		
		x := 0;
		y := 0;
		while y < h do
		begin
			while x < w do
			begin
				case bpp of
				4:
					begin
						p := Stream.readbyte;
						Img.pixels[x,y] := p and $f0;
						inc(x);
						Img.pixels[x,y] := p and $f;
					end;
				8: Img.pixels[x,y] := Stream.readbyte;
				16: Img.pixels[x,y] := RGBA5551ToDWord(leton(Stream.readword));
				else
				end;
				
				inc(x);
			end;
			x := 0;
			inc(y);
		end;
{$ifopt d+}
		timinfo.clutsize := clutsize;
		timinfo.imgsize := imgsize;
		timinfo.colors := colors;
		timinfo.npals := npals;
		timinfo.imgw := w;
		timinfo.imgh := h;
		timinfo.bpp := bpp;
		timinfo.hasclut := hasCLUT;
{$endif}
	end;

end.
