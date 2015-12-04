//
//  TwitterStatus.h
//  ALTableViewFrameworkExamples
//
//  Created by lorenzo villarroel perez on 4/12/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "MetaModel.h"

@class TwitterUser;
@interface TwitterStatus : MetaModel

@property(strong, nonatomic) NSString * text;
@property(strong, nonatomic) TwitterUser * user;

@end
