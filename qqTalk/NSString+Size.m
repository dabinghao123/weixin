//
//  NSString+Size.m
//  qqTalk
//
//  Created by binghuang on 16/4/23.
//  Copyright © 2016年 binghuang. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)


//对象方法
-(CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font{
    
    NSDictionary * attrs = @{NSFontAttributeName:font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

//类方法
+(CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font{
    
    return [text sizeOfTextWithMaxSize:maxSize font:font];
}
@end
