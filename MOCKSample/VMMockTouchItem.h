
@import Foundation;
@import UIKit;

@interface VMMockTouchItem : NSObject

typedef void (^VMMockViewTouchHandlerBlock)();

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, copy  ) VMMockViewTouchHandlerBlock handler;

+ (instancetype)createTouchTarget:(CGRect)frame
                     touchHandler:(VMMockViewTouchHandlerBlock)handler;

+ (instancetype)createTouchTarget:(CGRect)frame
                     withImageURL:(NSURL *)url
                     touchHandler:(VMMockViewTouchHandlerBlock)handler;

@end
