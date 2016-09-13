//
//  CellHeightVC2.m
//  GithubDemoTest
//
//  Created by hb on 16/9/6.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import "CellHeightVC2.h"
#import "ManagerSayCell.h"

//lib
#import "HZPhotoGroup.h"
#import "HZPhotoItem.h"

@interface CellHeightVC2 ()<
UITableViewDataSource,
UITableViewDelegate
>{
    NSMutableArray *maComments;
}

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation CellHeightVC2

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.estimatedRowHeight = 500;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:@"ManagerSayCell" bundle:nil] forCellReuseIdentifier:@"ManagerSayCell"];
    
    [self.view addSubview:self.tableView];
    
    
    WS(ws);
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(padding);
    }];
    
    maComments = [NSMutableArray array];
    [maComments addObject:@"这是一个测试信息"];
    [maComments addObject:@"这是一个测试信息,这是一个测试信息,这是一个测试信息,这是一个测试信息,这是一个测试信息,这是一个测试信息,这是一个测试信息,这是一个测试信息,这是一个测试信息,这是一个测试信息."];
    [maComments addObject:@"这特么的到底是啥玩意."];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return maComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer = @"ManagerSayCell";
    ManagerSayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ManagerSayCell" owner:nil options:nil] lastObject];
    }
    cell.model = maComments[indexPath.row];
    NSArray *images = [cell images];
    cell.onItemClikcBlock = ^(NSIndexPath *indexP){
        HZPhotoGroup *photoGroup = [[HZPhotoGroup alloc] init];
        NSMutableArray *temp = [NSMutableArray array];
        [images enumerateObjectsUsingBlock:^(NSString *src, NSUInteger idx, BOOL *stop) {
            HZPhotoItem *item = [[HZPhotoItem alloc] init];
            item.thumbnail_pic = src;
            [temp addObject:item];
        }];
        
        photoGroup.photoItemArray = [temp copy];
    };
    return cell;
}


@end
