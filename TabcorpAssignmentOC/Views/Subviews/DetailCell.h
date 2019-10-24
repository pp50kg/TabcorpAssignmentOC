//
//  DetailCell.h
//  TabcorpAssignmentOC
//
//  Created by YuChen Hsu on 2019/10/24.
//  Copyright © 2019 Adam Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *missionLabelOne;
@property (weak, nonatomic) IBOutlet UILabel *missionLabelTwo;
@property (weak, nonatomic) IBOutlet UILabel *missionLabelThree;
@property (weak, nonatomic) IBOutlet UILabel *missionLabelFour;
@property (weak, nonatomic) IBOutlet UILabel *rocketLabelOne;
@property (weak, nonatomic) IBOutlet UILabel *rocketLabelTwo;
@property (weak, nonatomic) IBOutlet UILabel *rocketLabelThree;
@property (weak, nonatomic) IBOutlet UILabel *rocketLabelFour;
@property (weak, nonatomic) IBOutlet UIButton *launchWikiBtn;


@end

NS_ASSUME_NONNULL_END
