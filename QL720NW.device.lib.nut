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

const QL720NW_CMD_ESCP_ENABLE      = "\x1B\x69\x61\x00";
const QL720NW_CMD_ESCP_INIT        = "\x1B\x40";

const QL720NW_CMD_SET_ORIENTATION  = "\x1B\x69\x4C"
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

const QL720NW_CMD_BARCODE          = "\x1B\x69"
const QL720NW_CMD_2D_BARCODE       = "\x1B\x69\x71"

const QL720NW_LANDSCAPE            = "\x31";
const QL720NW_PORTRAIT             = "\x30";

// Special characters
const QL720NW_TEXT_NEWLINE         = "\x0A";
const QL720NW_PAGE_FEED            = "\x0C";

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

// 2D Barcode Parameters
const QL720NW_BARCODE_2D_CELL_SIZE_3   = "\x03";
const QL720NW_BARCODE_2D_CELL_SIZE_4   = "\x04";
const QL720NW_BARCODE_2D_CELL_SIZE_5   = "\x05";
const QL720NW_BARCODE_2D_CELL_SIZE_6   = "\x06";
const QL720NW_BARCODE_2D_CELL_SIZE_8   = "\x08";
const QL720NW_BARCODE_2D_CELL_SIZE_10  = "\x0A";

const QL720NW_BARCODE_2D_SYMBOL_MODEL_1    = "\x01";
const QL720NW_BARCODE_2D_SYMBOL_MODEL_2    = "\x02";
const QL720NW_BARCODE_2D_SYMBOL_MICRO_QR   = "\x03";

const QL720NW_BARCODE_2D_STRUCTURE_NOT_PARTITIONED = "\x00";
const QL720NW_BARCODE_2D_STRUCTURE_PARTITIONED     = "\x01";

const QL720NW_BARCODE_2D_ERROR_CORRECTION_HIGH_DENSITY             = "\x01";
const QL720NW_BARCODE_2D_ERROR_CORRECTION_STANDARD                 = "\x02";
const QL720NW_BARCODE_2D_ERROR_CORRECTION_HIGH_RELIABILITY         = "\x03";
const QL720NW_BARCODE_2D_ERROR_CORRECTION_ULTRA_HIGH_RELIABILITY   = "\x04";

const QL720NW_BARCODE_2D_DATA_INPUT_AUTO   = "\x00";
const QL720NW_BARCODE_2D_DATA_INPUT_MANUAL = "\x01";


class QL720NW {

    static VERSION = "0.1.0";

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
        // Create a new buffer that we prepend all of this information to
        local orientationBuffer = blob();

        // Set the orientation
        orientationBuffer.writestring(QL720NW_CMD_SET_ORIENTATION);
        orientationBuffer.writestring(orientation);

        _uart.write(orientationBuffer);

