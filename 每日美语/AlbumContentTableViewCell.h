//
//  AlbumContentTableViewCell.h
//  每日美语
//
//  Created by lanou3g on 15/10/26.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumContentsModel.h"

@interface AlbumContentTableViewCell : UITableViewCell

@property (nonatomic, strong) AlbumContentsModel *contentModel;

+(instancetype)AlbumContentTableViewCell:(UITableView *)tableView;

@end
