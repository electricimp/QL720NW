// These tests check the print buffer for expected data, it is not necessary to hook up a printer
// Only the methods writing to the print buffer are covered by these tests
class AutomatedPrintingTests extends ImpTestCase {

    printer = null;

    // Setup is written for an imp001 
    // If connecting a printer this is the configuration for a (kelly) connected with a DB9 connector
    function setUp() {
        local uart = hardware.uart12;
        uart.configure(9600, 8, PARITY_NONE, 1, NO_CTSRTS, function() {
            server.log(uart.readstring());
        });

        printer = QL720NW(uart);
    }

    function test1_setFont() {
        local expected = blob();

        // Set font SanDiego
        expected.writestring(format("%c%c%c", 0x1B, 0x6B, 0x04));
        printer.setFont(QL720NW_FONT_SAN_DIEGO);
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Set font Helsinki
        expected.writestring(format("%c%c%c", 0x1B, 0x6B, 0x03));
        printer.setFont(QL720NW_FONT_HELSINKI);
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Set font Brussels
        expected.writestring(format("%c%c%c", 0x1B, 0x6B, 0x02));
        printer.setFont(QL720NW_FONT_BRUSSELS);
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Set font GothicBold
        expected.writestring(format("%c%c%c", 0x1B, 0x6B, 0x01));
        printer.setFont(QL720NW_FONT_LETTER_GOTHIC_BOLD);
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Set font Brougham
        expected.writestring(format("%c%c%c", 0x1B, 0x6B, 0x00));
        printer.setFont(QL720NW_FONT_BROUGHAM);
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());
    }

    function test2_setFontSize() {
        local expected = blob();

        // Set font size 24
        expected.writestring(format("%c%c%c%c%c", 0x1B, 0x58, 0x00, 24, 0x00));
        printer.setFontSize(QL720NW_FONT_SIZE_24);
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Set font size 32
        expected.writestring(format("%c%c%c%c%c", 0x1B, 0x58, 0x00, 32, 0x00));
        printer.setFontSize(QL720NW_FONT_SIZE_32);
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Set font size 48
        expected.writestring(format("%c%c%c%c%c", 0x1B, 0x58, 0x00, 48, 0x00));
        printer.setFontSize(QL720NW_FONT_SIZE_48);
        assertEqual(expected.tostring(), printer._buffer.tostring());                

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());
    }

    function test3_write() {
        local expected = blob();
        local text = "text";

        // text only
        expected.writestring(text);
        printer.write(text);
        assertEqual(expected.tostring(), printer._buffer.tostring());
        
        // italic text
        expected.writestring(format("%c%c%s%c%c", 0x1B, 0x34, text, 0x1B, 0x35));
        printer.write(text, QL720NW_ITALIC);
        assertEqual(expected.tostring(), printer._buffer.tostring());    

        // bold text
        expected.writestring(format("%c%c%s%c%c", 0x1B, 0x45, text, 0x1B, 0x46));
        printer.write(text, QL720NW_BOLD);
        assertEqual(expected.tostring(), printer._buffer.tostring());       
          
        // underline text
        expected.writestring(format("%c%c%c%s%c%c%c", 0x1B, 0x2D, 0x31, text, 0x1B, 0x2D, 0x30));
        printer.write(text, QL720NW_UNDERLINE);
        assertEqual(expected.tostring(), printer._buffer.tostring());   

        // italic and bold text 
        expected.writestring(format("%c%c%c%c%s%c%c%c%c", 0x1B, 0x34, 0x1B, 0x45, text, 0x1B, 0x35, 0x1B, 0x46));
        printer.write(text, QL720NW_ITALIC | QL720NW_BOLD);
        assertEqual(expected.tostring(), printer._buffer.tostring());  

        // italic and underline text
        expected.writestring(format("%c%c%c%c%c%s%c%c%c%c%c", 0x1B, 0x34, 0x1B, 0x2D, 0x31, text, 0x1B, 0x35, 0x1B, 0x2D, 0x30));
        printer.write(text, QL720NW_ITALIC | QL720NW_UNDERLINE);
        assertEqual(expected.tostring(), printer._buffer.tostring());  

        // bold and underline text
        expected.writestring(format("%c%c%c%c%c%s%c%c%c%c%c", 0x1B, 0x45, 0x1B, 0x2D, 0x31, text, 0x1B, 0x46, 0x1B, 0x2D, 0x30));
        printer.write(text, QL720NW_BOLD | QL720NW_UNDERLINE);
        assertEqual(expected.tostring(), printer._buffer.tostring());  

        // italic bold and underline text      
        expected.writestring(format("%c%c%c%c%c%c%c%s%c%c%c%c%c%c%c", 0x1B, 0x34, 0x1B, 0x45, 0x1B, 0x2D, 0x31, text, 0x1B, 0x35, 0x1B, 0x46, 0x1B, 0x2D, 0x30));
        printer.write(text, QL720NW_ITALIC | QL720NW_BOLD | QL720NW_UNDERLINE);
        assertEqual(expected.tostring(), printer._buffer.tostring()); 

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());
    }

    function test4_writen() {
        local expected = blob();
        local text = "text";

        // text only
        expected.writestring(format("%s%c", text, 0x0A));
        printer.writen(text);
        assertEqual(expected.tostring(), printer._buffer.tostring());
        
        // italic text
        expected.writestring(format("%c%c%s%c%c%c", 0x1B, 0x34, text, 0x0A, 0x1B, 0x35));
        printer.writen(text, QL720NW_ITALIC);
        assertEqual(expected.tostring(), printer._buffer.tostring());    

        // bold text
        expected.writestring(format("%c%c%s%c%c%c", 0x1B, 0x45, text, 0x0A, 0x1B, 0x46));
        printer.writen(text, QL720NW_BOLD);
        assertEqual(expected.tostring(), printer._buffer.tostring());       
          
        // underline text
        expected.writestring(format("%c%c%c%s%c%c%c%c", 0x1B, 0x2D, 0x31, text, 0x0A, 0x1B, 0x2D, 0x30));
        printer.writen(text, QL720NW_UNDERLINE);
        assertEqual(expected.tostring(), printer._buffer.tostring());   

        // italic and bold text 
        expected.writestring(format("%c%c%c%c%s%c%c%c%c%c", 0x1B, 0x34, 0x1B, 0x45, text, 0x0A, 0x1B, 0x35, 0x1B, 0x46));
        printer.writen(text, QL720NW_ITALIC | QL720NW_BOLD);
        assertEqual(expected.tostring(), printer._buffer.tostring());  

        // italic and underline text
        expected.writestring(format("%c%c%c%c%c%s%c%c%c%c%c%c", 0x1B, 0x34, 0x1B, 0x2D, 0x31, text, 0x0A, 0x1B, 0x35, 0x1B, 0x2D, 0x30));
        printer.writen(text, QL720NW_ITALIC | QL720NW_UNDERLINE);
        assertEqual(expected.tostring(), printer._buffer.tostring());  

        // bold and underline text
        expected.writestring(format("%c%c%c%c%c%s%c%c%c%c%c%c", 0x1B, 0x45, 0x1B, 0x2D, 0x31, text, 0x0A, 0x1B, 0x46, 0x1B, 0x2D, 0x30));
        printer.writen(text, QL720NW_BOLD | QL720NW_UNDERLINE);
        assertEqual(expected.tostring(), printer._buffer.tostring());  

        // italic bold and underline text      
        expected.writestring(format("%c%c%c%c%c%c%c%s%c%c%c%c%c%c%c%c", 0x1B, 0x34, 0x1B, 0x45, 0x1B, 0x2D, 0x31, text, 0x0A, 0x1B, 0x35, 0x1B, 0x46, 0x1B, 0x2D, 0x30));
        printer.writen(text, QL720NW_ITALIC | QL720NW_BOLD | QL720NW_UNDERLINE);
        assertEqual(expected.tostring(), printer._buffer.tostring()); 

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());
    }

    function test5_newline() {
        local expected = blob();

        // Check newline
        expected.writen(0x0A, 'b');
        printer.newline();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());
    }

    function test6_writeBarcode_types() {
        local expected = blob();
        local barcodeData = 12345;
        local eanData = 1234567;
        local upcAData = "01234567890";
        local upcEData = 123456;
        local codabarData = "D123";
        local rssData = "0123456";

        // Check defaults
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "t0", "r1", "w0", "h", 150, 0x00, "z2", 0x62, barcodeData.tostring(), 0x5C));
        printer.writeBarcode(barcodeData);
        assertEqual(expected.tostring(), printer._buffer.tostring());
        
        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check QL720NW_BARCODE_CODE39
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "t0", "r1", "w0", "h", 150, 0x00, "z2", 0x62, barcodeData.tostring(), 0x5C));
        printer.writeBarcode(barcodeData, {"type" : QL720NW_BARCODE_CODE39});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check QL720NW_BARCODE_ITF
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "t1", "r1", "w0", "h", 150, 0x00, "z2", 0x62, barcodeData.tostring(), 0x5C));
        printer.writeBarcode(barcodeData, {"type" : QL720NW_BARCODE_ITF});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check QL720NW_BARCODE_EAN_8_13
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "t5", "r1", "w0", "h", 150, 0x00, "z2", 0x62, eanData.tostring(), 0x5C));
        printer.writeBarcode(eanData, {"type" : QL720NW_BARCODE_EAN_8_13});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check QL720NW_BARCODE_UPC_A
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "t5", "r1", "w0", "h", 150, 0x00, "z2", 0x62, upcAData, 0x5C));
        printer.writeBarcode(upcAData, {"type" : QL720NW_BARCODE_UPC_A});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check QL720NW_BARCODE_UPC_E
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "t6", "r1", "w0", "h", 150, 0x00, "z2", 0x62, upcEData.tostring(), 0x5C));
        printer.writeBarcode(upcEData, {"type" : QL720NW_BARCODE_UPC_E});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check QL720NW_BARCODE_CODABAR
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "t9", "r1", "w0", "h", 150, 0x00, "z2", 0x62, codabarData, 0x5C));
        printer.writeBarcode(codabarData, {"type" : QL720NW_BARCODE_CODABAR});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check QL720NW_BARCODE_CODE128
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c%c%c", 0x1B, 0x69, "ta", "r1", "w0", "h", 150, 0x00, "z2", 0x62, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.writeBarcode(barcodeData, {"type" : QL720NW_BARCODE_CODE128});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check QL720NW_BARCODE_GS1_128
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c%c%c", 0x1B, 0x69, "tb", "r1", "w0", "h", 150, 0x00, "z2", 0x62, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.writeBarcode(barcodeData, {"type" : QL720NW_BARCODE_GS1_128});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());        

        // Check QL720NW_BARCODE_RSS
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "tc", "r1", "w0", "h", 150, 0x00, "z2", 0x62, rssData, 0x5C));
        printer.writeBarcode(rssData, {"type" : QL720NW_BARCODE_RSS});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());   

        // Check QL720NW_BARCODE_CODE93
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c%c%c", 0x1B, 0x69, "td", "r1", "w0", "h", 150, 0x00, "z2", 0x62, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.writeBarcode(barcodeData, {"type" : QL720NW_BARCODE_CODE93});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());  

        // Check QL720NW_BARCODE_POSTNET
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "te", "r1", "w0", "h", 150, 0x00, "z2", 0x62, barcodeData.tostring(), 0x5C));
        printer.writeBarcode(barcodeData, {"type" : QL720NW_BARCODE_POSTNET});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring()); 

        // Check QL720NW_BARCODE_UPC_EXTENTION
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "tf", "r1", "w0", "h", 150, 0x00, "z2", 0x62, barcodeData.tostring(), 0x5C));
        printer.writeBarcode(barcodeData, {"type" : QL720NW_BARCODE_UPC_EXTENTION});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring()); 

    }

    function test7_writeBarcode_params() {
        local expected = blob();
        local barcodeData = 12345;

        // Check charsBelowBarcode
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "t0", "r0", "w0", "h", 150, 0x00, "z2", 0x62, barcodeData.tostring(), 0x5C));
        printer.writeBarcode(barcodeData, {"charsBelowBarcode" : false});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring()); 

        // Check width QL720NW_BARCODE_WIDTH_XXS
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "t0", "r1", "w4", "h", 150, 0x00, "z2", 0x62, barcodeData.tostring(), 0x5C));
        printer.writeBarcode(barcodeData, {"width" : QL720NW_BARCODE_WIDTH_XXS});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring()); 

        // Check width QL720NW_BARCODE_WIDTH_XS
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "t0", "r1", "w0", "h", 150, 0x00, "z2", 0x62, barcodeData.tostring(), 0x5C));
        printer.writeBarcode(barcodeData, {"width" : QL720NW_BARCODE_WIDTH_XS});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring()); 

        // Check width QL720NW_BARCODE_WIDTH_S
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "t0", "r1", "w1", "h", 150, 0x00, "z2", 0x62, barcodeData.tostring(), 0x5C));
        printer.writeBarcode(barcodeData, {"width" : QL720NW_BARCODE_WIDTH_S});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring()); 

        // Check width QL720NW_BARCODE_WIDTH_M
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "t0", "r1", "w2", "h", 150, 0x00, "z2", 0x62, barcodeData.tostring(), 0x5C));
        printer.writeBarcode(barcodeData, {"width" : QL720NW_BARCODE_WIDTH_M});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring()); 

        // Check width QL720NW_BARCODE_WIDTH_L
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "t0", "r1", "w3", "h", 150, 0x00, "z2", 0x62, barcodeData.tostring(), 0x5C));
        printer.writeBarcode(barcodeData, {"width" : QL720NW_BARCODE_WIDTH_L});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring()); 

        // Check height
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "t0", "r1", "w0", "h", 0x2C, 0x01, "z2", 0x62, barcodeData.tostring(), 0x5C));
        printer.writeBarcode(barcodeData, {"height" : 1});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring()); 

        // Check ratio QL720NW_BARCODE_RATIO_3_1
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "t0", "r1", "w0", "h", 150, 0x00, "z0", 0x62, barcodeData.tostring(), 0x5C));
        printer.writeBarcode(barcodeData, {"ratio" : QL720NW_BARCODE_RATIO_3_1});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring()); 

        // Check ratio QL720NW_BARCODE_RATIO_25_1
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "t0", "r1", "w0", "h", 150, 0x00, "z1", 0x62, barcodeData.tostring(), 0x5C));
        printer.writeBarcode(barcodeData, {"ratio" : QL720NW_BARCODE_RATIO_25_1});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring()); 

        // Check ratio QL720NW_BARCODE_RATIO_2_1
        expected.writestring(format("%c%c%s%s%s%s%c%c%s%c%s%c", 0x1B, 0x69, "t0", "r1", "w0", "h", 150, 0x00, "z2", 0x62, barcodeData.tostring(), 0x5C));
        printer.writeBarcode(barcodeData, {"ratio" : QL720NW_BARCODE_RATIO_2_1});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring()); 
    }

    function test8_write2dbarcode_QR() {
        local expected = blob();
        local barcodeData = 12345;
        local type = QL720NW_BARCODE_2D_QR;

        // Check defaults
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x71, 3, 0x02, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode(barcodeData, type);
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring()); 

        // Check cell_size 10 (no need to check all settings, since we just pass in an integer)
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x71, 10, 0x02, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode(barcodeData, type, {"cell_size" : 10});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring()); 

        // Check symbol_type QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_1
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x71, 3, 0x01, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode(barcodeData, type, {"symbol_type" : QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_1});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check symbol_type QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_2
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x71, 3, 0x02, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode(barcodeData, type, {"symbol_type" : QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_2});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check symbol_type QL720NW_BARCODE_2D_QR_SYMBOL_MICRO_QR
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x71, 3, 0x03, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode(barcodeData, type, {"symbol_type" : QL720NW_BARCODE_2D_QR_SYMBOL_MICRO_QR});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check structured_append_partitioned 
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x71, 3, 0x02, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode(barcodeData, type, {"structured_append_partitioned" : false});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check structured_append_partitioned 
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x71, 3, 0x02, 0x01, 0x01, 0x03, 0x31, 0x02, 0x00, "123", 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode("123", type, {"structured_append_partitioned" : true, "code_number" : 1, "num_partitions" : 3, "parity_data" : 0x31});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check structured_append_partitioned 
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x71, 3, 0x02, 0x01, 0x02, 0x03, 0x31, 0x02, 0x00, "456", 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode("456", type, {"structured_append_partitioned" : true, "code_number" : 2, "num_partitions" : 3, "parity_data" : 0x31});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check structured_append_partitioned 
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x71, 3, 0x02, 0x01, 0x03, 0x03, 0x31, 0x02, 0x00, "789", 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode("789", type, {"structured_append_partitioned" : true, "code_number" : 3, "num_partitions" : 3, "parity_data" : 0x31});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check error_correction QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_HIGH_DENSITY
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x71, 3, 0x02, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode(barcodeData, type, {"error_correction" : QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_HIGH_DENSITY});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check error_correction 
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x71, 3, 0x02, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode(barcodeData, type, {"error_correction" : QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_STANDARD});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check error_correction 
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x71, 3, 0x02, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode(barcodeData, type, {"error_correction" : QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_HIGH_RELIABILITY});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check error_correction 
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x71, 3, 0x02, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode(barcodeData, type, {"error_correction" : QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_ULTRA_HIGH_RELIABILITY});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check data_input_method 
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x71, 3, 0x02, 0x00, 0x00, 0x00, 0x00, 0x02, 0x01, "N12345", 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode("N12345", type, {"data_input_method" : QL720NW_BARCODE_2D_QR_DATA_INPUT_MANUAL});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check data_input_method 
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x71, 3, 0x02, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode(barcodeData, type, {"data_input_method" : QL720NW_BARCODE_2D_QR_DATA_INPUT_AUTO});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());
    }

    function test9_write2dbarcode_DM() {
        local expected = blob();
        local barcodeData = 12345;
        local type = QL720NW_BARCODE_2D_DATAMATRIX;

        // Check defaults
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x64, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode(barcodeData, type);
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check cell_size 6 (no need to check all settings, since we just pass in an integer)
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x64, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode(barcodeData, type, {"cell_size" : 6});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Check symbol_type
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x64, 0x03, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode(barcodeData, type, {"symbol_type" : QL720NW_BARCODE_2D_DM_SYMBOL_RECTANGLE});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());        

        // Check symbol_type
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x64, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode(barcodeData, type, {"symbol_type" : QL720NW_BARCODE_2D_DM_SYMBOL_SQUARE});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());  

        // Check size
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x64, 0x03, 0x01, 8, 32, 0x00, 0x00, 0x00, 0x00, 0x00, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode(barcodeData, type, {"symbol_type" : QL720NW_BARCODE_2D_DM_SYMBOL_RECTANGLE, "vertical_size" : 8, "horizontal_size" : 32});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring());        

        // Check size 
        expected.writestring(format("%c%c%c%c%c%c%c%c%c%c%c%c%s%c%c%c", 0x1B, 0x69, 0x64, 0x03, 0x00, 24, 24, 0x00, 0x00, 0x00, 0x00, 0x00, barcodeData.tostring(), 0x5C, 0x5C, 0x5C));
        printer.write2dBarcode(barcodeData, type, {"symbol_type" : QL720NW_BARCODE_2D_DM_SYMBOL_SQUARE, "vertical_size" : 24});
        assertEqual(expected.tostring(), printer._buffer.tostring());

        // Clear print buffer
        expected = blob();
        printer._buffer = blob();
        assertEqual(expected.tostring(), printer._buffer.tostring()); 
    }

    function tearDown() {
        info("Barcode Manual Tests Done");
    }

}