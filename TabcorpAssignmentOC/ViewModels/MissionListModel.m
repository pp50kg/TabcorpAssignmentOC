//
//  MissionListModel.m
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/24.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LaunchMission.h"
#import "MissionListModel.h"

@interface MissionListModel ()

@property (strong, nonatomic) NSMutableArray *missions;
@property (strong, nonatomic) NSMutableArray *sortList;
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

- (NSMutableArray *)sortByType:(SortType)selectedType{
    NSMutableArray *sortArray = [NSMutableArray new];

    switch (selectedType) {
        case SortByDate:{
            NSMutableSet *dateSet = [NSMutableSet new];
            for (LaunchMission *tempMission in _missions) {
                [dateSet addObject:tempMission.launchYear];
            }
            for (NSString *launchYear in dateSet) {
                NSMutableArray *yearGroup = [NSMutableArray new];
                for (LaunchMission *tempMission in _missions) {
                    if ([tempMission.launchYear isEqualToString:launchYear]) {
                        [yearGroup addObject:tempMission];
                    }
                }
                NSArray *sortedArray;
                sortedArray = [yearGroup sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                    NSDate *first = [NSDate dateWithTimeIntervalSince1970:[[(LaunchMission*)a launchUnix] intValue]];
                    NSDate *second = [NSDate dateWithTimeIntervalSince1970:[[(LaunchMission*)b launchUnix] intValue]];
                    return [first compare:second];
                }];
                [sortArray addObject:sortedArray];
            }
        }
            break;
        case SortByName:{
                NSMutableSet *alphabetSet = [NSMutableSet new];
            for (LaunchMission *tempMission in _missions) {
                if (tempMission.missionName.length>0) {
                    [alphabetSet addObject:[tempMission.missionName substringToIndex:1]];
                }
            }
            for (NSString *alphabet in alphabetSet) {
                NSMutableArray *alphabetGroup = [NSMutableArray new];
                for (LaunchMission *tempMission in _missions) {
                    if (tempMission.missionName.length>0) {
                        if ([alphabet isEqualToString:[tempMission.missionName substringToIndex:1]]) {
                            [alphabetGroup addObject:tempMission];
                        }
                    }
                }
                NSArray *sortedArray;
                sortedArray = [alphabetGroup sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                    NSString *first = [(LaunchMission*)a missionName];
                    NSString *second = [(LaunchMission*)b missionName];
                    return [first compare:second];
                }];
                [sortArray addObject:sortedArray];
            }
        }
            break;
        default:
            break;
    }
    return sortArray;
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
    NSMutableArray *sectionItems = _sortList[indexPath.section];
    LaunchMission *mission = sectionItems[indexPath.row];
    return mission.missionName;
}

- (NSString *)subTitleAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *sectionItems = _sortList[indexPath.section];
    LaunchMission *mission = sectionItems[indexPath.row];
    return mission.launchDate;
}

@end
