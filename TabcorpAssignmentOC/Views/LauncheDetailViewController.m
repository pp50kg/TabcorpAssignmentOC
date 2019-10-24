//
//  LauncheDetailViewController.m
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/23.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import "LauncheDetailViewController.h"
#import "MissionDetailPresenter.h"

@interface LauncheDetailViewController ()<MissionDetailPresenterDelegate>

@end

@implementation LauncheDetailViewController{
    LaunchMission *launchedDetail;
    Rocket *rocketDetail;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [viewControllerTitleLabel setText:@"Mission Detail"];
    
    MissionDetailPresenter *presenter = [MissionDetailPresenter new];
    [presenter setDelegate:self];
    [presenter requestMissionDetailWith:_launchMission.flightNumber];
    [presenter requestRocketDetailWith:_launchMission.rocketId];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - MissionDetailPresenterDelegate
-(void)updateLaunchedDetail:(LaunchMission *)launchedInfo{
    launchedDetail = launchedInfo;
    [tableView reloadData];
}

-(void)updateRocketDetail:(Rocket *)rocketInfo{
    rocketDetail = rocketInfo;
    [tableView reloadData];
}

-(void)failWithAPI{
    
}

#pragma mark - Action
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
