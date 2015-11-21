//
//  ExtendNSLogFunctionality.h
//  GestionDeStocks
//
//  Created by Avantgarde Macbook air on 8/10/15.
//  Copyright (c) 2015 Indra. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSLog(args...) ExtendNSLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);

@interface ExtendNSLogFunctionality : NSObject

@end
