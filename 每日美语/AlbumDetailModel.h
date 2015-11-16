//
//  AlbumDetailModel.h
//  每日美语
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumDetailModel : NSObject
@property (nonatomic, copy) NSString *title_en;
@property (nonatomic, copy) NSString *hasImage;
@property (nonatomic, copy) NSString *title_cn;
@property (nonatomic, copy) NSString *diglossia;
@property (nonatomic, copy) NSString *author_cn;
@property (nonatomic, copy) NSString *author_en;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *category_cn;
@property (nonatomic, copy) NSString *category_en;
@property (nonatomic, copy) NSString *book;
@property (nonatomic, copy) NSString *synopsis;
@property (nonatomic, copy) NSString *note;


+(instancetype)AlbumDetailModelWithDict:(NSDictionary *)dict;

-(instancetype)initWithDict:(NSDictionary *)dict;
@end
