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
#import "MissionCell.h"
#import "LauncheDetailViewController.h"

@interface MissionListViewController ()<MissionListPresenterDelegate>

@end

@implementation MissionListViewController{
    NSMutableArray *missionList;
    MissionListModel *listModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [tableView registerNib:[UINib nibWithNibName:@"MissionCell" bundle:nil] forCellReuseIdentifier:@"MissionCell"];
    
    [viewControllerTitleLabel setText:@"Launch List"];
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
    MissionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MissionCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = [listModel titleAtIndexPath:indexPath];
    cell.subTitleLabel.text = [listModel subTitleAtIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LauncheDetailViewController *detailViewController = [LauncheDetailViewController new];
    [detailViewController setLaunchMission:[listModel selectedMissionAtIndexPath:indexPath]];
    [self presentViewController:detailViewController animated:YES completion:nil];
}

#pragma mark - MissionListPresenterDelegate
-(void)updateList:(NSMutableArray *)missions{
    missionList = [NSMutableArray arrayWithArray:missions];
    listModel = [[MissionListModel alloc] initWithMissionList:missions];
    NSMutableArray *resultList = [NSMutableArray arrayWithArray:[listModel sortByType:SortByDate processArray:missionList]];
    listModel.resultList = resultList;
    [tableView reloadData];
}

-(void)failWithAPI{
    
}

#pragma mark - Action
- (IBAction)selectedSortAction:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    NSMutableArray *resultList;
    switch (segment.selectedSegmentIndex) {
        case 0:{//Sort By Date
        resultList = [NSMutableArray arrayWithArray:[listModel sortByType:SortByDate processArray:missionList]];
    }
            break;
        case 1:{//Sort By Name
        resultList = [NSMutableArray arrayWithArray:[listModel sortByType:SortByName processArray:missionList]];
    }
            break;
        default:
            break;
    }
    listModel.resultList = resultList;
    [tableView reloadData];
}

- (IBAction)filterAction:(id)sender {
    
    NSString *message = @"Launch Result";
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle: nil
                                                                             message: message
                                                                      preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *allAction = [UIAlertAction actionWithTitle:@"All Result"
                                                      style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        self->listModel.resultList = [self->listModel filterByType:FilterType_All];
        [self->tableView reloadData];
    }];
    
    [actionSheetController addAction:allAction];
    
    UIAlertAction *successAction = [UIAlertAction actionWithTitle:@"Success"
                                                      style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        self->listModel.resultList = [self->listModel filterByType:FilterType_Success];
        [self->tableView reloadData];
    }];
    [actionSheetController addAction:successAction];
    
    UIAlertAction *failAction = [UIAlertAction actionWithTitle:@"Fail"
                                                      style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
        self->listModel.resultList = [self->listModel filterByType:FilterType_Fail];
        [self->tableView reloadData];
    }];
    [actionSheetController addAction:failAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                      style:UIAlertActionStyleCancel
                                                    handler:nil];
    [actionSheetController addAction:cancelAction];
    
    [self presentViewController:actionSheetController animated:YES completion:nil];
}

@end
