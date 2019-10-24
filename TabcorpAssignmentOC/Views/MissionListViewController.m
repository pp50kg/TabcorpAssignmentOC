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
    MissionListModel *listModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"LaunchCell"];
    MissionListPresenter *presenter = [MissionListPresenter new];
    [presenter setDelegate:self];
    [presenter requestMissionList];
    
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [listModel numberSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listModel numberOfMissionInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [listModel sectionTitleInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LaunchCell" forIndexPath:indexPath];

    cell.textLabel.text = [listModel titleAtIndexPath:indexPath];
    cell.detailTextLabel.text = [listModel subTitleAtIndexPath:indexPath];
    
    return cell;
}

#pragma mark - MissionListPresenterDelegate
-(void)updateList:(NSMutableArray *)missions{
    listModel = [[MissionListModel alloc] initWithMissionList:missions];
//    missionList = [NSMutableArray arrayWithArray:[listModel sortByType:SortByDate]];
        missionList = [NSMutableArray arrayWithArray:[listModel sortByType:SortByName]];
    listModel.sortList = missionList;
    [tableView reloadData];
}

-(void)failWithAPI{
    
}

@end
