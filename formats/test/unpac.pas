program unpac;
{$mode objfpc}{$H+}
	uses classes, pac;
var
	f: tfilestream;
	p: tpaccontainer;
begin
	f := tfilestream.create(paramstr(1), fmopenread);
	p := tpaccontainer.create(f);
	f.free;
	p.extractall;
	p.free;
end.
