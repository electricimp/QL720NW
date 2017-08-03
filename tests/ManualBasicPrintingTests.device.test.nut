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
class ManualBasicPrintingTests extends ImpTestCase {

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
        local uart = hardware.uart12;
        uart.configure(9600, 8, PARITY_NONE, 1, NO_CTSRTS, function() {
            server.log(uart.readstring());
        });

        printer = QL720NW(uart);
    }

    function test1_OrientationPortrait() {
        printer.setOrientation(QL720NW_PORTRAIT);
        printer.write("portrait").print();
        pause(0.5);
    }

    function test2_OrientationLandscape() {
        printer.setOrientation(QL720NW_LANDSCAPE);
        printer.write("landscape").print();
        pause(0.5);
    }

    function test3_Fonts() {
        printer.setOrientation(QL720NW_LANDSCAPE);

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
        pause(0.5);
    }

    function test4_WriteOptions() {
        printer.setOrientation(QL720NW_PORTRAIT);

        printer.setFont(QL720NW_FONT_SAN_DIEGO)
               .setFontSize(QL720NW_FONT_SIZE_32)
               .write("Plain Text")
               .newline()
               .write("Bold", QL720NW_BOLD )
               .newline()
               .write("Underline and Italic", QL720NW_UNDERLINE | QL720NW_ITALIC )
               .newline()
               .print();
        pause(0.5);
    }

    function test5_WritenOptions() {
        printer.setOrientation(QL720NW_PORTRAIT);

        printer.setFont(QL720NW_FONT_SAN_DIEGO)
               .setFontSize(QL720NW_FONT_SIZE_32)
               .writen("Plain Text")
               .writen("Underline", QL720NW_UNDERLINE)
               .writen("Bold and Italic", QL720NW_BOLD | QL720NW_ITALIC)
               .print();
        pause(0.5);
    }

    function test6_NewLine() {
        printer.setOrientation(QL720NW_PORTRAIT);

        printer.setFont(QL720NW_FONT_SAN_DIEGO)
               .setFontSize(QL720NW_FONT_SIZE_32)
               .write("Newline Test 3 blank lines")
               .newline()
               .newline()
               .newline()
               .write("written between text")
               .print();
        pause(0.5);
    }

    function test7_PageFeed() {
        printer.setOrientation(QL720NW_PORTRAIT);

        printer.setFont(QL720NW_FONT_SAN_DIEGO)
               .setFontSize(QL720NW_FONT_SIZE_32)
               .write("Label 1: Custom font settings")
               .pageFeed()
               .write("Label 2: Default font settings")
               .print();
        pause(0.5);
    }

    function test8_MarginsSet() {
        printer.setOrientation(QL720NW_PORTRAIT);
        printer.writen("text written to buffer before margin set")
        printer.setRightMargin(15)
        printer.setLeftMargin(3)
        printer.writen("margins set to L:3 R:15").print();

        pause(3);

        printer.setRightMargin(10)
        printer.setLeftMargin(5)
        printer.writen("new margins set")
        printer.writen("margins set to L:5 R:10").print();
        
        pause(3);
    }

    function test9_MarginsIgnored() {

        printer.setOrientation(QL720NW_PORTRAIT);
        printer.writen("margins set to L:25 R:25")
        printer.setRightMargin(25)
        printer.setLeftMargin(25)
        printer.write("Left margin is ignored").print();

        pause(3);

        printer.setOrientation(QL720NW_LANDSCAPE);
        printer.setRightMargin(10)
        printer.setLeftMargin(3)
        printer.write("Set to landscape with margins L:3 R:10").print();

        pause(3);

        // Reset to printer defaults
        printer.initialize();
    }

    function tearDown() {
        info("Basic Manual Tests Done");
    }

}