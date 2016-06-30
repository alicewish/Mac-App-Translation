#import "StatusItemView.h"

@implementation StatusItemView

@synthesize statusItem = _statusItem;
@synthesize image = _image;
@synthesize alternateImage = _alternateImage;
@synthesize isHighlighted = _isHighlighted;
@synthesize action = _action;
@synthesize target = _target;
@synthesize temp = _temp;
@synthesize weatherIcon = _weatherIcon;


#pragma mark -

- (id)initWithStatusItem:(NSStatusItem *)statusItem
{
    CGFloat itemWidth = [statusItem length];
    CGFloat itemHeight = [[NSStatusBar systemStatusBar] thickness];
    NSRect itemRect = NSMakeRect(0.0, 0.0, itemWidth, itemHeight);
    self = [super initWithFrame:itemRect];
    
    if (self != nil) {
        _statusItem = statusItem;
        _statusItem.view = self;
        
        NSDictionary *systemVersionDictionary = [NSDictionary dictionaryWithContentsOfFile:@"/System/Library/CoreServices/SystemVersion.plist"];
        NSString *actualVersion = [systemVersionDictionary objectForKey:@"ProductVersion"];
        
        NSString* requiredVersion = @"10.11";
        
        if([requiredVersion compare:actualVersion options:NSNumericSearch] <= NSOrderedAscending) {
            blackColor = 0.1;
        } else {
            blackColor = 0;
        }
    }
    return self;
}

-(BOOL)isDarkMode {
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] persistentDomainForName:NSGlobalDomain];
    id style = [dict objectForKey:@"AppleInterfaceStyle"];
    return style && [style isKindOfClass:[NSString class]] && NSOrderedSame == [style caseInsensitiveCompare:@"dark"];
}

-(NSString*) accessibilityLabel {
    return _temp;
}

#pragma mark -

- (void)drawRect:(NSRect)dirtyRect
{
	// Set up dark mode for icon and font color
    NSUserDefaults *defaults = [[NSUserDefaults alloc]initWithSuiteName:@"435LW8C29V.com.rcg.forecastbar"];

    BOOL useCustomFontColor = [[defaults objectForKey:@"use_custom_menu_bar_text_color"] boolValue];
    
    NSColor* fontColor;
    
    if (useCustomFontColor) {
        NSData *colorData = [defaults objectForKey:@"menu_bar_text_color"];
        fontColor = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
    } else {
        fontColor = [self isDarkMode] ? [NSColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8] : [NSColor colorWithRed:blackColor green:blackColor blue:blackColor alpha:0.8];
    }
    
	[self.statusItem drawStatusBarBackgroundInRect:dirtyRect withHighlight:NO];
    
    
    NSSize textSize = [self.weatherIcon sizeWithAttributes:[NSDictionary dictionaryWithObject:[NSFont fontWithName:@"Climacons-Font" size:[self climaconSize]] forKey:NSFontAttributeName]];

    NSDictionary *attributes = [NSDictionary dictionaryWithObjects:
                                @[[NSFont fontWithName:@"Climacons-Font" size:[self climaconSize]], fontColor] forKeys:
                                @[NSFontAttributeName, NSForegroundColorAttributeName]];
    
    NSRect bounds = self.bounds;
    CGFloat iconX = roundf(textSize.width);
    CGFloat iconY = ((NSHeight(bounds) - textSize.height) / 2) - [self climaconLocation];
    NSPoint iconPoint = NSMakePoint(0, iconY);
    [self.weatherIcon drawAtPoint:iconPoint withAttributes:attributes];

    NSSize textSize2 = [self.temp sizeWithAttributes:[NSDictionary dictionaryWithObject:[NSFont systemFontOfSize:14] forKey:NSFontAttributeName]];

    NSDictionary *attributes2 = [NSDictionary dictionaryWithObjects:
                                @[[NSFont systemFontOfSize:14], fontColor]
                                                           forKeys:
                                @[NSFontAttributeName, NSForegroundColorAttributeName]];
    CGFloat textY = ((NSHeight(bounds) - textSize2.height) / 2) + 1;
    NSPoint textPoint = NSMakePoint(iconX + 3, textY);
    [self.temp drawAtPoint:textPoint withAttributes:attributes2];
}

#pragma mark -
#pragma mark Mouse tracking

- (void)mouseDown:(NSEvent *)theEvent
{
    [NSApp sendAction:self.action to:self.target from:self];
}

#pragma mark -
#pragma mark Accessors

- (void)setHighlighted:(BOOL)newFlag
{
    if (_isHighlighted == newFlag) return;
    _isHighlighted = newFlag;
    [self setNeedsDisplay:YES];
}

#pragma mark -

- (void)setImage:(NSImage *)newImage
{
    if (_image != newImage) {
        _image = newImage;
        [self setNeedsDisplay:YES];
    }
}

- (void)setAlternateImage:(NSImage *)newImage
{
    if (_alternateImage != newImage) {
        _alternateImage = newImage;
        if (self.isHighlighted) {
            [self setNeedsDisplay:YES];
        }
    }
}

#pragma mark -

- (NSRect)globalRect
{
    NSRect frame = [self frame];
    return [self.window convertRectToScreen:frame];
}

- (double)climaconLocation
{
    NSUserDefaults *defaults = [[NSUserDefaults alloc]initWithSuiteName:@"435LW8C29V.com.rcg.forecastbar"];
    NSString* description = [defaults stringForKey:@"currentCondition"];

    double location = 0;
    
    if([description isEqualToString:@"clear-night"]) {
        location = -0.5;
    } else if([description isEqualToString:@"clear"]) {
        location = 0;
    } else if([description isEqualToString:@"cloudy"]) {
        location = 0.5;
    } else if([description isEqualToString:@"partly-cloudy-day"]) {
        location = 2.5;
    } else if([description isEqualToString:@"partly-cloudy-night"]) {
        location = 1.2;
    } else if([description isEqualToString:@"rain"]  ||
              [description isEqualToString:@"thunderstorm"]) {
        location = -1.5;
    } else if([description isEqualToString:@"sleet"]) {
        location = -1.2;
    }else if([description isEqualToString:@"snow"]) {
        location = -0.5;
    } else if([description isEqualToString:@"wind"]) {
        location = -0.2;
    } else if([description isEqualToString:@"fog"]) {
        location = -1;
    }
    return location;
}

- (float)climaconSize
{
    NSUserDefaults *defaults = [[NSUserDefaults alloc]initWithSuiteName:@"435LW8C29V.com.rcg.forecastbar"];
    NSString* description = [defaults stringForKey:@"currentCondition"];
    
    if([description isEqualToString:@"clear-night"]) {
        return 30.f;
    } else {
        return 20.f;
    }
}



@end
