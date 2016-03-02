//
//  CAFTRichFont.h
//  CrossApp
//
//  Created by �콨 on 16-02-23.
//  Copyright (c) 2014 http://www.9miao.com All rights reserved.
//

#ifndef __CC_PLATFORM_CAFTRICHFONT_H
#define __CC_PLATFORM_CAFTRICHFONT_H

#include "CAFreeTypeFont.h"
#include "view/CAView.h"

NS_CC_BEGIN

class CALabelFont;
class CALabelFontText;

typedef struct TGlyphEx_
{
	TGlyphEx_() : index(0), image(0), isEmoji(false), face(0) {}

	FT_UInt    index;  // glyph index
	FT_Vector  pos;    // glyph origin on the baseline
	FT_Glyph   image;  // glyph image
	FT_ULong   c;
	FT_Bool	   isEmoji;
	FT_Face	   face;
	FT_UInt	   fontSize;
	FT_UInt	   width;
	CAColor4B  col;
	bool	   underLine;
	bool	   deleteLine;

} TGlyphEx, *PGlyphEx;


typedef struct FTLineInfoEx_
{
	std::vector<TGlyphEx>	glyphs;     // glyphs for the line text
	FT_BBox					bbox;       // bounding box containing all of the glyphs in the line
	FT_UInt					width;      // width of the line
	FT_UInt					height;
	FT_Vector				pen;        // current pen position

} FTLineInfoEx;

class CC_DLL CAFTRichFont
{
public:
	CAFTRichFont();
	virtual ~CAFTRichFont();

	CAImage* initWithString(const CAVector<CALabelFontText*>& labels, const DSize& sz);

protected:
	void newLine();
	void endLine();
	void destroyAllLines();
	void initGlyphs(const CAVector<CALabelFontText*>& labels);
	void initGlyphsLine(const CAVector<CALabelFontText*>& labels);
	void initGlyphsLineEx(const CAVector<CALabelFontText*>& labels);
	FT_Error initWordGlyphs(const CAVector<CALabelFontText*>& labels, std::vector<TGlyphEx>& glyphs, FT_Vector& pen);
	FT_Error initWordGlyph(CALabelFontText* label, std::vector<TGlyphEx>& glyphs, FT_Vector& pen);
	FT_Face convertToSPFont(CALabelFont* ft);
	void compute_bbox(std::vector<TGlyphEx>& glyphs, FT_BBox *abbox);
	void calcuMultiLines(std::vector<TGlyphEx>& glyphs);
	void getLineYBBox(std::vector<TGlyphEx>& glyphs, FT_Pos& yPosMin, FT_Pos& yPosMax);
	unsigned char* getBitmap(int* outWidth, int* outHeight);
	void drawText(FTLineInfoEx* pInfo, unsigned char* pBuffer, FT_Vector *pen);
	void draw_bitmap(unsigned char* pBuffer, FT_Bitmap* bitmap, const CAColor4B& col, FT_Int x, FT_Int y);
	void draw_line(unsigned char* pBuffer, const CAColor4B& col, FT_Int x1, FT_Int y1, FT_Int x2, FT_Int y2);

private:
	DSize m_inSize;
	DSize m_textSize;
	FTLineInfoEx* m_pCurrentLine;
	std::vector<FTLineInfoEx*> m_lines;
	FT_Matrix m_ItalicMatrix;
};

extern CAFTRichFont g_AFTRichFont;

NS_CC_END

#endif