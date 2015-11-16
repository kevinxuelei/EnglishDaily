//
//  AlbumContentTableViewCell.m
//  每日美语
//
//  Created by lanou3g on 15/10/26.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "AlbumContentTableViewCell.h"
#import "Colours.h"
#import "HDAllUse.h"

@interface AlbumContentTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *enLabel;
@property (strong, nonatomic) IBOutlet UILabel *cnLabel;

@end

@implementation AlbumContentTableViewCell


+(instancetype)AlbumContentTableViewCell:(UITableView *)tableView{
    
    static NSString *ID = @"ContentCell";
    
    AlbumContentTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AlbumContentTableViewCell" owner:nil options:nil] lastObject];
        
    }
    cell.nightBackgroundColor = UIColorFromRGB(0x343434);
    
    return cell;
    
}

-(void)setContentModel:(AlbumContentsModel *)contentModel{
    
    _contentModel = contentModel;
    
    self.enLabel.nightTextColor = [UIColor whiteColor];
    self.cnLabel.nightTextColor = [UIColor whiteColor];
    self.cnLabel.text = contentModel.cn;
    self.cnLabel.textColor = [UIColor carrotColor];
    [self.cnLabel sizeToFit];
    self.enLabel.text = contentModel.en;
    [self.enLabel sizeToFit];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    

}


@end