        return this;
    }

    function setRightMargin(column) {
        return _setMargin(CQL720NW_MD_SET_RIGHT_MARGIN, column);
    }

    function setLeftMargin(column) {
        return _setMargin(QL720NW_CMD_SET_LEFT_MARGIN, column);;
    }

    function setFont(font) {
        if (font < 0 || font > 4) throw "Unknown font";

        _buffer.writestring(QL720NW_CMD_SET_FONT);
        _buffer.writen(font, 'b');

        return this;
    }

    function setFontSize(size) {
        if (size != 24 && size != 32 && size != 48) throw "Invalid font size";

        _buffer.writestring(QL720NW_CMD_SET_FONT_SIZE)
        _buffer.writen(size, 'b');
        _buffer.writen(0, 'b');

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
        // Set defaults
        if(!("type" in config)) { config.type <- QL720NW_BARCODE_CODE39; }
        if(!("charsBelowBarcode" in config)) { config.charsBelowBarcode <- true; }
        if(!("width" in config)) { config.width <- QL720NW_BARCODE_WIDTH_XS; }
        if(!("height" in config)) { config.height <- 0.5; }
        if(!("ratio" in config)) { config.ratio <- QL720NW_BARCODE_RATIO_2_1; }

        // Start the barcode
        _buffer.writestring(QL720NW_CMD_BARCODE);

        // Set the type
        _buffer.writestring(config.type);

        // Set the text option
        if (config.charsBelowBarcode) {
            _buffer.writestring(QL720NW_BARCODE_CHARS);
        } else {
            _buffer.writestring(QL720NW_BARCODE_NO_CHARS);
        }

        // Set the width
        _buffer.writestring(config.width);

        // Convert height to dots
        local h = (config.height*300).tointeger();
        // Set the height
        _buffer.writestring("h");               // Height marker
        _buffer.writen(h & 0xFF, 'b');          // Lower bit of height
        _buffer.writen((h / 256) & 0xFF, 'b');  // Upper bit of height

        // Set the ratio of thick to thin bars
        _buffer.writestring(config.ratio);

        // Set data
        _buffer.writestring("\x62");
        _buffer.writestring(data);

        // End the barcode
        if (config.type == QL720NW_BARCODE_CODE128 || config.type == QL720NW_BARCODE_GS1_128 || config.type == QL720NW_BARCODE_CODE93) {
            _buffer.writestring("\x5C\x5C\x5C");
        } else {
            _buffer.writestring("\x5C");
        }

        return this;
    }

    function write2dBarcode(data, config = {}) {
        // Set defaults
        if (!("cell_size" in config)) { config.cell_size <- QL720NW_BARCODE_2D_CELL_SIZE_3; }
        if (!("symbol_type" in config)) { config.symbol_type <- QL720NW_BARCODE_2D_SYMBOL_MODEL_2; }
        if (!("structured_append_partitioned" in config)) { config.structured_append_partitioned <- false; }
        if (!("code_number" in config)) { config.code_number <- 0; }
        if (!("num_partitions" in config)) { config.num_partitions <- 0; }

        if (!("parity_data" in config)) { config["parity_data"] <- 0; }
        if (!("error_correction" in config)) { config["error_correction"] <- QL720NW_BARCODE_2D_ERROR_CORRECTION_STANDARD; }
        if (!("data_input_method" in config)) { config["data_input_method"] <- QL720NW_BARCODE_2D_DATA_INPUT_AUTO; }

        // Check ranges
        if (config.structured_append_partitioned) {
            config.structured_append <- QL720NW_BARCODE_2D_STRUCTURE_PARTITIONED;
            if (config.code_number < 1 || config.code_number > 16) throw "Unknown code number";
            if (config.num_partitions < 2 || config.num_partitions > 16) throw "Unknown number of partitions";
        } else {
            config.structured_append <- QL720NW_BARCODE_2D_STRUCTURE_NOT_PARTITIONED;
            config.code_number = "\x00";
            config.num_partitions = "\x00";
            config.parity_data = "\x00";
        }

        // Start the barcode
        _buffer.writestring(QL720NW_CMD_2D_BARCODE);

        // Set the parameters
        _buffer.writestring(config.cell_size);
        _buffer.writestring(config.symbol_type);
        _buffer.writestring(config.structured_append);
        _buffer.writestring(config.code_number);
        _buffer.writestring(config.num_partitions);
        _buffer.writestring(config.parity_data);
        _buffer.writestring(config.error_correction);
        _buffer.writestring(config.data_input_method);

        // Write data
        _buffer.writestring(data);

        // End the barcode
        _buffer.writestring("\x5C\x5C\x5C");

        return this;
    }

    // Prints the label
    function print() {
        _buffer.writestring(QL720NW_PAGE_FEED);
        _uart.write(_buffer);
        _buffer = blob();
    }

    function _setMargin(command, margin) {
        local marginBuffer = blob();
        marginBuffer.writestring(command);
        marginBuffer.writen(margin & 0xFF, 'b');

        _uart.write(marginBuffer);

        return this;
    }

    function _typeof() {
        return "QL720NW";
    }
}