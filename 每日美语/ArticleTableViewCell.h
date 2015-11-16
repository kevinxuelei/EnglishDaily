//
//  ArticleTableViewCell.h
//  每日美语
//
//  Created by lanou3g on 15/10/23.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleListModel.h"

@interface ArticleTableViewCell : UITableViewCell
@property (nonatomic, strong) ArticleListModel *model;

+(instancetype)ArticleTableViewCellWith:(UITableView *)tableView;
@end
