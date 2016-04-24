//
//  NSString+Size.h
//  qqTalk
//
//  Created by binghuang on 16/4/23.
//  Copyright © 2016年 binghuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Size)
//对象方法
-(CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font;

//类方法
+(CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font;

@end
