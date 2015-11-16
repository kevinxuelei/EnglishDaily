//
//  ArticleContentModel.h
//  每日美语
//
//  Created by lanou3g on 15/10/24.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleContentModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *classid;
@property (nonatomic, copy) NSString *newstext;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *ftitle;
@property (nonatomic, copy) NSString *jctitle;
@property (nonatomic, copy) NSString *gendu;
@property (nonatomic, copy) NSString *mp3url;
@property (nonatomic, copy) NSString *mp3lrc;
@property (nonatomic, copy) NSString *titleurl;
@property (nonatomic, copy) NSString *zhongwen;
@property (nonatomic, copy) NSString *video;
@property (nonatomic, copy) NSString *diggtop;
@property (nonatomic, copy) NSString *classname;
@property (nonatomic, copy) NSString *fava;
@property (nonatomic, copy) NSString *digg;
@property (nonatomic, copy) NSString *countdigg;


+(instancetype)ArticleContentModelWithDict:(NSDictionary *)dict;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
