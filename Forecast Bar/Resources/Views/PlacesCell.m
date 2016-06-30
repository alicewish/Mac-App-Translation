//
//  PlacesCell.m
//  Forecast Bar
//
//  Created by Jason Malashock on 9/26/15.
//
//

#import "PlacesCell.h"

@interface PlacesCell ()
@property BOOL mouseInside;
@end


@implementation PlacesCell

@synthesize subTitle;

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@dynamic mouseInside;


- (void)setMouseInside:(BOOL)value {
    if (mouseInside != value) {
        mouseInside = value;
        [self setNeedsDisplay:YES];
    }
}

- (BOOL)mouseInside {
    return mouseInside;
}

- (void)ensureTrackingArea {
    if (trackingArea == nil) {
        trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect options:NSTrackingInVisibleRect | NSTrackingActiveAlways | NSTrackingMouseEnteredAndExited owner:self userInfo:nil];
    }
}

- (void)updateTrackingAreas {
    [super updateTrackingAreas];
    [self ensureTrackingArea];
    if (![[self trackingAreas] containsObject:trackingArea]) {
        [self addTrackingArea:trackingArea];
    }
}

- (void)mouseEntered:(NSEvent *)theEvent {
    self.mouseInside = YES;
    
    NSColor *color2 = [self isDarkMode] ? [NSColor whiteColor] :  [NSColor blackColor];
    [subTitle setTextColor: color2];
}

- (void)mouseExited:(NSEvent *)theEvent {
    self.mouseInside = NO;
    
    NSColor *color = [self isDarkMode] ? [NSColor colorWithRed:193/255.0 green:193/255.0  blue:193/255.0  alpha:1] :  [NSColor colorWithRed:108/255.0 green:108/255.0  blue:108/255.0  alpha:1];
    
    [subTitle setTextColor:color];
    
    NSColor *color2 = [self isDarkMode] ? [NSColor whiteColor] :  [NSColor blackColor];
    [self.textField setTextColor:color2];
}

#pragma mark - Dark Mode
-(BOOL)isDarkMode {
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] persistentDomainForName:NSGlobalDomain];
    id style = [dict objectForKey:@"AppleInterfaceStyle"];
    return style && [style isKindOfClass:[NSString class]] && NSOrderedSame == [style caseInsensitiveCompare:@"dark"];
}

@end
