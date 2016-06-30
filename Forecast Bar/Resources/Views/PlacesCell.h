//
//  PlacesCell.h
//  Forecast Bar
//
//  Created by Jason Malashock on 9/26/15.
//
//

#import <Cocoa/Cocoa.h>

@interface PlacesCell : NSTableCellView {
@private
    BOOL mouseInside;
    NSTrackingArea *trackingArea;
}


@property (nonatomic, retain) IBOutlet NSTextField *subTitle;

@end
