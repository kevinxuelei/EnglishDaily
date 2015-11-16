//
//  RecommandListTableViewCell.m
//  每日美语
//
//  Created by lanou3g on 15/10/28.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "RecommandListTableViewCell.h"
#import "HDAllUse.h"

@interface RecommandListTableViewCell ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *kindLabel;

@end

@implementation RecommandListTableViewCell

+(instancetype)RecommandListTableViewCellWith:(UITableView *)tableView{
    
    static NSString *ID = @"RecommandListCell";
    RecommandListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RecommandListTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.nightBackgroundColor = UIColorFromRGB(0x343434);
    
    return cell;
    
}

-(void)setModel:(RecommandListModel *)model{
    
    _model = model;
    
    self.titleLabel.nightTextColor = [UIColor whiteColor];
    self.kindLabel.nightTextColor = [UIColor whiteColor];
    self.kindLabel.textColor = [UIColor grayColor];
    self.titleLabel.text = model.title_cn;
    self.kindLabel.text = model.category_cn;
    [self.titleLabel sizeToFit];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.kindLabel.frame = CGRectMake(self.kindLabel.frame.origin.x
                                          , CGRectGetMaxY(self.titleLabel.frame) , self.kindLabel.frame.size.width, self.kindLabel.frame.size.height);
}
@end
