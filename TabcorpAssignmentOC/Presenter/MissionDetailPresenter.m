//
//  MissionDetailPresenter.m
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/24.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import "MissionDetailPresenter.h"
#import "NetworkingManager.h"

@implementation MissionDetailPresenter

-(void)requestMissionDetailWith:(NSString *)flightNumber{
    
    [[NetworkingManager shared] GET:@"launches" parameters:@{@"flight_number":flightNumber} progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadProgress-->%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]){
            NSArray *responseArray = responseObject;
 
            LaunchMission *mission = [[LaunchMission alloc]initWithDictionary:[responseArray firstObject]];
            if ([self->_delegate respondsToSelector:@selector(updateLaunchedDetail:)]) {
                [self->_delegate updateLaunchedDetail:mission];
            }
            /* do something with responseDict */
        }  else if ([responseObject isKindOfClass:[NSDictionary class]]){
            if ([self->_delegate respondsToSelector:@selector(failWithAPI)]) {
                [self->_delegate failWithAPI];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"error-->%@",error);
        if ([self->_delegate respondsToSelector:@selector(failWithAPI)]) {
            [self->_delegate failWithAPI];
        }
    }];
}

-(void)requestRocketDetailWith:(NSString *)rockerID{
    
    [[NetworkingManager shared] GET:@"rockets" parameters:@{@"rocket_id":rockerID} progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadProgress-->%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *responseArray = responseObject;
            NSDictionary *correctDictionary;
            for (NSDictionary *tempDic in responseArray) {
                if ([tempDic[@"rocket_id"]isEqualToString:rockerID]) {
                    correctDictionary = [NSDictionary dictionaryWithDictionary:tempDic];
                }
            }
            Rocket *rocketInfo = [[Rocket alloc]initWithDictionary:correctDictionary];
            if ([self->_delegate respondsToSelector:@selector(updateLaunchedDetail:)]) {
                [self->_delegate updateRocketDetail:rocketInfo];
            }
            /* do something with responseDict */
        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([self->_delegate respondsToSelector:@selector(failWithAPI)]) {
                [self->_delegate failWithAPI];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"error-->%@",error);
        if ([self->_delegate respondsToSelector:@selector(failWithAPI)]) {
            [self->_delegate failWithAPI];
        }
    }];
}

@end
