//
//  TwitterUser.m
//  ALTableViewFrameworkExamples
//
//  Created by lorenzo villarroel perez on 4/12/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "TwitterUser.h"

@implementation TwitterUser

- (instancetype)initWithDictionary: (NSDictionary *) dictionary {
    self = [super init];
    if (self) {
        self.screenName = dictionary[@"screen_name"];
    }
    return self;
}

@end
