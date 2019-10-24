//
//  MissionListPresenter.h
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/24.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MissionListPresenterDelegate <NSObject>
-(void)updateList:(NSMutableArray *)missions;
-(void)failWithAPI;

@end

@interface MissionListPresenter : NSObject
@property (weak, nonatomic) id<MissionListPresenterDelegate> delegate;

-(void)requestMissionList;

@end

NS_ASSUME_NONNULL_END
