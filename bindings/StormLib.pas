unit StormLib;
interface

{
	Automatically converted by H2Pas 1.0.0 from StormLib.h
	The following command line parameters were used:
		-D
		-e
		-c
		-S
		-w
		StormLib.h
}

const
{$ifdef UNIX}
	External_library='storm';
{$endif}
{$ifdef WINDOWS}
	External_library='StormLib';
{$endif}
	MAX_PATH = 1024;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

const
	STORMLIB_VERSION = $0815;  
	STORMLIB_VERSION_STRING = '8.21';  
	ID_MPQ = $1A51504D;  
	ID_MPQ_USERDATA = $1B51504D;  
	ERROR_AVI_FILE = 10000;  
	ERROR_UNKNOWN_FILE_KEY = 10001;  
	ERROR_CHECKSUM_ERROR = 10002;  
	ERROR_INTERNAL_FILE = 10003;  
	ERROR_BASE_FILE_MISSING = 10004;  
	ERROR_MARKED_FOR_DELETE = 10005;  
	HASH_TABLE_SIZE_MIN = $00000004;  
	HASH_TABLE_SIZE_DEFAULT = $00001000;  
	HASH_TABLE_SIZE_MAX = $00080000;  
	HASH_ENTRY_DELETED = $FFFFFFFE;  
	HASH_ENTRY_FREE = $FFFFFFFF;  
	HET_ENTRY_DELETED = $80;  
	HET_ENTRY_FREE = $00;  
	HASH_STATE_SIZE = $60;  
	MPQ_PATCH_PREFIX_LEN = $20;  
	SFILE_OPEN_HARD_DISK_FILE = 2;  
	SFILE_OPEN_CDROM_FILE = 3;  
	SFILE_OPEN_FROM_MPQ = $00000000;  
	SFILE_OPEN_BASE_FILE = $FFFFFFFD;  
	SFILE_OPEN_ANY_LOCALE = $FFFFFFFE;  
	SFILE_OPEN_LOCAL_FILE = $FFFFFFFF;  
	MPQ_FLAG_READ_ONLY = $00000001;  
	MPQ_FLAG_CHANGED = $00000002;  
	MPQ_FLAG_PROTECTED = $00000004;  
	MPQ_FLAG_CHECK_SECTOR_CRC = $00000008;  
	MPQ_FLAG_NEED_FIX_SIZE = $00000010;  
	MPQ_FLAG_INV_LISTFILE = $00000020;  
	MPQ_FLAG_INV_ATTRIBUTES = $00000040;  
	SFILE_INVALID_SIZE = $FFFFFFFF;  
	SFILE_INVALID_POS = $FFFFFFFF;  
	SFILE_INVALID_ATTRIBUTES = $FFFFFFFF;  
	MPQ_FILE_IMPLODE = $00000100;  
	MPQ_FILE_COMPRESS = $00000200;  
	MPQ_FILE_COMPRESSED = $0000FF00;  
	MPQ_FILE_ENCRYPTED = $00010000;  
	MPQ_FILE_FIX_KEY = $00020000;  
	MPQ_FILE_PATCH_FILE = $00100000;  
	MPQ_FILE_SINGLE_UNIT = $01000000;  
	MPQ_FILE_DELETE_MARKER = $02000000;  
	MPQ_FILE_SECTOR_CRC = $04000000;  
	MPQ_FILE_EXISTS = $80000000;  
	MPQ_FILE_REPLACEEXISTING = $80000000;  
	MPQ_FILE_VALID_FLAGS = (((((((MPQ_FILE_IMPLODE or MPQ_FILE_COMPRESS) or MPQ_FILE_ENCRYPTED) or MPQ_FILE_FIX_KEY) or MPQ_FILE_PATCH_FILE) or MPQ_FILE_SINGLE_UNIT) or MPQ_FILE_DELETE_MARKER) or MPQ_FILE_SECTOR_CRC) or MPQ_FILE_EXISTS;  
	MPQ_COMPRESSION_HUFFMANN = $01;  
	MPQ_COMPRESSION_ZLIB = $02;  
	MPQ_COMPRESSION_PKWARE = $08;  
	MPQ_COMPRESSION_BZIP2 = $10;  
	MPQ_COMPRESSION_SPARSE = $20;  
	MPQ_COMPRESSION_ADPCM_MONO = $40;  
	MPQ_COMPRESSION_ADPCM_STEREO = $80;  
	MPQ_COMPRESSION_LZMA = $12;  
	MPQ_COMPRESSION_NEXT_SAME = $FFFFFFFF;  
	MPQ_WAVE_QUALITY_HIGH = 0;  
	MPQ_WAVE_QUALITY_MEDIUM = 1;  
	MPQ_WAVE_QUALITY_LOW = 2;  
	HET_TABLE_SIGNATURE = $1A544548;  
	BET_TABLE_SIGNATURE = $1A544542;  
	MPQ_KEY_HASH_TABLE = $C3AF3770;  
	MPQ_KEY_BLOCK_TABLE = $EC83B3A3;  
	MPQ_DATA_BITMAP_SIGNATURE = $33767470;  
	SFILE_INFO_ARCHIVE_NAME = 1;  
	SFILE_INFO_ARCHIVE_SIZE = 2;  
	SFILE_INFO_MAX_FILE_COUNT = 3;  
	SFILE_INFO_HASH_TABLE_SIZE = 4;  
	SFILE_INFO_BLOCK_TABLE_SIZE = 5;  
	SFILE_INFO_SECTOR_SIZE = 6;  
	SFILE_INFO_HASH_TABLE = 7;  
	SFILE_INFO_BLOCK_TABLE = 8;  
	SFILE_INFO_NUM_FILES = 9;  
	SFILE_INFO_STREAM_FLAGS = 10;  
	SFILE_INFO_IS_READ_ONLY = 11;  
	SFILE_INFO_HASH_INDEX = 100;  
	SFILE_INFO_CODENAME1 = 101;  
	SFILE_INFO_CODENAME2 = 102;  
	SFILE_INFO_LOCALEID = 103;  
	SFILE_INFO_BLOCKINDEX = 104;  
	SFILE_INFO_FILE_SIZE = 105;  
	SFILE_INFO_COMPRESSED_SIZE = 106;  
	SFILE_INFO_FLAGS = 107;  
	SFILE_INFO_POSITION = 108;  
	SFILE_INFO_KEY = 109;  
	SFILE_INFO_KEY_UNFIXED = 110;  
	SFILE_INFO_FILETIME = 111;  
	SFILE_INFO_PATCH_CHAIN = 112;  
	LISTFILE_NAME = '(listfile)';  
	SIGNATURE_NAME = '(signature)';  
	ATTRIBUTES_NAME = '(attributes)';  
	PATCH_METADATA_NAME = '(patch_metadata)';  
	MPQ_FORMAT_VERSION_1 = 0;  
	MPQ_FORMAT_VERSION_2 = 1;  
	MPQ_FORMAT_VERSION_3 = 2;  
	MPQ_FORMAT_VERSION_4 = 3;  
	MPQ_ATTRIBUTE_CRC32 = $00000001;  
	MPQ_ATTRIBUTE_FILETIME = $00000002;  
	MPQ_ATTRIBUTE_MD5 = $00000004;  
	MPQ_ATTRIBUTE_PATCH_BIT = $00000008;  
	MPQ_ATTRIBUTE_ALL = $0000000F;  
	MPQ_ATTRIBUTES_V1 = 100;  
	BASE_PROVIDER_FILE = $00000000;  
	BASE_PROVIDER_MAP = $00000001;  
	BASE_PROVIDER_HTTP = $00000002;  
	BASE_PROVIDER_MASK = $0000000F;  
	STREAM_PROVIDER_LINEAR = $00000000;  
	STREAM_PROVIDER_PARTIAL = $00000010;  
	STREAM_PROVIDER_ENCRYPTED = $00000020;  
	STREAM_PROVIDER_MASK = $000000F0;  
	STREAM_FLAG_READ_ONLY = $00000100;  
	STREAM_FLAG_WRITE_SHARE = $00000200;  
	STREAM_FLAG_MASK = $0000FF00;  
	STREAM_OPTIONS_MASK = $0000FFFF;  
	MPQ_OPEN_NO_LISTFILE = $00010000;  
	MPQ_OPEN_NO_ATTRIBUTES = $00020000;  
	MPQ_OPEN_FORCE_MPQ_V1 = $00040000;  
	MPQ_OPEN_CHECK_SECTOR_CRC = $00080000;  
	MPQ_OPEN_READ_ONLY = STREAM_FLAG_READ_ONLY;  
	MPQ_OPEN_ENCRYPTED = STREAM_PROVIDER_ENCRYPTED;  
	MPQ_CREATE_ATTRIBUTES = $00100000;  
	MPQ_CREATE_ARCHIVE_V1 = $00000000;  
	MPQ_CREATE_ARCHIVE_V2 = $01000000;  
	MPQ_CREATE_ARCHIVE_V3 = $02000000;  
	MPQ_CREATE_ARCHIVE_V4 = $03000000;  
	MPQ_CREATE_ARCHIVE_VMASK = $0F000000;  
	FLAGS_TO_FORMAT_SHIFT = 24;  
	SFILE_VERIFY_SECTOR_CRC = $00000001;  
	SFILE_VERIFY_FILE_CRC = $00000002;  
	SFILE_VERIFY_FILE_MD5 = $00000004;  
	SFILE_VERIFY_RAW_MD5 = $00000008;  
	SFILE_VERIFY_ALL = $0000000F;  
	VERIFY_OPEN_ERROR = $0001;  
	VERIFY_READ_ERROR = $0002;  
	VERIFY_FILE_HAS_SECTOR_CRC = $0004;  
	VERIFY_FILE_SECTOR_CRC_ERROR = $0008;  
	VERIFY_FILE_HAS_CHECKSUM = $0010;  
	VERIFY_FILE_CHECKSUM_ERROR = $0020;  
	VERIFY_FILE_HAS_MD5 = $0040;  
	VERIFY_FILE_MD5_ERROR = $0080;  
	VERIFY_FILE_HAS_RAW_MD5 = $0100;  
	VERIFY_FILE_RAW_MD5_ERROR = $0200;  
	VERIFY_FILE_ERROR_MASK = ((((VERIFY_OPEN_ERROR or VERIFY_READ_ERROR) or VERIFY_FILE_SECTOR_CRC_ERROR) or VERIFY_FILE_CHECKSUM_ERROR) or VERIFY_FILE_MD5_ERROR) or VERIFY_FILE_RAW_MD5_ERROR;  
	SFILE_VERIFY_MPQ_HEADER = $0001;  
	SFILE_VERIFY_HET_TABLE = $0002;  
	SFILE_VERIFY_BET_TABLE = $0003;  
	SFILE_VERIFY_HASH_TABLE = $0004;  
	SFILE_VERIFY_BLOCK_TABLE = $0005;  
	SFILE_VERIFY_HIBLOCK_TABLE = $0006;  
	SFILE_VERIFY_FILE = $0007;  
	ERROR_NO_SIGNATURE = 0;  
	ERROR_VERIFY_FAILED = 1;  
	ERROR_WEAK_SIGNATURE_OK = 2;  
	ERROR_WEAK_SIGNATURE_ERROR = 3;  
	ERROR_STRONG_SIGNATURE_OK = 4;  
	ERROR_STRONG_SIGNATURE_ERROR = 5;  
	MD5_DIGEST_SIZE = $10;  
	SHA1_DIGEST_SIZE = $14;  
	LANG_NEUTRAL = $00;  
	CCB_CHECKING_FILES = 1;  
	CCB_CHECKING_HASH_TABLE = 2;  
	CCB_COPYING_NON_MPQ_DATA = 3;  
	CCB_COMPACTING_FILES = 4;  
	CCB_CLOSING_ARCHIVE = 5;  
