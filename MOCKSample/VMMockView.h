
@import UIKit;

@interface VMMockView : UIView

typedef void (^VMMockViewTouchHandlerBlock)();

@property (nonatomic, assign) BOOL visibleTargets;

+ (instancetype)create;
+ (instancetype)createWithFrame:(CGRect)frame;

- (void)addMockTarget:(CGRect)frame
         touchHandler:(VMMockViewTouchHandlerBlock)handler;

- (void)addImageMockTarget:(CGRect)frame
              withImageURL:(NSURL *)url
              touchHandler:(VMMockViewTouchHandlerBlock)handler;

@end
