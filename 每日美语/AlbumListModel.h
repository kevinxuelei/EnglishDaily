//
//  AlbumListModel.h
//  每日美语
//
//  Created by lanou3g on 15/10/21.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumListModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title_en;
@property (nonatomic, copy) NSString *chapterCount;
@property (nonatomic, copy) NSString *title_cn;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *synopsis;
@property (nonatomic, copy) NSString *author_cn;
@property (nonatomic, copy) NSString *author_en;
@property (nonatomic, copy) NSString *image;

+(instancetype)AlbumListModelWithDict:(NSDictionary *)dict;

-(instancetype)initWithDict:(NSDictionary *)dict;
@end