type
	TSFILE_ADDFILE_CALLBACK = procedure (var pvUserData:pointer; dwBytesWritten:DWORD; dwTotalBytes:DWORD; bFinalCall:boolean);
	TSFILE_COMPACT_CALLBACK = procedure (var pvUserData:pointer; dwWorkType:DWORD; BytesProcessed:qword; TotalBytes:qword);
	
	PFileStream = ^TFileStream;
	TFileStream = record
		data: pointer;
	end;
	
	PBitArray = ^TBitArray;
	TBitArray = record
			NumberOfBits : DWORD;
			Elements : array[0..0] of BYTE;
		end;

procedure GetBits(var _array:TBitArray; nBitPosition:dword; nBitLength:dword; var pvBuffer:pointer; nResultSize:longint);cdecl;external External_library name 'GetBits';
procedure SetBits(var _array:TBitArray; nBitPosition:dword; nBitLength:dword; var pvBuffer:pointer; nResultSize:longint);cdecl;external External_library name 'SetBits';
type
	PFileBitmap = ^TFileBitmap;
	TFileBitmap = record
			StartOffset : qword;
			EndOffset : qword;
			IsComplete : DWORD;
			BitmapSize : DWORD;
			BlockSize : DWORD;
			Reserved : DWORD;
		end;

