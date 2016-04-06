class QL720NW {
    static version = [1,0,0];
    
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

    static BARCOD_RATIO_2_1     = "z0";
    static BARCOD_RATIO_25_1    = "z1";
    static BARCOD_RATIO_3_1     = "z2";

    constructor(uart, init = true) {
        _uart = uart;
        _buffer = blob();
        
        if (init) return initialize();
    }
    
    function initialize() {
        _uart.write(CMD_ESCP_ENABLE);
        _uart.write(CMD_ESCP_INIT);
        
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
    function writeBarcode(data, type = "t0", charsBelowText = true, width = "w4", height = 0.5, ratio = "z3") {
        // Start the barcode
        _buffer.writestring(CMD_BARCODE);
        
        // Set the type
        _buffer.writestring(type);
        
        // Set the text option
        if (charsBelowText) _buffer.writestring(BARCODE_CHARS);
        else _buffer.writestring(BARCODE_NO_CHARS);
        
        // Set the width
        _buffer.writestring(width);
        
        // Convert height to dots
        local h = (height*300).tointeger();
        
        _buffer.writestring("h");               // Height marker
        _buffer.writen(h & 0xFF, 'b');          // Lower bit of height
        _buffer.writen((h / 256) & 0xFF, 'b');  // Upper bit of height
        
        // Set the ratio of thick to thin bars
        _buffer.writestring(ratio);
        
        _buffer.writestring("\x62");
        _buffer.writestring(data);
        _buffer.writestring("\x5C");
        
        return this;
    }
    
    // Prints the label
    function print() {
        _buffer.writestring(PAGE_FEED);
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

uart <- hardware.uart12;
uart.configure(9600, 8, PARITY_NONE, 1, NO_CTSRTS, function() {
    server.log(uart.readstring());
});

printer <- QL720NW(uart)
    .setOrientation(QL720NW.LANDSCAPE);

printer
    .setFont(QL720NW.FONT_BROUGHAM)
        .setFontSize(QL720NW.FONT_SIZE_48).write("Brougham 48 ")
        .setFontSize(QL720NW.FONT_SIZE_32).write("Brougham 32 ")
        .setFontSize(QL720NW.FONT_SIZE_24).write("Brougham 24")
        .newline()
    .setFont(QL720NW.FONT_LETTER_GOTHIC_BOLD)
        .setFontSize(QL720NW.FONT_SIZE_48).write("Letter Gothic 48 ")
        .setFontSize(QL720NW.FONT_SIZE_32).write("Letter Gothic 32 ")
        .setFontSize(QL720NW.FONT_SIZE_24).write("Letter Gothic 24")
        .newline()
    .setFont(QL720NW.FONT_BRUSSELS)
        .setFontSize(QL720NW.FONT_SIZE_48).write("Brussels 48 ")
        .setFontSize(QL720NW.FONT_SIZE_32).write("Brussels 32 ")
        .setFontSize(QL720NW.FONT_SIZE_24).write("Brussels 24")
        .newline()
    .setFont(QL720NW.FONT_HELSINKI)
        .setFontSize(QL720NW.FONT_SIZE_48).write("Helsink 48 ")
        .setFontSize(QL720NW.FONT_SIZE_32).write("Helsink 32 ")
        .setFontSize(QL720NW.FONT_SIZE_24).write("Helsink 24")
        .newline()
    .setFont(QL720NW.FONT_SAN_DIEGO)
        .setFontSize(QL720NW.FONT_SIZE_48).write("San Diego 48 ")
        .setFontSize(QL720NW.FONT_SIZE_32).write("San Diego 32 ")
        .setFontSize(QL720NW.FONT_SIZE_24).write("San Diego 24")
        .newline()

printer.print();

imp.sleep(0.5)

printer
    .setFont(QL720NW.FONT_HELSINKI)
    .setFontSize(QL720NW.FONT_SIZE_48);

printer.writeBarcode("HIKU 001", QL720NW.BARCODE_CODE39, true, QL720NW.BARCODE_WIDTH_M, 0.33);
printer.writeBarcode(imp.getmacaddress(), QL720NW.BARCODE_CODE39, true, QL720NW.BARCODE_WIDTH_M, 0.33).newline();

printer.print();


server.log("Done");

