//
//  TwitterStatus.m
//  ALTableViewFrameworkExamples
//
//  Created by lorenzo villarroel perez on 4/12/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "TwitterStatus.h"
#import "TwitterUser.h"

@implementation TwitterStatus

- (instancetype)initWithDictionary: (NSDictionary *) dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.text = dictionary[@"text"];
        self.user = [[TwitterUser alloc] initWithDictionary:dictionary[@"user"]];
    }
    return self;
}

@end
