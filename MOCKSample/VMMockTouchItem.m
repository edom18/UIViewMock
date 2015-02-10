
#import "VMMockTouchItem.h"

@implementation VMMockTouchItem

+ (instancetype)createTouchTarget:(CGRect)frame
                     touchHandler:(VMMockViewTouchHandlerBlock)handler;
{
    return [[self.class alloc] initWithTouchTarget:frame
                                      withImageURL:nil
                                      touchHandler:handler];
}

+ (instancetype)createTouchTarget:(CGRect)frame
                     withImageURL:(NSURL *)url
                     touchHandler:(VMMockViewTouchHandlerBlock)handler
{
    return [[self.class alloc] initWithTouchTarget:frame
                                      withImageURL:url
                                      touchHandler:handler];
}

- (instancetype)initWithTouchTarget:(CGRect)frame
                       withImageURL:(NSURL *)url
                       touchHandler:(VMMockViewTouchHandlerBlock)handler
{
    self = [super init];
    if (self) {
        self.frame   = frame;
        self.url     = url;
        self.handler = handler;
    }
    return self;
}

@end
