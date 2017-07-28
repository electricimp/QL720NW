// MIT License
//
// Copyright 2016-7 Electric Imp
//
// SPDX-License-Identifier: MIT
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
// OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.

// Commands
// Commands are of varing lengths, so leave as strings
const QL720NW_CMD_ESCP_ENABLE      = "\x1B\x69\x61\x00";
const QL720NW_CMD_ESCP_INIT        = "\x1B\x40";

const QL720NW_CMD_SET_ORIENTATION  = "\x1B\x69\x4C";
const QL720NW_CMD_SET_TB_MARGINS   = "\x1B\x28\x63\x34\x30";
const QL720NW_CMD_SET_LEFT_MARGIN  = "\x1B\x6C";
const QL720NW_CMD_SET_RIGHT_MARGIN = "\x1B\x51";

const QL720NW_CMD_ITALIC_START     = "\x1B\x34";
const QL720NW_CMD_ITALIC_STOP      = "\x1B\x35";
const QL720NW_CMD_BOLD_START       = "\x1B\x45";
const QL720NW_CMD_BOLD_STOP        = "\x1B\x46";
const QL720NW_CMD_UNDERLINE_START  = "\x1B\x2D\x31";
const QL720NW_CMD_UNDERLINE_STOP   = "\x1B\x2D\x30";

const QL720NW_CMD_SET_FONT_SIZE    = "\x1B\x58\x00";
const QL720NW_CMD_SET_FONT         = "\x1B\x6B";

const QL720NW_CMD_BARCODE          = "\x1B\x69";
const QL720NW_CMD_BARCODE_DATA     = "\x62"
const QL720NW_CMD_2D_BARCODE       = "\x1B\x69\x71";

// Orientation Parameters
const QL720NW_LANDSCAPE            = 0x31;
const QL720NW_PORTRAIT             = 0x30;

// Special Characters
const QL720NW_TEXT_NEWLINE         = 0x0A;
const QL720NW_PAGE_FEED            = 0x0C;
const QL720NW_BACKSLASH            = 0x5C;

// Font Parameters
const QL720NW_ITALIC               = 0x01;
const QL720NW_BOLD                 = 0x02;
const QL720NW_UNDERLINE            = 0x04;

const QL720NW_FONT_SIZE_24         = 24;
const QL720NW_FONT_SIZE_32         = 32;
const QL720NW_FONT_SIZE_48         = 48;

const QL720NW_FONT_BROUGHAM           = 0x00;
const QL720NW_FONT_LETTER_GOTHIC_BOLD = 0x01;
const QL720NW_FONT_BRUSSELS           = 0x02;
const QL720NW_FONT_HELSINKI           = 0x03;
const QL720NW_FONT_SAN_DIEGO          = 0x04;

const QL720NW_DOTS_PER_INCH           = 300;

// Barcode Parameters
// Keep as strings since this correlates with data sheet
const QL720NW_BARCODE_CODE39        = "t0";
const QL720NW_BARCODE_ITF           = "t1";
const QL720NW_BARCODE_EAN_8_13      = "t5";
const QL720NW_BARCODE_UPC_A         = "t5";
const QL720NW_BARCODE_UPC_E         = "t6";
const QL720NW_BARCODE_CODABAR       = "t9";
const QL720NW_BARCODE_CODE128       = "ta";
const QL720NW_BARCODE_GS1_128       = "tb";
const QL720NW_BARCODE_RSS           = "tc";
const QL720NW_BARCODE_CODE93        = "td";
const QL720NW_BARCODE_POSTNET       = "te";
const QL720NW_BARCODE_UPC_EXTENTION = "tf";

const QL720NW_BARCODE_CHARS         = "r1";
const QL720NW_BARCODE_NO_CHARS      = "r0";

const QL720NW_BARCODE_WIDTH_XXS     = "w4";
const QL720NW_BARCODE_WIDTH_XS      = "w0";
const QL720NW_BARCODE_WIDTH_S       = "w1";
const QL720NW_BARCODE_WIDTH_M       = "w2";
const QL720NW_BARCODE_WIDTH_L       = "w3";