const
	MPQ_HEADER_SIZE_V1 = $20;  
	MPQ_HEADER_SIZE_V2 = $2C;  
	MPQ_HEADER_SIZE_V3 = $44;  
	MPQ_HEADER_SIZE_V4 = $D0;  
type
	PMPQUserData = ^TMPQUserData;
	TMPQUserData = record
			dwID : DWORD;
			cbUserDataSize : DWORD;
			dwHeaderOffs : DWORD;
			cbUserDataHeader : DWORD;
		end;
type
	PMPQHeader = ^TMPQHeader;
	TMPQHeader = record
			dwID : DWORD;
			dwHeaderSize : DWORD;
			dwArchiveSize : DWORD;
			wFormatVersion : word;
			wSectorSize : word;
			dwHashTablePos : DWORD;
			dwBlockTablePos : DWORD;
			dwHashTableSize : DWORD;
			dwBlockTableSize : DWORD;
			HiBlockTablePos64 : qword;
			wHashTablePosHi : word;
			wBlockTablePosHi : word;
			ArchiveSize64 : qword;
			BetTablePos64 : qword;
			HetTablePos64 : qword;
			HashTableSize64 : qword;
			BlockTableSize64 : qword;
			HiBlockTableSize64 : qword;
			HetTableSize64 : qword;
			BetTableSize64 : qword;
			dwRawChunkSize : DWORD;
			MD5_BlockTable : array[0..(MD5_DIGEST_SIZE)-1] of byte;
			MD5_HashTable : array[0..(MD5_DIGEST_SIZE)-1] of byte;
			MD5_HiBlockTable : array[0..(MD5_DIGEST_SIZE)-1] of byte;
			MD5_BetTable : array[0..(MD5_DIGEST_SIZE)-1] of byte;
			MD5_HetTable : array[0..(MD5_DIGEST_SIZE)-1] of byte;
			MD5_MpqHeader : array[0..(MD5_DIGEST_SIZE)-1] of byte;
		end;
