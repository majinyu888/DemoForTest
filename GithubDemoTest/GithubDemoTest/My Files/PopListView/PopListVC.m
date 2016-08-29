//
//  PopListVC.m
//  GithubDemoTest
//
//  Created by hb on 16/8/29.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import "PopListVC.h"

#import "PopMenuTableView.h"


@interface PopListVC ()<
PopMenuTableViewDelegate
>
@property(nonatomic,strong)PopMenuTableView *popMenuTableView;

@end

@implementation PopListVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"弹出" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightItemAction {
    __weak __typeof(self) weakSelf = self;
    if (!self.popMenuTableView) {
        self.popMenuTableView = [[PopMenuTableView alloc] initWithDataArr:@[@"附近学校", @"联赛流程", @"其他联赛", @"校内群聊", @"邀请好友"] origin:CGPointMake(0, 0) width:125 rowHeight:44];
        _popMenuTableView.delegate = self;
        _popMenuTableView.dismiss = ^() {
            weakSelf.popMenuTableView = nil;
        };
        _popMenuTableView.arrImgName = @[@"item_school.png", @"item_battle.png", @"item_list.png", @"item_chat.png", @"item_share.png"];
        [self.view addSubview:_popMenuTableView];
    }else{
        [_popMenuTableView dismissWithCompletion:^(PopMenuTableView *object) {
            weakSelf.popMenuTableView = nil;
        }];
    }
}

- (void)PopMenuTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        self.view.backgroundColor = [UIColor redColor];
    }
    if (indexPath.row == 1) {
        self.view.backgroundColor = [UIColor yellowColor];
    }
}

@end
