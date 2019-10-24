//
//  MissionListModel.h
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/24.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MissionListModel : NSObject

//- (instancetype)initWithStore:(PersonStore *)store;

- (NSString *)viewControllerTitle;
- (NSUInteger)numberOfMissionInSection:(NSInteger)section;
- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)subTitleAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
