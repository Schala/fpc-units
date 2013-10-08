unit hotline;
{$mode objfpc}{$H+}
interface
	const
		{ $54525450 }
		ProtocolID = 'TRTP';
		SubProtocolID = 'HOTL';
		TrackerMagic = 'HTRK';
		{ $48545846 }
		FileXferProtocolID = 'HTXF';
		FileResumeMagic = 'RFLT';
		ForkMagic = 'DATA';
		{ Currently 1 }
		ProtocolVersion = 1;
		ProtocolSubVersion = 2;
	{$I transaction_type.inc}
	{$I transaction_id.inc}
	{$I permissions.inc}
	
	type
		{$I binary_data.inc}
		{$I transaction_data.inc}
		
		PHLTransactionParam = ^THLTransactionParam;
		THLTransactionParam = record
			id: longword;
			{ Size of the data part }
			size: longword;
		case type_id of
			T_Error: ();
			T_GetMsgs, T_NewMsg, T_OldPostNews:
				(data: string);
			T_ServerMsg: (server_msg: THLServerMessage);
			T_SendChat: (send_chat: THLSendChat);
			T_ChatMsg: (chat_msg: THLChatMessage);
			T_Login: (login: THLLogin);
		end;
		
		{ After the initial handshake, client and server communicate over the
		connection by sending and receiving transactions. Every transaction contains
		description (request) and/or status (reply) of the operation that is performed,
		and parameters used for that specific operation. }
		THLTransaction = class
		private
			FFlags: byte;
			FIsReply: boolean;
			FKind: word;
			FId: longword;
			FErrorCode: longword;
			FTotalSize: longword;
			FDataSize: longword;
			FParamNum: word;
			FParams: PHLTransactionParam;
		public
			constructor Create(AReply: boolean; AKind: word; AId: longword;
			{ Reserved (should be 0) }
			property Flags: byte read FFlags;
			{ Request (false) or reply (true) }
			property IsReply: boolean read FIsReply;
			{ Requested operation (user defined) }
			property Kind: word read FKind;
			{ Unique transaction ID (must be <> 0) }
			property ID: longword read FId;
			{ Used in the reply (user defined, 0 = no error) }
			property ErrorCode: longword read FErrorCode;
			{ Total data size for the transaction (all parts) }
			property TotalSize: longword read FTotalSize;
			{ Size of data in this transaction part. This allows splitting large
			transactions into smaller parts. }
			property DataSize: longword read FDataSize;
			{ Number of the parameters for this transaction }
			property ParamNum: word read FParamNum;
		end;
implementation
end.
