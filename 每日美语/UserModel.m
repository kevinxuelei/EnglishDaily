//
//  UserModel.m
//  每日美语
//
//  Created by lanou3g on 15/10/28.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
-(instancetype)initWithEmail:(NSString *)email
                    password:(NSString *)password
                 ArticleSave:(NSMutableArray *)ArticleSave
                SentenceSave:(NSMutableArray *)SentenceSave{
    
    if ( self = [super init]) {
      
        self.password = password;
        self.email = email;
        self.ArticleSave = ArticleSave;
        self.SentenceSave = SentenceSave;
    }
    return self;
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder{

    
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.ArticleSave forKey:@"ArticleSave"];
    [aCoder encodeObject:self.SentenceSave forKey:@"SentenceSave"];

}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
      
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.ArticleSave = [aDecoder decodeObjectForKey:@"ArticleSave"];
        self.SentenceSave = [aDecoder decodeObjectForKey:@"SentenceSave"];
    }
    
    return self;
}


@end
