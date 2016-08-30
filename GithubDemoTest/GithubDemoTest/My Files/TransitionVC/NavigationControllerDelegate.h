//
//  MyNavController.h
//  GithubDemoTest
//
//  Created by hb on 16/8/30.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationControllerDelegate : NSObject<UINavigationControllerDelegate>

- (void)setDeletateForNavagationVC:(UINavigationController *)nav;

@end
