//
//  AlbumListTableViewCell.h
//  每日美语
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumListModel.h"

@interface AlbumListTableViewCell : UITableViewCell

@property (nonatomic, strong) AlbumListModel *ALModel;

+(instancetype)AlbumListTableViewCellWith:(UITableView *)tableView;

@end
