//
//  BaseHeader.h
//  GithubDemoTest
//
//  Created by hb on 16/8/19.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height


//lib
#import "Masonry.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"

//util
#import "Utils.h"

