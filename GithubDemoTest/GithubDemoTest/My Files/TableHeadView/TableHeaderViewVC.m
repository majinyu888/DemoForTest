//
//  TableHeaderViewVC.m
//  GithubDemoTest
//
//  Created by hb on 2017/3/7.
//  Copyright © 2017年 com.bm.hb. All rights reserved.
//

#import "TableHeaderViewVC.h"
#import "UIScrollView+SpringHeadView.h"

@interface TableHeaderViewVC ()

@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) UIImageView *topImageView;

@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, assign) CGFloat originHeight;



@end

@implementation TableHeaderViewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.topImageView = [[UIImageView alloc] initWithFrame:self.header.bounds];
    self.topImageView.image = [UIImage imageNamed:@"img"];
    self.topImageView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, SpringHeadViewHeight);
    //只需要一行代码，就能实现同样效果
    [self.tableView addSpringHeadView:self.topImageView];
    
    
    
    
    
//    self.header = [[UIView alloc] init];
//    
//    self.header.bounds = CGRectMake(0, 0, self.tableview.bounds.size.width, 300);
//    self.topImageView = [[UIImageView alloc] initWithFrame:self.header.bounds];
//    self.topImageView.image = [UIImage imageNamed:@"img"];
//    [self.header addSubview:self.topImageView];
//    self.tableview.tableHeaderView = self.header;
//    
//    //在viewDidLoad方法中记录原始的y和height
//    self.originY = self.topImageView.frame.origin.y;
//    self.originHeight = self.topImageView.frame.size.height;
    
}


//#pragma mark - UIScrollViewDelegate
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat offy = scrollView.contentOffset.y;
//    
//    if (offy < 0) {
//        self.topImageView.frame = CGRectMake(self.topImageView.frame.origin.x,
//                                             offy,
//                                             self.topImageView.frame.size.width,
//                                             self.originHeight - offy);
//    } else {
//        self.topImageView.frame = CGRectMake(self.topImageView.frame.origin.x,
//                                             self.originY,
//                                             self.topImageView.frame.size.width,
//                                             self.originHeight);
//    }
//}



@end