const QL720NW_BARCODE_RATIO_2_1     = "z0";
const QL720NW_BARCODE_RATIO_25_1    = "z1";
const QL720NW_BARCODE_RATIO_3_1     = "z2";

const QL720NW_DEFAULT_HEIGHT        = 0.5;

// 2D Barcode Parameters
const QL720NW_BARCODE_2D_QR            = 0x71;
const QL720NW_BARCODE_2D_DATAMATRIX    = 0x64;

const QL720NW_BARCODE_2D_CELL_SIZE_3   = 0x03;
const QL720NW_BARCODE_2D_CELL_SIZE_4   = 0x04;
const QL720NW_BARCODE_2D_CELL_SIZE_5   = 0x05;
const QL720NW_BARCODE_2D_CELL_SIZE_6   = 0x06;
const QL720NW_BARCODE_2D_CELL_SIZE_8   = 0x08;
const QL720NW_BARCODE_2D_CELL_SIZE_10  = 0x0A;

// 2D QR Barcode Parameters
const QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_1    = 0x01;
const QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_2    = 0x02;
const QL720NW_BARCODE_2D_QR_SYMBOL_MICRO_QR   = 0x03;

const QL720NW_BARCODE_2D_QR_STRUCTURE_NOT_PARTITIONED = 0x00;
const QL720NW_BARCODE_2D_QR_STRUCTURE_PARTITIONED     = 0x01;

const QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_HIGH_DENSITY             = 0x01;
const QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_STANDARD                 = 0x02;
const QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_HIGH_RELIABILITY         = 0x03;
const QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_ULTRA_HIGH_RELIABILITY   = 0x04;

const QL720NW_BARCODE_2D_QR_DATA_INPUT_AUTO     = 0x00;
const QL720NW_BARCODE_2D_QR_DATA_INPUT_MANUAL   = 0x01;

const QL720NW_DEFAULT_CODE_NUMBER               = 0x00;
const QL720NW_DEFAULT_NUM_PARTITIONS            = 0x00;
const QL720NW_DEFAULT_PARITY_DATA               = 0x00;

// 2D DataMatrix Barcode Parameters
const QL720NW_BARCODE_2D_DM_SYMBOL_SQUARE       = 0x00;
const QL720NW_BARCODE_2D_DM_SYMBOL_RECTANGLE    = 0x01;

const QL720NW_BARCODE_2D_DM_VERTICAL_AUTO       = 0x00;
const QL720NW_BARCODE_2D_DM_VERTICAL_8          = 0x08;
const QL720NW_BARCODE_2D_DM_VERTICAL_10         = 0x0A;
const QL720NW_BARCODE_2D_DM_VERTICAL_12         = 0x0C;
const QL720NW_BARCODE_2D_DM_VERTICAL_14         = 0x0E;
const QL720NW_BARCODE_2D_DM_VERTICAL_16         = 0x10;
const QL720NW_BARCODE_2D_DM_VERTICAL_18         = 0x12;
const QL720NW_BARCODE_2D_DM_VERTICAL_20         = 0x14;
const QL720NW_BARCODE_2D_DM_VERTICAL_22         = 0x16;
const QL720NW_BARCODE_2D_DM_VERTICAL_24         = 0x18;
const QL720NW_BARCODE_2D_DM_VERTICAL_26         = 0x1A;
const QL720NW_BARCODE_2D_DM_VERTICAL_32         = 0x20;
const QL720NW_BARCODE_2D_DM_VERTICAL_36         = 0x24;
const QL720NW_BARCODE_2D_DM_VERTICAL_40         = 0x28;
const QL720NW_BARCODE_2D_DM_VERTICAL_44         = 0x2C;
const QL720NW_BARCODE_2D_DM_VERTICAL_48         = 0x30;
const QL720NW_BARCODE_2D_DM_VERTICAL_52         = 0x34;
const QL720NW_BARCODE_2D_DM_VERTICAL_64         = 0x40;
const QL720NW_BARCODE_2D_DM_VERTICAL_72         = 0x48;
const QL720NW_BARCODE_2D_DM_VERTICAL_80         = 0x50;
const QL720NW_BARCODE_2D_DM_VERTICAL_88         = 0x58;
const QL720NW_BARCODE_2D_DM_VERTICAL_96         = 0x60;
const QL720NW_BARCODE_2D_DM_VERTICAL_104        = 0x68;
const QL720NW_BARCODE_2D_DM_VERTICAL_120        = 0x78;
const QL720NW_BARCODE_2D_DM_VERTICAL_132        = 0x84;
const QL720NW_BARCODE_2D_DM_VERTICAL_144        = 0x90;

