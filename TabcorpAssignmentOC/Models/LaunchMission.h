//
//  LaunchMission.h
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/24.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Rocket.h"
#import "Launched.h"
NS_ASSUME_NONNULL_BEGIN

@interface LaunchMission : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)tempDic;

@property (strong, nonatomic) NSString *flightNumber;
@property (strong, nonatomic) NSString *launchYear;
@property (strong, nonatomic) NSString *missionName;
@property (strong, nonatomic) NSString *launchDate;
@property (strong, nonatomic) NSString *launchUnix;
@property (strong, nonatomic) NSString *rocketId;

@end

NS_ASSUME_NONNULL_END
