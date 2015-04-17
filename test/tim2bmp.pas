{$mode objfpc}{$h+}
{$apptype console}
{$unitpath ../fcl-image}
program tim2bmp;

uses FPReadTIM, FPImage, classes, FPWriteBMP, sysutils;

var
	img: TFPMemoryImage;
	r: TFPCustomImageReader;
	w: TFPCustomImageWriter;
	rf, wf: string;
begin
	if paramcount <> 2 then
	begin
		writeln('tim2bmp [source] [dest]');
		exit;
	end;
	
	try
		r := TFPReaderTIM.Create;
		w := tfpwriterbmp.create;
		tfpwriterbmp(w).bitsperpixel := 32;
		img := TFPMemoryImage.create(0,0);
		rf := paramstr(1);
		wf := paramstr(2);
		
		img.loadfromfile(rf, r);
		img.savetofile(wf, w);
		r.free;
		w.free;
		img.free;
	except
		on e: exception do
			writeln('error: ', e.message);
	end;
{$ifopt d+}
	with timinfo do
	begin
		writeln('Magic: ', hexstr(magic, 8));
		writeln('CLUT size: ', clutsize);
		writeln('Has CLUT: ', hasclut);
		writeln('Bits per pixel: ', bpp);
		writeln('Colors: ', colors);
		writeln('Palettes: ', npals);
		writeln('Image size: ', imgsize);
		writeln('Width: ', imgw);
		writeln('Height: ', imgh);
	end;
{$endif}
end.
