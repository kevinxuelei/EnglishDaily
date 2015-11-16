//
//  DictionaryDBHandle.m
//  每日美语
//
//  Created by lanou3g on 15/10/26.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "DictionaryDBHandle.h"
#import <sqlite3.h>

@implementation DictionaryDBHandle

+(instancetype )shareDictDataBase{
    
    
    
    static DictionaryDBHandle *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[DictionaryDBHandle alloc] init];
        }
    });
    
    return instance;
}
static sqlite3  *dataBase = nil;

-(void)openDB{
    
    if (dataBase != nil) {
        return;
    }
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"dict.db" ofType:nil];
    
    int result = sqlite3_open(filePath.UTF8String, &dataBase);
    
    if (result == SQLITE_OK) {
       // NSLog(@"打开成功");
    }else{
       // NSLog(@"打开失败");
    }
    
}

-(void)closeDB{
    
    int result = sqlite3_close(dataBase);
    if (result == SQLITE_OK) {
       // NSLog(@"关闭成功");
    }else{
       // NSLog(@"关闭失败");
    }
    
}

-(DictionaryModel *)selectFromTableWhereWord:(NSString *)word{
    
    
    DictionaryModel *model = [[DictionaryModel alloc] init];
    
    NSString *str = [NSString stringWithFormat:@"SELECT *FROM words WHERE word = '%@'",word];
   
    
    sqlite3_stmt *stmt = nil;
    
    
    int result = sqlite3_prepare_v2(dataBase, str.UTF8String, -1, &stmt, NULL);
    
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, word.UTF8String, -1, NULL);
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSString * word = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(stmt, 0)];
            
            NSString * means = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(stmt, 1)];
            model.word = word;
            model.means = means;
        }
        
        sqlite3_finalize(stmt);
        
        
       // NSLog(@"查找成功");
    }else{
       // NSLog(@"查找失败");
    }

    //NSLog(@"%@",model.means);
    return model;
    

}


@end
