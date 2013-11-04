{ LZSS is a type of dictionary encoding technique which attempts to reduce the
length of a file by replacing some bytes with pointers back to an earlier part
of the file, plus numbers representing the number of bytes to be copied from this
point. A single-bit flag is used to indicate whether the next item in the file is
a literal byte or a pointer + length. Depending on the ratio of pointers to literal
bytes, an ~LZSS-encoded file may be anywhere from ~12% to 112.5% of the size of
the original. (Yes, it can actually make the file bigger than it originally was,
because it takes 9 bits to encode an 8-bit literal byte.) }
unit lzss;
{$mode objfpc}{$H+}
interface
	uses
		classes;

	const
		{ The first four bytes are always 73 73 7A 6C—"sszl". }
		LZSSMagic = 'sszl';
		{ The Chrono Cross LZSS implementation uses a 4K ring buffer—that is, it stores
		4096 bytes of the decompressed file for use in back references, and when the
		data reaches the end of the buffer, the write loops back around to the beginning.
		The buffer is initialized with zero bytes. }
		LZSSRingBufferSize = 4096;
	
	type
		TBinary8 = array[0..7] of byte;
		TBinary16 = array[0..15] of byte;

		TLZSSBlob = class
		private
			FUnknown32: dword;
			FOutput: TMemoryStream;
		public
			constructor Create(const AStream: TStream);
			destructor Destroy; override;
			function Conv8(source: byte): TBinary8;
			function Conv16(source: dword): TBinary16;
			function ConvByte(value: TBinary8): byte;
		end;
implementation
	function TLZSSBlob.Conv8(source: byte): TBinary8;
	begin
		result := '
	end;
end.
