//
//  AlbumDetailModel.m
//  每日美语
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "AlbumDetailModel.h"

@implementation AlbumDetailModel

+(instancetype)AlbumDetailModelWithDict:(NSDictionary *)dict
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
        self.title_en = [aDecoder decodeObjectForKey:@"title_en"];
        self.hasImage = [aDecoder decodeObjectForKey:@"hasImage"];
        self.title_cn = [aDecoder decodeObjectForKey:@"title_cn"];
        self.diglossia = [aDecoder decodeObjectForKey:@"diglossia"];
        self.author_cn = [aDecoder decodeObjectForKey:@"author_cn"];
        self.author_en = [aDecoder decodeObjectForKey:@"author_en"];
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.category_cn = [aDecoder decodeObjectForKey:@"category_cn"];
        self.category_en = [aDecoder decodeObjectForKey:@"category_en"];
        self.author_en = [aDecoder decodeObjectForKey:@"author_en"];
        self.book = [aDecoder decodeObjectForKey:@"book"];
        self.synopsis = [aDecoder decodeObjectForKey:@"synopsis"];
        self.note = [aDecoder decodeObjectForKey:@"note"];
        
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.title_en forKey:@"title_en"];
    [aCoder encodeObject:self.hasImage forKey:@"hasImage"];
    [aCoder encodeObject:self.title_cn forKey:@"title_cn"];
    [aCoder encodeObject:self.diglossia forKey:@"diglossia"];
    [aCoder encodeObject:self.author_cn forKey:@"author_cn"];
    [aCoder encodeObject:self.author_en forKey:@"author_en"];
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.category_cn forKey:@"category_cn"];
    [aCoder encodeObject:self.category_en forKey:@"category_en"];
    [aCoder encodeObject:self.book forKey:@"book"];
    [aCoder encodeObject:self.synopsis forKey:@"synopsis"];
    [aCoder encodeObject:self.note forKey:@"note"];
    
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
