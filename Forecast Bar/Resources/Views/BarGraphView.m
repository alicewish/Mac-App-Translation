//
//  BarGraphView.m
//  Forecast Bar
//
//  Created by Jason Malashock on 4/30/15.
//
//

#import "BarGraphView.h"
#import "RCGSummaryManager.h"
#import "ApplicationDelegate.h"

@implementation BarGraphView

@synthesize rain, conditions, precipInt, precipType, showLegend, isWidget;

-(id) initWithData:(NSMutableArray*) conditionsData rainData:(NSMutableArray*) rainData precipData:(NSMutableArray *)precipData typeData:(NSMutableArray *)typeData{
    if ((self = [super init])) {
        rain = rainData;
        conditions = conditionsData;
        precipInt = precipData;
        precipType = typeData;
    }
    return self;
}


- (void)setUpArrays {
    NSUserDefaults *defaults = [[NSUserDefaults alloc]initWithSuiteName:@"435LW8C29V.com.rcg.forecastbar"];

    colorArray = [[NSMutableArray alloc] initWithCapacity:[conditions count]];
    colorNames = [[NSMutableArray alloc] initWithCapacity:[conditions count]];
    usedColors = [[NSMutableArray alloc] init];
    usedColorSizes = [[NSMutableArray alloc] init];
    usedColorColors = [[NSMutableArray alloc] init];
    
    ApplicationDelegate* del = (ApplicationDelegate*) [NSApplication sharedApplication].delegate;
    
    for (int i = 0; i < [conditions count]; i++) {
        NSArray* condition = [RCGSummaryManager conditionForClouds:[conditions[i] floatValue] rainType:precipType[i] rainIntensity:[precipInt[i] floatValue] units:(int)[defaults integerForKey:@"units"] shortened:NO darkMode:[del.panelController isDarkMode]];
        
        [colorNames addObject:condition[0]];
        [colorArray addObject:condition[1]];
    }
    
    int boxSize = 10;
    int spacing = 15;
    
    for(int i = 0; i < [colorNames count]; ++i) {
        NSString* color = colorNames[i];
        if(![usedColors containsObject:color]) {
            [usedColors addObject:color];
            int width = [self widthOfString:color withFont:[NSFont systemFontOfSize:12]] + boxSize + spacing;
            [usedColorSizes addObject:[NSNumber numberWithInt:width]];
            [usedColorColors addObject:colorArray[i]];
        }
    }
    
    for(NSNumber* number in usedColorSizes) {
        totalWidth += [number integerValue];
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    if(conditions == nil) {
        return;
    }
    
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
    
   [self setUpArrays];
    
    NSMutableArray *frameArray = [[NSMutableArray alloc] initWithCapacity:[conditions count]];

    int yPosition = showLegend ? 47 : 0;
    int height = showLegend ? 10 : 5;
    int width = showLegend ? 309 : isWidget ? 235: 230;
    double increment = (float) width / (float) [conditions count];

    for(double j = 0, currentX = 0; j < [conditions count]; ++j) {
        [frameArray addObject: [NSValue valueWithRect:NSMakeRect(currentX, yPosition, increment, height)]];
        currentX += increment;
    }
    
    for (int k = 0; k < [conditions count]; k++) {
        NSRect frame = [frameArray[k]rectValue];
        CGRect pow = NSRectToCGRect(frame);
        CGContextSetFillColorWithColor(context, [colorArray[k]CGColor]);
        CGContextFillRect(context, pow);
    }

    if (showLegend) {
        if(totalWidth > 300) {
            int itemsInRow1 = [usedColors count] > 3 ? 3 : (int)[usedColors count];
            int row1total = 0;
            int row2total = 0;
            for(int j = 0; j < itemsInRow1; ++j) {
                row1total += [usedColorSizes[j] integerValue];
            }
            
            for(int j = itemsInRow1; j < [usedColorSizes count]; ++j) {
                row2total += [usedColorSizes[j] integerValue];
            }
            
            for(int row = 0; row < 2; ++row) {
                int leftMargin = (300 - (row == 0 ? row1total : row2total)) / 2;
                int currentMargin = leftMargin;
                
                for(int i = (row == 0 ? 0 : itemsInRow1); i < (row == 0 ? itemsInRow1 : [usedColors count]); ++i) {
                    CGContextSetFillColorWithColor(context, [self isDarkMode] ? [NSColor whiteColor].CGColor : [NSColor blackColor].CGColor);
                    CGContextFillRect(context, CGRectMake(currentMargin - 1, row == 0 ? 17 : 1, 12, 12));
                    
                    CGContextSetFillColorWithColor(context, [usedColorColors[i] CGColor]);
                    CGContextFillRect(context, CGRectMake(currentMargin, row == 0 ? 18 : 2, 10, 10));
                    
                    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont systemFontOfSize:12], NSFontAttributeName, [self isDarkMode] ? [NSColor whiteColor] : [NSColor blackColor], NSForegroundColorAttributeName, nil];
                    NSAttributedString * currentText= [[NSAttributedString alloc] initWithString:usedColors[i] attributes: attributes];
                    [currentText drawAtPoint:NSMakePoint(currentMargin + 15, row == 0 ? 16 : 0)];
                    
                    currentMargin += [usedColorSizes[i] integerValue];
                }
            }
        } else {
            int leftMargin = (300 - totalWidth) / 2;
            int currentMargin = leftMargin;
            
            for(int i = 0; i < [usedColors count]; ++i) {
                CGContextSetFillColorWithColor(context, [self isDarkMode] ? [NSColor whiteColor].CGColor : [NSColor blackColor].CGColor);
                CGContextFillRect(context, CGRectMake(currentMargin - 1, 7, 12, 12));
                
                CGContextSetFillColorWithColor(context, [usedColorColors[i] CGColor]);
                CGContextFillRect(context, CGRectMake(currentMargin, 8, 10, 10));
                
                NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont systemFontOfSize:12], NSFontAttributeName, [self isDarkMode] ? [NSColor whiteColor] : [NSColor blackColor], NSForegroundColorAttributeName, nil];
                NSAttributedString * currentText= [[NSAttributedString alloc] initWithString:usedColors[i] attributes: attributes];
                [currentText drawAtPoint:NSMakePoint(currentMargin + 15, 6)];
                
                currentMargin += [usedColorSizes[i] integerValue];
            }
        }
    }
}

- (CGFloat)widthOfString:(NSString *)string withFont:(NSFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

#pragma mark - Dark Mode
-(BOOL)isDarkMode {
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] persistentDomainForName:NSGlobalDomain];
    id style = [dict objectForKey:@"AppleInterfaceStyle"];
    return style && [style isKindOfClass:[NSString class]] && NSOrderedSame == [style caseInsensitiveCompare:@"dark"];
}

@end
