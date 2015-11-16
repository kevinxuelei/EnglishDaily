//
//  ArticleDailyListModel.m
//  每日美语
//
//  Created by lanou3g on 15/10/24.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "ArticleDailyListModel.h"

@implementation ArticleDailyListModel
+(instancetype)ArticleDailyListModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
