PHLFileInfo = ^THLFileInfo;
THLFileInfo = record
	kind: longword;
	creator: longword;
	size: longword;
	reserved: longword;
	name_script: word;
	name: string;
	procedure FromFile(f: file);
end;

PHLPath = ^THLPath;
{ Path parameters in Hotline are formatted in a rather obscure way }
THLPath = record
	dir_levels: word;
	unknown: word;
	dirname: string;
	procedure FromFilePath(filepath: string);
	function ToFilePath: string;
end;

PHLFork = ^THLFork;
THLFork = record
	magic: longword;
	{ Current file size }
	size: longword;
	{ ? }
	rsvd1: longword;
	{ ? }
	rsvd2: longword;
end;

PHLFileResume = ^THLFileResume;
THLFileResume = record
	magic: longword;
	{ Currently 1 }
	version: word;
	{ ? }
	rsvd: array[0..33] of byte;
	{ Currently 2 }
	forknum: word;
	forks: PHLFork;
end;

PHLDate = ^THLDate;
{ Seconds and milliseconds represent the amount of time that passed since
January 1st of any given year. For instance, 70 seconds and 2,000 milliseconds
for a year value of 2010 would represent 1 January 2010 at 00:01:12 AM.
432,000 seconds and 5,000 milliseconds for a year value of 2008 would represent
6 January 2008 at 00:00:15 AM (43,210 seconds = 5 days, 10 seconds;
5,000 milliseconds = 5 seconds). }
THLDate = record
	year: word;
	millisecs: word;
	secs: longword;
	procedure FromDateTime(dt: TDateTime);
	function ToDateTime: TDateTime;
end;

PHLUserInfo = ^THLUserInfo;
THLUserInfo = record
	id: word;
	icon_id: word;
	flags: word;
	name: string;
end;

PHLNewsCategoriesData1 = ^THLNewsCategoriesData1;
{ This field is used for client/server version 1.5 (prior to April 15, 1999?). }
THLNewsCategoriesData1 = record
	{ Category folder (1), category (10) or other (255) }
	kind: byte;
	name: string;
end;

PHLMime = ^THLMime;
THLMime = record
	txt: string;
	article_size: word;
end;

PHLArticle = ^THLArticle;
THLArticle = record
	id: longword;
	timestamp: THLDate;
	parent_id: longword;
	flags: longword;
	mime_num: word;
	{ Title string }
	title: string;
	{ Poster string }
	poster: string;
	{ Optional (if mime_num > 0) }
	mimes: PHLMime;
end;

PHLNewsArticlesData = ^THLNewsArticlesData;
THLNewsArticlesData = record
	id: longword;
	{ Number of articles }
	article_num: longword;
	{ Name string }
	name: string;
	{ Description string }
	description: string;
	articles: PHLArticle;
end;

PHLNewsCategoriesData2 = ^THLNewsCategoriesData2;
THLNewsCategoriesData2 = record
	{ Bundle (2) or category (3) }
case kind: word of
	2:
		(bunnum: word;
		 bunname: string);
	3:
		(catnum: word;
		 guid: TGuid;
		 add_sn: longword;
		 del_sn: longword;
		 catname: string);
end;
