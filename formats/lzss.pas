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
	const
		{ The first four bytes are always 73 73 7A 6C—"sszl". }
		LZSSMagic = 'sszl';
implementation
end.
