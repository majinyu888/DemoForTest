//
//  MyVC1.m
//  GithubDemoTest
//
//  Created by hb on 16/8/30.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import "MyVC1.h"
#import "MyVC2.h"
#import "NavigationControllerDelegate.h"


@interface MyVC1 ()

@property (nonatomic, strong) NavigationControllerDelegate *navDelegate;

@end

@implementation MyVC1

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navDelegate = [[NavigationControllerDelegate alloc] init];
    [self.navDelegate setDeletateForNavagationVC:self.navigationController];
    
    UIButton *btn = [UIButton new];
    btn.backgroundColor = [UIColor purpleColor];
    [btn setTitle:@"点我跳转到VC2" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushToVC2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    WS(ws);
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.view).with.offset(10);
        make.right.mas_equalTo(ws.view).with.offset(-10);
        make.top.mas_equalTo(ws.view).with.offset(10);
        make.bottom.mas_equalTo(ws.view).with.offset(-10);

    }];
}

- (void)pushToVC2
{
    [self.navigationController pushViewController:[MyVC2 new] animated:YES];
}

@end
