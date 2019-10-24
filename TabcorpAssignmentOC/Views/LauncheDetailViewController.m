//
//  LauncheDetailViewController.m
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/23.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import "LauncheDetailViewController.h"
#import "MissionDetailPresenter.h"
#import <SDWebImage/SDWebImage.h>
#import "DetailCell.h"

@interface LauncheDetailViewController ()<MissionDetailPresenterDelegate>

@end

@implementation LauncheDetailViewController{
    LaunchMission *launchedDetail;
    Rocket *rocketDetail;
    UIImageView *rocketImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [tableView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellReuseIdentifier:@"DetailCell"];
    
    [viewControllerTitleLabel setText:@"Mission Detail"];
    
    MissionDetailPresenter *presenter = [MissionDetailPresenter new];
    [presenter setDelegate:self];
    [presenter requestMissionDetailWith:_launchMission.flightNumber];
    [presenter requestRocketDetailWith:_launchMission.rocketId];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300.0f)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    rocketImageView = [[UIImageView alloc]initWithFrame:headerView.frame];
    [rocketImageView setContentMode:UIViewContentModeScaleAspectFit];
    [rocketImageView setImage:[UIImage imageNamed:@"noImage"]];
    
    [headerView addSubview:rocketImageView];
    
    tableView.tableHeaderView = headerView;
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
    
    [cell.missionLabelOne setText:[NSString stringWithFormat:@"%@",launchedDetail.flightNumber]];
    [cell.missionLabelTwo setText:launchedDetail.missionName];
    [cell.missionLabelThree setText:launchedDetail.launchDate];
    [cell.missionLabelFour setText:launchedDetail.rocketId];
    
    [cell.rocketLabelOne setText:rocketDetail.firstFlight];
    [cell.rocketLabelTwo setText:rocketDetail.company];
    [cell.rocketLabelThree setText:rocketDetail.country];
    [cell.rocketLabelFour setText:rocketDetail.rocketID];
    
    [cell.launchWikiBtn addTarget:self action:@selector(goToWikiAction) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark - MissionDetailPresenterDelegate
-(void)updateLaunchedDetail:(LaunchMission *)launchedInfo{
    launchedDetail = launchedInfo;
    [tableView reloadData];
}

-(void)updateRocketDetail:(Rocket *)rocketInfo{
    rocketDetail = rocketInfo;

    [rocketImageView sd_setImageWithURL:[NSURL URLWithString:rocketDetail.imageUrl]
                 placeholderImage:[UIImage imageNamed:@"noImage.png"]];
    
    [tableView reloadData];
}

-(void)failWithAPI{
    
}

#pragma mark - Action
-(void)goToWikiAction{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:rocketDetail.wikipedia] options:@{} completionHandler:nil];
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
