//
//  MessageFrame.m
//  qqTalk
//
//  Created by binghuang on 16/4/23.
//  Copyright © 2016年 binghuang. All rights reserved.
//

#import "MessageFrame.h"
#import "NSString+Size.h"

@implementation MessageFrame

- (void)setMessage:(Message *)message{
    _message = message;
    
    
    //计算每个控件的frame和行高
    //获取屏幕的宽高
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    //设置一个统一的间距
    CGFloat  margin = 5;
    //计算时间的Label
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    CGFloat timeW = screenW;
    CGFloat timeH = 15;
    
    _timeFrame  = CGRectMake(timeX,timeY,timeW,timeH);
    //计算头像的frame
    CGFloat iconImageY =  CGRectGetMaxY(_timeFrame)+margin;
    CGFloat iconImageW = 30;
    CGFloat iconImageH = 30;
    
    CGFloat iconImageX = message.type == MessageToYou?margin:(screenW - margin - iconImageW);
    _imageIconFrame = CGRectMake(iconImageX, iconImageY,iconImageW, iconImageH);
    //计算正文的frame
    CGSize  btnTextSize = [message.text sizeOfTextWithMaxSize:CGSizeMake(280, MAXFLOAT) font:textFont];
    CGFloat btnTextW = btnTextSize.width + 30;
    CGFloat btnTextH = btnTextSize.height + 30;
    //
    CGFloat btnTextY = iconImageY;
    CGFloat btnTextX = message.type == MessageToYou ? CGRectGetMaxX(_imageIconFrame):(screenW - iconImageW - margin - btnTextW);
    
    _textBtnFrame = CGRectMake(btnTextX, btnTextY,btnTextW, btnTextH);
    
    
    //计算行高
    CGFloat maxHeight = MAX(CGRectGetMaxY(_textBtnFrame), CGRectGetMaxY(_imageIconFrame));
    
    _cellHeight = maxHeight + margin;
    
   
}





@end
