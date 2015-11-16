//
//  AlbumContentsModel.h
//  每日美语
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumContentsModel : NSObject
@property (nonatomic, copy) NSString *cn;
@property (nonatomic, copy) NSString *en;

+(instancetype)AlbumContentsModelWithDict:(NSDictionary *)dict;

-(instancetype)initWithDict:(NSDictionary *)dict;
@end