type
	PMPQHash = ^TMPQHash;
	TMPQHash = record
			dwName1 : DWORD;
			dwName2 : DWORD;
		{$ifdef ENDIAN_LITTLE}
			lcLocale : word;
			wPlatform : word;
		{$else}
			wPlatform : word;
			lcLocale : word;
		{$endif}
			dwBlockIndex : DWORD;
		end;
	
	PMPQBlock = ^TMPQBlock;
	TMPQBlock = record
			dwFilePos : DWORD;
			dwCSize : DWORD;
			dwFSize : DWORD;
			dwFlags : DWORD;
		end;
	
	PPatchInfo = ^TPatchInfo;
	TPatchInfo = record
			dwLength : DWORD;
			dwFlags : DWORD;
			dwDataSize : DWORD;
			md5 : array[0..15] of BYTE;
		end;
	
	PPatchHeader = ^TPatchHeader;
	TPatchHeader = record
			dwSignature : DWORD;
			dwSizeOfPatchData : DWORD;
			dwSizeBeforePatch : DWORD;
			dwSizeAfterPatch : DWORD;
			dwMD5 : DWORD;
			dwMd5BlockSize : DWORD;
			md5_before_patch : array[0..15] of BYTE;
			md5_after_patch : array[0..15] of BYTE;
			dwXFRM : DWORD;
			dwXfrmBlockSize : DWORD;
			dwPatchType : DWORD;
		end;

const
	SIZE_OF_XFRM_HEADER = $0C;  
