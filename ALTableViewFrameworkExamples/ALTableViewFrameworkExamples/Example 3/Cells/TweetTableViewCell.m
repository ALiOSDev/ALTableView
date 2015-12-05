//
//  TweetTableViewCell.m
//  ALTableViewFrameworkExamples
//
//  Created by lorenzo villarroel perez on 5/12/15.
//  Copyright © 2015 Abimael Barea Puyana. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "TwitterStatus.h"
#import "TwitterUser.h"

@implementation TweetTableViewCell

-(void) executeAction: (UIViewController *) viewController {

}

-(void) configureCell: (id) object {
    if ([object isKindOfClass:[TwitterStatus class]]) {
        TwitterStatus * twitterStatus = (TwitterStatus *) object;
        self.screenName.text = [NSString stringWithFormat:@"@%@",twitterStatus.user.screenName];
        self.name.text = twitterStatus.user.name;
        
//        self.text.textContainer.lineFragmentPadding = 0;
//        self.text.textContainerInset = UIEdgeInsetsZero;
        self.text.text = twitterStatus.text;
        [self.text sizeToFit];
        
        [self performSelectorInBackground:@selector(downloadUserImageWithURL:) withObject:twitterStatus.user.imageURL];
    }
}

-(void) downloadUserImageWithURL: (NSString *) imageURL {
    NSURL * url = [NSURL URLWithString:imageURL];
    NSData * data = [NSData dataWithContentsOfURL:url];
    UIImage * image = [UIImage imageWithData:data];
    [self.userImage performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
}

-(void) cellDeselected {
    
}
@end
