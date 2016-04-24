//
//  MessageFrame.h
//  qqTalk
//
//  Created by binghuang on 16/4/23.
//  Copyright © 2016年 binghuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "Message.h"

#define textFont  [UIFont systemFontOfSize:13]

@interface MessageFrame : NSObject

@property (nonatomic,strong) Message *message;

@property (nonatomic,assign,readonly) CGRect  timeFrame;

@property (nonatomic,assign,readonly) CGRect  imageIconFrame;

@property (nonatomic,assign,readonly) CGRect   textBtnFrame;

@property  (nonatomic,assign,readonly) CGFloat  cellHeight;


@end
