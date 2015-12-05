//
//  TweetTableViewCell.h
//  ALTableViewFrameworkExamples
//
//  Created by lorenzo villarroel perez on 5/12/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UITextView *text;

@end
