# QL720NW #

This is a driver library for the Brother Label Printer QL720NW. The printer’s data sheet can be found [here](./cv_ql720_eng_escp_100.pdf). This library exposes basic text and barcode print functionality. It does not implement all of the functionality offered by the printer and outlined in the data sheet. Please submit pull requests for added features.  

**Note** The QL-720NW has been discontinued and may be hard to purchase. We have also tested this library on the Brother QL-1050 and confirmed that it supports both the QL-720NW and QL-1050 printers. Please note that the default baud rate for the QL-720NW is 9600 and the default baud rate for the QL-1050 is 115,200, so the UART will need to be configured accordingly.

**To use this library, add** `#require "QL720NW.device.lib.nut:1.0.0"` **to the top of your device code**

[![Build Status](https://api.travis-ci.org/electricimp/QL720NW.svg?branch=master)](https://travis-ci.org/electricimp/QL720NW)

## Class Usage ##

All public methods in the QL720NW class return *this*, allowing you to easily chain multiple commands together:

```squirrel
printer
    .setOrientation(QL720NW_LANDSCAPE)
    .setFont(QL720NW_FONT_SAN_DIEGO)
    .setFontSize(QL720NW_FONT_SIZE_48)
    .write("San Diego 48")
    .print();
```

### Constructor: QL720NW(*uart[, init]*) ###

The class constructor has one required parameter: a pre-configured imp UART object. You can also supply a boolean parameter, *init*, but this is optional. By default *init* is set to `true` and this causes the constructor to call the *initialize()* method, which will run the setup commands to put the printer in ESC/P standard mode and set up the printer’s defaults.

```squirrel
// Configure QL-720NW Printer
uart <- hardware.uart12;
uart.configure(9600, 8, PARITY_NONE, 1, NO_CTSRTS, function() {
    server.log(uart.readstring());
});

printer <- QL720NW(uart);
```

```squirrel
// Configure QL-1050 Printer
uart <- hardware.uart12;
uart.configure(115200, 8, PARITY_NONE, 1, NO_CTSRTS, function() {
    server.log(uart.readstring());
});

printer <- QL720NW(uart);
```

## Class Methods ##

### initialize() ###

This method runs the setup commands to put the printer in ESC/P standard mode and initialize its defaults.

```squirrel
printer.initialize();
```

### setOrientation(*orientation*) ###

This method sets the orientation of the printed text. It has one required parameter, *orientation*, into which should be passed either of the constants *QL720NW_LANDSCAPE* or *QL720NW_PORTRAIT*.

**Note** The value of *orientation* is written to UART when the method is called, and so will take effect immediately and affect everything stored in the print buffer.

```squirrel
// Set to landscape mode
printer.setOrientation(QL720NW_LANDSCAPE);
```

```squirrel
// Set to portrait mode
printer.setOrientation(QL720NW_PORTRAIT);
```

### setRightMargin(*column*) ###

This method sets the printer’s right-hand margin. It has one parameter, *column*, which is an integer. The position of the right-hand margin is the character width times *column* from the left edge. See the ‘Margin Notes’ diagram, below, for more details.

**Note** The value of *column* is written to UART when the method is called, and so will take effect immediately and affect everything stored in the print buffer.

### setLeftMargin(*column*) ###

This method sets the printer’s left-hand margin. It has one parameter, *column*, which is an integer. The position of the left-hand margin is the character width times *column* from the left edge. See the ‘Margin Notes’ diagram, below, for more details.

**Note** The value of *column* is written to UART when the method is called, and so will take effect immediately and affect everything stored in the print buffer.

#### Margin Notes ####

![Margin Column Settings](./MarginFigure.png)

Cases when margin settings are ignored include:

- The left margin is to the right of the right margin.
- The difference between the right and left margins is less than one character.
- The print medium is continuous length tape with no page length specified and the print orientation is landscape.

```squirrel
// Print 'Hello' and 'world' on different lines using margin settings
printer
  .setOrientation(QL720NW_PORTRAIT);
  .setFont(QL720NW_FONT_BROUGHAM)
  .setFontSize(QL720NW_FONT_SIZE_32)
  .write("Hello world")
  .setLeftMargin(5)
  .setRightMargin(11)
  .print();
```

### setFont(*font*) ###

This method sets the font, which is selected by passing one of constants listed in the table below into the *fonts* parameter. Brougham is the default font.

| Font Constant |
| --- |
| *QL720NW_FONT_BROUGHAM* |
| *QL720NW_FONT_LETTER_GOTHIC_BOLD* |
| *QL720NW_FONT_BRUSSELS* |
| *QL720NW_FONT_HELSINKI* |
| *QL720NW_FONT_SAN_DIEGO* |

**Note** *setFont()* settings only affect text sent to the printer *after* the method is called. Font settings are often cleared after *pageFeed()* or *print()* are called, so it is best to set the font for each label.

```squirrel
// Set font to Helsinki
printer.setFont(QL720NW_FONT_HELSINKI);
```

### setFontSize(*size*) ###

This method sets the font size in points, which is chosen by passing one of constants listed in the table below into the *size* parameter. The default size is 32.

| Size Constant |
| --- |
| *QL720NW_FONT_SIZE_24* |
| *QL720NW_FONT_SIZE_32* |
| *QL720NW_FONT_SIZE_48* |

**Note** *setFontSize()* settings only effect text sent to the printer *after* the method is called. Font settings are often cleared after *pageFeed()* or *print()* are called, so it is best to set the font size for each label.

```squirrel
// Set font size to 48
printer.setFontSize(QL720NW_FONT_SIZE_48);
```

### write(*text[, options]*) ###

This method adds the text to be printed. It has one parameter, *text*, into which a string containing the text to be printed is passed. It also has one optional parameter, *options*, which takes any of the following constants: *QL720NW_ITALIC*, *QL720NW_BOLD* and *QL720NW_UNDERLINE*. These options can be combined by OR-ing them, as the example below shows. By default no options are set.

**Note** This method stores the text to be printed in a buffer. To print the buffer, you must also call *print()*, as the example below shows.

```squirrel
// Print an underlined and italicized line of text
printer.setFont(QL720NW_FONT_SAN_DIEGO)
       .setFontSize(QL720NW_FONT_SIZE_48)
       .write("Hello World", QL720NW_UNDERLINE | QL720NW_ITALIC )
       .print();
```

### writen(*text[, options]*) ###

This method adds a line of text to be printed and automatically appends the text with a New Line character. It has one parameter, *text*, into which a string containing the line to be printed is passed. It also has one optional parameter, *options*, which takes any of the following constants: *QL720NW_ITALIC*, *QL720NW_BOLD* and *QL720NW_UNDERLINE*. These options can be combined by OR-ing them, as the example below shows. By default no options are set.

**Note** This method stores the text to be printed in a buffer. To print the buffer, you must also call *print()* as the example below shows.

```squirrel
// Print an italicized line of text then an underlined line of text
printer.setFont(QL720NW_FONT_SAN_DIEGO)
       .setFontSize(QL720NW_FONT_SIZE_48)
       .writen("Hello World", QL720NW_BOLD | QL720NW_ITALIC )
       .write("I'm Alive!", QL720NW_UNDERLINE )
       .print();
```

### newline() ###

This method adds a New Line character to the print buffer.

```squirrel
// Print two lines of text
printer.setFont(QL720NW_FONT_SAN_DIEGO)
       .setFontSize(QL720NW_FONT_SIZE_48)
       .write("Hello World")
       .newline()
       .write("I'm Alive!")
       .print();
```

### pageFeed() ###

This method adds a Page Feed character to the print buffer. Please note that after printing a Page Feed, font name and size settings are often reset to defaults.

```squirrel
// Print two labels in one print job
printer.setFont(QL720NW_FONT_SAN_DIEGO)
       .setFontSize(QL720NW_FONT_SIZE_48)
       .write("Hello World")
       .pageFeed()
       .write("I'm Alive!")
       .print();
```

### writeBarcode(*data[, configuration]*) ###

This method defines a barcode for printing. It has one required parameter, *data*, which is an integer or string value and is the value to be presented as a barcode. It also has one optional parameter, *configuration*, which takes a table of barcode parameters.

#### Configuration Table ####

| Configuration Table Key | Value Data type | Default Value | Description |
| -- | --- | --- | --- |
| *type* | Barcode Type Constant | *QL720NW_BARCODE_CODE39* | Type of barcode to print. See table below |
| *charsBelowBarcode* | Boolean | `true ` | Whether to print data below the barcode |
| *width* | Barcode Width Constant | *QL720NW_BARCODE_WIDTH_XS* | Width of barcode. See table below |
| *height* | Float | 0.5 | Height of barcode in inches |
| *ratio* | Barcode Ratio Constants | *QL720NW_BARCODE_RATIO_2_1* | Ratio between thick and thin bars. Setting available only for type *QL720NW_BARCODE_CODE39*, *QL720NW_BARCODE_ITF* or *QL720NW_BARCODE_CODABAR*. See table below |

#### Barcode Type Constants ####

| Barcode Type Constant | Data Length |
| --- | --- |
| *QL720NW_BARCODE_CODE39* | 1-50 characters ("*" is not included) |
| *QL720NW_BARCODE_ITF* | 1-64 characters |
| *QL720NW_BARCODE_EAN_8_13* | 7 characters (EAN-8), 12 characters (EAN-13) |
| *QL720NW_BARCODE_UPC_A* | 11 characters |
| *QL720NW_BARCODE_UPC_E* | 6 characters |
| *QL720NW_BARCODE_CODABAR* | 3-64 characters (Must begin and end with A, B, C, D) |
| *QL720NW_BARCODE_CODE128* | 1-64 characters |
| *QL720NW_BARCODE_GS1_128* | 1-64 characters |
| *QL720NW_BARCODE_RSS* | 3-15 characters (begins with "01") |
| *QL720NW_BARCODE_CODE93* | 1-64 characters |
| *QL720NW_BARCODE_POSTNET* | 5 characters, 9 characters,11 characters |
| *QL720NW_BARCODE_UPC_EXTENTION* | 2 characters, 5 characters |

#### Barcode Width Constants ####

| Barcode Width Constant |
| --- |
| *QL720NW_BARCODE_WIDTH_XXS* |
| *QL720NW_BARCODE_WIDTH_XS* |
| *QL720NW_BARCODE_WIDTH_S* |
| *QL720NW_BARCODE_WIDTH_M* |
| *QL720NW_BARCODE_WIDTH_L* |

#### Barcode Ratio Constants ####

| Barcode Ratio Constant |
| --- |
| *QL720NW_BARCODE_RATIO_2_1* |
| *QL720NW_BARCODE_RATIO_25_1* |
| *QL720NW_BARCODE_RATIO_3_1* |

**Note** This method stores the barcode to be printed in a buffer. To print the barcode, you must also call *print()*, as the example below shows.

```squirrel
// Print the device's MAC address as a barcode
barcodeConfig <- {"type" : QL720NW_BARCODE_CODE39,
                  "charsBelowBarcode" : true,
                  "width" : QL720NW_BARCODE_WIDTH_M,
                  "height" : 1,
                  "ratio" : QL720NW_BARCODE_RATIO_3_1 }

local i = imp.net.info();
local a = i.interface[("active" in i ? i.active : 0)];
printer.writeBarcode(a.macaddress, barcodeConfig)
       .print();
```

### write2dBarcode(*data, type[, configuration]*) ###

This method creates a 2D barcode. It has two required parameters. The first, *data*, takes an integer or string and which is the data to be printed as a barcode. The second, *type*, specifies the type of barcode to be printed. The method also has one optional parameter, *configuration*, which takes a table of configuration parameters. Which configuration parameters are available depends on which type of 2D barcode you select &mdash; both sets are listed in the tables below.

The supported 2D types are QR, selected by passing the constant *QL720NW_BARCODE_2D_QR* into *type*, and Data Matrix, which selected by passing in the constant *QL720NW_BARCODE_2D_DATAMATRIX*. 

#### QR Configuration Table ####

| Configuration Table Key | Value Data type | Default Value | Description |
| --- | --- | --- | --- |
| *cell_size* | Integer | 3 | Specifies the dot size per cell side. Supported values are 3, 4, 5, 6, 8 and 10 |
| *symbol_type* | Symbol Type Constant | *QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_2* | Symbol type to be used. See table below |
| *structured_append_partitioned* | Boolean | `false` | Whether the structured append is partitioned |
| *code_number* | Integer | 0 | Indicates the number of the symbol in a partitioned QR Code. Must set a number between 1-16 if *structured_append_partitioned* is set to `true` |
| *num_partitions* | Integer | 0 | Indicates the total number of symbols in a partitioned QR Code. Must set a number between 2-16 if *structured_append_partitioned* is set to `true` |
| *parity_data* | hexadecimal | 0 | Value in bytes of exclusively OR-ing all the print data (print data before partition) |
| *error_correction* | Error Correction Constant | *QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_STANDARD* | See table below |
| *data_input_method* | Data Input Method Constant | *QL720NW_BARCODE_2D_QR_DATA_INPUT_AUTO* | Auto: *QL720NW_BARCODE_2D_QR_DATA_INPUT_AUTO*,<br>Manual: *QL720NW_BARCODE_2D_QR_DATA_INPUT_MANUAL* |

#### QR Symbol Type Constants ####

| Symbol Type Constant |
| --- |
| *QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_1* |
| *QL720NW_BARCODE_2D_QR_SYMBOL_MODEL_2* |
| *QL720NW_BARCODE_2D_QR_SYMBOL_MICRO_QR* |

#### QR Error Correction Constants ####

| Error Correction Constant | Level |
| --- | --- |
| *QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_HIGH_DENSITY* | High-density level: L 7% |
| *QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_STANDARD* | Standard level: M 15% |
| *QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_HIGH_RELIABILITY* | High-reliability level: Q 25% |
| *QL720NW_BARCODE_2D_QR_ERROR_CORRECTION_ULTRA_HIGH_RELIABILITY* | Ultra-high-reliability level: H 30% |

#### Data Matrix Configuration Table ####

| Configuration Table Key | Value Data Type | Default Value | Description |
| --- | --- | --- | --- |
| *cell_size* | integer | 3 | Specifies the dot size per cell side. Supported values are 3, 4, 5, 6, 8 and 10 |
| *symbol_type* | Symbol Type Constant | *QL720NW_BARCODE_2D_DM_SYMBOL_SQUARE* | Symbol type to be used. Square: *QL720NW_BARCODE_2D_DM_SYMBOL_SQUARE*, Rectangular: *QL720NW_BARCODE_2D_DM_SYMBOL_RECTANGLE* |
| *vertical_size* | integer | 0 | Specifies the vertical number of cells. Supported values for square type are 0 (Auto), 10, 12, 14, 16, 18, 20, 22, 24, 26, 32, 36, 40, 44, 48, 52, 64, 72, 80, 88, 96, 104, 120, 132 and 144. Supported values for rectangular type are 0 (Auto), 8, 12 and 16 |
| *horizontal_size* | integer | 0 | Specifies the horizontal number of cells. If square type is selected, *horizontal_size* will be set to match the vertical size. The *horizontal_size* is only supported in conjunction with specific *vertical_size*  values. See table below for supported rectangular horizontal cell sizes |

#### Data Matrix Rectangular Horizontal Size Values ####

| Horizontal Cell Size | Data Type | Supported Vertical Cell Size |
| --- | --- | --- |
| 0 | integer | Auto |
| 18 | integer | 8 cells |
| 32 | integer | 8 cells |
| 26 | integer | 12 cells |
| 36 | integer | 12 cells or 16 cells |
| 48 | integer | 16 cells |

**Note** This method stores the barcode to be printed in a buffer. To print the barcode, you must also call *print()*, as the example below shows.

```squirrel
qrSettings <- { "cell_size": 5 };
dataMatrixSettings <- { "cell_size" : 8 };

// Write QR barcode
local i = imp.net.info();
local a = i.interface[("active" in i ? i.active : 0)];
printer.write2dBarcode(a.macaddress, QL720NW_BARCODE_2D_QR, qrSettings);

// Write dataMatrix barcode
printer.write2dBarcode(mac, QL720NW_BARCODE_2D_DATAMATRIX, dataMatrixSettings);

// Print barcodes
printer.print();
```

### print() ###

This method outputs the contents of the print buffer as set by the *write()*, *writen()*, *writeBarcode()* and/or *write2dBarcode()* methods.

```squirrel
// Print a line of text
printer.write("Hello World")
       .print();
```

## Known Issues ##

- The QL-720NW appears to drop UART commands while printing. The workaround is add a pause after calling *print()*. The QL-1050 does not have this issue.
- The printer state may become inconsistant when resetting font and font size between print jobs. The workaround is to always set font and font size for each label printed.

## License ##

The QL720NW class is licensed under the [MIT License](./LICENSE).
