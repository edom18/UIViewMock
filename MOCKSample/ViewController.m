
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
    [mockView addMockTarget:CGRectMake(100, 100, 44, 44)
               touchHandler:^{
                   NSLog(@"mock!!!");
               }];
    [mockView addMockTarget:CGRectMake(100, 154, 44, 44)
               touchHandler:^{
                   NSLog(@"mock2!!!");
               }];
    
    [mockView addImageMockTarget:CGRectMake(100, 208, 120, 120)
                    withImageURL:[NSURL URLWithString:@"https://878afc88c41ea4f638275872f0a796f86144cf47.googledrive.com/host/0BzgQC1agpgIDfi13eTJVeUUtU3I4X2JKSHE2Y3lwS2FhazFTZVZ3bmJxSHpYQVc3SEFaVEU/dummy_game_list.png"]
                    touchHandler:^{
                        NSLog(@"image mock!!");
                    }];
    [self.view addSubview:mockView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
