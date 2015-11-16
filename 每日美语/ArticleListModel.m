//
//  ArticleListModel.m
//  每日美语
//
//  Created by lanou3g on 15/10/21.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "ArticleListModel.h"

@implementation ArticleListModel

+(instancetype)ArticleListModelWithDict:(NSDictionary *)dict
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
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    if (self) {
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.gendu = [aDecoder decodeObjectForKey:@"gendu"];
        self.titlepic = [aDecoder decodeObjectForKey:@"titlepic"];
        self.evsmalltext = [aDecoder decodeObjectForKey:@"evsmalltext"];
        self.style = [aDecoder decodeObjectForKey:@"style"];
        self.classname = [aDecoder decodeObjectForKey:@"classname"];
        self.zhongwen = [aDecoder decodeObjectForKey:@"zhongwen"];
        self.mp3lrc = [aDecoder decodeObjectForKey:@"mp3lrc"];
        self.video = [aDecoder decodeObjectForKey:@"video"];
        self.isgood = [aDecoder decodeObjectForKey:@"isgood"];
        self.mp3url = [aDecoder decodeObjectForKey:@"mp3url"];
        self.bielei = [aDecoder decodeObjectForKey:@"bielei"];
        self.newstime = [aDecoder decodeObjectForKey:@"newstime"];
        self.iconr = [aDecoder decodeObjectForKey:@"iconr"];
        self.iconl = [aDecoder decodeObjectForKey:@"iconl"];
        self.tbname = [aDecoder decodeObjectForKey:@"tbname"];

    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.gendu forKey:@"gendu"];
    [aCoder encodeObject:self.titlepic forKey:@"titlepic"];
    [aCoder encodeObject:self.evsmalltext forKey:@"evsmalltext"];
    [aCoder encodeObject:self.style forKey:@"style"];
    [aCoder encodeObject:self.classname forKey:@"classname"];
    [aCoder encodeObject:self.zhongwen forKey:@"zhongwen"];
    [aCoder encodeObject:self.mp3lrc forKey:@"mp3lrc"];
    [aCoder encodeObject:self.video forKey:@"video"];
    [aCoder encodeObject:self.isgood forKey:@"isgood"];
    [aCoder encodeObject:self.mp3url forKey:@"mp3url"];
    [aCoder encodeObject:self.bielei forKey:@"bielei"];
    [aCoder encodeObject:self.newstime forKey:@"newstime"];
    [aCoder encodeObject:self.iconr forKey:@"iconr"];
    [aCoder encodeObject:self.iconl forKey:@"iconl"];
    [aCoder encodeObject:self.tbname forKey:@"tbname"];
   
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
