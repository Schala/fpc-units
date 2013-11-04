unit wired;
{$mode objfpc}{$H+}
{$modeswitch advancedrecords}
interface
	const
		{ <US-ASCII EOT, end of transmission (4)> }
		EOT = #4;
		{ <US-ASCII FS, file separator (28)> }
		FS = #28;
		{ <US-ASCII GS, group separator (29)> }
		GS = #29;
		{ <US-ASCII US, record separator (30)> }
		RS = #30;
		{ <US-ASCII SP, space (32)> }
		SP = #32;
		{ The protocol version string uses a fixed format }
		WiProtocolVersion = '1.1';
	type
		{$I types.inc}

implementation
end.
