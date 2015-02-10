
@import UIKit;

#import "VMMockTouchItem.h"

@interface VMMockView : UIView

typedef void (^VMMockViewTouchHandlerBlock)();

@property (nonatomic, assign) BOOL visibleTargets;

+ (instancetype)create;
+ (instancetype)createWithFrame:(CGRect)frame;

/**
 *  Add touch item
 *
 *  @param item VMMockTouchItem
 */
- (void)addTouchItem:(VMMockTouchItem *)item;


/**
 *  Add touch items
 *
 *  @param items VMMockTouchItems
 */
- (void)addTouchItems:(NSArray *)items;

@end
