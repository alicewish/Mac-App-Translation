//
//  MouseoverGraphHostingView.m
//  Forecast Bar
//
//  Created by Derek Johnson on 5/30/15.
//
//

#import "MouseoverGraphHostingView.h"

@implementation MouseoverGraphHostingView

-(void) setupMouseTracking {
    self.window.acceptsMouseMovedEvents = YES;
    [self.window makeFirstResponder:self];
    
    area = [[NSTrackingArea alloc] initWithRect:self.frame
                                        options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow| NSTrackingActiveAlways)
                                          owner:self userInfo:nil];
    
    [self addTrackingArea:area];
    [self becomeFirstResponder];
}

- (void)updateTrackingAreas {
    [self removeTrackingArea:area];
    area = [[NSTrackingArea alloc] initWithRect:self.frame
                                        options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow| NSTrackingActiveAlways)
                                          owner:self userInfo:nil];
    [self addTrackingArea:area];
}

- (void)mouseMoved:(NSEvent *)theEvent
{
    NSPoint location = [self convertPoint: [theEvent locationInWindow] fromView: nil];
    CGPoint mouseLocation = NSPointToCGPoint(location);
    [self setLocationOfMouse:[self.layer convertPoint: mouseLocation toLayer:nil]];
}

-(void) dealloc{
    [self removeTrackingArea:area];
}

@end