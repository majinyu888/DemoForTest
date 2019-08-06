//
//  JYRoundMenuItemView.m
//  GithubDemoTest
//
//  Created by hb on 2019/8/6.
//  Copyright © 2019 com.bm.hb. All rights reserved.
//

#import "JYRoundMenuItemView.h"

@interface JYRoundMenuItemView()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, strong) UIImageView *iv;
@property (nonatomic, strong) UILabel *lbl;

@end

@implementation JYRoundMenuItemView


- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName {
    if (self = [super initWithFrame:CGRectZero]) {
        self.title = title;
        self.imageName = imageName;
        [self configView];
    }
    return self;
}

- (void)configView {
    if (!_max_item_width) {
        _max_item_width = 80;
    }
    if (!_max_item_height) {
        _max_item_height = 80 + 20;
    }
    if (!_iv) {
        _iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _max_item_width, _max_item_width)];
        _iv.image = [UIImage imageNamed:self.imageName];
        [self addSubview:_iv];
    }
    if (!_lbl) {
        _lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, _max_item_width, _max_item_width, _max_item_height - _max_item_width)];
        _lbl.textAlignment = NSTextAlignmentCenter;
        _lbl.font = [UIFont systemFontOfSize:14];
        _lbl.textColor = [UIColor whiteColor];
        _lbl.text = self.title;
        [self addSubview:_lbl];
    }
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 0, _max_item_width, _max_item_height);
}

@end
