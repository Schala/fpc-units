unit kdx;
{$modeswitch result}
interface
	function Encrypt(key: dword; const data: pbyte; datasize: dword): dword;
implementation
	function Encrypt(key: dword; const data: pbyte; datasize: dword): dword;
	var
		data32: pdword;
		i: word;
	begin
		datasize := datasize shr 2;
		data32 := pdword(data);
		for i to datasize do begin
			key := (key shl 1) + $4878;
			data32[i] := data32 xor ntobe(key);
		end;
		result := key;
	end;
end.
