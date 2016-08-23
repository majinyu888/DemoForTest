//
//  CellHeightVC.m
//  GithubDemoTest
//
//  Created by hb on 16/8/23.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import "CellHeightVC.h"
#import "CellHeightCell.h"

@interface CellHeightVC ()<
UITableViewDataSource,
UITableViewDelegate
>{
    NSMutableArray *maList;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CellHeightVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    maList = @[].mutableCopy;
    [maList addObject:@"老婆今天心情不错，聊天时问我和她相处是什么感觉????。"];
    [maList addObject:@"老婆今天心情不错，聊天时问我和她相处是什么感觉？ 我回答说跟过年放鞭炮一样。 那就是是很开心咯？ 就像过年时放的窜天猴，高兴就上天，不高兴就炸。。。 不说了，搓衣板又拿来了。。。"];
    [maList addObject:@"我：“吃点啥好呢……我想吃拉面，你吃啥？”\
     男友：“跟你一样就行。\
     我：“哦了……服务员！点餐！\
     店员：“您想要点什么？\
     我：“两碗拉面。\
     男友：“一样，两碗拉面。\
     我：…………"];
    [maList addObject:@"医生，你得救救我们啊，我们在一起三年了都没有怀孕，父母还等着抱孙子呢！\
     医生：“这我也没办法啊，这都是你们自己的问题。\
     “不行啊，医生你帮帮我们吧。\
     医生：“首先，你们得各自找个女朋友 医生：“首先，你们得各自找个女朋友 医生：“首先，你们得各自找个女朋友 医生：“首先，你们得各自找个女朋友 医生：“首先，你们得各自找个女朋友 医生：“首先，你们得各自找个女朋友 医生：“首先，你们得各自找个女朋友 医生：“首先，你们得各自找个女朋友 医生：“首先，你们得各自找个女朋友 医生：“首先，你们得各自找个女朋友 医生：“首先，你们得各自找个女朋友 医生：“首先，你们得各自找个女朋友 医生：“首先，你们得各自找个女朋友 医生：“首先，你们得各自找个女朋友 医生：“首先，你们得各自找个女朋友。\
     "];
    
    
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.estimatedRowHeight = 150;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"CellHeightCell" bundle:nil] forCellReuseIdentifier:@"CellHeightCell"];
    
    WS(ws);
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(padding);
    }];
}

#pragma mark - TableView Datasource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return maList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CellHeightCell";
    CellHeightCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CellHeightCell" owner:nil options:nil] lastObject];
    }
    NSString *text = maList[indexPath.row];
    cell.lbl.text = text;
    
    return cell;
}



@end
