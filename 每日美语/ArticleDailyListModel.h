//
//  ArticleDailyListModel.h
//  每日美语
//
//  Created by lanou3g on 15/10/24.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleDailyListModel : NSObject

@property (nonatomic, copy) NSString *newstime;
@property (nonatomic, copy) NSString *timeurl;

+(instancetype)ArticleDailyListModelWithDict:(NSDictionary *)dict;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
