//
//  AlbumDetailHeaderView.m
//  每日美语
//
//  Created by lanou3g on 15/10/26.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "AlbumDetailHeaderView.h"

@interface AlbumDetailHeaderView ()
@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *chapterLabel;

@end

@implementation AlbumDetailHeaderView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame: frame];
    if (self) {
        [self p_setup];
    }
    return self;
}

-(void)p_setup{
    
    self.headerImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headerImage];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    
    self.chapterLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.chapterLabel];
    
}
-(void)layoutSubviews{
    
    [super layoutSubviews ];
    self.headerImage.frame = CGRectMake(10, 10, 100, 100);
    
}

@end