type
	PFileEntry = ^TFileEntry;
	TFileEntry = record
			ByteOffset : qword;
			FileTime : qword;
			BetHash : qword;
			dwHashIndex : DWORD;
			dwHetIndex : DWORD;
			dwFileSize : DWORD;
			dwCmpSize : DWORD;
			dwFlags : DWORD;
			lcLocale : word;
			wPlatform : word;
			dwCrc32 : DWORD;
			md5 : array[0..(MD5_DIGEST_SIZE)-1] of byte;
			szFileName : pchar;
		end;
	
	PMPQExtTable = ^TMPQExtTable;
	TMPQExtTable = record
			dwSignature : DWORD;
			dwVersion : DWORD;
			dwDataSize : DWORD;
		end;
	
	PMPQBitmap = ^TMPQBitmap;
	TMPQBitmap = record
			dwSignature : DWORD;
			dwAlways3 : DWORD;
			dwBuildNumber : DWORD;
			dwMapOffsetLo : DWORD;
			dwMapOffsetHi : DWORD;
			dwBlockSize : DWORD;
		end;
	
	PMPQHetTable = ^TMPQHetTable;
	TMPQHetTable = record
			pBetIndexes : PBitArray;
			pHetHashes : pbyte;
			AndMask64 : qword;
			OrMask64 : qword;
			dwIndexSizeTotal : DWORD;
			dwIndexSizeExtra : DWORD;
			dwIndexSize : DWORD;
			dwMaxFileCount : DWORD;
			dwHashTableSize : DWORD;
			dwHashBitSize : DWORD;
		end;
	
	PMPQBetTable = ^TMPQBetTable;
	TMPQBetTable = record
			pBetHashes : PBitArray;
			pFileTable : PBitArray;
			pFileFlags : pdword;
			dwTableEntrySize : DWORD;
			dwBitIndex_FilePos : DWORD;
			dwBitIndex_FileSize : DWORD;
			dwBitIndex_CmpSize : DWORD;
			dwBitIndex_FlagIndex : DWORD;
			dwBitIndex_Unknown : DWORD;
			dwBitCount_FilePos : DWORD;
			dwBitCount_FileSize : DWORD;
			dwBitCount_CmpSize : DWORD;
			dwBitCount_FlagIndex : DWORD;
			dwBitCount_Unknown : DWORD;
			dwBetHashSizeTotal : DWORD;
			dwBetHashSizeExtra : DWORD;
			dwBetHashSize : DWORD;
			dwFileCount : DWORD;
			dwFlagCount : DWORD;
		end;
	
	PMPQArchive = ^TMPQArchive;
	TMPQArchive = record
			pStream : PFileStream;
			UserDataPos : qword;
			MpqPos : qword;
			haPatch : PMPQArchive;
			haBase : PMPQArchive;
			szPatchPrefix : array[0..(MPQ_PATCH_PREFIX_LEN)-1] of char;
			cchPatchPrefix : sizeuint;
			pUserData : PMPQUserData;
			pHeader : PMPQHeader;
			pBitmap : PMPQBitmap;
			pHashTable : PMPQHash;
			pHetTable : PMPQHetTable;
			pFileTable : PFileEntry;
			UserData : TMPQUserData;
			HeaderData : array[0..(MPQ_HEADER_SIZE_V4)-1] of BYTE;
			dwHETBlockSize : DWORD;
			dwBETBlockSize : DWORD;
			dwFileTableSize : DWORD;
			dwMaxFileCount : DWORD;
			dwSectorSize : DWORD;
			dwFileFlags1 : DWORD;
			dwFileFlags2 : DWORD;
			dwAttrFlags : DWORD;
			dwFlags : DWORD;
		end;
	
	PMPQFile = ^TMPQFile;
	TMPQFile = record
			pStream : PFileStream;
			ha : PMPQArchive;
			pFileEntry : PFileEntry;
			dwFileKey : DWORD;
			dwFilePos : DWORD;
			RawFilePos : qword;
			MpqFilePos : qword;
			dwMagic : DWORD;
			hfPatchFile : PMPQFile;
			pPatchHeader : PPatchHeader;
			pbFileData : pbyte;
			cbFileData : DWORD;
			pPatchInfo : PPatchInfo;
			SectorOffsets : ^DWORD;
			SectorChksums : ^DWORD;
			dwSectorCount : DWORD;
			dwPatchedFileSize : DWORD;
			dwDataSize : DWORD;
			pbFileSector : pbyte;
			dwSectorOffs : DWORD;
			dwSectorSize : DWORD;
			hctx : array[0..(HASH_STATE_SIZE)-1] of byte;
			dwCrc32 : DWORD;
			bLoadedSectorCRCs : boolean;
			bCheckSectorCRCs : boolean;
			bIsWritepointer : boolean;
			bErrorOccured : boolean;
		end;

	TSFILE_FIND_DATA = record
			cFileName : array[0..(MAX_PATH)-1] of char;
			szPlainName : pchar;
			dwHashIndex : DWORD;
			dwBlockIndex : DWORD;
			dwFileSize : DWORD;
			dwFileFlags : DWORD;
			dwCompSize : DWORD;
			dwFileTimeLo : DWORD;
			dwFileTimeHi : DWORD;
			lcLocale : cardinal;
		end;
	PSFILE_FIND_DATA = ^TSFILE_FIND_DATA;

	TSFILE_CREATE_MPQ = record
			cbSize : DWORD;
			dwMpqVersion : DWORD;
			pvUserData : pointer;
			cbUserData : DWORD;
			dwStreamFlags : DWORD;
			dwFileFlags1 : DWORD;
			dwFileFlags2 : DWORD;
			dwAttrFlags : DWORD;
			dwSectorSize : DWORD;
			dwRawChunkSize : DWORD;
			dwMaxFileCount : DWORD;
		end;
	PSFILE_CREATE_MPQ = ^TSFILE_CREATE_MPQ;

