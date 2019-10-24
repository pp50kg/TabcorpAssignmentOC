//
//  Rocket.m
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/23.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import "Rocket.h"

@implementation Rocket

- (instancetype)initWithDictionary:(NSDictionary *)tempDic {
    self = [super init];
    if (!self) return nil;
    
    _firstFlight = tempDic[@"first_flight"];
    _country = tempDic[@"country"];
    _company = tempDic[@"company"];
    _rocketID = tempDic[@"rocket_id"];
    _rocketType = tempDic[@"rocket_type"];
    _imageUrl = [tempDic[@"flickr_images"] firstObject];
    _wikipedia = tempDic[@"wikipedia"];
    
    return self;
}

@end
