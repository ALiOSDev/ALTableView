//
//  Home2ViewController.m
//  Test
//
//  Created by lorenzo villarroel perez on 31/10/15.
//  Copyright © 2015 lorenzo villarroel perez. All rights reserved.
//

#import "Home2ViewController.h"

@interface Home2ViewController ()

@end

@implementation Home2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"home";
    NSLog(@"viewDidLoad %@",NSStringFromCGRect(self.view.frame));
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:view];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    
    ////    [self.view layoutIfNeeded];
    //    if ([self isMovingToParentViewController]) {
    //        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2)];
    //        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    //        view.backgroundColor = [UIColor blackColor];
    //            [self.view addSubview:view];
    //    }
    //    NSLog(@"%d",[self isMovingToParentViewController]);
    NSLog(@"viewWillAppear %@",NSStringFromCGRect(self.view.frame));
    //    NSLog(@"%d",[self isViewLoaded]);
}

-(void) viewDidLayoutSubviews {
    NSLog(@"viewDidLayoutSubviews %@",NSStringFromCGRect(self.view.frame));
    //    NSLog(@"viewDidLayoutSubviews");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