const QL720NW_BARCODE_2D_DM_HORIZONTAL_X        = "x";
const QL720NW_BARCODE_2D_DM_HORIZONTAL_AUTO     = 0x00;
const QL720NW_BARCODE_2D_DM_HORIZONTAL_18       = 0x12;
const QL720NW_BARCODE_2D_DM_HORIZONTAL_26       = 0x1A;
const QL720NW_BARCODE_2D_DM_HORIZONTAL_32       = 0x20;
const QL720NW_BARCODE_2D_DM_HORIZONTAL_36       = 0x24;
const QL720NW_BARCODE_2D_DM_HORIZONTAL_48       = 0x30;

// Store parameter as a string because of length, but note that you can not concatinate with format()
const QL720NW_BARCODE_2D_DM_RESERVED            = "\x00\x00\x00\x00\x00";

// Error Messages
const ERROR_INVALID_ORIENTATION          = "Invalid Orientation";
const ERROR_UNKNOWN_FONT                 = "Unknown font";
const ERROR_INVALID_FONT_SIZE            = "Invalid font size";
const ERROR_2D_BARCODE_NOT_SUPPORTED     = "2D barcode type not supported";
const ERROR_INVALID_CODE_NUMBER          = "Code number must be between 1-16";
const ERROR_INVALID_NUMBER_OF_PARTITIONS = "Number of partitions must be between 2-16";

class QL720NW {

    static VERSION = "0.3.0";

    _uart = null;   // A preconfigured UART
    _buffer = null; // buffer for building text

    constructor(uart, init = true) {
        _uart = uart;
        _buffer = blob();

        if (init) initialize();
    }

    function initialize() {
        _uart.write(QL720NW_CMD_ESCP_ENABLE); // Select ESC/P mode
        _uart.write(QL720NW_CMD_ESCP_INIT);   // Initialize ESC/P mode

        return this;
    }

    // Formating commands
    // --------------------------------------------------------------------------
    function setOrientation(orientation) {
        if (orientation == QL720NW_LANDSCAPE || orientation == QL720NW_PORTRAIT) {
            // Write orientation to uart
            _uart.write(format("%s%c", QL720NW_CMD_SET_ORIENTATION, orientation));
        } else {
            throw ERROR_INVALID_ORIENTATION;
        }

        return this;
    }

    function setRightMargin(column) {
        return _setMargin(QL720NW_CMD_SET_RIGHT_MARGIN, column);
    }

    function setLeftMargin(column) {
        return _setMargin(QL720NW_CMD_SET_LEFT_MARGIN, column);;
    }

    function setFont(font) {
        // Current supported fonts number 0 to 4
        if (font < 0 || font > 4) {
            throw ERROR_UNKNOWN_FONT;
        } else {
            _buffer.writestring(format("%s%c", QL720NW_CMD_SET_FONT, font));
        }
        return this;
    }

    function setFontSize(size) {
        if (size != 24 && size != 32 && size != 48) {
            throw ERROR_INVALID_FONT_SIZE;
        } else {
            // Write command, size lower bit, size upper bit
            _buffer.writestring(QL720NW_CMD_SET_FONT_SIZE); // Command has 0x00 char(s), so cannnot use format()
            _buffer.writestring(format("%c%c", size & 0xFF, (size >> 8) & 0xFF));
        }
        return this;
    }

