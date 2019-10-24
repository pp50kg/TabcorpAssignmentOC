//
//  LaunchMission.m
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/24.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import "LaunchMission.h"

@implementation LaunchMission

#pragma mark - Lifecycle

- (instancetype)initWithDictionary:(NSDictionary *)tempDic {
    self = [super init];
    if (!self) return nil;

    _flightNumber = tempDic[@"flight_number"];
    _missionName = tempDic[@"mission_name"];
    _launchYear = tempDic[@"launch_year"];
    _launchDate = tempDic[@"launch_date_utc"];
    _launchUnix = tempDic[@"launch_date_unix"];
    NSDictionary *rocketInfo = tempDic[@"rocket"];
    _rocketId = rocketInfo[@"rocket_id"];
    
    _launchSuccess = NO;

    id value = tempDic[@"launch_success"];
    
    if (![value isKindOfClass:[NSNull class]]) {
        _launchSuccess = [value boolValue];
    }
    
    return self;
}

@end