function FileStream_CreateFile(szFileName:pchar; dwStreamFlags:DWORD):PFileStream;cdecl;external External_library name 'FileStream_CreateFile';
function FileStream_OpenFile(szFileName:pchar; dwStreamFlags:DWORD):PFileStream;cdecl;external External_library name 'FileStream_OpenFile';
function FileStream_GetFileName(var pStream:TFileStream):pchar;cdecl;external External_library name 'FileStream_GetFileName';
function FileStream_IsReadOnly(var pStream:TFileStream):boolean;cdecl;external External_library name 'FileStream_IsReadOnly';
function FileStream_Read(var pStream:TFileStream; var pByteOffset:qword; var pvBuffer:pointer; dwBytesToRead:DWORD):boolean;cdecl;external External_library name 'FileStream_Read';
function FileStream_Write(var pStream:TFileStream; var pByteOffset:qword; var pvBuffer:pointer; dwBytesToWrite:DWORD):boolean;cdecl;external External_library name 'FileStream_Write';
function FileStream_GetPos(var pStream:TFileStream; var pByteOffset:qword):boolean;cdecl;external External_library name 'FileStream_GetPos';
function FileStream_SetPos(var pStream:TFileStream; ByteOffset:qword):boolean;cdecl;external External_library name 'FileStream_SetPos';
function FileStream_GetSize(var pStream:TFileStream; var pFileSize:qword):boolean;cdecl;external External_library name 'FileStream_GetSize';
function FileStream_SetSize(var pStream:TFileStream; NewFileSize:qword):boolean;cdecl;external External_library name 'FileStream_SetSize';
function FileStream_GetTime(var pStream:TFileStream; var pFT:qword):boolean;cdecl;external External_library name 'FileStream_GetTime';
function FileStream_GetFlags(var pStream:TFileStream; pdwStreamFlags:pdword):boolean;cdecl;external External_library name 'FileStream_GetFlags';
function FileStream_Switch(var pStream:TFileStream; var pTempStream:TFileStream):boolean;cdecl;external External_library name 'FileStream_Switch';
function FileStream_SetBitmap(var pStream:TFileStream; var pBitmap:TFileBitmap):boolean;cdecl;external External_library name 'FileStream_SetBitmap';
function FileStream_GetBitmap(var pStream:TFileStream; var pBitmap:TFileBitmap; Length:DWORD; LengthNeeded:pdword):boolean;cdecl;external External_library name 'FileStream_GetBitmap';
procedure FileStream_Close(var pStream:TFileStream);cdecl;external External_library name 'FileStream_Close';
type

	TSFILESETLOCALE = function (_para1:cardinal):cardinal;

	TSFILEOPENARCHIVE = function (_para1:Pchar; _para2:DWORD; _para3:DWORD; _para4:pointer):boolean;

	TSFILECLOSEARCHIVE = function (_para1:pointer):boolean;

	TSFILEOPENFILEEX = function (_para1:pointer; _para2:Pchar; _para3:DWORD; _para4:pointer):boolean;

	TSFILECLOSEFILE = function (_para1:pointer):boolean;

	TSFILEGETFILESIZE = function (_para1:pointer; _para2:pdword):DWORD;

	TSFILESETFILEPOINTER = function (_para1:pointer; _para2:longint; _para3:Plongint; _para4:DWORD):DWORD;

	TSFILEREADFILE = function (_para1:pointer; _para2:pointer; _para3:DWORD; _para4:pdword; _para5:pointer):boolean;

