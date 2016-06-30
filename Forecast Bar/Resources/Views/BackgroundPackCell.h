//
//  BackgroundPackCell.h
//  Forecast Bar
//
//  Created by Jason Malashock on 3/13/16.
//
//

#import <Cocoa/Cocoa.h>
#import "PVAsyncImageView.h"

@interface BackgroundPackCell : NSTableCellView

@property (nonatomic, retain) IBOutlet NSTextField *bgPackAuthor;
@property (nonatomic, retain) IBOutlet NSTextField *bgPackName;
@property (nonatomic, retain) IBOutlet PVAsyncImageView *bgPackImage;
@property (nonatomic, retain) IBOutlet NSImageView *accessoryView;
@property (nonatomic, retain) IBOutlet NSImageView *weatherBadge;

@end
