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
const QL720NW_CMD_ESCP_ENABLE      = "\x1B\x69\x61\x00";
const QL720NW_CMD_ESCP_INIT        = "\x1B\x40";

const QL720NW_CMD_SET_ORIENTATION  = "\x1B\x69\x4C";
const QL720NW_CMD_SET_TB_MARGINS   = "\x1B\x28\x63\x34\x30";
const QL720NW_CMD_SET_LEFT_MARGIN  = "\x1B\x6C";
const QL720NW_CMD_SET_RIGHT_MARGIN = "\x1B\x51";

const QL720NW_CMD_ITALIC_START     = "\x1b\x34";
const QL720NW_CMD_ITALIC_STOP      = "\x1B\x35";
const QL720NW_CMD_BOLD_START       = "\x1b\x45";
const QL720NW_CMD_BOLD_STOP        = "\x1B\x46";
const QL720NW_CMD_UNDERLINE_START  = "\x1B\x2D\x31";
const QL720NW_CMD_UNDERLINE_STOP   = "\x1B\x2D\x30";

const QL720NW_CMD_SET_FONT_SIZE    = "\x1B\x58\x00";
const QL720NW_CMD_SET_FONT         = "\x1B\x6B";

const QL720NW_CMD_BARCODE          = "\x1B\x69";
const QL720NW_CMD_BARCODE_DATA     = "\x62"
const QL720NW_CMD_2D_BARCODE       = "\x1B\x69\x71";

const QL720NW_LANDSCAPE            = "\x31";
const QL720NW_PORTRAIT             = "\x30";

// Special characters
const QL720NW_TEXT_NEWLINE         = "\x0A";
const QL720NW_PAGE_FEED            = "\x0C";
const QL720NW_BACKSLASH            = "\x5C";

const DOTS_PER_INCH                = 300;

// Font Parameters
const QL720NW_ITALIC               = 1;
const QL720NW_BOLD                 = 2;
const QL720NW_UNDERLINE            = 4;

const QL720NW_FONT_SIZE_24         = 24;
const QL720NW_FONT_SIZE_32         = 32;
const QL720NW_FONT_SIZE_48         = 48;

const QL720NW_FONT_BROUGHAM           = 0;
const QL720NW_FONT_LETTER_GOTHIC_BOLD = 1;
const QL720NW_FONT_BRUSSELS           = 2;
const QL720NW_FONT_HELSINKI           = 3;
const QL720NW_FONT_SAN_DIEGO          = 4;

// Barcode Parameters
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
const QL720NW_BARCODE_2D_QR            = "\x71";
const QL720NW_BARCODE_2D_DATAMATRIX    = "\x64";

const QL720NW_BARCODE_2D_CELL_SIZE_3   = "\x03";
const QL720NW_BARCODE_2D_CELL_SIZE_4   = "\x04";
const QL720NW_BARCODE_2D_CELL_SIZE_5   = "\x05";
const QL720NW_BARCODE_2D_CELL_SIZE_6   = "\x06";
const QL720NW_BARCODE_2D_CELL_SIZE_8   = "\x08";
const QL720NW_BARCODE_2D_CELL_SIZE_10  = "\x0A";

// 2D QR Barcode Parameters
const QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_1    = "\x01";
const QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_2    = "\x02";
const QL720NW_BARCODE_2D_QR_SYMBOL_MICRO_QR   = "\x03";

const QL720NW_BARCODE_2D_QR_STRUCTURE_NOT_PARTITIONED = "\x00";
const QL720NW_BARCODE_2D_QR_STRUCTURE_PARTITIONED     = "\x01";

const QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_HIGH_DENSITY             = "\x01";
const QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_STANDARD                 = "\x02";
const QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_HIGH_RELIABILITY         = "\x03";
const QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_ULTRA_HIGH_RELIABILITY   = "\x04";

const QL720NW_BARCODE_2D_QR_DATA_INPUT_AUTO   = "\x00";
const QL720NW_BARCODE_2D_QR_DATA_INPUT_MANUAL = "\x01";

// 2D DataMatrix Barcode Parameters
const QL720NW_BARCODE_2D_DM_SYMBOL_SQUARE       = "\x00";
const QL720NW_BARCODE_2D_DM_SYMBOL_RECTANGLE    = "\x01";

