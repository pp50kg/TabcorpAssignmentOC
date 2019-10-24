//
//  Mission.h
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/23.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Rocket.h"
#import "Launched.h"

NS_ASSUME_NONNULL_BEGIN

@interface Mission : NSObject

@property (strong, nonatomic) NSString *flightNumber;
@property (strong, nonatomic) NSString *launchYear;
@property (strong, nonatomic) NSString *missionName;
@property (strong, nonatomic) NSString *launchDate;
@property (strong, nonatomic) NSString *rocketId;

@end

NS_ASSUME_NONNULL_END
