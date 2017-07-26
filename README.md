# QL720NW

Driver library for Brother Label Printer. User manual for printer can be found [here](./cv_ql720_eng_escp_100.pdf). 

**To use this library add the following statement to the top of your device code:**

```squirrel
#require "QL720NW.device.lib.nut:0.2.0"
```

## Class Usage
All public methods in the QL720NW class return this, allowing you to easily chain multiple commands together:

```squirrel
printer
    .setOrientation(QL720NW_LANDSCAPE)
    .setFont(QL720NW_FONT_SAN_DIEGO)
    .setFontSize(QL720NW_FONT_SIZE_48)
    .write("San Diego 48")
    .print();
```

### Constructor: QL720NW(*uart[, init]*)

The QL720NW constructor takes one required parameter: a pre-configured *uart* and an optional boolean parameter: *init*.  By default *init* is set to true. When *init* is true the constructor will call the initialize method, which will run the setup commands to put the printer in ESC/P standard mode and initialize the printer defaults.

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

The *setOrientation* method sets the orientation of the printed text.  This method takes one required parameter *orientation*, a constant QL720NW_LANDSCAPE or QL720NW_PORTRAIT.

```squirrel
// set to landscape mode
printer.setOrientation(QL720NW_LANDSCAPE);

// set to portrait mode
printer.setOrientation(QL720NW_PORTRAIT);
```

### setRightMargin(*column*)

The *setRightMargin* method sets the right margin. This method takes one required parameter *column*, an integer.  The position of the right margin is the character width times *column* from the left edge. See Margin Notes for more details.

### setLeftMargin(*column*)

The *setLeftMargin* method sets the left margin.  This method takes one required parameter *column*, an integer.  The position of the left margin is the character width times *column* from the left edge.

##### Margin Notes:

![Margin Column Settings](./MarginFigure.png)

###### Cases when margin settings are ignored include:
- left margin to the right of the right margin
- difference between right and left margin less than one character
- print media continuous length tape with no page length specified and orientation is landscape

```squirrel
// print hello and world on different lines using margin settings
printer
  .setOrientation(QL720NW_PORTRAIT);
  .setFont(QL720NW_FONT_BROUGHAM)
  .setFontSize(QL720NW_FONT_SIZE_32)
  .write("hello world")
  .setLeftMargin(5)
  .setRightMargin(11)
  .print();
```

### setFont(*font*)

The *setFont* method sets the font using the *font* parameter.  See the table below for supported font class constants.

| Font Constant |
| ------------ |
| QL720NW_FONT_BROUGHAM |
| QL720NW_FONT_LETTER_GOTHIC_BOLD |
| QL720NW_FONT_BRUSSELS |
| QL720NW_FONT_HELSINKI |
| QL720NW_FONT_SAN_DIEGO |

```squirrel
// set font to Helsinki
printer.setFont(QL720NW_FONT_HELSINKI);
```

### setFontSize(*size*)

The *setFontSize* method sets the font size using the *size* parameter.  See the table below for supported font size class constants.

| Size Constant |
| ------------ |
| QL720NW_FONT_SIZE_24 |
| QL720NW_FONT_SIZE_32 |
| QL720NW_FONT_SIZE_48 |

```squirrel
// set font size to 32
printer.setFont(QL720NW_FONT_SIZE_32);
```

### write(*text[, options]*)

The *write* method sets the text to be printed.  This method takes one required parameter *text*, the text to be printed, and one optional parameter *options*.  By default no options are set.  Options are selected by OR'ing together the class constants QL720NW_ITALIC, QL720NW_BOLD, or QL720NW_UNDERLINE.

**NOTE:** This method only sets the text to be printed.  To print you must call the *print* method.

```squirrel
// print an underlined and italicized line of text
printer.setFont(QL720NW_FONT_SAN_DIEGO)
       .setFontSize(QL720NW_FONT_SIZE_48)
       .write("Hello World", QL720NW_UNDERLINE | QL720NW_ITALIC )
       .print();
```

### writen(*text[, options]*)

