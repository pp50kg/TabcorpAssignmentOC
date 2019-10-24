//
//  MissionListViewController.h
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/23.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MissionListViewController : UIViewController{
    __weak IBOutlet UITableView *tableView;
    __weak IBOutlet UILabel *viewControllerTitleLabel;
    __weak IBOutlet UISegmentedControl *segment;
}


@end

