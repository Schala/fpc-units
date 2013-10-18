unit myutils;
{$modeswitch result}
interface
	function BEtoN(const AValue: single): single;
	function BEtoN(const AValue: double): double;
	function LEtoN(const AValue: single): single;
	function LEtoN(const AValue: double): double;
	function NtoBE(const AValue: single): single;
	function NtoBE(const AValue: double): double;
	function NtoLE(const AValue: single): single;
	function NtoLE(const AValue: double): double;

implementation
	type
		usingle = record
		case boolean of
			false: (valf: single);
			true: (vali: dword);
		end;
		
		udouble = record
		case boolean of
			false: (valf: double);
			true: (vali: qword);
		end;
	
	function BEtoN(const AValue: single): single;
	var
		u: usingle;
	begin
		u.valf := AValue;
		u.vali := system.beton(u.vali);
		result := u.valf;
	end;
	
	function BEtoN(const AValue: double): double;
	var
		u: udouble;
	begin
		u.valf := AValue;
		u.vali := system.beton(u.vali);
		result := u.valf;
	end;
	
	function LEtoN(const AValue: single): single;
	var
		u: usingle;
	begin
		u.valf := AValue;
		u.vali := system.leton(u.vali);
		result := u.valf;
	end;
	
	function LEtoN(const AValue: double): double;
	var
		u: udouble;
	begin
		u.valf := AValue;
		u.vali := system.leton(u.vali);
		result := u.valf;
	end;
	
	function NtoBE(const AValue: single): single;
	var
		u: usingle;
	begin
		u.valf := AValue;
		u.vali := system.ntobe(u.vali);
		result := u.valf;
	end;
	
	function NtoBE(const AValue: double): double;
	var
		u: udouble;
	begin
		u.valf := AValue;
		u.vali := system.ntobe(u.vali);
		result := u.valf;
	end;
	
	function NtoLE(const AValue: single): single;
	var
		u: usingle;
	begin
		u.valf := AValue;
		u.vali := system.ntole(u.vali);
		result := u.valf;
	end;
	
	function NtoLE(const AValue: double): double;
	var
		u: udouble;
	begin
		u.valf := AValue;
		u.vali := system.ntole(u.vali);
		result := u.valf;
	end;

end.
