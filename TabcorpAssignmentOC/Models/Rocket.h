//
//  Rocket.h
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/23.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Rocket : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)tempDic;

@property (strong, nonatomic) NSString *firstFlight;//first_flight

@property (strong, nonatomic) NSString *country;//country

@property (strong, nonatomic) NSString *company;//company

@property (strong, nonatomic) NSString *rocketID;//rocket_id

@property (strong, nonatomic) NSString *rocketType;//rocket_type

@property (strong, nonatomic) NSString *wikipedia;//wikipedia

@end

NS_ASSUME_NONNULL_END
