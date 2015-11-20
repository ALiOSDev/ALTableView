//
//  ButtonLabelTableViewCell.m
//  ALTableViewFramework
//
//  Created by Avantgarde Macbook air on 10/11/15.
//
//

#import "ButtonLabelTableViewCell.h"

@implementation ButtonLabelTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) executeAction:(UIViewController *)viewController {
    NSLog(@"ButtonLabelCell pressed");
}

@end
