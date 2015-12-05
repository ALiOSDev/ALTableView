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
    self = [super initWithDictionary:dictionary];
    if (self) {
//        NSLog(@"%@",dictionary);
        self.screenName = dictionary[@"screen_name"];
        self.name = dictionary[@"name"];
        self.imageURL = dictionary[@"profile_image_url_https"];
    }
    return self;
}

@end
