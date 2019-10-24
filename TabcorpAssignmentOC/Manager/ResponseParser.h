//
//  ResponseParser.h
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/24.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResponseParser : NSObject

+ (NSDictionary *)transferBodyToDictionary:(NSString *)body;

@end

NS_ASSUME_NONNULL_END
