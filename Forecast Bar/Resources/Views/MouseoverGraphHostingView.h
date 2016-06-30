//
//  MouseoverGraphHostingView.h
//  Forecast Bar
//
//  Created by Derek Johnson on 5/30/15.
//
//

#import "CPTGraphHostingView.h"

@interface MouseoverGraphHostingView : CPTGraphHostingView {
    NSTrackingArea* area;
}

@property (nonatomic) CGPoint locationOfMouse;

-(void) setupMouseTracking;

@end
