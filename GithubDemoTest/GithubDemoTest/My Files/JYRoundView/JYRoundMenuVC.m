//
//  JYRoundMenuVC.m
//  GithubDemoTest
//
//  Created by hb on 2019/8/6.
//  Copyright © 2019 com.bm.hb. All rights reserved.
//

#import "JYRoundMenuVC.h"

#import "JYRoundMenuItemView.h"
#import "JYRoundMenuView.h"

@interface JYRoundMenuVC ()<
JYRoundMenuViewDelegate
>

@property (nonatomic, strong) NSMutableArray<JYRoundMenuItemView *> *items;
@property (nonatomic, strong) JYRoundMenuView *roundMenu;

@end

@implementation JYRoundMenuVC


#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    
}

#pragma mark - IBs & Actions

#pragma mark - Setter & Getter

#pragma mark - Private Methods

- (void)setup {
    
    self.tableView.backgroundColor = [UIColor purpleColor];
    
    JYRoundMenuItemView *item1 = [[JYRoundMenuItemView alloc] initWithTitle:@"普食品" imageName:@"home_btn_Discount"];
    JYRoundMenuItemView *item2 = [[JYRoundMenuItemView alloc] initWithTitle:@"吃的" imageName:@"home_btn_Food"];
    JYRoundMenuItemView *item3 = [[JYRoundMenuItemView alloc] initWithTitle:@"玩的" imageName:@"home_btn_Fun"];
    
    self.items = @[item1, item2, item3].mutableCopy;
    
    CGSize baseSize = CGSizeMake(item1.max_item_width, item1.max_item_width);
    self.roundMenu = [JYRoundMenuView roundMenuView:self.items andSize:baseSize andPosition:CGPointMake(300, 400)];
    self.roundMenu.backgroundColor = [UIColor redColor];
    self.roundMenu.delegate = self;
    [self.tableView addSubview:self.roundMenu];
    
}

#pragma mark - Public Methods

#pragma mark - Notification Methods

#pragma mark - Datasource & Delegate

- (void)JYRoundMenu:(JYRoundMenuView *)menu onBaseMenuTaped:(UIButton *)baseBtn widthOpened:(BOOL)isOppened {
    
}
- (void)JYRoundMenu:(JYRoundMenuView *)menu onMenuItemTaped:(NSInteger)index {
    NSLog(@"%d", index);
}

@end
