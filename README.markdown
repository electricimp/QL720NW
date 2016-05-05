#QL720NW

Class for Brother Label Printer.
This code is under development.  Please submit pull requests if you make improvements.

**To add this library to your project, add** `#require "QL720NW.class.nut:0.1.0"` **to the top of your agent code**

## Class Usage
All public methods in the QL720NW class return this, allowing you to easily chain multiple commands together:

```squirrel
printer
    .setOrientation(QL720NW.LANDSCAPE)
    .setFont(QL720NW.FONT_SAN_DIEGO)
    .setFontSize(QL720NW.FONT_SIZE_48)
    .write("San Diego 48 ")
    .print();
```

### Constructor: QL720NW(*uart[, init ]*)

The QL720NW constructor takes one required parameter: a pre-configured uart and an optional boolean parameter: init.  By default init is set to true. When init is true the constructor will call the initialize method, which will run the setup commands to put the printer in ESC/P standard mode and initialize the printer defaults.

```squirrel
uart <- hardware.uart12;
uart.configure(9600, 8, PARITY_NONE, 1, NO_CTSRTS, function() {
    server.log(uart.readstring());
});

printer <- QL720NW(uart);
```

## Class Methods

### initialize()
The *initialize* method runs the setup commands to put the printer in ESC/P standard mode and initialize the printer defaults.

```squirrel
printer.initialize();
```

### setOrientation(*orientation*)
The *setOrientation* method sets the orientation of the printed text.  This method takes one required parameter *orientation*, a class constant LANDSCAPE or PORTRAIT.

```squirrel
// set to landscape mode
printer.setOrientation(QL720NW.LANDSCAPE);

// set to portrait mode
printer.setOrientation(QL720NW.PORTRAIT);
```

### setRightMargin(*column*)
The *setRightMargin* method sets the right margin...
doesn't appear to be working as expected

### setLeftMargin(*column*)
The *setLeftMargin* method sets the left margin...
doesn't appear to be working as expected

### setFont(*font*)
The *setFont* method sets the font using the *font* parameter.  See the table below for supported font class constants.

| Font Constant |
| ------------ |
| FONT_BROUGHAM |
| FONT_LETTER_GOTHIC_BOLD |
| FONT_BRUSSELS |
| FONT_HELSINKI |
| FONT_SAN_DIEGO |

```squirrel
// set font to Helsinki
printer.setFont(QL720NW.FONT_HELSINKI);
```

### setFontSize(*size*)
The *setFontSize* method sets the font size using the *size* parameter.  See the table below for supported font size class constants.

| Size Constant |
| ------------ |
| FONT_SIZE_24 |
| FONT_SIZE_32 |
| FONT_SIZE_48 |

```squirrel
// set font size to 32
printer.setFont(QL720NW.FONT_SIZE_32);
```

### write(*text[, options]*)
The *write* method sets the text to be printed.  This method takes one required parameter *text*, the text to be printed, and one optional parameter *options*.  By default no options are set.  Options are selected by OR'ing together the class constants ITALIC, BOLD, or UNDERLINE.

**NOTE:** This method only sets the text to be printed.  To print you must call the *print* method.

```squirrel
// print an underlined and italicized line of text
printer.setFont(QL720NW.FONT_SAN_DIEGO)
       .setFontSize(QL720NW.FONT_SIZE_48)
       .write("Hello World", QL720NW.UNDERLINE | QL720NW.ITALIC )
       .print();
```

### writen(*text[, options]*)
The *writen* method sets a line of text to be printed.  This method takes one required parameter *text*, the text to be printed, and one optional parameter *options*.  By default no options are set.  Options are selected by OR'ing together the constants ITALIC, BOLD, or UNDERLINE.

**NOTE:** This method only sets the line to be printed.  To print you must call the *print* method.

```squirrel
// print an italicized line of text then an underlined line of text
printer.setFont(QL720NW.FONT_SAN_DIEGO)
       .setFontSize(QL720NW.FONT_SIZE_48)
       .writen("Hello World", QL720NW.BOLD | QL720NW.ITALIC )
       .write("I'm Alive!", QL720NW.UNDERLINE )
       .print();
```

### newline()
The *newline* method adds a new line in the stored data to be printed.

```squirrel
// print two lines of text
printer.setFont(QL720NW.FONT_SAN_DIEGO)
       .setFontSize(QL720NW.FONT_SIZE_48)
       .write("Hello World")
       .newline()
       .write("I'm Alive!")
       .print();
```

### writeBarcode(*data[, config]*)
The *writeBarcode* method sets a barcode to be printed.  This method takes one required parameter *data*, and one optional parameter a table of configuation parameters.

#####Configuation Table
| Config Table Key | Value Data type | Default Value | Description |
| ----------------------- | ------------------------------------- | ---------- | --------------- |
| *type* | Barcode Type Constant  | BARCODE_CODE39 | Type of barcode to print. See chart below. |
| *charsBelowBarcode* | Boolean | true | Whether to print data below the barcode. |
| *width* | Barcode Width Constant | BARCODE_WIDTH_XS | Width of barcode. See chart below. |
| *height* | Float | 0.5 | Height of barcode in inches. |
| *ratio* | Barcode Ratio Constants | BARCODE_RATIO_2_1 | Ratio between thick and thin bars. Setting available only for type BARCODE_CODE39, BARCODE_ITF, or BARCODE_CODABAR. See chart below. |

