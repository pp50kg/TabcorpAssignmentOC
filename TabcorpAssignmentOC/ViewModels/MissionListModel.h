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

typedef NS_ENUM(NSInteger, FilterType) {
    FilterType_All = 0,
    FilterType_Success,
    FilterType_Fail
};

@interface MissionListModel : NSObject

- (instancetype)initWithMissionList:(NSMutableArray *)missionList;

@property (strong, nonatomic) NSMutableArray *resultList;

- (NSMutableArray *)sortByType:(SortType)selectedType processArray:(NSMutableArray *)processArray;

- (NSMutableArray *)filterByType:(FilterType)selectedType;

- (NSString *)viewControllerTitle;

- (NSString *)sectionTitleInSection:(NSInteger)section;

- (NSUInteger)numberSection;

- (NSUInteger)numberOfMissionInSection:(NSInteger)section;

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)subTitleAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