    // Text commands
    // --------------------------------------------------------------------------

    function write(text, options = 0) {
        local beforeText = "";
        local afterText = "";

        if (options & QL720NW_ITALIC) {
            beforeText  += QL720NW_CMD_ITALIC_START;
            afterText   += QL720NW_CMD_ITALIC_STOP;
        }

        if (options & QL720NW_BOLD) {
            beforeText  += QL720NW_CMD_BOLD_START;
            afterText   += QL720NW_CMD_BOLD_STOP;
        }

        if (options & QL720NW_UNDERLINE) {
            beforeText  += QL720NW_CMD_UNDERLINE_START;
            afterText   += QL720NW_CMD_UNDERLINE_STOP;
        }

        _buffer.writestring(format("%s%s%s", beforeText, text, afterText));

        return this;
    }

    function writen(text, options = 0) {
        return write(format("%s%c", text, QL720NW_TEXT_NEWLINE), options);
    }

    function newline() {
        return write(QL720NW_TEXT_NEWLINE.tochar());
    }

    // Barcode commands
    // --------------------------------------------------------------------------

    function writeBarcode(data, config = {}) {
        // Write barcode command and parameters to buffer
        _buffer.writestring(QL720NW_CMD_BARCODE);
        _buffer.writestring((!("type" in config)) ? QL720NW_BARCODE_CODE39 : config.type);
        _buffer.writestring((!("charsBelowBarcode" in config) || config.charsBelowBarcode) ? QL720NW_BARCODE_CHARS : QL720NW_BARCODE_NO_CHARS);
        _buffer.writestring((!("width" in config)) ? QL720NW_BARCODE_WIDTH_XS : config.width); 
        _buffer.writestring((!("height" in config)) ? _getBarcodeHeightCmd(QL720NW_DEFAULT_HEIGHT) : _getBarcodeHeightCmd(config.height));
        _buffer.writestring((!("ratio" in config)) ? QL720NW_BARCODE_RATIO_2_1 : config.ratio);

        // Write data & ending command to buffer
        local endBarcode = (config.type == QL720NW_BARCODE_CODE128 || config.type == QL720NW_BARCODE_GS1_128 || config.type == QL720NW_BARCODE_CODE93) ? format("%c%c%c", QL720NW_BACKSLASH, QL720NW_BACKSLASH, QL720NW_BACKSLASH) : QL720NW_BACKSLASH.tochar();
        _buffer.writestring(format("%s%s%s", QL720NW_CMD_BARCODE_DATA, data, endBarcode));

        return this;
    }

    function write2dBarcode(data, type, config = {}) {
        // Note for 2d barcodes the order of the paramters matters
        local cell_size = (!("cell_size" in config)) ? QL720NW_BARCODE_2D_CELL_SIZE_3 : config.cell_size;
        // Organize and check parameters for errors before writing to print buffer 
        local paramsBuffer = blob();
        // Set barcode command and parameters
        paramsBuffer.writestring(QL720NW_CMD_2D_BARCODE);
        switch (type) {
            case QL720NW_BARCODE_2D_QR :
                paramsBuffer.writen(QL720NW_BARCODE_2D_QR, 'b');
                paramsBuffer.writen(cell_size, 'b');
                _setQRParams(config, paramsBuffer);
                break;
            case QL720NW_BARCODE_2D_DATAMATRIX : 
                paramsBuffer.writen(QL720NW_BARCODE_2D_DATAMATRIX, 'b');
                paramsBuffer.writen(cell_size, 'b');
                _setDMParams(config, paramsBuffer);
                break;
            default : 
                throw ERROR_2D_BARCODE_NOT_SUPPORTED;
        }

        // Write the barcode parameters to buffer
        _buffer.writeblob(paramsBuffer);
        // Write the barcode to buffer
        _buffer.writestring(format("%s%c%c%c", data, QL720NW_BACKSLASH, QL720NW_BACKSLASH, QL720NW_BACKSLASH));

        return this;
    }

