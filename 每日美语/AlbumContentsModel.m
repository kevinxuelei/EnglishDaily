//
//  AlbumContentsModel.m
//  每日美语
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "AlbumContentsModel.h"

@implementation AlbumContentsModel

+(instancetype)AlbumContentsModelWithDict:(NSDictionary *)dict
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
