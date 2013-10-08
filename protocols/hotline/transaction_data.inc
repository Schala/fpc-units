PHLServerMessage = ^THLServerMessage;
{ Receive a message from the user on the current server, server’s administrator,
or server software itself. }
THLServerMessage = record
	userid: longword;
	username: string;
	{ Bitmap created by combining the following values:
	auto reply (4), refuse private chat (2), refuse private message (1) }
	options: longword;
	{ Message to display }
	data: string;
	{ Message to quote }
	quote: string;
	{ If User ID (103) field is not sent Server message (1) or admin message (any
	other value) }
	chat_options: longword;
end;

PHLSendChat = ^THLSendChat;
{ Send a chat message to the chat. Note: While the chat message data can have a
theoretical length of 32KB, many servers will clip the text to some length (server
dependent) far before this point. Best practice is to not allow the client to send
more than 4KB in one chat message. }
THLSendChat = record
	{ Optional, Normal (0) or alternate (1) chat message }
	options: longword;
	{ Optional }
	id: longword;
	{ Chat message string }
	data: string;
end;

PHLChatMessage = ^THLChatMessage;
{ Receive a chat message from the chat. }
THLChatMessage = record
	id: longword;
	{ Chat text, If Chat ID is not available, the Data field contains Special chat
	message }
	data: string;
end;

PHLLogin = ^ THLLogin;
{ Start login sequence with the server }
THLLogin = record
	login: string;
	password: string;
	{ Currently 151 }
	version: longword;
case version of
	151:
		(banner_id: longword;
		 server_name: string);
end;
