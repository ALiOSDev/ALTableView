//
//  DetailViewController.m
//  ALTableViewFrameworkExamples
//
//  Created by Abimael Barea Puyana on 20/11/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Setup ViewController

- (void) setupViewController:(UIViewController *) controller {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    for (UIViewController *vC in self.childViewControllers) {
        [vC.view removeFromSuperview];
        [vC removeFromParentViewController];
    }
    self.controller = nil;
    
    self.view.autoresizesSubviews = YES;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.view.frame =  UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]) ? CGRectMake(0, 63, 703, 704) : CGRectMake(0, 63, 768, 961);
    }
    
    self.controller = (UIViewController *) controller;
    [self addChildViewController:self.controller];
    [self.view addSubview:self.controller.view];
    self.title = self.controller.title;
}

@end
