//
//  MasterTableViewCell.m
//  ALTableViewFrameworkExamples
//
//  Created by lorenzo villarroel perez on 20/11/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "MasterTableViewCell.h"

@implementation MasterTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) configureCell: (NSString *) object {
    self.label.text = object;
}

@end
