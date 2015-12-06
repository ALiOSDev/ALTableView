//
//  Example3ViewController.m
//  ALTableViewFrameworkExamples
//
//  Created by lorenzo villarroel perez on 29/11/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "Example3ViewController.h"
#import "STTwitterAPI.h"
#import "TwitterStatus.h"
#import "TwitterUser.h"

#import "TweetTableViewCell.h"

@interface Example3ViewController ()

@end

@implementation Example3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Twitter Example";
    [self registerCells];
    self.modeMoveCells = YES;
    [self getTwitterTimelineFromUser:@"barackobama"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) registerCells {
    [self registerClass:[TweetTableViewCell class] CellIdentifier:@"TweetTableViewCell"];
}

-(void) getTwitterTimelineFromUser: (NSString *) user {
    NSString * apiKey = @"RBM2ooCpTzBU9Sc6hV96oH9aK";
    NSString * apiSecret = @"bC5raWX4BF4szbxl3yuW3FR7gUSPfTuqlDOmviMLNbFxQQLQAs";
    
    __block STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:apiKey consumerSecret:apiSecret];
    __block typeof(self) weakSelf = self;
    
    [twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {        
        [twitter getUserTimelineWithScreenName:user successBlock:^(NSArray *statuses) {
            NSMutableArray * sections = [NSMutableArray array];
            NSMutableArray * rowElements = [NSMutableArray array];
            for (NSDictionary * status in statuses) {
                TwitterStatus * twitterStatus = [[TwitterStatus alloc] initWithDictionary:status];
                NSNumber * height = @100;
                RowElement * rowElement = [RowElement rowElementWithClassName:[TweetTableViewCell class] object:twitterStatus heightCell:height cellIdentifier:nil];
                rowElement.estimateHeightMode = YES;
                [rowElements addObject:rowElement];
                
            }
            [sections addObject:[SectionElement sectionElementWithSectionTitleIndex:nil viewHeader:nil viewFooter:nil heightHeader:nil heightFooter:nil cellObjects:rowElements isExpandable:NO]];
            
            [weakSelf replaceAllSectionElements:sections];
            [weakSelf.tableView setTableFooterView:[[UIView alloc] init]];
        } errorBlock:^(NSError *error) {
            NSString * errorMessage = @"";
            errorMessage = error.localizedDescription;
            [self showAlertViewWithMessage:errorMessage];
        }];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"-- error %@", error);
    }];
}

-(void) showAlertViewWithMessage: (NSString *) message {
    UIAlertController * alert =   [UIAlertController
                                   alertControllerWithTitle:@"Error"
                                   message:message
                                   preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}



@end