#####Barcode Type
| Barcode Type Constant | Data Length |
| --------------------------------- | -------------------------------- |
| BARCODE_CODE39 | 1-50 characters ("*" is not included)
| BARCODE_ITF | 1-64 characters |
| BARCODE_EAN_8_13 | 7 characters (EAN-8), 12 characters (EAN-13) |
| BARCODE_UPC_A | 11 characters |
| BARCODE_UPC_E | 6 characters |
| BARCODE_CODABAR | 3-64 characters (Must begin and end with A, B, C, D) |
| BARCODE_CODE128 | 1-64 characters |
| BARCODE_GS1_128 | 1-64 characters |
| BARCODE_RSS | 3-15 characters (begins with "01") |
| BARCODE_CODE93 | 1-64 characters |
| BARCODE_POSTNET | 5 characters, 9  characters,11 characters |
| BARCODE_UPC_EXTENTION | 2 characters, 5 characters |

#####Barcode Width
| Barcode Width Constant |
| ---------------------------------- |
| BARCODE_WIDTH_XXS |
| BARCODE_WIDTH_XS |
| BARCODE_WIDTH_S |
| BARCODE_WIDTH_M |
| BARCODE_WIDTH_L |

#####Barcode Ratio
| Barcode Ratio Constant |
| ---------------------------------- |
| BARCODE_RATIO_2_1 |
| BARCODE_RATIO_25_1 |
| BARCODE_RATIO_3_1 |

**NOTE:** This method only sets the barcode to be printed.  To print you must call the *print* method.

```squirrel
// print the device's mac address as a barcode
barcodeConfig <- {"type" : QL720NW.BARCODE_CODE39,
                              "charsBelowBarcode" : true,
                              "width" : QL720NW.BARCODE_WIDTH_M,
                              "height" : 1,
                              "ratio" : QL720NW.BARCODE_RATIO_3_1 }

printer.writeBarcode(imp.getmacaddress(), barcodeConfig).print();
```

### write2dBarcode(*data[, config]*)
The *write2dBarcode* method creates a 2D QR barcode.  This method takes one required parameter *data*, and one optional parameter a table of configuation parameters.

#####Configuation Table
| Config Table Key | Value Data type | Default Value | Description |
| ----------------------- | ------------------------------------- | ---------- | --------------- |
| *cell_size* | Cell Size Constant  | BARCODE_2D_CELL_SIZE_3 | Specifies the dot size per cell side. See chart below. |
| *symbol_type* | Symbol Type Constant | BARCODE_2D_SYMBOL_MODEL_2 | Symbol type to be used. See chart below |
| *structured_append_partitioned* | Boolean | false | Whether the structured append is partitioned. |
| *code_number* | Integer | 0 | Indicates the number of the symbol in a partitioned QR Code. Must set a number between 1-16 if *structured_append_partitioned* is set to true. |
| *num_partitions* | Integer | 0 | Indicates the total number of symbols in a partitioned QR Code. Must set a number between 2-16 if *structured_append_partitioned* is set to true. |
| *parity_data* | hexadecimal | 0 | Value in bytes of exclusively OR'ing all the print data (print data before partition) |
| *error_correction* | Error Correction Constant | BARCODE_2D_ERROR_CORRECTION_STANDARD | See chart below. |
| *data_input_method* | Data Input Method Constant | BARCODE_2D_DATA_INPUT_AUTO | Auto: BARCODE_2D_DATA_INPUT_AUTO, Manual: BARCODE_2D_DATA_INPUT_MANUAL |

#####Cell Size
| Cell Size Constant |
| BARCODE_2D_CELL_SIZE_3 |
| BARCODE_2D_CELL_SIZE_4 |
| BARCODE_2D_CELL_SIZE_5 |
| BARCODE_2D_CELL_SIZE_6 |
| BARCODE_2D_CELL_SIZE_8 |
| BARCODE_2D_CELL_SIZE_10 |

#####Symbol Type
| Symbol Type Constant |
| BARCODE_2D_SYMBOL_MODEL_1 |
| BARCODE_2D_SYMBOL_MODEL_2 |
| BARCODE_2D_SYMBOL_MICRO_QR |

#####Error Correction
| Error Correction Constant | Level |
| BARCODE_2D_ERROR_CORRECTION_HIGH_DENSITY | High-density level: L 7% |
| BARCODE_2D_ERROR_CORRECTION_STANDARD | Standard level: M 15% |
| BARCODE_2D_ERROR_CORRECTION_HIGH_RELIABILITY | High-reliability level: Q 25% |
| BARCODE_2D_ERROR_CORRECTION_ULTRA_HIGH_RELIABILITY | Ultra-high-reliability level: H 30% |

```squirrel
// Print QR Code, all config params optional
printer.write2dBarcode(imp.getmacaddress(), {
    "cell_size": QL720NW.BARCODE_2D_CELL_SIZE_5,
});

printer.print();
```

### print()
The *print* method prints the stored data set by the *write*, *writen*, *writeBarcode* and/or *write2dBarcode* methods.

```squirrel
// print a line of text
printer.write("Hello World").print();
```

## To do

- Refactor writeBarcode to use a settings table instead of a dozen optional parameters
- More extensive testing (printer occasionally silently fails)
- Wake printer from standby mode
- fix margin methods
- Improve 2D barcode implementation to include more than QR codes and support partitioned data input
- Documentation


## License

The QL720NW class is licensed under the [MIT License](./LICENSE).


