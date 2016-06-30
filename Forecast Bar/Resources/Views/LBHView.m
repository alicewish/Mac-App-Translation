#import "LBHView.h"
#import "JRSwizzle.h"
#import <objc/runtime.h>

@interface CALayer (LBHBackingLayerHacks)

@property (nonatomic, assign) BOOL lbh_ignoreNSViewBackingLayerSynchronization;

@end

static void *LBHBackingLayerSynchronizationAssociatedObjectKey = &LBHBackingLayerSynchronizationAssociatedObjectKey;

@implementation CALayer (LBHBackingLayerHacks)

- (void)setLbh_ignoreNSViewBackingLayerSynchronization:(BOOL)ignores {
	objc_setAssociatedObject(self, LBHBackingLayerSynchronizationAssociatedObjectKey, @(ignores), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)lbh_ignoreNSViewBackingLayerSynchronization {
	return [objc_getAssociatedObject(self, LBHBackingLayerSynchronizationAssociatedObjectKey) boolValue];
}

- (void)lbh_setAffineTransform:(CGAffineTransform)m {
	if (self.lbh_ignoreNSViewBackingLayerSynchronization) {
		// do nothing
	} else {
		[self lbh_setAffineTransform:m];
	}
}

- (void)lbh_setAnchorPoint:(CGPoint)anchorPoint {
    if (self.lbh_ignoreNSViewBackingLayerSynchronization) {
        [self lbh_setAnchorPoint:CGPointMake(0.5, 0.5)];
    } else {
        [self lbh_setAnchorPoint:anchorPoint];
    }
}

@end

@implementation LBHView

- (instancetype)initWithFrame:(NSRect)frameRect {
	self = [super initWithFrame:frameRect];
	if (self == nil) return nil;
	self.wantsLayer = YES;
	self.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
	
	return self;
}

- (CALayer *)makeBackingLayer {
	CALayer *backingLayer = [super makeBackingLayer];
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		// Get the class for _NSBackingLayer.
		Class nsBackingLayerClass = backingLayer.class;
		
		NSError *error = nil;
		
		// Swizzle the setters for anchor point and affine transform.
		[nsBackingLayerClass jr_swizzleMethod:@selector(setAnchorPoint:) withMethod:@selector(lbh_setAnchorPoint:) error:&error];
		[nsBackingLayerClass jr_swizzleMethod:@selector(setAffineTransform:) withMethod:@selector(lbh_setAffineTransform:) error:&error];
		
		if (error != nil) {
			NSLog(@"Fatal error: could not swizzle the view's backing layer! %@", error);
		}
	});
	
	return backingLayer;
}

- (void)setIgnoreNSViewBackingLayerSynchronization:(BOOL)ignoreSynchronization {
	self.layer.lbh_ignoreNSViewBackingLayerSynchronization = ignoreSynchronization;
}

@end
