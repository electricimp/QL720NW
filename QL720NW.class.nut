class QL720NW {
    static version = [0,2,0];

    _uart = null;   // A preconfigured UART
    _buffer = null; // buffer for building text

    // Commands
    static CMD_ESCP_ENABLE      = "\x1B\x69\x61\x00";
    static CMD_ESCP_INIT        = "\x1B\x40";

    static CMD_SET_ORIENTATION  = "\x1B\x69\x4C"
    static CMD_SET_TB_MARGINS   = "\x1B\x28\x63\x34\x30";
    static CMD_SET_LEFT_MARGIN  = "\x1B\x6C";
    static CMD_SET_RIGHT_MARGIN = "\x1B\x51";

    static CMD_ITALIC_START     = "\x1b\x34";
    static CMD_ITALIC_STOP      = "\x1B\x35";
    static CMD_BOLD_START       = "\x1b\x45";
    static CMD_BOLD_STOP        = "\x1B\x46";
    static CMD_UNDERLINE_START  = "\x1B\x2D\x31";
    static CMD_UNDERLINE_STOP   = "\x1B\x2D\x30";

    static CMD_SET_FONT_SIZE    = "\x1B\x58\x00";
    static CMD_SET_FONT         = "\x1B\x6B";

    static CMD_BARCODE          = "\x1B\x69"
    static CMD_2D_BARCODE       = "\x1B\x69"

    static LANDSCAPE            = "\x31";
    static PORTRAIT             = "\x30";

    // Special characters
    static TEXT_NEWLINE         = "\x0A";
    static PAGE_FEED            = "\x0C";

    // Font Parameters
    static ITALIC               = 1;
    static BOLD                 = 2;
    static UNDERLINE            = 4;

    static FONT_SIZE_24         = 24;
    static FONT_SIZE_32         = 32;
    static FONT_SIZE_48         = 48;

    static FONT_BROUGHAM        = 0;
    static FONT_LETTER_GOTHIC_BOLD = 1;
    static FONT_BRUSSELS        = 2;
    static FONT_HELSINKI        = 3;
    static FONT_SAN_DIEGO       = 4;

    // Barcode Parameters
    static BARCODE_CODE39       = "t0";
    static BARCODE_ITF          = "t1";
    static BARCODE_EAN_8_13     = "t5";
    static BARCODE_UPC_A = "t5";
    static BARCODE_UPC_E        = "t6";
    static BARCODE_CODABAR      = "t9";
    static BARCODE_CODE128      = "ta";
    static BARCODE_GS1_128      = "tb";
    static BARCODE_RSS          = "tc";
    static BARCODE_CODE93       = "td";
    static BARCODE_POSTNET      = "te";
    static BARCODE_UPC_EXTENTION = "tf";

    static BARCODE_CHARS        = "r1";
    static BARCODE_NO_CHARS     = "r0";

    static BARCODE_WIDTH_XXS    = "w4";
    static BARCODE_WIDTH_XS     = "w0";
    static BARCODE_WIDTH_S      = "w1";
    static BARCODE_WIDTH_M      = "w2";
    static BARCODE_WIDTH_L      = "w3";

    static BARCODE_RATIO_2_1     = "z0";
    static BARCODE_RATIO_25_1    = "z1";
    static BARCODE_RATIO_3_1     = "z2";

    // 2D Barcode Parameters
    static BARCODE_2D_QR = "\x71";
    static BARCODE_2D_DATAMATRIX = "\x64";

    static BARCODE_2D_CELL_SIZE_3   = "\x03";
    static BARCODE_2D_CELL_SIZE_4   = "\x04";
    static BARCODE_2D_CELL_SIZE_5   = "\x05";
    static BARCODE_2D_CELL_SIZE_6   = "\x06";
    static BARCODE_2D_CELL_SIZE_8   = "\x08";
    static BARCODE_2D_CELL_SIZE_10  = "\x0A";

    // 2D QR Barcode Parameters
    static BARCODE_2D_QR_SYMBOL_MODEL_1    = "\x01";
    static BARCODE_2D_QR_SYMBOL_MODEL_2    = "\x02";
    static BARCODE_2D_QR_SYMBOL_MICRO_QR   = "\x03";

    static BARCODE_2D_QR_STRUCTURE_NOT_PARTITIONED = "\x00";
    static BARCODE_2D_QR_STRUCTURE_PARTITIONED     = "\x01";

    static BARCODE_2D_QR_ERROR_CORRECTION_HIGH_DENSITY             = "\x01";
    static BARCODE_2D_QR_ERROR_CORRECTION_STANDARD                 = "\x02";
    static BARCODE_2D_QR_ERROR_CORRECTION_HIGH_RELIABILITY         = "\x03";
    static BARCODE_2D_QR_ERROR_CORRECTION_ULTRA_HIGH_RELIABILITY   = "\x04";

    static BARCODE_2D_QR_DATA_INPUT_AUTO   = "\x00";
    static BARCODE_2D_QR_DATA_INPUT_MANUAL = "\x01";

    // 2D DataMatrix Barcode Parameters
    static BARCODE_2D_DM_SYMBOL_SQUARE = "\x00";
    static BARCODE_2D_DM_SYMBOL_RECTANGLE = "\x01";

    static BARCODE_2D_DM_VERTICAL_AUTO = "\x00";
    static BARCODE_2D_DM_VERTICAL_8 = "\x08";
    static BARCODE_2D_DM_VERTICAL_10 = "\x0A";
    static BARCODE_2D_DM_VERTICAL_12 = "\x0C";
    static BARCODE_2D_DM_VERTICAL_14 = "\x0E";
    static BARCODE_2D_DM_VERTICAL_16 = "\x10";
    static BARCODE_2D_DM_VERTICAL_18 = "\x12";
    static BARCODE_2D_DM_VERTICAL_20 = "\x14";
    static BARCODE_2D_DM_VERTICAL_22 = "\x16";
    static BARCODE_2D_DM_VERTICAL_24 = "\x18";
    static BARCODE_2D_DM_VERTICAL_26 = "\x1A";
    static BARCODE_2D_DM_VERTICAL_32 = "\x20";
    static BARCODE_2D_DM_VERTICAL_36 = "\x24";
    static BARCODE_2D_DM_VERTICAL_40 = "\x28";
    static BARCODE_2D_DM_VERTICAL_44 = "\x2C";
    static BARCODE_2D_DM_VERTICAL_48 = "\x30";
    static BARCODE_2D_DM_VERTICAL_52 = "\x34";
    static BARCODE_2D_DM_VERTICAL_64 = "\x40";
    static BARCODE_2D_DM_VERTICAL_72 = "\x48";
    static BARCODE_2D_DM_VERTICAL_80 = "\x50";
    static BARCODE_2D_DM_VERTICAL_88 = "\x58";
    static BARCODE_2D_DM_VERTICAL_96 = "\x60";
    static BARCODE_2D_DM_VERTICAL_104 = "\x68";
    static BARCODE_2D_DM_VERTICAL_120 = "\x78";
    static BARCODE_2D_DM_VERTICAL_132 = "\x84";
    static BARCODE_2D_DM_VERTICAL_144 = "\x90";

    static BARCODE_2D_DM_HORIZONTAL_X = "x";
    static BARCODE_2D_DM_HORIZONTAL_AUTO = "\x00";
    static BARCODE_2D_DM_HORIZONTAL_18 = "\x12";
    static BARCODE_2D_DM_HORIZONTAL_26 = "\x1A";
    static BARCODE_2D_DM_HORIZONTAL_32 = "\x20";
    static BARCODE_2D_DM_HORIZONTAL_36 = "\x24";
    static BARCODE_2D_DM_HORIZONTAL_48 = "\x30";

    static BARCODE_2D_DM_RESERVED = "\x00\x00\x00\x00\x00";

    constructor(uart, init = true) {
        _uart = uart;
        _buffer = blob();

        if (init) return initialize();
    }

    function initialize() {
        _uart.write(CMD_ESCP_ENABLE); // Select ESC/P mode
        _uart.write(CMD_ESCP_INIT); // Initialize ESC/P mode

        return this;
    }


    // Formating commands
    function setOrientation(orientation) {
        // Create a new buffer that we prepend all of this information to
        local orientationBuffer = blob();

        // Set the orientation
        orientationBuffer.writestring(CMD_SET_ORIENTATION);
        orientationBuffer.writestring(orientation);

        _uart.write(orientationBuffer);

        return this;
    }

    function setRightMargin(column) {
        return _setMargin(CMD_SET_RIGHT_MARGIN, column);
    }

    function setLeftMargin(column) {
        return _setMargin(CMD_SET_LEFT_MARGIN, column);;
    }

    function setFont(font) {
        if (font < 0 || font > 4) throw "Unknown font";

        _buffer.writestring(CMD_SET_FONT);
        _buffer.writen(font, 'b');

        return this;
    }

    function setFontSize(size) {
        if (size != 24 && size != 32 && size != 48) throw "Invalid font size";

        _buffer.writestring(CMD_SET_FONT_SIZE)
        _buffer.writen(size, 'b');
        _buffer.writen(0, 'b');

        return this;
    }

    // Text commands
    function write(text, options = 0) {
        local beforeText = "";
        local afterText = "";

        if (options & ITALIC) {
            beforeText  += CMD_ITALIC_START;
            afterText   += CMD_ITALIC_STOP;
        }

        if (options & BOLD) {
            beforeText  += CMD_BOLD_START;
            afterText   += CMD_BOLD_STOP;
        }

        if (options & UNDERLINE) {
            beforeText  += CMD_UNDERLINE_START;
            afterText   += CMD_UNDERLINE_STOP;
        }

        _buffer.writestring(beforeText + text + afterText);

        return this;
    }

    function writen(text, options = 0) {
        return write(text + TEXT_NEWLINE, options);
    }

    function newline() {
        return write(TEXT_NEWLINE);
    }

    // Barcode commands
    function writeBarcode(data, config = {}) {
        // Set defaults
        if(!("type" in config)) { config.type <- BARCODE_CODE39; }
        if(!("charsBelowBarcode" in config)) { config.charsBelowBarcode <- true; }
        if(!("width" in config)) { config.width <- BARCODE_WIDTH_XS; }
        if(!("height" in config)) { config.height <- 0.5; }
        if(!("ratio" in config)) { config.ratio <- BARCODE_RATIO_2_1; }

        // Start the barcode
        _buffer.writestring(CMD_BARCODE);

        // Set the type
        _buffer.writestring(config.type);

        // Set the text option
        if (config.charsBelowBarcode) {
            _buffer.writestring(BARCODE_CHARS);
        } else {
            _buffer.writestring(BARCODE_NO_CHARS);
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
        if (config.type == BARCODE_CODE128 || config.type == BARCODE_GS1_128 || config.type == BARCODE_CODE93) {
            _buffer.writestring("\x5C\x5C\x5C");
        } else {
            _buffer.writestring("\x5C");
        }

        return this;
    }

    function write2dBarcode(data, type, config = {}) {
        // Set Defaults
        if (!("cell_size" in config)) { config.cell_size <- BARCODE_2D_CELL_SIZE_3; }
        if (type == BARCODE_2D_QR) { config = _setQRDefaults(config); }
        if (type == BARCODE_2D_DATAMATRIX) { config = _setDMDefaults(config); }

        // Start the barcode
        _buffer.writestring(CMD_2D_BARCODE);
        _buffer.writestring(config.type);

        // Set the parameters
        _buffer.writestring(config.cell_size);
        _buffer.writestring(config.symbol_type);

        if (type == BARCODE_2D_QR) {
            _buffer.writestring(config.structured_append);
            _buffer.writestring(config.code_number);
            _buffer.writestring(config.num_partitions);
            _buffer.writestring(config.parity_data);
            _buffer.writestring(config.error_correction);
            _buffer.writestring(config.data_input_method);
        }

        if (type == BARCODE_2D_DATAMATRIX) {
            _buffer.writestring(config.vertical_size);
            _buffer.writestring(config.horizontal_size);
            _buffer.writestring(BARCODE_2D_DM_RESERVED);
        }

        // Write data
        _buffer.writestring(data);

        // End the barcode
        _buffer.writestring("\x5C\x5C\x5C");

        return this;
    }

    // Prints the label
    function print() {
        _buffer.writestring(PAGE_FEED);
        _uart.write(_buffer);
        _buffer = blob();
    }

    function _setDMDefaults(config) {
        config.type <- BARCODE_2D_DATAMATRIX;
        if (!("symbol_type" in config)) { config.symbol_type <- BARCODE_2D_DM_SYMBOL_SQUARE; }
        if (!("vertical_size" in config)) { config.vertical_size <- BARCODE_2D_DM_VERTICAL_AUTO; }
        if (!("horizontal_size" in config)) { config.horizontal_size <- BARCODE_2D_DM_HORIZONTAL_AUTO; }
        return config;
    }

    function _setQRDefaults(config) {
        config.type <- BARCODE_2D_QR;
        if (!("symbol_type" in config)) { config.symbol_type <- BARCODE_2D_QR_SYMBOL_MODEL_2; }
        if (!("structured_append_partitioned" in config)) { config.structured_append_partitioned <- false; }
        if (!("code_number" in config)) { config.code_number <- 0; }
        if (!("num_partitions" in config)) { config.num_partitions <- 0; }
        if (!("parity_data" in config)) { config["parity_data"] <- 0; }
        if (!("error_correction" in config)) { config["error_correction"] <- BARCODE_2D_QR_ERROR_CORRECTION_STANDARD; }
        if (!("data_input_method" in config)) { config["data_input_method"] <- BARCODE_2D_QR_DATA_INPUT_AUTO; }

        // Check ranges
        if (config.structured_append_partitioned) {
            config.structured_append <- BARCODE_2D_QR_STRUCTURE_PARTITIONED;
            if (config.code_number < 1 || config.code_number > 16) throw "Unknown code number";
            if (config.num_partitions < 2 || config.num_partitions > 16) throw "Unknown number of partitions";
        } else {
            config.structured_append <- BARCODE_2D_QR_STRUCTURE_NOT_PARTITIONED;
            config.code_number = "\x00";
            config.num_partitions = "\x00";
            config.parity_data = "\x00";
        }
        return config;
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