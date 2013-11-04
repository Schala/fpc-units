unit hotline;
{$mode objfpc}{$H+}
{$modeswitch advancedrecords}
interface
	uses
		classes, fgl;

	const
		{ $54525450 }
		HLProtocolID = 'TRTP';
		HLSubProtocolID = 'HOTL';
		HLTrackerMagic = 'HTRK';
		{ $48545846 }
		HLFileXferProtocolID = 'HTXF';
		HLFileResumeMagic = 'RFLT';
		HLForkMagic = 'DATA';
		HLNewsArticleMIME = 'text/plain';
		{ $46494C50 }
		HLFlatFileMagic = 'FILP';
		{ $494E464F }
		HLFlatFileForkMagic = 'INFO';
		HLOSMac = 'AMAC';
		HLOSWin = 'MWIN';
		L_URL = 'URL ';
		L_JPEG = 'JPEG';
		L_BMP = 'BMP ';
		L_GIF = 'GIFf';
		L_PICT = 'PICT';
		{ Currently 1 }
		HLProtocolVersion = 1;
		HLProtocolSubVersion = 2;
	
	type
	{$I enums.inc}
	{$I binary_types.inc}
	
		PHLTransactionParam = ^THLTransactionParam;
		THLTransactionParam = record
			id: dword;
			data: TMemoryStream;
		end;
		THLParameterList = specialize TFPGList<THLTransactionParam>;
		
		{ After the initial handshake, client and server communicate over the
		connection by sending and receiving transactions. Every transaction contains
		description (request) and/or status (reply) of the operation that is performed,
		and parameters used for that specific operation. }
		THLTransaction = class
		private
			FFlags: byte;
			FIsReply: boolean;
			FKind: word;
			FId: dword;
			FErrorCode: dword;
			FTotalSize: dword;
			FDataSize: dword;
			FParams: THLParameterList;
			FStream: TStream;
		public
			constructor CreateRequest(AKind: word; AId: dword; AStream: TStream);
			constructor CreateReply(AKind: word; AId: dword; AErr: dword; AStream: TStream);
			destructor Destroy; override;
			procedure Add(constref param: THLTransactionParam);
			function GetParam(i: integer): PHLTransactionParam;
			{ Reserved (should be 0) }
			property Flags: byte read FFlags;
			{ Request (false) or reply (true) }
			property IsReply: boolean read FIsReply;
			{ Requested operation (user defined) }
			property Kind: word read FKind;
			{ Unique transaction ID (must be <> 0) }
			property ID: dword read FId;
			{ Used in the reply (user defined, 0 = no error) }
			property ErrorCode: dword read FErrorCode;
			{ Total data size for the transaction (all parts) }
			property TotalSize: dword read FTotalSize;
			{ Size of data in this transaction part. This allows splitting large
			transactions into smaller parts. }
			property DataSize: dword read FDataSize;
			property Parameter[i: integer]: PHLTransactionParam read GetParam;
		end;
implementation
	constructor THLTransaction.CreateRequest(AKind: word; AId: dword; AStream: TStream);
	begin
		FFlags := 0;
		FIsReply := false;
		FKind := AKind;
		FId := AId;
		FErrorCode := 0;
		FTotalSize := 22;
		FDataSize := 2;
		FParams := nil;
		FStream := AStream;
	end;
	
	constructor THLTransaction.CreateReply(AKind: word; AId: dword; AErr: dword = 0; AStream: TStream);
	begin
		FFlags := 0;
		FIsReply := true;
		FKind := AKind;
		FId := AId;
		FErrorCode := AErr;
		FTotalSize := 22;
		FDataSize := 2;
		FParams := nil;
		FStream := AStream;
	end;
	
	destructor THLTransaction.Destroy;
	var
		i: integer;
	begin
		if FParams <> nil then begin
			for i := 0 to FParams.size-1 do begin
				if FParams.items[i].data <> nil then
					freemem(FParams.items[i].data);
			end;
			FParams.free;
		end;
	end;
	
	procedure THLTransaction.Add(constref param: THLTransactionParam);
	begin
		if FParams = nil then
			FParams := THLParameterList.Create;
		FParams.add(param);
		inc(FTotalSize, 8 + param.size);
		inc(FDataSize, 8 + param.size);
	end;
	
	function THLTransaction.GetParam(i: integer): PHLTransactionParam;
	begin
		result := FParams.items[i];
	end;
end.
