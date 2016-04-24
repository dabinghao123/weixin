//
//  Message.m
//  qqTalk
//
//  Created by binghuang on 16/4/23.
//  Copyright © 2016年 binghuang. All rights reserved.
//

#import "Message.h"

@implementation Message



-(instancetype)initWithDictinary:(NSDictionary *) dict
{
    
    if (self = [super init]) {
    
        [self setValuesForKeysWithDictionary:dict];
        
    }
    
    return self;
    
}


+(instancetype)messageWithDictinary:(NSDictionary *) dict{
    
    return [[self alloc ] initWithDictinary:dict];
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    if ([key isEqualToString:@"type"]) {
//        int type = [(NSNumber*)value intValue];
//    }
//    
    NSLog(@"under====%@===%@",key,value);
}

@end
