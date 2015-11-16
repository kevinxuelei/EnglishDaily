//
//  UserHandle.h
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface UserHandle : NSObject

@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, strong) UserModel *userModel;

+(UserHandle *)shareUserHandle;

@end
