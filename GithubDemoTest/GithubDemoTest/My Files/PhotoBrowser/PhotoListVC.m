//
//  PhotoListVC.m
//  GithubDemoTest
//
//  Created by hb on 16/8/23.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import "PhotoListVC.h"

//lib
#import "HZPhotoGroup.h"
#import "HZPhotoItem.h"

@interface PhotoListVC ()<
UITableViewDataSource,
UITableViewDelegate
>{
    NSMutableArray *maImageURLs;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PhotoListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"图片浏览";
    
    maImageURLs = @[
                    @"http://ww2.sinaimg.cn/thumbnail/9ecab84ejw1emgd5nd6eaj20c80c8q4a.jpg",
                    @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif",
                    @"http://ww4.sinaimg.cn/thumbnail/9e9cb0c9jw1ep7nlyu8waj20c80kptae.jpg",
                    @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
                    @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                    @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                    @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg",
                    @"http://ww2.sinaimg.cn/thumbnail/677febf5gw1erma104rhyj20k03dz16y.jpg",
                    @"http://ww4.sinaimg.cn/thumbnail/677febf5gw1erma1g5xd0j20k0esa7wj.jpg"
                    ].mutableCopy;
    
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 300;
    [self.view addSubview:_tableView];
    
    WS(ws);
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(padding);
    }];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"photo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    HZPhotoGroup *photoGroup = [[HZPhotoGroup alloc] init];
    
    NSMutableArray *temp = [NSMutableArray array];
    [maImageURLs enumerateObjectsUsingBlock:^(NSString *src, NSUInteger idx, BOOL *stop) {
        HZPhotoItem *item = [[HZPhotoItem alloc] init];
        item.thumbnail_pic = src;
        [temp addObject:item];
    }];
    
    photoGroup.photoItemArray = [temp copy];
    [cell.contentView addSubview:photoGroup];
    
    return cell;
}

@end
