uart <- hardware.uart12;
uart.configure(9600, 8, PARITY_NONE, 1, NO_CTSRTS, function() {
    server.log(uart.readstring());
});

printer <- QL720NW(uart)
    .setOrientation(QL720NW.LANDSCAPE);

// Print different font options
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

imp.sleep(0.5);

printer
    .setFont(QL720NW.FONT_HELSINKI)
    .setFontSize(QL720NW.FONT_SIZE_48);

// Print two Code39 Barcodes
barcodeSettings <- { "type" : QL720NW.BARCODE_CODE39,
                                  "charsBelowBarcode" : true,
                                  "width" : QL720NW.BARCODE_WIDTH_M,
                                  "height" : 0.33 };

printer.writeBarcode("HIKU 001", barcodeSettings);
printer.writeBarcode(imp.getmacaddress(), barcodeSettings).newline();

printer.print();

imp.sleep(0.5);

// Print QR Code, all config params optional
printer.write2dBarcode(imp.getmacaddress(), {
    "cell_size": QL720NW.BARCODE_2D_CELL_SIZE_5,
    "symbol_type": QL720NW.BARCODE_2D_SYMBOL_MODEL_2,
    "structured_append_partitioned": false,
    "error_correction": QL720NW.BARCODE_2D_ERROR_CORRECTION_STANDARD,
    "data_input_method": QL720NW.BARCODE_2D_DATA_INPUT_AUTO
});

printer.print();

server.log("Done");
