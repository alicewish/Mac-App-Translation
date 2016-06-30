//
//  CustomCell.h
//  Forecast Bar
//
//  Created by Jason Malashock on 9/25/15.
//
//

#import <Cocoa/Cocoa.h>

@interface CustomCell : NSTableCellView

@property (nonatomic, retain) IBOutlet NSButton *deleteButton;
@property (nonatomic, retain) IBOutlet NSTextField *cityLabel;
@property (nonatomic, retain) IBOutlet NSTextField *shortcutLabel;


@end