The *writen* method sets a line of text to be printed.  This method takes one required parameter *text*, the text to be printed, and one optional parameter *options*.  By default no options are set.  Options are selected by OR'ing together the constants QL720NW_ITALIC, QL720NW_BOLD, or QL720NW_UNDERLINE.

**NOTE:** This method only sets the line to be printed.  To print you must call the *print* method.

```squirrel
// print an italicized line of text then an underlined line of text
printer.setFont(QL720NW_FONT_SAN_DIEGO)
       .setFontSize(QL720NW_FONT_SIZE_48)
       .writen("Hello World", QL720NW_BOLD | QL720NW_ITALIC )
       .write("I'm Alive!", QL720NW_UNDERLINE )
       .print();
```

### newline()

The *newline* method adds a new line in the stored data to be printed.

```squirrel
// print two lines of text
printer.setFont(QL720NW_FONT_SAN_DIEGO)
       .setFontSize(QL720NW_FONT_SIZE_48)
       .write("Hello World")
       .newline()
       .write("I'm Alive!")
       .print();
```

### writeBarcode(*data[, config]*)

The *writeBarcode* method sets a barcode to be printed.  This method takes one required parameter *data*, and one optional parameter a table of configuation parameters.

##### Configuation Table

| Config Table Key     | Value Data type         | Default Value             | Description     |
| -------------------- | ----------------------- | ------------------------- | --------------- |
| *type*               | Barcode Type Constant   | QL720NW_BARCODE_CODE39    | Type of barcode to print. See chart below. |
| *charsBelowBarcode*  | Boolean                 | true                      | Whether to print data below the barcode. |
| *width*              | Barcode Width Constant  | QL720NW_BARCODE_WIDTH_XS  | Width of barcode. See chart below. |
| *height*             | Float                   | 0.5                       | Height of barcode in inches. |
| *ratio*              | Barcode Ratio Constants | QL720NW_BARCODE_RATIO_2_1 | Ratio between thick and thin bars. Setting available only for type QL720NW_BARCODE_CODE39, QL720NW_BARCODE_ITF, or QL720NW_BARCODE_CODABAR. See chart below. |

##### Barcode Type

| Barcode Type Constant         | Data Length                                           |
| ----------------------------- | ----------------------------------------------------- |
| QL720NW_BARCODE_CODE39        | 1-50 characters ("*" is not included)                 |
| QL720NW_BARCODE_ITF           | 1-64 characters                                       |
| QL720NW_BARCODE_EAN_8_13      | 7 characters (EAN-8), 12 characters (EAN-13)          |
| QL720NW_BARCODE_UPC_A         | 11 characters                                         |
| QL720NW_BARCODE_UPC_E         | 6 characters                                          |
| QL720NW_BARCODE_CODABAR       | 3-64 characters (Must begin and end with A, B, C, D)  |
| QL720NW_BARCODE_CODE128       | 1-64 characters                                       |
| QL720NW_BARCODE_GS1_128       | 1-64 characters                                       |
| QL720NW_BARCODE_RSS           | 3-15 characters (begins with "01")                    |
| QL720NW_BARCODE_CODE93        | 1-64 characters                                       |
| QL720NW_BARCODE_POSTNET       | 5 characters, 9  characters,11 characters             |
| QL720NW_BARCODE_UPC_EXTENTION | 2 characters, 5 characters                            |

##### Barcode Width

| Barcode Width Constant    |
| ------------------------- |
| QL720NW_BARCODE_WIDTH_XXS |
| QL720NW_BARCODE_WIDTH_XS  |
| QL720NW_BARCODE_WIDTH_S   |
| QL720NW_BARCODE_WIDTH_M   |
| QL720NW_BARCODE_WIDTH_L   |

##### Barcode Ratio

| Barcode Ratio Constant     |
| -------------------------- |
| QL720NW_BARCODE_RATIO_2_1  |
| QL720NW_BARCODE_RATIO_25_1 |
| QL720NW_BARCODE_RATIO_3_1  |

**NOTE:** This method only sets the barcode to be printed.  To print you must call the *print* method.

