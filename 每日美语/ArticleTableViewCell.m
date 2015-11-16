//
//  ArticleTableViewCell.m
//  每日美语
//
//  Created by lanou3g on 15/10/23.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "HDAllUse.h"


@interface ArticleTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *MP3Btn;


@property (strong, nonatomic) IBOutlet UIButton *video;


@end

@implementation ArticleTableViewCell

+(instancetype)ArticleTableViewCellWith:(UITableView *)tableView{
    
    static NSString *ID = @"articleListCell";
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ArticleTableViewCell" owner:nil options:nil] lastObject];
        
    }
    cell.nightBackgroundColor = UIColorFromRGB(0x343434);
    
    return cell;

}

-(void)setModel:(ArticleListModel *)model{
    
    _model = model;
    
    
     self.titleLabel.nightTextColor = [UIColor whiteColor];
     self.subTitleLabel.nightTextColor = [UIColor whiteColor];
    self.subTitleLabel.textColor = [UIColor grayColor];
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.classname;
    
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.titlepic]];
    
    if ([model.mp3url isEqualToString:@""]) {
        self.MP3Btn.hidden = YES;
    }
    if (![model.video isEqualToString:@""]) {
        self.video.hidden = NO;
    }
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
}



@end
