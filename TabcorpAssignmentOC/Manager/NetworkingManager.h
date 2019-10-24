//
//  NetworkingManager.h
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/24.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkingManager : NSObject
SINGLETON_FOR_HEADER(NetworkingManager);

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

- (NSURLSessionDataTask *)GET:(NSString *)URLString
parameters:(id)parameters
  progress:(void (^)(NSProgress * downloadProgress))downloadProgressHandler
   success:(void (^)(NSURLSessionDataTask *task, id responseObject))successHandler
   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failureHandler;

@end

NS_ASSUME_NONNULL_END
