//
//  ManagerSayCell.h
//  店长说Cell
//
//  Created by hb on 16/9/5.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagerSayCell : UITableViewCell

@property (strong, nonatomic) NSString *model;

@property (copy, nonatomic) void (^onItemClikcBlock)(NSIndexPath *indexPath);//cell点击
@property (copy, nonatomic) void (^onShowMoreCommentClickBlock)(id model);//查看更多点击
@property (copy, nonatomic) void (^onFavouriteClickBlock)(id model);//喜欢点击
@property (copy, nonatomic) void (^onCommentClickBlock)(id model);//评论点击
@property (copy, nonatomic) void (^onPraiseClickBlock)(id model);//赞点击

- (NSArray *)images;

@end
