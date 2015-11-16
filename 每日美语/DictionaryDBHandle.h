//
//  DictionaryDBHandle.h
//  每日美语
//
//  Created by lanou3g on 15/10/26.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DictionaryModel.h"

@interface DictionaryDBHandle : NSObject

+(instancetype )shareDictDataBase;
-(void)openDB;
-(void)closeDB;
-(DictionaryModel *)selectFromTableWhereWord:(NSString *)word;

@end
