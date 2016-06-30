//
//  ClickableImageView.m
//  Forecast Bar
//
//  Created by Jason Malashock on 10/30/15.
//
//

#import "ClickableImageView.h"

@implementation ClickableImageView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(void) mouseDown:(NSEvent *)theEvent {
    [self sendAction:@selector(manageLocations:) to:[self target]];
}


@end
