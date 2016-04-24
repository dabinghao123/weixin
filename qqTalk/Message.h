//
//  Message.h
//  qqTalk
//
//  Created by binghuang on 16/4/23.
//  Copyright © 2016年 binghuang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
  MessageToMe = 0,
  MessageToYou = 1,
    
} MessageType;


@interface Message : NSObject

@property(nonatomic,strong) NSString  *text;
@property(nonatomic,strong) NSString  *time;
@property(nonatomic,assign) MessageType type;
@property(nonatomic,assign) BOOL isHide;

-(instancetype)initWithDictinary:(NSDictionary *) dict;

+(instancetype)messageWithDictinary:(NSDictionary *) dict;

@end
