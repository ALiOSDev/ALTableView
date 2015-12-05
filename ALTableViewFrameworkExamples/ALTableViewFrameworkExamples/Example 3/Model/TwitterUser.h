//
//  TwitterUser.h
//  ALTableViewFrameworkExamples
//
//  Created by lorenzo villarroel perez on 4/12/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "MetaModel.h"

@interface TwitterUser : MetaModel

@property(strong, nonatomic) NSString * screenName;
@property(strong, nonatomic) NSString * name;
@property(strong, nonatomic) NSString * imageURL;

@end