function SFileGetLocale:cardinal;external External_library name 'SFileGetLocale';
function SFileSetLocale(lcNewLocale:cardinal):cardinal;external External_library name 'SFileSetLocale';
function SFileOpenArchive(szMpqName:pchar; dwPriority:DWORD; dwFlags:DWORD; var phMpq:pointer):boolean;external External_library name 'SFileOpenArchive';
function SFileCreateArchive(szMpqName:pchar; dwFlags:DWORD; dwMaxFileCount:DWORD; var phMpq:pointer):boolean;external External_library name 'SFileCreateArchive';
function SFileCreateArchive2(szMpqName:pchar; pCreateInfo:PSFILE_CREATE_MPQ; var phMpq:pointer):boolean;external External_library name 'SFileCreateArchive2';
function SFileGetArchiveBitmap(hMpq:pointer; var pBitmap:TFileBitmap; Length:DWORD; LengthNeeded:pdword):boolean;external External_library name 'SFileGetArchiveBitmap';
function SFileFlushArchive(hMpq:pointer):boolean;external External_library name 'SFileFlushArchive';
function SFileCloseArchive(hMpq:pointer):boolean;external External_library name 'SFileCloseArchive';
function SFileAddListFile(hMpq:pointer; szListFile:Pchar):longint;external External_library name 'SFileAddListFile';
function SFileSetCompactCallback(hMpq:pointer; CompactCB:TSFILE_COMPACT_CALLBACK; var pvData:pointer):boolean;external External_library name 'SFileSetCompactCallback';
function SFileCompactArchive(hMpq:pointer; szListFile:Pchar; bReserved:boolean):boolean;external External_library name 'SFileCompactArchive';
function SFileGetMaxFileCount(hMpq:pointer):DWORD;external External_library name 'SFileGetMaxFileCount';
function SFileSetMaxFileCount(hMpq:pointer; dwMaxFileCount:DWORD):boolean;external External_library name 'SFileSetMaxFileCount';
function SFileGetAttributes(hMpq:pointer):DWORD;external External_library name 'SFileGetAttributes';
function SFileSetAttributes(hMpq:pointer; dwFlags:DWORD):boolean;external External_library name 'SFileSetAttributes';
function SFileUpdateFileAttributes(hMpq:pointer; szFileName:Pchar):boolean;external External_library name 'SFileUpdateFileAttributes';
function SFileOpenPatchArchive(hMpq:pointer; szPatchMpqName:pchar; szPatchPathPrefix:Pchar; dwFlags:DWORD):boolean;external External_library name 'SFileOpenPatchArchive';
function SFileIsPatchedArchive(hMpq:pointer):boolean;external External_library name 'SFileIsPatchedArchive';
function SFileOpenFileEx(hMpq:pointer; szFileName:Pchar; dwSearchScope:DWORD; var phFile:pointer):boolean;external External_library name 'SFileOpenFileEx';
function SFileGetFileSize(hFile:pointer; pdwFileSizeHigh:pdword):DWORD;external External_library name 'SFileGetFileSize';
function SFileSetFilePointer(hFile:pointer; lFilePos:longint; var plFilePosHigh:longint; dwMoveMethod:DWORD):DWORD;external External_library name 'SFileSetFilePointer';
function SFileReadFile(hFile:pointer; var lpBuffer:pointer; dwToRead:DWORD; pdwRead:pdword; pointer:pointer):boolean;external External_library name 'SFileReadFile';
function SFileCloseFile(hFile:pointer):boolean;external External_library name 'SFileCloseFile';
function SFileHasFile(hMpq:pointer; szFileName:Pchar):boolean;external External_library name 'SFileHasFile';
function SFileGetFileName(hFile:pointer; szFileName:Pchar):boolean;external External_library name 'SFileGetFileName';
function SFileGetFileInfo(hMpqOrFile:pointer; dwInfoType:DWORD; var pvFileInfo:pointer; cbFileInfo:DWORD; pcbLengthNeeded:pdword):boolean;external External_library name 'SFileGetFileInfo';
function SFileExtractFile(hMpq:pointer; szToExtract:Pchar; szExtracted:pchar; dwSearchScope:DWORD):boolean;external External_library name 'SFileExtractFile';
function SFileGetFileChecksums(hMpq:pointer; szFileName:Pchar; pdwCrc32:pdword; pMD5:Pchar):boolean;external External_library name 'SFileGetFileChecksums';
function SFileVerifyFile(hMpq:pointer; szFileName:Pchar; dwFlags:DWORD):DWORD;external External_library name 'SFileVerifyFile';
function SFileVerifyRawData(hMpq:pointer; dwWhatToVerify:DWORD; szFileName:Pchar):longint;external External_library name 'SFileVerifyRawData';
function SFileVerifyArchive(hMpq:pointer):DWORD;external External_library name 'SFileVerifyArchive';
function SFileFindFirstFile(hMpq:pointer; szMask:Pchar; var lpFindFileData:TSFILE_FIND_DATA; szListFile:Pchar):pointer;external External_library name 'SFileFindFirstFile';
function SFileFindNextFile(hFind:pointer; var lpFindFileData:TSFILE_FIND_DATA):boolean;external External_library name 'SFileFindNextFile';
function SFileFindClose(hFind:pointer):boolean;external External_library name 'SFileFindClose';
function SListFileFindFirstFile(hMpq:pointer; szListFile:Pchar; szMask:Pchar; var lpFindFileData:TSFILE_FIND_DATA):pointer;external External_library name 'SListFileFindFirstFile';
function SListFileFindNextFile(hFind:pointer; var lpFindFileData:TSFILE_FIND_DATA):boolean;external External_library name 'SListFileFindNextFile';
function SListFileFindClose(hFind:pointer):boolean;external External_library name 'SListFileFindClose';
function SFileEnumLocales(hMpq:pointer; szFileName:Pchar; var plcLocales:cardinal; pdwMaxLocales:pdword; dwSearchScope:DWORD):longint;external External_library name 'SFileEnumLocales';
function SFileCreateFile(hMpq:pointer; szArchivedName:Pchar; FileTime:qword; dwFileSize:DWORD; lcLocale:cardinal; 
					dwFlags:DWORD; var phFile:pointer):boolean;external External_library name 'SFileCreateFile';
