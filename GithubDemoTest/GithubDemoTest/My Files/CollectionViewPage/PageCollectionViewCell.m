//
//  PageCollectionViewCell.m
//  GithubDemoTest
//
//  Created by hb on 16/9/20.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import "PageCollectionViewCell.h"

@implementation PageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        self.backgroundColor = [UIColor redColor];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