const QL720NW_BARCODE_2D_DM_VERTICAL_AUTO       = "\x00";
const QL720NW_BARCODE_2D_DM_VERTICAL_8          = "\x08";
const QL720NW_BARCODE_2D_DM_VERTICAL_10         = "\x0A";
const QL720NW_BARCODE_2D_DM_VERTICAL_12         = "\x0C";
const QL720NW_BARCODE_2D_DM_VERTICAL_14         = "\x0E";
const QL720NW_BARCODE_2D_DM_VERTICAL_16         = "\x10";
const QL720NW_BARCODE_2D_DM_VERTICAL_18         = "\x12";
const QL720NW_BARCODE_2D_DM_VERTICAL_20         = "\x14";
const QL720NW_BARCODE_2D_DM_VERTICAL_22         = "\x16";
const QL720NW_BARCODE_2D_DM_VERTICAL_24         = "\x18";
const QL720NW_BARCODE_2D_DM_VERTICAL_26         = "\x1A";
const QL720NW_BARCODE_2D_DM_VERTICAL_32         = "\x20";
const QL720NW_BARCODE_2D_DM_VERTICAL_36         = "\x24";
const QL720NW_BARCODE_2D_DM_VERTICAL_40         = "\x28";
const QL720NW_BARCODE_2D_DM_VERTICAL_44         = "\x2C";
const QL720NW_BARCODE_2D_DM_VERTICAL_48         = "\x30";
const QL720NW_BARCODE_2D_DM_VERTICAL_52         = "\x34";
const QL720NW_BARCODE_2D_DM_VERTICAL_64         = "\x40";
const QL720NW_BARCODE_2D_DM_VERTICAL_72         = "\x48";
const QL720NW_BARCODE_2D_DM_VERTICAL_80         = "\x50";
const QL720NW_BARCODE_2D_DM_VERTICAL_88         = "\x58";
const QL720NW_BARCODE_2D_DM_VERTICAL_96         = "\x60";
const QL720NW_BARCODE_2D_DM_VERTICAL_104        = "\x68";
const QL720NW_BARCODE_2D_DM_VERTICAL_120        = "\x78";
const QL720NW_BARCODE_2D_DM_VERTICAL_132        = "\x84";
const QL720NW_BARCODE_2D_DM_VERTICAL_144        = "\x90";

const QL720NW_BARCODE_2D_DM_HORIZONTAL_X        = "x";
const QL720NW_BARCODE_2D_DM_HORIZONTAL_AUTO     = "\x00";
const QL720NW_BARCODE_2D_DM_HORIZONTAL_18       = "\x12";
const QL720NW_BARCODE_2D_DM_HORIZONTAL_26       = "\x1A";
const QL720NW_BARCODE_2D_DM_HORIZONTAL_32       = "\x20";
const QL720NW_BARCODE_2D_DM_HORIZONTAL_36       = "\x24";
const QL720NW_BARCODE_2D_DM_HORIZONTAL_48       = "\x30";

const QL720NW_BARCODE_2D_DM_RESERVED            = "\x00\x00\x00\x00\x00";

// Error Messages
const ERROR_INVALID_ORIENTATION          = "Invalid Orientation";
const ERROR_UNKNOWN_FONT                 = "Unknown font";
const ERROR_INVALID_FONT_SIZE            = "Invalid font size";
const ERROR_2D_BARCODE_NOT_SUPPORTED     = "2D barcode type not supported";
const ERROR_INVALID_CODE_NUMBER          = "Code number must be between 1-16";
const ERROR_INVALID_NUMBER_OF_PARTITIONS = "Number of partitions must be between 2-16";

class QL720NW {

    static VERSION = "0.2.0";

    _uart = null;   // A preconfigured UART
    _buffer = null; // buffer for building text

    constructor(uart, init = true) {
        _uart = uart;
        _buffer = blob();

        if (init) initialize();
    }

    function initialize() {
        _uart.write(QL720NW_CMD_ESCP_ENABLE); // Select ESC/P mode
        _uart.write(QL720NW_CMD_ESCP_INIT); // Initialize ESC/P mode

        return this;
    }

    // Formating commands

    function setOrientation(orientation) {
        if (orientation == QL720NW_LANDSCAPE || orientation == QL720NW_PORTRAIT) {
            // Create a new buffer that we prepend all of this information to
            local orientationBuffer = blob();

            // Set the orientation
            orientationBuffer.writestring(format("%s%s", QL720NW_CMD_SET_ORIENTATION, orientation));

            // Write data to uart
            _uart.write(orientationBuffer);
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
            _buffer.writestring(format("%s%c%c", QL720NW_CMD_SET_FONT_SIZE, size & 0xFF, (size >> 8) & 0xFF));
        }
        return this;
    }

    // Text commands
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

        _buffer.writestring(beforeText + text + afterText);

