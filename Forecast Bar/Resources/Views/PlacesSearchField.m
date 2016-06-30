//
//  PlacesSearchField.m
//  Forecast Bar
//
//  Created by Jason Malashock on 9/29/15.
//
//

#import "PlacesSearchField.h"
#import "ApplicationDelegate.h"

@implementation PlacesSearchField

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(BOOL)textView:(NSTextView *)aTextView doCommandBySelector:
(SEL)aSelector{
    return [self tryToPerform:aSelector with:aTextView];
}

-(void)moveDown:(id)sender{
    ApplicationDelegate* del = (ApplicationDelegate*)[NSApp delegate];
    [del.panelController.locationTableController.view.window makeFirstResponder:del.panelController.locationTableController.placesTable];
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
    [del.panelController.locationTableController.placesTable selectRowIndexes:indexSet byExtendingSelection:NO];
}

@end
