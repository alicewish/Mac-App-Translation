//
//  IconPackCell.h
//  Forecast Bar
//
//  Created by Jason Malashock on 3/12/16.
//
//

#import <Cocoa/Cocoa.h>
#import "PVAsyncImageView.h"

@interface IconPackCell : NSTableCellView

@property NSString* lastUrl;

@property (nonatomic, retain) IBOutlet NSTextField *iconPackAuthor;
@property (nonatomic, retain) IBOutlet NSTextField *iconPackName;
@property (nonatomic, retain) IBOutlet PVAsyncImageView *iconPackImage;
@property (nonatomic, retain) IBOutlet NSImageView *downloadBadge;
@property (nonatomic, retain) IBOutlet NSImageView *checkmark;

@end
