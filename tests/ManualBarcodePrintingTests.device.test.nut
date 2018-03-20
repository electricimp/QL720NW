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

// These tests actually print and should always be checked that the printed data is what is expected
// Note: These tests will always "pass" unless an error is encountered
class ManualBarcodePrintingTests extends ImpTestCase {

    printer = null;

    // Currently the UART buffer drops data when the printer 
    // is printing a label.
    // To prevent data being dropped use this pause function to 
    // add time between prints
    function pause(time) {
        imp.sleep(time);
    }

    // Setup is written for an imp001 (kelly) connected to the printer with a DB9 connector
    function setUp() {
        local uart = hardware.uart0;
        uart.configure(115200, 8, PARITY_NONE, 1, NO_CTSRTS, function() {
            server.log(uart.readstring());
        });

        printer = QL720NW(uart);
    }

    function test1_BarcodesWithRatio() {
        // settings for barcodes
        local code39 = {"type" : QL720NW_BARCODE_CODE39,
                        "charsBelowBarcode" : true,
                        "width" : QL720NW_BARCODE_WIDTH_L,
                        "height" : 0.5,
                        "ratio" : QL720NW_BARCODE_RATIO_2_1};
        local itf = {"type" : QL720NW_BARCODE_ITF,
                      "charsBelowBarcode" : true,
                      "width" : QL720NW_BARCODE_WIDTH_L,
                      "height" : 0.3,
                      "ratio" : QL720NW_BARCODE_RATIO_25_1};
        local codabar = {"type" : QL720NW_BARCODE_CODABAR,
                          "charsBelowBarcode" : true,
                          "width" : QL720NW_BARCODE_WIDTH_S,
                          "height" : 0.4,
                          "ratio" : QL720NW_BARCODE_RATIO_3_1};

        printer.setOrientation(QL720NW_LANDSCAPE)
               .writeBarcode("123456789", code39)
               .newline()
               .newline()
               .writeBarcode("123456789", itf)
               .newline()
               .newline()
               .writeBarcode("A123456789A", codabar)
               .print();

        pause(2);

        printer.writeBarcode("123")
               .newline()
               .writeBarcode("456" {"charsBelowBarcode" : false})
               .newline()
        printer.print();

        pause(3);
    }

    function test2_BarcodeUPC() {
        local upcA = {"type" : QL720NW_BARCODE_UPC_A,
                       "charsBelowBarcode" : true,
                       "width" : QL720NW_BARCODE_WIDTH_S,
                       "height" : 0.3}
        local upcE = {"type" : QL720NW_BARCODE_UPC_E,
                       "charsBelowBarcode" : true,
                       "width" : QL720NW_BARCODE_WIDTH_M,
                       "height" : 0.3}
        local upcExt = {"type" : QL720NW_BARCODE_UPC_EXTENTION,
                       "charsBelowBarcode" : true,
                       "width" : QL720NW_BARCODE_WIDTH_L,
                       "height" : 0.3}

        printer.setOrientation(QL720NW_LANDSCAPE)
               .writeBarcode("01234567890", upcA)
               .newline()
               .newline()
               .writeBarcode("123456", upcE)
               .newline()
               .newline()               
               .writeBarcode("12345", upcExt)
               .print();

        pause(3);
    }

    function test3_BarcodeMisc() {
        local ean813 = {"type" : QL720NW_BARCODE_EAN_8_13,
                         "width" : QL720NW_BARCODE_WIDTH_S,
                         "height" : 0.3}
        local code128 = {"type" : QL720NW_BARCODE_CODE128,
                          "width" : QL720NW_BARCODE_WIDTH_S,
                          "height" : 0.3}
        local gs1128 = {"type" : QL720NW_BARCODE_GS1_128,
                         "width" : QL720NW_BARCODE_WIDTH_S,
                         "height" : 0.3}
        local rss = {"type" : QL720NW_BARCODE_RSS,
                      "width" : QL720NW_BARCODE_WIDTH_S,
                      "height" : 0.3}
        local code93 = {"type" : QL720NW_BARCODE_CODE93,
                         "width" : QL720NW_BARCODE_WIDTH_S,
                         "height" : 0.3}
        local postnet = {"type" : QL720NW_BARCODE_POSTNET,
                          "width" : QL720NW_BARCODE_WIDTH_S,
                          "height" : 0.3}

        printer.setOrientation(QL720NW_LANDSCAPE)
               .writeBarcode("1234567", ean813)
               .newline()
               .newline()               
               .writeBarcode("123456789", code128)
               .newline()
               .newline()  
               .writeBarcode("123456789", gs1128)
               .newline()
               .newline()  
               .print();
        
        pause(3);

        printer.writeBarcode("0123456", rss)
               .newline()
               .newline()  
               .writeBarcode("123456", code93)
               .newline()
               .newline()  
               .writeBarcode("12345", postnet)
               .print();

        pause(3);
    }

