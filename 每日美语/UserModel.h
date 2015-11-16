//
//  UserModel.h
//  每日美语
//
//  Created by lanou3g on 15/10/28.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, strong) NSMutableArray *ArticleSave;
@property (nonatomic, strong) NSMutableArray *SentenceSave;


-(instancetype)initWithEmail:(NSString *)email
                   password:(NSString *)password
               ArticleSave:(NSMutableArray *)ArticleSave
                  SentenceSave:(NSMutableArray *)SentenceSave;

@end
