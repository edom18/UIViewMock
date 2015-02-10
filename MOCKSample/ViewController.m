
#import "ViewController.h"

#import "MOCKView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    MOCKView *mockView = [[MOCKView alloc] initWithFrame:self.view.bounds];
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
                    withImageURL:[NSURL URLWithString:@"https://assets.nakamap.com/img/game/6c6b3f355146d7ba030ea2c9f09baedb625e936f_120.png"]
                    touchHandler:^{
                        NSLog(@"image mock!!");
                    }];
    [self.view addSubview:mockView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
