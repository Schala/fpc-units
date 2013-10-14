program pacmake;
{$mode objfpc}{$H+}
	uses classes, pac;
var
	f: tfilestream;
	m: tmemorystream;
	p: tpaccontainer;
	i: integer;
begin
	p := tpaccontainer.create;
	for i:=1 to paramcount do
		p.add(paramstr(i));
	m := p.pack;
	f := tfilestream.create(paramstr(1)+'.pac', fmcreate);
	f.copyfrom(m, 0);
	m.free;
	f.free;
end.
