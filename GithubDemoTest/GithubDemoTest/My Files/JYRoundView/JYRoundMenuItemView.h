//
//  JYRoundMenuItemView.h
//  GithubDemoTest
//
//  Created by hb on 2019/8/6.
//  Copyright © 2019 com.bm.hb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYRoundMenuItemView : UIView

@property (nonatomic, assign) CGFloat max_item_width;
@property (nonatomic, assign) CGFloat max_item_height;

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