    function test4_2DQR_NotPartitioned() {
        // test various cell size, and error correction
        local s1 = {"cell_size" : 3, 
                    "symbol_type" : QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_2, 
                    "error_correction" : QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_STANDARD,
                    "data_input_method" : QL720NW_BARCODE_2D_QR_DATA_INPUT_AUTO };
        local s2 = {"cell_size" : 4, 
                    "symbol_type" : QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_2, 
                    "error_correction" : QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_HIGH_RELIABILITY,
                    "data_input_method" : QL720NW_BARCODE_2D_QR_DATA_INPUT_AUTO };
        local s3 = {"cell_size" : 5, 
                    "symbol_type" : QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_2, 
                    "error_correction" : QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_HIGH_DENSITY,
                    "data_input_method" : QL720NW_BARCODE_2D_QR_DATA_INPUT_AUTO };
        local s4 = {"cell_size" : 6, 
                    "symbol_type" : QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_2, 
                    "error_correction" : QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_STANDARD,
                    "data_input_method" : QL720NW_BARCODE_2D_QR_DATA_INPUT_AUTO };
        local s5 = {"cell_size" : 8, 
                    "symbol_type" : QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_2, 
                    "error_correction" : QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_STANDARD,
                    "data_input_method" : QL720NW_BARCODE_2D_QR_DATA_INPUT_AUTO };
        local s6 = {"cell_size" : 10, 
                    "symbol_type" : QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_2, 
                    "error_correction" : QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_STANDARD,
                    "data_input_method" : QL720NW_BARCODE_2D_QR_DATA_INPUT_AUTO };

        printer.setOrientation(QL720NW_PORTRAIT)
               .write2dBarcode("3m1", QL720NW_BARCODE_2D_QR, s1) 
               .newline()
               .newline()
               .write2dBarcode("4m1", QL720NW_BARCODE_2D_QR, s2)
               .newline()
               .newline()
               .write2dBarcode("5m2", QL720NW_BARCODE_2D_QR, s3)
               .newline()
               .newline()
               .write2dBarcode("6m2", QL720NW_BARCODE_2D_QR, s4)
               .newline()
               .newline()
               .write2dBarcode("8mm", QL720NW_BARCODE_2D_QR, s5)
               .newline()
               .newline()
               .write2dBarcode("10mm", QL720NW_BARCODE_2D_QR, s6)

               printer.print();

        pause(3);
    }

    function test5_2DQR_Partitioned() {
        // Not partitioned (from datasheet example)
        // esc i Q 0x04 0x02 0x00 0x00 0x00 0x00 0x02 0x00 123456789 \\\

        // 3 partitioned (from datasheet example)
        // esc i Q 0x04 0x02 0x01 0x01 0x03 0x31 0x02 0x00 123 \\\
        // esc i Q 0x04 0x02 0x01 0x02 0x03 0x31 0x02 0x00 456 \\\
        // esc i Q 0x04 0x02 0x01 0x03 0x03 0x31 0x02 0x00 789 \\\
        // the parity for 123456789 is 0x31

        // default settings except cell_size
        local control = {"cell_size" : 4};
        // partition settings
        local partitioned = {"cell_size" : 4,
                              "structured_append_partitioned" : true,
                              "code_number" : 1,
                              "num_partitions" : 3,
                              "parity_data" : 0x31 };

        info("Print control barcode first value: 123456789");
        printer.setOrientation(QL720NW_LANDSCAPE)
               .write2dBarcode("123456789", QL720NW_BARCODE_2D_QR, control)
               .print();

        pause(3);

        info("Print partitioned barcode next value: 123456789");
        printer.setOrientation(QL720NW_LANDSCAPE);
        printer.write2dBarcode("123", QL720NW_BARCODE_2D_QR, partitioned);
        partitioned.code_number = 2;
        printer.write2dBarcode("456", QL720NW_BARCODE_2D_QR, partitioned);
        partitioned.code_number = 3;
        printer.write2dBarcode("789", QL720NW_BARCODE_2D_QR, partitioned);
        printer.print();

        pause(3);
    }