        return this;
    }

    function writen(text, options = 0) {
        return write(text + QL720NW_TEXT_NEWLINE, options);
    }

    function newline() {
        return write(QL720NW_TEXT_NEWLINE);
    }

    // Barcode commands
    function writeBarcode(data, config = {}) {
        // Configure barcode parameters
        local params = {};
        params.type <- (!("type" in config)) ? QL720NW_BARCODE_CODE39 : config.type;
        params.charsBelowBarcode <- (!("charsBelowBarcode" in config) || config.charsBelowBarcode) ? QL720NW_BARCODE_CHARS : QL720NW_BARCODE_NO_CHARS; 
        params.width <- (!("width" in config)) ? QL720NW_BARCODE_WIDTH_XS : config.width;
        params.height <- (!("height" in config)) ? _getBarcodeHeightCmd(QL720NW_DEFAULT_HEIGHT) : _getBarcodeHeightCmd(config.height);
        params.ratio <- (!("ratio" in config)) ? QL720NW_BARCODE_RATIO_2_1 : config.ratio;

        // Write barcode parameters to buffer
        _buffer.writestring(format("%s%s%s%s%s%s", QL720NW_CMD_BARCODE, params.type, params.charsBelowBarcode, params.width, params.height, params.ratio));

        // Write data & ending command to buffer
        local endBarcode = (config.type == QL720NW_BARCODE_CODE128 || config.type == QL720NW_BARCODE_GS1_128 || config.type == QL720NW_BARCODE_CODE93) ? format("%s%s%s", QL720NW_BACKSLASH, QL720NW_BACKSLASH, QL720NW_BACKSLASH) : QL720NW_BACKSLASH;
        _buffer.writestring(format("%s%s%s", QL720NW_CMD_BARCODE_DATA, data, endBarcode))

        return this;
    }

    function write2dBarcode(data, type, config = {}) {
        // Set defaults & configure barcode parameters
        local cell_size = (!("cell_size" in config)) ? QL720NW_BARCODE_2D_CELL_SIZE_3 : config.cell_size;
        local barcodeParams = null;
        switch (type) {
            case QL720NW_BARCODE_2D_QR :
                barcodeParams = _getQRParams(cell_size, config);
                break;
            case QL720NW_BARCODE_2D_DATAMATRIX : 
                barcodeParams = _getDMParams(cell_size, config);
                break;
            default : 
                throw ERROR_2D_BARCODE_NOT_SUPPORTED;
        }

        // Write the barcode
        _buffer.writestring(format("%s%s%s%s%s%s%s", QL720NW_CMD_2D_BARCODE, type, barcodeParams, data, QL720NW_BACKSLASH, QL720NW_BACKSLASH, QL720NW_BACKSLASH));

        return this;
    }

    // Prints the label
    function print() {
        _buffer.writestring(QL720NW_PAGE_FEED);
        _uart.write(_buffer);
        _buffer = blob();
    }

    function _getDMParams(cell_size, config) {
        // Configure Data Matrix parameters
        local params = {};
        params.symbol_type <- (!("symbol_type" in config)) ? QL720NW_BARCODE_2D_DM_SYMBOL_SQUARE : config.symbol_type;
        params.vertical_size <- (!("vertical_size" in config)) ? QL720NW_BARCODE_2D_DM_VERTICAL_AUTO : config.vertical_size;
        params.horizontal_size <- (!("horizontal_size" in config)) ? QL720NW_BARCODE_2D_DM_HORIZONTAL_AUTO : config.horizontal_size;
        // Return Data Matrix parameter string
        return format("%s%s%s%s%s", cell_size, params.symbol_type, params.vertical_size, params.horizontal_size, QL720NW_BARCODE_2D_DM_RESERVED);
    }

    function _getQRParams(cell_size, config) {
        // Configure QR paramters
        local params = {};
        params.symbol_type <- (!("symbol_type" in config)) ? QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_2 : config.symbol_type;
        params.error_correction <- (!("error_correction" in config)) ? QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_STANDARD : config.error_correction;
        params.data_input_method <- (!("data_input_method" in config)) ? QL720NW_BARCODE_2D_QR_DATA_INPUT_AUTO : config.data_input_method;
        
        // Configure structure append partitioned or not partitioned paramters
        if (!("structured_append_partitioned" in config) || !config.structured_append_partitioned) { 
            params.structured_append <- QL720NW_BARCODE_2D_QR_STRUCTURE_NOT_PARTITIONED;
            params.code_number <- 0;
            params.num_partitions <- 0;
            params.parity_data <- 0;
        } else {
            params.structured_append <- QL720NW_BARCODE_2D_QR_STRUCTURE_PARTITIONED;
            if (!("code_number" in config) || config.code_number < 1 || config.code_number > 16) { 
                throw ERROR_INVALID_CODE_NUMBER; 
            } else {
                params.code_number <- config.code_number;
            }
            if (!("num_partitions" in config) || config.num_partitions < 2 || config.num_partitions > 16) { 
                throw ERROR_INVALID_NUMBER_OF_PARTITIONS; 
            } else {
                params.num_partitions <- config.num_partitions;
            }
            if (!("parity_data" in config)) { 
                params.parity_data <- 0; 
            } else {
                params.parity_data <- config.parity_data;
            }
        }
        // Return QR parameter string
        return format("%s%s%s%c%c%c%s%s" , cell_size, params.symbol_type, params.structured_append, params.code_number, params.num_partitions, params.parity_data, params.error_correction, params.data_input_method);
    }

    function _getBarcodeHeightCmd(height) {
        // Convert height (in inches) to dots
        height = (height * DOTS_PER_INCH).tointeger();
        // Height marker command "h", height lower bit, height upper bit
        return format("h%c%c", height & 0xFF, (height >> 8) & 0xFF);
    }

    function _setMargin(command, margin) {
        local marginBuffer = blob();
        marginBuffer.writestring(format("%s%c", command, margin & 0xFF));
        _uart.write(marginBuffer);

        return this;
    }

    function _typeof() {
        return "QL720NW";
    }
}
