//
//  LauncheDetailViewController.h
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/23.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LaunchMission.h"

NS_ASSUME_NONNULL_BEGIN

@interface LauncheDetailViewController : UIViewController{
    __weak IBOutlet UILabel *viewControllerTitleLabel;
    __weak IBOutlet UITableView *tableView;
}

@property (strong, nonatomic) LaunchMission *launchMission;

@end

NS_ASSUME_NONNULL_END
