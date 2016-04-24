//
//  MessageCellTableViewCell.m
//  qqTalk
//
//  Created by binghuang on 16/4/23.
//  Copyright © 2016年 binghuang. All rights reserved.
//

#import "MessageCellTableViewCell.h"



@interface MessageCellTableViewCell ()

@property(nonatomic,weak) UILabel *lblTime;

@property(nonatomic,weak) UIImageView *imageViewIcon;

@property(nonatomic,weak) UIButton *btnText;


@end


@implementation MessageCellTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         //创建子控件
        
        //显示时间的
        UILabel *lblTime = [[UILabel alloc] init];
        lblTime.font  = [UIFont systemFontOfSize:12];
        lblTime.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lblTime];
        self.lblTime  = lblTime;
        
        //显示头像的
        UIImageView * imageViewIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:imageViewIcon];
        self.imageViewIcon = imageViewIcon;
        
        //显示正文的
        UIButton * btnText = [[UIButton alloc] init];
        btnText.titleLabel.font = textFont;
        [btnText setTitleColor:[UIColor redColor
                                ] forState:UIControlStateNormal];
        btnText.titleLabel.numberOfLines  = 0;
//        btnText.titleLabel.backgroundColor = [UIColor greenColor];
        btnText.contentEdgeInsets = UIEdgeInsetsMake(-10,15, 0, 15);
        
        [self.contentView addSubview:btnText];
        
        self.btnText  = btnText;
        
    }
    return self;
}



- (void)setMessageFrame:(MessageFrame *)messageFrame{
    
    _messageFrame = messageFrame;
    
    //分别设置每个子控件的数据和frame
    Message  *message = _messageFrame.message;
    
    //设置 时间label 的数据和frame
    self.lblTime.text  = message.time;
    self.lblTime.frame = messageFrame.timeFrame;
    self.lblTime.hidden  = message.isHide;
    //设置头像
    
    NSString *iconImage = (message.type == MessageToMe)? @"DefaultProfileHead_kf":@"DefaultProfileHead_qq";
    self.imageViewIcon.image = [UIImage imageNamed:iconImage];
    self.imageViewIcon.frame = messageFrame.imageIconFrame;
    
    self.imageViewIcon.layer.borderColor = [UIColor redColor].CGColor;
    self.imageViewIcon.layer.borderWidth = 1;
    //设置消息正文
    [self.btnText setTitle:message.text forState:UIControlStateNormal];
    self.btnText.frame  = messageFrame.textBtnFrame;
    
    
    //设置正文的背景图
    NSString *iamgeNor ,*imageHighligthed;
    if (message.type == MessageToMe) {
        //自己发的消息
        iamgeNor = @"SenderAppNodeBkg_HL";
        imageHighligthed = @"SenderAppNodeBkg_HL";
    }else{
        
        iamgeNor = @"ReceiverVoiceNodeBack";
        imageHighligthed = @"ReceiverVoiceNodeBack";
    }
    
    //加载图片
    UIImage *imageNormal = [UIImage imageNamed:iamgeNor];
    UIImage *imageHighlighted = [UIImage imageNamed:imageHighligthed];
    imageNormal = [imageNormal stretchableImageWithLeftCapWidth:imageNormal.size.width*0.5 topCapHeight:imageNormal.size.height*0.5];
    
    imageHighlighted = [imageNormal stretchableImageWithLeftCapWidth:imageHighlighted.size.width*0.5 topCapHeight:imageHighlighted.size.height*0.5];
    
    [self.btnText setBackgroundImage:imageNormal forState:UIControlStateNormal];
    [self.btnText setBackgroundImage:imageHighlighted forState:UIControlStateHighlighted];
}


+(instancetype)messageCellWithTableView:(UITableView *)tableView{
    
    MessageCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MessageCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    return cell;
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
