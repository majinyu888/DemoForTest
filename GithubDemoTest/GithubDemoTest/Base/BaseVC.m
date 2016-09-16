//
//  BaseVC.m
//  GithubDemoTest
//
//  Created by hb on 16/8/23.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [Utils randomColor];
   
}


@end
