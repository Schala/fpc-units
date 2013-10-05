unit drp;
interface
	const
		MAGIC = 'drp';
		T_DRP = 1;
		T_MESH = 2;
		T_TIMINFO = 3;
		T_TIM = 4;
		T_MINST = 5;
		T_07 = 7;
		T_0A = 10;
		T_MDL = 11;
		T_0C = 12;
		T_10 = 16;
		T_12 = 18;
		T_15 = 21;
		T_MSEQ = 22;
		T_ANIM = 25;
		T_1A = 26;
		T_LZSS = 37;
	
	type
		PFileEntry = ^TFileEntry;
		TFileEntry = record
			name: string[4];
			kind: byte;
			size: dword;
			buffer: pointer;
		end;
		
		PDynamicResourcePack = ^TDynamicResourcePack;
		TDynamicResourcePack = record
			id: string[3];
			files: dword;
			entries: array of TFileEntry;
		end;
		
	function GetFileExt(ft: byte): string;
implementation
end.
