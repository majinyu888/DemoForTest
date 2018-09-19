//
//  TTTTDemoVC.m
//  GithubDemoTest
//
//  Created by hb on 2017/3/13.
//  Copyright © 2017年 com.bm.hb. All rights reserved.
//

#import "DispatchTimerVC.h"

@interface DispatchTimerVC ()
{
    dispatch_source_t timer;
    NSInteger count;
}

@property (strong, nonatomic) UILabel *lbl;

@end

@implementation DispatchTimerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.lbl = [UILabel new];
    self.lbl.textColor = [UIColor redColor];
    self.lbl.font = [UIFont systemFontOfSize:18];
    self.lbl.text = @"测试 gcd timer 01";
    [self.view addSubview:self.lbl];
    [self.lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self createTimer];
}

- (void)createTimer
{
    // 拿到一个队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 创建一个timer放到队列里面
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置timer的首次执行时间, 执行时间间隔, 精确度
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    
    __weak typeof(self) weakSelf = self;
    
    // 设置timer执行的事件
    dispatch_source_set_event_handler(timer, ^{
        // 注意
        // 如果更新UI
        // 一定要在主线程
        dispatch_async(dispatch_get_main_queue(), ^{
             [weakSelf doSomeThing];
        });
    });
    
    // 激活timer
    dispatch_resume(timer);
}


- (void)doSomeThing
{
    count ++;
    self.lbl.text = [NSString stringWithFormat:@"%ld", count];

}



@end
