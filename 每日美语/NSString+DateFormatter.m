//
//  NSString+DateFormatter.m
//  每日美语
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "NSString+DateFormatter.h"

@implementation NSString (DateFormatter)

+(NSString *)dataWithString:(NSString *)string{
    
  
    
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyyMMdd"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *strYMD = [outputFormatter stringFromDate:inputDate];
    
    
        NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
       NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
        
        [calendar setTimeZone: timeZone];
        
        NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
        NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    
    NSString *data = [NSString stringWithFormat:@" %@",[weekdays objectAtIndex:theComponents.weekday]];
    
    NSString *backData = [[strYMD stringByAppendingString:data] substringFromIndex:5];
    
        return backData;
    
}

@end
