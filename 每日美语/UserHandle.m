//
//  UserHandle.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "UserHandle.h"

@implementation UserHandle

+(UserHandle *)shareUserHandle{
    
    static dispatch_once_t onceToken;
    static UserHandle *instance = nil;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[UserHandle alloc] init];
        }
    });
    
    return instance;
}

@end
