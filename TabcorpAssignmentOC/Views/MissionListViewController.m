//
//  MissionListViewController.m
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/23.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import "MissionListViewController.h"
#import "MissionListPresenter.h"
#import "MissionListModel.h"

@interface MissionListViewController ()<MissionListPresenterDelegate>

@end

@implementation MissionListViewController{
    NSMutableArray *missionList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MissionListPresenter *presenter = [MissionListPresenter new];
    [presenter setDelegate:self];
    [presenter requestMissionList];
    
    // Do any additional setup after loading the view.
}

#pragma mark - MissionListPresenterDelegate
-(void)updateList:(NSMutableArray *)missions{
    missionList = [NSMutableArray arrayWithArray:missions];
    NSLog(@"%@",missions);
    
}

-(void)failWithAPI{
    
}

@end
