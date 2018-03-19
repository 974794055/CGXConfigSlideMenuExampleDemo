//
//  CGXScrollMenuChannerModel.m
//  CGXMenu
//
//  Created by 曹贵鑫 on 2017/6/23.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import "CGXSlideChannelModel.h"

@implementation CGXSlideChannelModel

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.title = [aDecoder decodeObjectForKey:@"title"];

    self.tag = [aDecoder decodeIntegerForKey:@"tag"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeInteger:self.tag forKey:@"tag"];
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