function SFileWriteFile(hFile:pointer; var pvData:pointer; dwSize:DWORD; dwCompression:DWORD):boolean;external External_library name 'SFileWriteFile';
function SFileFinishFile(hFile:pointer):boolean;external External_library name 'SFileFinishFile';
function SFileAddFileEx(hMpq:pointer; szFileName:pchar; szArchivedName:Pchar; dwFlags:DWORD; dwCompression:DWORD; 
					dwCompressionNext:DWORD):boolean;external External_library name 'SFileAddFileEx';
function SFileAddFile(hMpq:pointer; szFileName:pchar; szArchivedName:Pchar; dwFlags:DWORD):boolean;external External_library name 'SFileAddFile';
function SFileAddWave(hMpq:pointer; szFileName:pchar; szArchivedName:Pchar; dwFlags:DWORD; dwQuality:DWORD):boolean;external External_library name 'SFileAddWave';
function SFileRemoveFile(hMpq:pointer; szFileName:Pchar; dwSearchScope:DWORD):boolean;external External_library name 'SFileRemoveFile';
function SFileRenameFile(hMpq:pointer; szOldFileName:Pchar; szNewFileName:Pchar):boolean;external External_library name 'SFileRenameFile';
function SFileSetFileLocale(hFile:pointer; lcNewLocale:cardinal):boolean;external External_library name 'SFileSetFileLocale';
function SFileSetDataCompression(DataCompression:DWORD):boolean;external External_library name 'SFileSetDataCompression';
function SFileSetAddFileCallback(hMpq:pointer; AddFileCB:TSFILE_ADDFILE_CALLBACK; var pvData:pointer):boolean;external External_library name 'SFileSetAddFileCallback';
function SCompImplode(var pvOutBuffer:pointer; var pcbOutBuffer:longint; var pvInBuffer:pointer; cbInBuffer:longint):longint;external External_library name 'SCompImplode';
function SCompExplode(var pvOutBuffer:pointer; var pcbOutBuffer:longint; var pvInBuffer:pointer; cbInBuffer:longint):longint;external External_library name 'SCompExplode';
function SCompCompress(var pvOutBuffer:pointer; var pcbOutBuffer:longint; var pvInBuffer:pointer; cbInBuffer:longint; uCompressionMask:dword; 
					nCmpType:longint; nCmpLevel:longint):longint;external External_library name 'SCompCompress';
function SCompDecompress(var pvOutBuffer:pointer; var pcbOutBuffer:longint; var pvInBuffer:pointer; cbInBuffer:longint):longint;external External_library name 'SCompDecompress';
function SCompDecompress2(var pvOutBuffer:pointer; var pcbOutBuffer:longint; var pvInBuffer:pointer; cbInBuffer:longint):longint;external External_library name 'SCompDecompress2';
{$ifndef windows}

procedure SetLastError(err:longint);cdecl;external External_library name 'SetLastError';
function GetLastError:longint;cdecl;external External_library name 'GetLastError';
{$endif}

implementation


end.
