program ipsext;
{$mode objfpc}{$H+}
uses
	classes, ips, sysutils;
var
	f: tfilestream;
	i: tipspatch;
begin
	f := tfilestream.create(paramstr(1), fmopenread);
	i := tipspatch.create(f);
	f.free;
	mkdir(paramstr(1)+'-dump');
	chdir(paramstr(1)+'-dump');
	i.extractall;
	i.free;
end.
