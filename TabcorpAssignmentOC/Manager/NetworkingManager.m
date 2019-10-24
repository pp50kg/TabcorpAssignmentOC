//
//  NetworkingManager.m
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/24.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import "NetworkingManager.h"

#define SystemNetworkMaxTime 60.0

@implementation NetworkingManager{
    UIView *blackLoadingView;
}
SINGLETON_FOR_CLASS(NetworkingManager);

- (instancetype)init
{
    if (self = [super init])
    {
        NSURL *baseURL = [NSURL URLWithString:BaseURL];
        self.sessionManager = [[AFHTTPSessionManager manager] initWithBaseURL:baseURL];
        
        // 請求格式
        // AFHTTPRequestSerializer            二進制格式
        // AFJSONRequestSerializer            JSON
        // AFPropertyListRequestSerializer    PList(是一種特殊的XML,解析起来相對容易)
        
        self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上傳普通格式
        
        // 超時時間
        [self.sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        [self.sessionManager.requestSerializer setTimeoutInterval: SystemNetworkMaxTime];
        [self.sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        // 設置請求header
        [self.sessionManager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
        // 設置接收的Content-Type
        self.sessionManager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
        
        // 返回格式
        // AFHTTPResponseSerializer           二進制格式
        // AFJSONResponseSerializer           JSON
        // AFXMLParserResponseSerializer      XML,只能返回XMLParser,還需要自己通過代理方法解析
        // AFXMLDocumentResponseSerializer (Mac OS X)
        // AFPropertyListResponseSerializer   PList
        // AFImageResponseSerializer          Image
        // AFCompoundResponseSerializer       组合
        
        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];//返回格式 JSON
        //設置返回C的ontent-type
        self.sessionManager.responseSerializer.acceptableContentTypes=[[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
        
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
        {
            NSLog(@"NetworkStatus:%ld", (long)status);
        }];
    }
    
    return self;
}

- (void)showLogWithURLString:(NSString *)urlString parameters:(id)parameters
{
    NSMutableString *strings = [NSMutableString string];
    NSArray *allKeys = [parameters allKeys];
    for (NSUInteger index = 0; index < allKeys.count; index++)
    {
        if (index != 0)
        {
            [strings appendString:@"&"];
        }
        
        NSString *key = [allKeys objectAtIndex:index];
        id value = [parameters objectForKey:key];
        
        NSString *parameter = [NSString stringWithFormat:@"%@:%@", key, value];
        [strings appendString:parameter];
    }
    
    NSString *log = [NSString stringWithFormat:@"%@%@?%@",
                     self.sessionManager.baseURL.absoluteString,
                     urlString,
                     strings];
    NSLog(@"%@", log);
}


- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                     progress:(void (^)(NSProgress * downloadProgress))downloadProgressHandler
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))successHandler
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failureHandler
{
    [self showLogWithURLString:URLString parameters:parameters];
    self.sessionManager.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    self.sessionManager.requestSerializer= [AFJSONRequestSerializer serializer];
    NSURLSessionDataTask *task = [self.sessionManager GET:URLString
                                               parameters:parameters
                                                 progress:^(NSProgress * _Nonnull downloadProgress)
                                  {
                                      if (downloadProgressHandler)
                                      {
                                          downloadProgressHandler(downloadProgress);
                                      }
                                  }
                                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                                  {
//                                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                      if (successHandler)
                                      {
                                          successHandler(task, responseObject);
                                      }
                                  }
                                                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                                  {
//                                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                      if (failureHandler) {
                                          failureHandler(task, error);
                                      }
                                  }];
    
    return task;
}

@end
