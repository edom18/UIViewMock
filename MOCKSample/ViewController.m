
#import "ViewController.h"

#import "VMMockView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    VMMockView *mockView = [[VMMockView alloc] initWithFrame:self.view.bounds];
    mockView.backgroundColor = UIColor.redColor;
    mockView.visibleTargets = YES;
    
    VMMockTouchItem *item1 = [VMMockTouchItem createTouchTarget:CGRectMake(100, 100, 44, 44)
                                                   touchHandler:^{
                                                       NSLog(@"mock!!!");
                                                   }];
    VMMockTouchItem *item2 = [VMMockTouchItem createTouchTarget:CGRectMake(100, 154, 44, 44)
                                                   touchHandler:^{
                                                       NSLog(@"mock!!!2");
                                                   }];
    VMMockTouchItem *item3 = [VMMockTouchItem createTouchTarget:CGRectMake(100, 208, 120, 120)
                                                   withImageURL:[NSURL URLWithString:@"https://878afc88c41ea4f638275872f0a796f86144cf47.googledrive.com/host/0BzgQC1agpgIDfi13eTJVeUUtU3I4X2JKSHE2Y3lwS2FhazFTZVZ3bmJxSHpYQVc3SEFaVEU/dummy_game_list.png"]
                                                   touchHandler:^{
                                                       NSLog(@"image mock!!");
                                                   }];
    [mockView addTouchItems:@[item1, item2, item3]];
    [self.view addSubview:mockView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
