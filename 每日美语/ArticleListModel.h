//
//  ArticleListModel.h
//  每日美语
//
//  Created by lanou3g on 15/10/21.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleListModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *gendu;
@property (nonatomic, copy) NSString *titlepic;
@property (nonatomic, copy) NSString *evsmalltext;
@property (nonatomic, copy) NSString *style;
@property (nonatomic, copy) NSString *classname;
@property (nonatomic, copy) NSString *zhongwen;
@property (nonatomic, copy) NSString *mp3lrc;
@property (nonatomic, copy) NSString *video;
@property (nonatomic, copy) NSString *isgood;
@property (nonatomic, copy) NSString *mp3url;
@property (nonatomic, copy) NSString *bielei;
@property (nonatomic, copy) NSString *newstime;
@property (nonatomic, copy) NSString *iconr;
@property (nonatomic, copy) NSString *iconl;
@property (nonatomic, copy) NSString *tbname;


+(instancetype)ArticleListModelWithDict:(NSDictionary *)dict;

-(instancetype)initWithDict:(NSDictionary *)dict;
@end
