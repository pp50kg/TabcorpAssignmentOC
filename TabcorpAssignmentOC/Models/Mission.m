//
//  Mission.m
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/23.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import "Mission.h"

@implementation Mission

#pragma mark - Lifecycle

- (instancetype)initWithDictionary:(NSDictionary *)tempDic {
    self = [super init];
    if (!self) return nil;

    _flightNumber = tempDic[@"flight_number"];
    _missionName = tempDic[@"mission_name"];
    _launchYear = tempDic[@"launch_year"];
    _launchDate = tempDic[@"launch_date_utc"];
    NSDictionary *rocketInfo = tempDic[@"rocket"];
    _rocketId = rocketInfo[@"rocket_id"];

    return self;
}

@end
