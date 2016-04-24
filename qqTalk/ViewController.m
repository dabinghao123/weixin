//
//  ViewController.m
//  qqTalk
//
//  Created by binghuang on 16/4/23.
//  Copyright © 2016年 binghuang. All rights reserved.
//

#import "ViewController.h"
#import "Message.h"
#import "MessageFrame.h"
#import "MessageCellTableViewCell.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
   
    
    
}

@property (nonatomic ,strong)  NSMutableArray *  messageArray;

@property (nonatomic ,weak)   IBOutlet UITableView *tableView;

@property (nonatomic ,weak)  IBOutlet UITextField *textField;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"===%@",self.messageArray);
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.allowsSelection = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


- (void)keyboardWillChangeFrame:(NSNotification *)notiInfo{
    
    
    CGRect rectEnd = [notiInfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyboardY = rectEnd.origin.y;
    
    CGFloat transformValue = keyboardY - CGRectGetHeight(self.view.frame);
    
    self.view.transform = CGAffineTransformMakeTranslation(0, transformValue);
    
    // 让UItable的最后一行滚到最上面
    NSIndexPath *lastRowIndexpath = [NSIndexPath indexPathForRow:self.messageArray.count - 1 inSection:0];
    
    [self.tableView scrollToRowAtIndexPath:lastRowIndexpath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}






//懒加载

- (NSArray *)messageArray{
    
    if (!_messageArray) {
        NSMutableArray * dataArray = [NSMutableArray new];
        NSString *path = [[NSBundle  mainBundle] pathForResource:@"message" ofType:@"plist"];
        NSArray * array = [[NSArray alloc] initWithContentsOfFile:path];
        
        for (NSDictionary * dict in array) {
            
            Message *model = [Message messageWithDictinary:dict];
            MessageFrame * messageFrame = [[MessageFrame alloc] init];
            messageFrame.message = model;
    
            Message *lastMessage = (Message *)[[dataArray lastObject] message];
            
            if ([model.time isEqualToString:lastMessage.time]) {
                model.isHide = YES;
            }
            
            [dataArray addObject:messageFrame];

        }
        _messageArray = dataArray;
    }
    
    return _messageArray;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.messageArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 1.获取模型数据
     MessageFrame * messageFrame = self.messageArray[indexPath.row];
    // 2.创建单元格
    MessageCellTableViewCell *cell  = [MessageCellTableViewCell messageCellWithTableView:tableView];
    //3.把模型设置给单元格对象
    cell.messageFrame  = messageFrame;
    //返回单元格
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MessageFrame * messageFrame = self.messageArray[indexPath.row];
    
    return messageFrame.cellHeight;
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
    
}


-(BOOL)prefersStatusBarHidden{
    
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //我的回复
    [self sendMessage:textField.text  withType:MessageToMe];
    
    //对方的回复
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self sendMessage:@"我在忙不好意思！稍后联系我吧!" withType:MessageToYou];
    });
    
    textField.text = nil;
    return YES;
}

#pragma mark -  发送消息
- (void)sendMessage:(NSString *)msg withType:(MessageType) type{
    
    Message *model = [[Message alloc] init];
    
    NSDate *nowDate = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"今天 HH:mm";
    
    model.time = [formatter stringFromDate:nowDate];
    
    model.type  = type;
    
    model.text  = msg;
    
    //创建一个Frame模型
    MessageFrame *messageFrame = [[MessageFrame alloc] init];
    messageFrame.message = model;
    
    //根据当前的消息时间和上一条消息的时间，来设置是否需要隐藏时间Label
    MessageFrame *lastMessageFrame = [self.messageArray lastObject];
    NSString *lastTime = lastMessageFrame.message.time;
    if ([model.time isEqualToString:lastTime]) {
        model.isHide = YES;
    }
    //3.把frame模型加到集合中去
    [self.messageArray  addObject:messageFrame];
    //4.刷新UItableview的数据
    [self.tableView reloadData];
    //5.把最后一行滚动到最上面
    NSIndexPath *lastRowIndexpath = [NSIndexPath indexPathForRow:self.messageArray.count - 1 inSection:0];
    
    [self.tableView scrollToRowAtIndexPath:lastRowIndexpath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
