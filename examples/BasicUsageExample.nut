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

#require "QL720NW.device.lib.nut:0.3.0"

// Configure UART
uart <- hardware.uart12;
uart.configure(9600, 8, PARITY_NONE, 1, NO_CTSRTS, function() {
    server.log(uart.readstring());
});

// Initialize printer & set orientation
printer <- QL720NW(uart)
    .setOrientation(QL720NW_LANDSCAPE);

// Write different font options and sizes to memory
printer
    .setFont(QL720NW_FONT_BROUGHAM)
        .setFontSize(QL720NW_FONT_SIZE_48).write("Brougham 48 ")
        .setFontSize(QL720NW_FONT_SIZE_32).write("Brougham 32 ")
        .setFontSize(QL720NW_FONT_SIZE_24).write("Brougham 24")
        .newline()
    .setFont(QL720NW_FONT_LETTER_GOTHIC_BOLD)
        .setFontSize(QL720NW_FONT_SIZE_48).write("Letter Gothic 48 ")
        .setFontSize(QL720NW_FONT_SIZE_32).write("Letter Gothic 32 ")
        .setFontSize(QL720NW_FONT_SIZE_24).write("Letter Gothic 24")
        .newline()
    .setFont(QL720NW_FONT_BRUSSELS)
        .setFontSize(QL720NW_FONT_SIZE_48).write("Brussels 48 ")
        .setFontSize(QL720NW_FONT_SIZE_32).write("Brussels 32 ")
        .setFontSize(QL720NW_FONT_SIZE_24).write("Brussels 24")
        .newline()
    .setFont(QL720NW_FONT_HELSINKI)
        .setFontSize(QL720NW_FONT_SIZE_48).write("Helsink 48 ")
        .setFontSize(QL720NW_FONT_SIZE_32).write("Helsink 32 ")
        .setFontSize(QL720NW_FONT_SIZE_24).write("Helsink 24")
        .newline()
    .setFont(QL720NW_FONT_SAN_DIEGO)
        .setFontSize(QL720NW_FONT_SIZE_48).write("San Diego 48 ")
        .setFontSize(QL720NW_FONT_SIZE_32).write("San Diego 32 ")
        .setFontSize(QL720NW_FONT_SIZE_24).write("San Diego 24")
        .newline()

// Print font examples data
printer.print();

// Wait for half a second
imp.sleep(0.5);

// Update font settings
printer
    .setFont(QL720NW_FONT_HELSINKI)
    .setFontSize(QL720NW_FONT_SIZE_48);

// Configure settings for Code39 Barcodes
barcodeSettings <- { "type" : QL720NW_BARCODE_CODE39,
                     "charsBelowBarcode" : true,
                     "width" : QL720NW_BARCODE_WIDTH_M,
                     "height" : 0.33 };

// Write two barcodes to memory
printer.writeBarcode("HIKU 001", barcodeSettings).newline();
printer.writeBarcode(imp.getmacaddress(), barcodeSettings).newline();

// Print barcodes
printer.print();

imp.sleep(0.5);

// Configure and print QR Code
qrBarcodeSettings <- { "cell_size": QL720NW_BARCODE_2D_CELL_SIZE_5,
                       "symbol_type": QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_2,
                       "structured_append_partitioned": false,
                       "error_correction": QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_STANDARD,
                       "data_input_method": QL720NW_BARCODE_2D_QR_DATA_INPUT_AUTO };

printer.write2dBarcode(imp.getmacaddress(), QL720NW_BARCODE_2D_QR, qrBarcodeSettings).print();

server.log("Done");
