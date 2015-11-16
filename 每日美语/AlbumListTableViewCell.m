//
//  AlbumListTableViewCell.m
//  每日美语
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "AlbumListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "HDAllUse.h"

@interface AlbumListTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UILabel *titileLabel;
@property (strong, nonatomic) IBOutlet UILabel *chapterLabel;

@end

@implementation AlbumListTableViewCell

+(instancetype)AlbumListTableViewCellWith:(UITableView *)tableView
{
    static NSString *ID = @"albumListVCCell";
    AlbumListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AlbumListTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.nightBackgroundColor = UIColorFromRGB(0x343434);
    return cell;

}

-(void)setALModel:(AlbumListModel *)ALModel{
    
    _ALModel = ALModel;

        self.titileLabel.nightTextColor = [UIColor whiteColor];
        self.chapterLabel.nightTextColor = [UIColor whiteColor];
       self.chapterLabel.textColor = [UIColor grayColor];
        self.nightBackgroundColor = UIColorFromRGB(0x343434);
    
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:ALModel.image]];
    self.titileLabel.text = ALModel.title_cn;
    [self.titileLabel sizeToFit];
    self.chapterLabel.text = [NSString stringWithFormat:@"章节:%@",ALModel.chapterCount];;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
}

-(CGFloat)cellHeight:(NSString *)stringValue{
    
    CGRect stringRect = [stringValue boundingRectWithSize:CGSizeMake(180, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil];
    
    return stringRect.size.height;
}


@end
