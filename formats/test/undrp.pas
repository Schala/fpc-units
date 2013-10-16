program undrp;
{$mode objfpc}{$H+}
uses
	classes, drp;
var
	f: tfilestream;
	d: tdynamicresourcepack;
begin
	f := tfilestream.create(paramstr(1), fmopenread);
	d := tdynamicresourcepack.create(f);
	f.free;
	d.extractall;
	d.free;
end.
