//
//  MissionDetailPresenter.h
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/24.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rocket.h"
#import "LaunchMission.h"

NS_ASSUME_NONNULL_BEGIN
@protocol MissionDetailPresenterDelegate <NSObject>

-(void)updateLaunchedDetail:(LaunchMission *)launchedInfo;

-(void)updateRocketDetail:(Rocket *)rocketInfo;

-(void)failWithAPI;

@end

@interface MissionDetailPresenter : NSObject
@property (weak, nonatomic) id<MissionDetailPresenterDelegate> delegate;

-(void)requestMissionDetailWith:(NSString *)flightNumber;

-(void)requestRocketDetailWith:(NSString *)rockerID;

@end

NS_ASSUME_NONNULL_END