```squirrel
// print the device's mac address as a barcode
barcodeConfig <- {"type" : QL720NW_BARCODE_CODE39,
                  "charsBelowBarcode" : true,
                  "width" : QL720NW_BARCODE_WIDTH_M,
                  "height" : 1,
                  "ratio" : QL720NW_BARCODE_RATIO_3_1 }

printer.writeBarcode(imp.getmacaddress(), barcodeConfig).print();
```

### write2dBarcode(*data, type[, config]*)

The *write2dBarcode* method creates a 2D barcode. This method takes two required parameters *data*, the data to be printed as a barcode, and *type*, the type of barcode to be printed.  Currently the supported 2D types are QR, selected by passing in the QL720NW_BARCODE_2D_QR class constant, and Data Matrix, selected by passing in the QL720NW_BARCODE_2D_DATAMATRIX constants. This method also takes one optional parameter a table of configuation parameters. See the tables below for configuration details.

##### QR Configuation Table

| Config Table Key                | Value Data type            | Default Value                                | Description     |
| ------------------------------- | -------------------------- | -------------------------------------------- | --------------- |
| *cell_size*                     | Cell Size Constant         | QL720NW_BARCODE_2D_CELL_SIZE_3               | Specifies the dot size per cell side. See chart below. |
| *symbol_type*                   | Symbol Type Constant       | QL720NW_BARCODE_2D_SYMBOL_MODEL_2            | Symbol type to be used. See chart below |
| *structured_append_partitioned* | Boolean                    | false                                        | Whether the structured append is partitioned. |
| *code_number*                   | Integer                    | 0                                            | Indicates the number of the symbol in a partitioned QR Code. Must set a number between 1-16 if *structured_append_partitioned* is set to true. |
| *num_partitions*                | Integer                    | 0                                            | Indicates the total number of symbols in a partitioned QR Code. Must set a number between 2-16 if *structured_append_partitioned* is set to true. |
| *parity_data*                   | hexadecimal                | 0                                            | Value in bytes of exclusively OR'ing all the print data (print data before partition) |
| *error_correction*              | Error Correction Constant  | QL720NW_BARCODE_2D_ERROR_CORRECTION_STANDARD | See chart below. |
| *data_input_method*             | Data Input Method Constant | QL720NW_BARCODE_2D_DATA_INPUT_AUTO           | Auto: QL720NW_BARCODE_2D_DATA_INPUT_AUTO, Manual: QL720NW_BARCODE_2D_DATA_INPUT_MANUAL |

##### Data Matrix Configuation Table
| Config Table Key  | Value Data type           | Default Value                 | Description     |
| ----------------- | ------------------------- | ----------------------------- | --------------- |
| *cell_size*       | Cell Size Constant        | QL720NW_BARCODE_2D_CELL_SIZE_3        | Specifies the dot size per cell side. See chart below. |
| *symbol_type*     | Symbol Type Constant      | QL720NW_BARCODE_2D_DM_SYMBOL_SQUARE   | Symbol type to be used. Square: QL720NW_BARCODE_2D_DM_SYMBOL_SQUARE, Rectangular: QL720NW_BARCODE_2D_DM_SYMBOL_RECTANGLE |
| *vertical_size*   | Vertical Size Constant    | QL720NW_BARCODE_2D_DM_VERTICAL_AUTO   | Specifies the vertical number of cells. See chart below. |
| *horizontal_size* | Horizontal Size Constant  | QL720NW_BARCODE_2D_DM_HORIZONTAL_AUTO | Specifies the horizontal number of cells. See chart below. |

##### Cell Size

| Cell Size Constant              |
| ------------------------------- |
| QL720NW_BARCODE_2D_CELL_SIZE_3  |
| QL720NW_BARCODE_2D_CELL_SIZE_4  |
| QL720NW_BARCODE_2D_CELL_SIZE_5  |
| QL720NW_BARCODE_2D_CELL_SIZE_6  |
| QL720NW_BARCODE_2D_CELL_SIZE_8  |
| QL720NW_BARCODE_2D_CELL_SIZE_10 |

