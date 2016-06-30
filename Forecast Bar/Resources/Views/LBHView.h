#import <Cocoa/Cocoa.h>

@interface LBHView : NSView

/// This property controls whether the view can indirectly control its
/// backing layer's properties, specifically the following:
///		`affineTransform`
///		`anchorPoint`
///
/// These properties cannot be modified on the layer during the time that
/// this property is enabled.
///
/// This is useful for preventing NSView from resetting custom modifications
/// to the layer, such as transforms for custom animations.
@property (nonatomic, assign) BOOL ignoreNSViewBackingLayerSynchronization;

@end
