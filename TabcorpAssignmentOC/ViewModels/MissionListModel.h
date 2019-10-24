//
//  MissionListModel.h
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/24.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, SortType) {
    SortByDate = 1,
    SortByName = 2
};

@interface MissionListModel : NSObject

- (instancetype)initWithMissionList:(NSMutableArray *)missionList;

- (NSMutableArray *)sortByType:(SortType)selectedType;
- (NSString *)viewControllerTitle;
- (NSString *)sectionTitleInSection:(NSInteger)section;
- (NSUInteger)numberOfMissionInSection:(NSInteger)section;
- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)subTitleAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
