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
The *setOrientation* method sets the orientation of the printed text to landscape or portrait.  This method takes one required parameter *orientation*, a class constant.

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
The *setFont* method sets the font using the *font* parameter.  See the table below for supported fonts.

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
The *setFontSize* method sets the font size using the *size* parameter.  See the table below for supported font sizes.

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
The *write* method sets the text to be printed.  This method takes one required parameter *text*, the text to be printed, and one optional parameter *options*.  By default no options are set.  Options are selected by OR'ing together the constants ITALIC, BOLD, or UNDERLINE.

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
printer.setFont(QL720NW.FONT_SAN_DIEGO)
       .setFontSize(QL720NW.FONT_SIZE_48)
       .writen("Hello World", QL720NW.BOLD | QL720NW.ITALIC )
       .write("I'm Alive!", QL720NW.UNDERLINE )
       .print();
```

### newline()
The *newline* method adds a new line in the stored data to be printed.

```squirrel
printer.setFont(QL720NW.FONT_SAN_DIEGO)
       .setFontSize(QL720NW.FONT_SIZE_48)
       .write("Hello World")
       .newline()
       .write("I'm Alive!")
       .print();
```

### writeBarcode(*data[, type = "t0", charsBelowText = true, width = "w4", height = 0.5, ratio = "z3"]*)

### write2dBarcode(*data[, config]*)

### print()
The *print* method prints the stored data set by the *write*, *writen*, *writeBarcode* and/or *write2dBarcode* methods.

```squirrel
printer.write("Hello World").print();
```

## To do

- Refactor writeBarcode to use a settings table instead of a dozen optional parameters
- More extensive testing (printer occasionally silently fails)
- Wake printer from standby mode
- Improve 2D barcode implementation to include more than QR codes and support partitioned data input
- Documentation


## License

The QL720NW class is licensed under the [MIT License](./LICENSE).


