//
//  NetWorkHandle.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NetWorkHandle.h"

@implementation NetWorkHandle

+(void)getDataWithUrlString:(NSString *)string
                    compare:(BackDataBlock)block{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:string]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data != nil) {
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            block(object);
        }
    }];
    
}


+(void)postDataWithUrlString:(NSString *)string
               andBodyString:(NSString *)bodyString
                     compare:(BackDataBlock)block{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:string]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data != nil) {
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            block(object);
        }
    }];
    
    
}
+(void)SynchronouspostDataWithUrlString:(NSString *)string
                          andBodyString:(NSString *)bodyString
                                compare:(BackDataBlock)block{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:string]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (data != nil) {
        
        id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        block(object);
    }
    
}

@end
