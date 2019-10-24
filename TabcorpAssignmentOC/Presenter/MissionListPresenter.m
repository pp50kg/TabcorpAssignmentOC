//
//  MissionListPresenter.m
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/24.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import "MissionListPresenter.h"
#import "NetworkingManager.h"
#import "Mission.h"

@implementation MissionListPresenter

-(void)requestMissionList{
    [[NetworkingManager shared] GET:@"launches" parameters:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadProgress-->%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *responseArray = responseObject;
            NSMutableArray *missionArray = [NSMutableArray new];
            for (NSDictionary *tempDic in responseArray) {
                Mission *mission = [[Mission alloc]initWithDictionary:tempDic];
                [missionArray addObject:mission];
            }
            if ([self->_delegate respondsToSelector:@selector(updateList:)]) {
                [self->_delegate updateList:missionArray];
            }
            /* do something with responseArray */
        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([self->_delegate respondsToSelector:@selector(failWithAPI)]) {
                [self->_delegate failWithAPI];
            }
            /* do something with responseDict */
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"error-->%@",error);
        if ([self->_delegate respondsToSelector:@selector(failWithAPI)]) {
            [self->_delegate failWithAPI];
        }
    }];
}

@end
