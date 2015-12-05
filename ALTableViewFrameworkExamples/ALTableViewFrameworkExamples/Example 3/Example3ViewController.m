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
                RowElement * rowElement = [RowElement rowElementWithClassName:[TweetTableViewCell class] object:twitterStatus heightCell:@130 cellIdentifier:nil];
                rowElement.automaticDimension = YES;
                [rowElements addObject:rowElement];
                
            }
            [sections addObject:[SectionElement sectionElementWithSectionTitleIndex:nil viewHeader:nil viewFooter:nil heightHeader:nil heightFooter:nil cellObjects:rowElements isExpandable:NO]];
            
            [weakSelf replaceAllSectionElements:sections];
            [weakSelf.tableView setTableFooterView:[[UIView alloc] init]];
        } errorBlock:^(NSError *error) {
            NSLog(@"-- error: %@", error);
        }];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"-- error %@", error);
    }];
}



@end
