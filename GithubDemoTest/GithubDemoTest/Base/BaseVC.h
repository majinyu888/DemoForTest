//
//  BaseVC.h
//  GithubDemoTest
//
//  Created by hb on 16/8/23.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface BaseVC : UIViewController<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *maList;


@end
