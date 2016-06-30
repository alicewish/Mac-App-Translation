#import "CustomScrollView.h"

@implementation CustomScrollView

- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self) {
        [self hideScrollers];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self hideScrollers];
}

- (void)hideScrollers
{
    // Hide the scrollers. You may want to do this if you're syncing the scrolling
    // this NSScrollView with another one.
    [self setHasHorizontalScroller:NO];
    [self setHasVerticalScroller:NO];
}

- (void)scrollWheel:(NSEvent *)theEvent
{
    // Do nothing: disable scrolling altogether
}

@end