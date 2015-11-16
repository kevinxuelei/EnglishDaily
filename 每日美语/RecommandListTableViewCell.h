//
//  RecommandListTableViewCell.h
//  每日美语
//
//  Created by lanou3g on 15/10/28.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommandListModel.h"

@interface RecommandListTableViewCell : UITableViewCell

@property (nonatomic, strong) RecommandListModel *model;
+(instancetype)RecommandListTableViewCellWith:(UITableView *)tableView;

@end
