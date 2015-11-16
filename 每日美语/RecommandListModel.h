//
//  RecommandListModel.h
//  每日美语
//
//  Created by lanou3g on 15/10/21.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommandListModel : NSObject

@property (nonatomic, copy) NSString *title_en;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *category_cn;
@property (nonatomic, copy) NSString *title_cn;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *articleId;
@property (nonatomic, copy) NSString *orderInDay;

+(instancetype)RecommandListModelWithDict:(NSDictionary *)dict;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
