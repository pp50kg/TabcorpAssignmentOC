//
//  MissionListModel.m
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/24.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MissionListModel.h"

@interface MissionListModel ()

@property (strong, nonatomic) NSMutableArray *missions;
@property (assign, nonatomic) SortType selectedSortType;

@end

@implementation MissionListModel{
    NSMutableArray *allItems;
    NSMutableArray *successItems;
    NSMutableArray *failItems;
}

- (instancetype)initWithMissionList:(NSMutableArray *)missionList{
    self = [super init];
    if (!self) return nil;

    _missions = missionList;
    allItems = [NSMutableArray new];
    successItems = [NSMutableArray new];
    failItems = [NSMutableArray new];
    
    [self filterArray];
    
    return self;
}

- (NSString *)viewControllerTitle{
    return @"List";
}

- (NSMutableArray *)sortByType:(SortType)selectedType processArray:(NSMutableArray *)processArray{
    NSMutableArray *sortArray = [NSMutableArray new];
    _selectedSortType = selectedType;
    
    switch (selectedType) {
        case SortByDate:{
             NSMutableSet *dateSet = [NSMutableSet new];
            for (LaunchMission *tempMission in processArray) {
                [dateSet addObject:tempMission.launchYear];
            }
            for (NSString *launchYear in dateSet) {
                NSMutableArray *yearGroup = [NSMutableArray new];
                for (LaunchMission *tempMission in processArray) {
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
            NSArray *sortedGroupArray;
                sortedGroupArray = [sortArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                LaunchMission *firstLaunchMission = [(NSMutableArray *)a firstObject];
                NSString *firstLaunchYear = firstLaunchMission.launchYear;
                    
                LaunchMission *secondLaunchMission = [(NSMutableArray *)b firstObject];
                NSString *secondLaunchYear = secondLaunchMission.launchYear;
                return [firstLaunchYear compare:secondLaunchYear];
            }];
            sortArray = [NSMutableArray arrayWithArray:sortedGroupArray];
        }
            break;
        case SortByName:{
                 NSMutableSet *alphabetSet = [NSMutableSet new];
            for (LaunchMission *tempMission in processArray) {
                if (tempMission.missionName.length>0) {
                    [alphabetSet addObject:[tempMission.missionName substringToIndex:1]];
                }
            }
            for (NSString *alphabet in alphabetSet) {
                NSMutableArray *alphabetGroup = [NSMutableArray new];
                for (LaunchMission *tempMission in processArray) {
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
            NSArray *sortedGroupArray;
                sortedGroupArray = [sortArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                LaunchMission *firstLaunchMission = [(NSMutableArray *)a firstObject];
                NSString *firstLaunchAlphabet = [firstLaunchMission.missionName substringToIndex:1];
                    
                LaunchMission *secondLaunchMission = [(NSMutableArray *)b firstObject];
                NSString *secondLaunchAlphabet = [secondLaunchMission.missionName substringToIndex:1];
                return [firstLaunchAlphabet compare:secondLaunchAlphabet];
            }];
            sortArray = [NSMutableArray arrayWithArray:sortedGroupArray];
        }
            break;
        default:
            break;
    }
    return sortArray;
}

-(void) filterArray{
    allItems = [NSMutableArray arrayWithArray:_missions];
    
    for (LaunchMission *tempMission in _missions) {
        if (tempMission.launchSuccess) {
            [successItems addObject:tempMission];
        }
    }
    
    for (LaunchMission *tempMission in _missions) {
        if (!tempMission.launchSuccess) {
            [failItems addObject:tempMission];
        }
    }
}

- (NSMutableArray *)filterByType:(FilterType)selectedType{
    NSMutableArray *filterArray = [NSMutableArray new];
    
    switch (selectedType) {
        case FilterType_All:{
            filterArray = [self sortByType:_selectedSortType processArray:allItems];
        }
            break;
        case FilterType_Success:{
            filterArray = [self sortByType:_selectedSortType processArray:successItems];
        }
            break;
        case FilterType_Fail:{
            filterArray = [self sortByType:_selectedSortType processArray:failItems];
        }
            break;
        default:
            break;
    }
    return filterArray;
}

- (NSString *)sectionTitleInSection:(NSInteger)section{
    NSString *sectionTitle;
    switch (_selectedSortType) {
        case SortByDate:{
            NSMutableArray *yearGroup = _resultList[section];
            LaunchMission *firstMission = [yearGroup firstObject];
            sectionTitle = firstMission.launchYear;
        }
            break;
        case SortByName:{
            NSMutableArray *alphabetGroup = _resultList[section];
            LaunchMission *firstMission = [alphabetGroup firstObject];
            sectionTitle = [firstMission.missionName substringToIndex:1];
        }
            break;
        default:
            break;
    }
    return sectionTitle;
}

- (NSUInteger)numberSection{
    return _resultList.count;
}

- (NSUInteger)numberOfMissionInSection:(NSInteger)section{
    NSMutableArray *sectionItems = _resultList[section];
    
    return sectionItems.count;
}

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *sectionItems = _resultList[indexPath.section];
    LaunchMission *mission = sectionItems[indexPath.row];
    
    return [NSString stringWithFormat:@"MissionName: %@",mission.missionName];
}

- (NSString *)subTitleAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *sectionItems = _resultList[indexPath.section];
    LaunchMission *mission = sectionItems[indexPath.row];
    
    return [NSString stringWithFormat:@"LaunchDate: %@",mission.launchDate];
}

-(LaunchMission *)selectedMissionAtIndexPath:(NSIndexPath *)indexPath{
   NSMutableArray *sectionItems = _resultList[indexPath.section];
   LaunchMission *mission = sectionItems[indexPath.row];
    
    return mission;
}
@end
