
@import UIKit;

@interface MOCKView : UIView

typedef void (^MOCKViewTouchHandlerBlock)();

@property (nonatomic, assign) BOOL visibleTargets;

+ (instancetype)create;
+ (instancetype)createWithFrame:(CGRect)frame;

- (void)addMockTarget:(CGRect)frame
         touchHandler:(MOCKViewTouchHandlerBlock)handler;

- (void)addImageMockTarget:(CGRect)frame
              withImageURL:(NSURL *)url
              touchHandler:(MOCKViewTouchHandlerBlock)handler;

@end
