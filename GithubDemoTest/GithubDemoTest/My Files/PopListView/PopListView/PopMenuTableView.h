//
//  PopMenuTableView.h
//  微信弹出菜单
//
//  Created by  漠然丶情到深处 on 16/3/31.
//  Copyright © 2016年  漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopMenuTableViewDelegate <NSObject>

- (void)PopMenuTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

typedef void(^Dismiss)(void);

@interface PopMenuTableView : UIView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)id<PopMenuTableViewDelegate> delegate;
@property(nonatomic,strong)NSArray *arrData;
@property(nonatomic,strong)NSArray *arrImgName;
@property(nonatomic,copy)Dismiss dismiss;

- (instancetype)initWithDataArr:(NSArray *)dataArr origin:(CGPoint)origin width:(CGFloat)width rowHeight:(CGFloat)rowHeight;

- (void)dismissWithCompletion:(void (^)(PopMenuTableView *object))completion;

@end
