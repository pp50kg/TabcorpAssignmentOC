//
//  MissionListModel.m
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/24.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MissionListModel.h"
#import "Mission.h"

@interface MissionListModel ()

@property (strong, nonatomic) NSMutableArray *missions;

@end

@implementation MissionListModel

- (instancetype)initWithMissionList:(NSMutableArray *)missionList{
    self = [super init];
    if (!self) return nil;

    _missions = missionList;

    return self;
}

- (NSString *)viewControllerTitle{
    return @"List";
}

- (NSString *)sectionTitleInSection:(NSInteger)section{
    NSString *sectionTitle;
    return sectionTitle;
}

- (NSUInteger)numberOfMissionInSection:(NSInteger)section{
    NSMutableArray *sectionItems = _missions[section];
    return sectionItems.count;
}

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *sectionItems = _missions[indexPath.section];
    Mission *mission = sectionItems[indexPath.row];
    return mission.missionName;
}

- (NSString *)subTitleAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *sectionItems = _missions[indexPath.section];
    Mission *mission = sectionItems[indexPath.row];
    return mission.launchDate;
}

@end