    function test6_2DQR_ManualInput() {
        local s1 = {"cell_size" : 5, 
                     "symbol_type" : QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_2, 
                     "error_correction" : QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_STANDARD,
                     "data_input_method" : QL720NW_BARCODE_2D_QR_DATA_INPUT_MANUAL };

            // In Manual Input Alphanumeric data must start with A or a
            printer.setOrientation(QL720NW_LANDSCAPE)
               .write2dBarcode("A12345679", QL720NW_BARCODE_2D_QR, s1)
               .print();

        pause(3);
    }

    function test7_2DDataMatrix() {
        // Test some square and rectangular sizes
        // test various cell sizes

        // Check that default vertical and horizontal work
        local s1 = {"cell_size" : 8, 
                     "symbol_type" : QL720NW_BARCODE_2D_DM_SYMBOL_SQUARE };

        local s2 = {"cell_size" : 8, 
                     "symbol_type" : QL720NW_BARCODE_2D_DM_SYMBOL_SQUARE, 
                     "vertical_size" : 10 };

        local s3 = {"cell_size" : 8, 
                     "symbol_type" : QL720NW_BARCODE_2D_DM_SYMBOL_SQUARE, 
                     "vertical_size" : 20 };

        local s4 = {"cell_size" : 4, 
                     "symbol_type" : QL720NW_BARCODE_2D_DM_SYMBOL_SQUARE, 
                     "vertical_size" : 52 };

        // Check that default vertical and horizontal work
        local r1 = {"cell_size" : 5, 
                     "symbol_type" : QL720NW_BARCODE_2D_DM_SYMBOL_RECTANGLE};

        local r2 = {"cell_size" : 5, 
                     "symbol_type" : QL720NW_BARCODE_2D_DM_SYMBOL_RECTANGLE, 
                     "vertical_size" : 8,
                     "horizontal_size" : 18 };

        local r3 = {"cell_size" : 5, 
                     "symbol_type" : QL720NW_BARCODE_2D_DM_SYMBOL_RECTANGLE, 
                     "vertical_size" : 12,
                     "horizontal_size" : 26 };

        local r4 = {"cell_size" : 5, 
                     "symbol_type" : QL720NW_BARCODE_2D_DM_SYMBOL_RECTANGLE, 
                     "vertical_size" : 16,
                     "horizontal_size" : 48 };

        printer.setOrientation(QL720NW_PORTRAIT)
               .write2dBarcode("sq1", QL720NW_BARCODE_2D_DATAMATRIX, s1)
               .newline()
               .newline()
               .write2dBarcode("sq2", QL720NW_BARCODE_2D_DATAMATRIX, s2)
               .newline()
               .newline()
               .write2dBarcode("sq3", QL720NW_BARCODE_2D_DATAMATRIX, s3)
               .newline()
               .newline()
               .write2dBarcode("sq4", QL720NW_BARCODE_2D_DATAMATRIX, s4)
               .newline()
               .newline()
               .print();

        pause(3);

        printer.write2dBarcode("r1", QL720NW_BARCODE_2D_DATAMATRIX, r1)
               .newline()
               .newline()
               .write2dBarcode("r2", QL720NW_BARCODE_2D_DATAMATRIX, r2)
               .newline()
               .newline()
               .write2dBarcode("r3", QL720NW_BARCODE_2D_DATAMATRIX, r3)
               .newline()
               .newline()
               .write2dBarcode("r4", QL720NW_BARCODE_2D_DATAMATRIX, r4)
               .print();

        pause(3);
    }

    function tearDown() {
        info("Barcode Manual Tests Done");
    }

}