##### QR Symbol Type

| Symbol Type Constant               |
| ---------------------------------- |
| QL720NW_BARCODE_2D_SYMBOL_MODEL_1  |
| QL720NW_BARCODE_2D_SYMBOL_MODEL_2  |
| QL720NW_BARCODE_2D_SYMBOL_MICRO_QR |

##### QR Error Correction

| Error Correction Constant                                  | Level                               |
| ---------------------------------------------------------- | ----------------------------------- |
| QL720NW_BARCODE_2D_ERROR_CORRECTION_HIGH_DENSITY           | High-density level: L 7%            |
| QL720NW_BARCODE_2D_ERROR_CORRECTION_STANDARD               | Standard level: M 15%               |
| QL720NW_BARCODE_2D_ERROR_CORRECTION_HIGH_RELIABILITY       | High-reliability level: Q 25%       |
| QL720NW_BARCODE_2D_ERROR_CORRECTION_ULTRA_HIGH_RELIABILITY | Ultra-high-reliability level: H 30% |

##### Data Matrix Vertical Size

| Vertical Size Constant              | Supported Symbol Type |
| ----------------------------------- | ----------------------|
| QL720NW_BARCODE_2D_DM_VERTICAL_AUTO | Square & Rectangular  |
| QL720NW_BARCODE_2D_DM_VERTICAL_8    | Rectangular           |
| QL720NW_BARCODE_2D_DM_VERTICAL_10   | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_12   | Square & Rectangular  |
| QL720NW_BARCODE_2D_DM_VERTICAL_14   | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_16   | Square & Rectangular  |
| QL720NW_BARCODE_2D_DM_VERTICAL_18   | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_20   | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_22   | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_24   | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_26   | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_32   | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_36   | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_40   | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_44   | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_48   | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_52   | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_64   | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_72   | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_80   | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_88   | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_96   | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_104  | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_120  | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_132  | Square                |
| QL720NW_BARCODE_2D_DM_VERTICAL_144  | Square                |

##### Data Matrix Horizontal Size

| Horizontal Size Constant              | Supported Symbol Type | Supported Vertical Cell Size |
| ------------------------------------- | --------------------- | ---------------------------- |
| QL720NW_BARCODE_2D_DM_HORIZONTAL_X    | Square                | Same value as vertical size  |
| QL720NW_BARCODE_2D_DM_HORIZONTAL_AUTO | Rectangular           | Auto                         |
| QL720NW_BARCODE_2D_DM_HORIZONTAL_18   | Rectangular           | 8 cells                      |
| QL720NW_BARCODE_2D_DM_HORIZONTAL_32   | Rectangular           | 8 cells                      |
| QL720NW_BARCODE_2D_DM_HORIZONTAL_26   | Rectangular           | 12 cells                     |
| QL720NW_BARCODE_2D_DM_HORIZONTAL_36   | Rectangular           | 12 cells or 16 cells         |
| QL720NW_BARCODE_2D_DM_HORIZONTAL_48   | Rectangular           | 16 cells                     |

```squirrel
mac <- imp.getmacaddress();
qrSettings <- { "cell_size": QL720NW_BARCODE_2D_CELL_SIZE_5 };
dataMatrixSettings <- { "cell_size" : QL720NW_BARCODE_2D_CELL_SIZE_8 };

// write QR barcode
printer.write2dBarcode(mac, QL720NW_BARCODE_2D_QR, qrSettings);
// write dataMatrix barcode
printer.write2dBarcode(mac, QL720NW_BARCODE_2D_DATAMATRIX, dataMatrixSettings);

// print barcodes
printer.print();
```

**NOTE:** This method only sets the line to be printed.  To print you must call the *print* method.

### print()

The *print* method prints the stored data set by the *write*, *writen*, *writeBarcode* and/or *write2dBarcode* methods.

```squirrel
// print a line of text
printer.write("Hello World").print();
```

## To do

- More extensive testing (printer occasionally silently fails)
- Improve 2D barcode implementation


## License

The QL720NW class is licensed under the [MIT License](./LICENSE).
