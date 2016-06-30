/*
     File: HoverTableView.m 
 Abstract: Custom NSTableView to override its grid drawing behavior (via drawGridInClipRect). 
  Version: 1.1 
  
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple 
 Inc. ("Apple") in consideration of your agreement to the following 
 terms, and your use, installation, modification or redistribution of 
 this Apple software constitutes acceptance of these terms.  If you do 
 not agree with these terms, please do not use, install, modify or 
 redistribute this Apple software. 
  
 In consideration of your agreement to abide by the following terms, and 
 subject to these terms, Apple grants you a personal, non-exclusive 
 license, under Apple's copyrights in this original Apple software (the 
 "Apple Software"), to use, reproduce, modify and redistribute the Apple 
 Software, with or without modifications, in source and/or binary forms; 
 provided that if you redistribute the Apple Software in its entirety and 
 without modifications, you must retain this notice and the following 
 text and disclaimers in all such redistributions of the Apple Software. 
 Neither the name, trademarks, service marks or logos of Apple Inc. may 
 be used to endorse or promote products derived from the Apple Software 
 without specific prior written permission from Apple.  Except as 
 expressly stated in this notice, no other rights or licenses, express or 
 implied, are granted by Apple herein, including but not limited to any 
 patent rights that may be infringed by your derivative works or by other 
 works in which the Apple Software may be incorporated. 
  
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE 
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION 
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS 
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND 
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS. 
  
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL 
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, 
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED 
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), 
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE 
 POSSIBILITY OF SUCH DAMAGE. 
  
 Copyright (C) 2012 Apple Inc. All Rights Reserved. 
  
 */

#import "HoverTableView.h"
#import "HoverTableRowView.h" // For the grid drawing shared code
#import "ApplicationDelegate.h"

@implementation HoverTableView

- (CGFloat)yPositionPastLastRow {
    // Only draw the grid past the last visible row
    NSInteger numberOfRows = self.numberOfRows;
    CGFloat yStart = 0;
    if (numberOfRows > 0) {
        yStart = NSMaxY([self rectOfRow:numberOfRows - 1]);
    }
    return yStart;
}

- (void)drawGridInClipRect:(NSRect)clipRect {
    // Only draw the grid past the last visible row
    CGFloat yStart = [self yPositionPastLastRow];
    // Draw the first separator one row past the last row
    yStart += self.rowHeight;

    // One thing to do is smarter clip testing to see if we actually need to draw!
    NSRect boundsToDraw = self.bounds;
    NSRect separatorRect = boundsToDraw;
    separatorRect.size.height = 1;
    while (yStart < NSMaxY(boundsToDraw)) {
        separatorRect.origin.y = yStart;
        DrawSeparatorInRect(separatorRect);
        yStart += self.rowHeight;
    }
}

- (void)setFrameSize:(NSSize)size {
    [super setFrameSize:size];
    // We need to invalidate more things when live-resizing since we fill with a gradient and stroke
    if ([self inLiveResize]) {
        CGFloat yStart = [self yPositionPastLastRow];
        if (NSHeight(self.bounds) > yStart) {
            // Redraw our horizontal grid lines
            NSRect boundsPastY = self.bounds;
            boundsPastY.size.height -= yStart;
            boundsPastY.origin.y = yStart;
            [self setNeedsDisplayInRect:boundsPastY];
        }
    }
}

- (void)mouseDown:(NSEvent *)theEvent {
    
    NSPoint globalLocation = [theEvent locationInWindow];
    NSPoint localLocation = [self convertPoint:globalLocation fromView:nil];
    NSInteger clickedRow = [self rowAtPoint:localLocation];
    
    [super mouseDown:theEvent];
    
    if (clickedRow != -1) {
        [self.hoverTableDelegate tableView:self didClickedRow:clickedRow];
    }
}

- (void)keyDown:(NSEvent *)theEvent {
    ApplicationDelegate* del = (ApplicationDelegate*)[NSApp delegate];
    int selectedRow = (int)[self selectedRow];
    NSString *keyString;
    unichar  keyChar;
    
    keyString = [theEvent charactersIgnoringModifiers];
    keyChar = [keyString characterAtIndex:0];
    
    switch(keyChar){
        case NSCarriageReturnCharacter:
        case NSEnterCharacter: {
            [del.panelController.locationTableController processSelection:(int)[self selectedRow]];
        }
        default:
            [super keyDown:theEvent];
    }
    
    switch ([theEvent keyCode]) {
        case 125:
            break;
        case 126: {// Up
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:selectedRow];
            if(del.panelController.locationTableController.placesTable.isHidden) {
                [del.panelController.locationTableController.placesTable selectRowIndexes:indexSet byExtendingSelection:NO];
                break;
            } else {
                if (selectedRow != 0) {
                    [del.panelController.locationTableController.placesTable selectRowIndexes:indexSet byExtendingSelection:NO];
                } else {
                    [del.panelController.locationTableController.view.window makeFirstResponder:del.panelController.locationTableController.manualLocation];
                }
            }
        }
        default:
            [super keyDown:theEvent];
    }
}

@end
