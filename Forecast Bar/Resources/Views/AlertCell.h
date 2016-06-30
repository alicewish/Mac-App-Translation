//
//  AlertCell.h
//  Forecast Bar
//
//  Created by Jason Malashock on 9/28/15.
//
//

#import <Cocoa/Cocoa.h>

@interface AlertCell : NSTableCellView {
@private
    BOOL mouseInside;
    NSTrackingArea *trackingArea;
}



@property (nonatomic, retain) IBOutlet NSTextField *timeLabel;


@end
