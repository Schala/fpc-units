{$packenum 1}
TMonth = (
	January = 1,
	February,
	March,
	April,
	May,
	June,
	July,
	August,
	September,
	October,
	November,
	December );

TFullYear = 1..9999;
TMonthDay = 1..31;
THour = 0..23;
TMinute = 0..59;
TSecond = 0..60;

TTimeOffset = packed record
	ahead: boolean;
	hour: THour;
	minute: TMinute;
	function Format: utf8string;
end;

TPartialTime = packed record
	hour: THour;
	minute: TMinute;
	second: TSecond;
	secfrac: single;
	function Format: utf8string;
end;

TFullDate = packed record
	year: TFullYear;
	month: TMonth;
	day: TMonthDay;
	function Format: utf8string;
end;

TFullTime = packed record
	partial: TPartialTime;
	offset: TTimeOffset;
	function Format: utf8string;
end;

{ Date are sent in the ISO 8601 full "date-time" format, as per RFC 
3339 }
TFullDateTime = packed record
	date: TFullDate;
	time: TFullTime;
	function Format: utf8string;
end;

TWiUserAccess =  packed record
	get_user_info,
	broadcast,
	post_news,
	clear_news,
	dl,
	ul,
	ul_anywhere,
	mk_dirs,
	edit_files,
	rm_files,
	view_dropboxes,
	mk_accounts,
	edit_accounts,
	rm_accounts,
	raise_access,
	kick,
	ban,
	unkickable,
	edit_topic: boolean;
	dl_speed,
	ul_speed: qword;
	dl_limit,
	ul_limit: word;
	function Format: utf8string;
end;

{$packenum 1}
{ The file type is mapped by the server }
TWiFileType = (
		wiFile = 0,
		wiDir,
		wiULDir,
		wiDBDir
);

TWiClientInfo = packed record
	user: word;
	idle: boolean;
	admin: boolean;
	icon: word;
	nick: utf8string;
	login: utf8string;
	ip: utf8string;
	host: utf8string;
	version: utf8string;
	cipher_name: utf8string;
	cipher_bits: dword;
	login_time: TFullDateTime;
	idle_time: TFullDateTime;
	dls: word;
	uls: word;
	status: utf8string;
	image: utf8string;
	transfer: utf8string;
	path: utf8string;
	transferred: qword;
	size: qword;
	speed: dword;
	function Format: utf8string;
end;

TWiFileInfo = packed record
	path: utf8string;
	kind: TWiFileType;
	size: qword;
	created: TFullDateTime;
	modified: TFullDateTime;
	checksum: utf8string;
	comment: utf8string;
	function Format: utf8string;
end;

{$packenum 2}
{ A message from a server to a client includes a unique three-digit 
number, followed by a space, then optional fields, and a terminator. }
TWiMsgID = (
	msgServerInfo = 200,
	msgLoginSuccess,
	msgPingReply,
	msgServerBanner,
	msgChat = 300,
	msgEmote,
	msgClientJoin,
	msgClientLeave,
	msgStatusChange,
	msgPM,
	msgClientKicked,
	msgClientBanned,
	msgClientInfo,
	msgBroadcast,
	msgUserList,
	msgUserListDone,
	msgNews = 320,
	msgNewsDone,
	msgNewsPosted,
	msgPrivChatMade = 330,
	msgPrivChatInv,
	msgPrivChatRej,
	msgClientImgChange = 340,
	msgChatSub,
	msgXferReady = 400,
	msgXferQueued,
	msgFileInfo,
	
);