    // Prints Command
    // --------------------------------------------------------------------------

    function print() {
        _buffer.writen(QL720NW_PAGE_FEED, 'b');
        _uart.write(_buffer);
        // Clear buffer
        _buffer = blob();
    }

    // Private Functions
    // ------------------------------------------------------------------------------------------------------

    function _setDMParams(config, paramsBuffer) {
        // Note for 2d barcodes the order of the paramters matters
        // Write Data Matrix parameters to buffer
        paramsBuffer.writen((!("symbol_type" in config)) ? QL720NW_BARCODE_2D_DM_SYMBOL_SQUARE : config.symbol_type, 'b');
        paramsBuffer.writen((!("vertical_size" in config)) ? QL720NW_BARCODE_2D_DM_VERTICAL_AUTO : config.vertical_size, 'b');
        paramsBuffer.writen((!("horizontal_size" in config)) ? QL720NW_BARCODE_2D_DM_HORIZONTAL_AUTO : config.horizontal_size, 'b');
        paramsBuffer.writestring(QL720NW_BARCODE_2D_DM_RESERVED);
    }

    function _setQRParams(config, paramsBuffer) {
        // Note for 2d barcodes the order of the paramters matters

        // Write QR parameters to buffer
        paramsBuffer.writen((!("symbol_type" in config)) ? QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_2 : config.symbol_type, 'b');
        
        // Configure structure append partitioned or not partitioned paramters
        if (!("structured_append_partitioned" in config) || !config.structured_append_partitioned) { 
            paramsBuffer.writen(QL720NW_BARCODE_2D_QR_STRUCTURE_NOT_PARTITIONED, 'b');
            paramsBuffer.writen(QL720NW_DEFAULT_CODE_NUMBER, 'b');
            paramsBuffer.writen(QL720NW_DEFAULT_NUM_PARTITIONS, 'b');
            paramsBuffer.writen(QL720NW_DEFAULT_PARITY_DATA, 'b');
        } else {
            paramsBuffer.writen(QL720NW_BARCODE_2D_QR_STRUCTURE_PARTITIONED, 'b');
            if (!("code_number" in config) || config.code_number < 1 || config.code_number > 16) { 
                throw ERROR_INVALID_CODE_NUMBER; 
            } else {
                paramsBuffer.writen(config.code_number, 'b');
            }
            if (!("num_partitions" in config) || config.num_partitions < 2 || config.num_partitions > 16) { 
                throw ERROR_INVALID_NUMBER_OF_PARTITIONS; 
            } else {
                paramsBuffer.writen(config.num_partitions, 'b');
            }
            if (!("parity_data" in config)) { 
                paramsBuffer.writen(QL720NW_DEFAULT_PARITY_DATA, 'b');
            } else {
                paramsBuffer.writen(config.parity_data, 'b');
            }
        }

        // Write QR parameters to buffer
        paramsBuffer.writen((!("error_correction" in config)) ? QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_STANDARD : config.error_correction, 'b');
        paramsBuffer.writen((!("data_input_method" in config)) ? QL720NW_BARCODE_2D_QR_DATA_INPUT_AUTO : config.data_input_method, 'b');
    }

    function _getBarcodeHeightCmd(height) {
        // set to defualt height if non-numeric height was passed in
        if (typeof height != "integer" || typeof height != "float") height = QL720NW_DEFAULT_HEIGHT; 
        // Convert height (in inches) to dots
        height = (height * QL720NW_DOTS_PER_INCH).tointeger();
        // Height marker command "h", height lower bit, height upper bit
        return format("h%c%c", height & 0xFF, (height >> 8) & 0xFF);
    }

    function _setMargin(command, margin) {
        _uart.write(format("%s%c", command, margin & 0xFF));
        return this;
    }

    function _typeof() {
        return "QL720NW";
    }
}
