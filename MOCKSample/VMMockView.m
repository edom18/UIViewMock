
#import "VMMockView.h"

#import <objc/runtime.h>

@interface VMMockView()

@property (nonatomic, strong) NSMutableArray *mockTargetList;
@property (nonatomic, strong) NSCache *imageCache;
    
@end


@implementation VMMockView

@synthesize visibleTargets = _visibleTargets;

////////////////////////////////////////////////////////////////////
#pragma mark - Life cycle

+ (instancetype)create
{
    return [self.class createWithFrame:CGRectZero];
}

+ (instancetype)createWithFrame:(CGRect)frame
{
    return [[self.class alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageCache = [[NSCache alloc] init];
        self.imageCache.countLimit = 20;
        [self setupTouchEvent];
    }
    return self;
}

- (void)dealloc
{
    for (UIView *view in self.mockTargetList) {
        objc_removeAssociatedObjects(view);
    }
    self.mockTargetList = nil;
}

/**
 *  Visible setting.
 *
 *  @param visible
 */
- (BOOL)visibleTargets
{
    return _visibleTargets;
}
- (void)setVisibleTargets:(BOOL)visible
{
    if (_visibleTargets == visible) {
        return;
    }
    _visibleTargets = visible;
    
    if (visible) {
        for (UIView *view in self.subviews) {
            view.backgroundColor = [self randomColor];
        }
    }
    else {
        for (UIView *view in self.subviews) {
            view.backgroundColor = UIColor.clearColor;
        }
    }
}


/**
 *  Seting up touch events.
 */
- (void)setupTouchEvent
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(highlight:)];
    [self addGestureRecognizer:tapGesture];
}


- (void)highlight:(id)sender
{
    NSLog(@"touch!!!!!");
}


/**
 *  Create a random color.
 *
 *  @return random color.
 */
- (UIColor *)randomColor
{
    CGFloat r = (CGFloat)(arc4random() % 100) / 100;
    CGFloat g = (CGFloat)(arc4random() % 100) / 100;
    CGFloat b = (CGFloat)(arc4random() % 100) / 100;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

/**
 *  Make a mock target
 *
 *  @param frame
 *
 *  @return mock target as UIView
 */
- (UIView *)makeMockTarget:(CGRect)frame
{
    UIView *mockTarget = [[UIView alloc] initWithFrame:frame];
    if (self.visibleTargets) {
        mockTarget.backgroundColor = [self randomColor];
    }
    return mockTarget;
}


/**
 *  Add mock target
 *
 *  @param frame
 *  @param handler tap callback.
 */
- (void)addMockTarget:(CGRect)frame
         touchHandler:(VMMockViewTouchHandlerBlock)handler
{
    UIView *mockTarget = [self makeMockTarget:frame];
    [self applyTapEvent:handler toView:mockTarget];
    [self addSubview:mockTarget];
    [self.mockTargetList addObject:mockTarget];
}


/**
 *  Add mock target with an image.
 *
 *  @param frame
 *  @param url     image url
 *  @param handler tap callback.
 */
- (void)addImageMockTarget:(CGRect)frame
         withImageURL:(NSURL *)url
         touchHandler:(VMMockViewTouchHandlerBlock)handler
{
    UIImageView *mockTarget = [[UIImageView alloc] initWithFrame:frame];
    mockTarget.userInteractionEnabled = YES;
    mockTarget.backgroundColor = UIColor.lightGrayColor;
    [self applyTapEvent:handler toView:mockTarget];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *key     = url.absoluteString;
        UIImage *cacheImg = [self.imageCache objectForKey:key];
        UIImage *img      = cacheImg ?: [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!img) {
                return;
            }
            
            [self.imageCache setObject:img forKey:key];
            mockTarget.image = img;
            mockTarget.backgroundColor = UIColor.clearColor;
        });
    });
    
    [self addSubview:mockTarget];
    [self.mockTargetList addObject:mockTarget];
}


/**
 *  Apply tap event with handler
 *
 *  @param handler handler
 *  @param view    target view
 */
- (void)applyTapEvent:(VMMockViewTouchHandlerBlock)handler
               toView:(UIView *)view
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(tapMock:)];
    [view addGestureRecognizer:tapGesture];
    objc_setAssociatedObject(view, @selector(tapMock:), handler, OBJC_ASSOCIATION_COPY);
}


/**
 *  Tap handler on mock item.
 */
- (void)tapMock:(UITapGestureRecognizer *)sender
{
    UIView *target = sender.view;
    VMMockViewTouchHandlerBlock block = objc_getAssociatedObject(target, _cmd);
    if (block) {
        block();
    }
}

@end
