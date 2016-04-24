//
//  MessageCellTableViewCell.h
//  qqTalk
//
//  Created by binghuang on 16/4/23.
//  Copyright © 2016年 binghuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageFrame.h"
#import "Message.h"

@interface MessageCellTableViewCell : UITableViewCell


@property (nonatomic,strong) MessageFrame * messageFrame;


+(instancetype)messageCellWithTableView:(UITableView *)table;

@end
