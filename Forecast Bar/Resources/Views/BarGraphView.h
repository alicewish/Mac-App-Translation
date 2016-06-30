//
//  BarGraphView.h
//  Forecast Bar
//
//  Created by Jason Malashock on 4/30/15.
//
//

#import <Cocoa/Cocoa.h>

@interface BarGraphView : NSView {
    NSMutableArray* colorArray;
    NSMutableArray* colorNames;
    NSMutableArray* usedColors;
    NSMutableArray* usedColorColors;
    NSMutableArray* usedColorSizes;
    int totalWidth;
}

@property (nonatomic) NSMutableArray* conditions;
@property (nonatomic) NSMutableArray* rain;
@property (nonatomic) NSMutableArray* precipInt;
@property (nonatomic) NSMutableArray* precipType;
@property (nonatomic) BOOL showLegend;
@property (nonatomic) BOOL isWidget;



-(id) initWithData:(NSMutableArray*) conditionsData rainData:(NSMutableArray*) rainData precipData:(NSMutableArray*) precipData typeData:(NSMutableArray*) typeData;
@end
