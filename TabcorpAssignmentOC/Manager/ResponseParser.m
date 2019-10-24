//
//  ResponseParser.m
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/24.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import "ResponseParser.h"

@implementation ResponseParser

+ (NSDictionary *)transferBodyToDictionary:(id)body {
    if ([body isKindOfClass:[NSString class]]) {
        NSString *bodyString = body;
        NSData *data = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
        id bodyObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if ([bodyObject isKindOfClass:[NSDictionary class]]) {
            return bodyObject;
        }
        
    } else if ([body isKindOfClass:[NSDictionary class]]) {
        return body;
    }
    
    return nil;
}

@end
