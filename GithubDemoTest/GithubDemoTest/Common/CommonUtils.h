//
//  CommonUtils.h
//  Utils
//
//  Created by typc on 15/10/11.
//  Copyright © 2015年 tianyuanshihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonUtils : NSObject

#pragma mark - UI无关的方法
//*******************************************
//和UI无关的方法
//*******************************************

/**
 *	@brief	判断应用运行在什么系统版本上
 *
 *	@return	返回系统版本 ：7.0     6.0     6.1等
 */
+ (CGFloat)checkSystemVersion;

/**
 *	@brief	判断应用的版本号
 *
 *	@return	返回版本号
 */
+ (NSString *)checkAPPVersion;

/**
 *  检查对象是不是null
 *
 *  @param imgStr 被检查的对象
 *
 *  @return 是 或者 不是 null
 */
+ (BOOL)checkImageURLIsNULL:(NSString *)imgStr;

/**
 *	@brief	处理null字符串
 *
 *	@param
 */
+ (NSString*)fuckNULL:(NSObject*)obj;

#pragma mark -

/**
 *  单个文件的大小
 *
 *  @param filePath 文件路径
 *
 *  @return 大小bit
 */
+ (long long)fileSizeAtPath:(NSString*) filePath;

/**
 *  整个文件夹的大小
 *
 *  @param folderPath 文件路径
 *
 *  @return 大小M
 */
+ (float )folderSizeAtPath:(NSString*) folderPath;

/**
 *  清理缓存
 *
 *  @param path 路径
 */
+ (void)clearCache:(NSString *)path;

/**
 *  获取沙盒路径
 *
 *  @return Document路径
 */
+ (NSString *)pathForDoucument;

/**
 *  获取沙盒路径
 *
 *  @return caches路径
 */
+ (NSString *)pathForCaches;

/**
 *  获取沙盒路径
 *
 *  @return Document路径
 */
+ (NSString *)pathForTemp;


#pragma mark -

/**
 *  消息推送是否开启
 *
 *  @return 是否开启
 */
+ (BOOL)isAllowedNotification;

/**
 *  根据车牌号获取管局的信息
 *
 *  @param lsnum 车牌号
 *
 *  @return 管局的字符串信息
 */
+ (NSString *)getCarorgWithLsnum:(NSString *)lsnum;

#pragma mark -

/**
 *  检测用户名格式
 *
 *  @param str 字符串
 *
 *  @return bool
 */
+ (BOOL)checkQQ:(NSString *)qq;
//QQ
+ (BOOL)checkTel:(NSString *)tel;
//座机
+ (BOOL)checkTellandline:(NSString *)telland;
//邮箱
+ (BOOL)checkEmail:(NSString *)email;
//验证码
+ (BOOL)checkVerifyCode:(NSString *)code;
//用户名
+ (BOOL)checkUserName:(NSString *)username;
//密码
+ (BOOL)checkPassWord:(NSString *)password;
//用户输入
+ (BOOL)checkUserInput:(NSString *)input;
//身份证号
+ (BOOL)checkPersonID:(NSString *)personID;


/**
 *  将tel替换为****
 *
 *  @param tel 电话号码
 *
 *  @return 替换完的tel
 */
+ (NSString *)telForStartWithTelNum:(NSString *)tel;

/**
 *  产生一个随机数
 *
 *  @param from 开始
 *  @param to   结束
 *
 *  @return 随机数
 */
+ (NSInteger)getRandomNumberFrom:(NSInteger)from to:(NSInteger)to;


#pragma mark -

/**
 *  把时间转化成字符串  YYYY - MM - DD
 *
 *  @param date 时间
 *
 *  @return 字符串时间
 */
+ (NSString *)dateStringFromDate:(NSDate *)date;

/**
 *  @author mjy
 *
 *  @brief 把时间转化成字符串
 *
 *  @param date   时间
 *  @param format 格式
 *
 *  @return 字符串时间
 */
+ (NSString *)dateStringFromDate:(NSDate *)date withDataFormat:(NSString *)format;





#pragma mark - UI相关的方法
//*******************************************
//UI相关的工具方法
//*******************************************

/**
 *  利用webView实现拨打电话的功能
 *
 *  @param phoneNumber 电话号码
 *  @param view        父视图
 */
+ (void)callPhone:(NSString *)phoneNumber withSuperView:(UIView *)view;


/**
 *	@brief	隐藏tableivew中多余的cell
 *
 *	@param 	tableview 	承载的Tableview
 */
+ (void)hiddleExtendCellForTableView:(UITableView *)tableView;

/**
 *  设置整个应用统一的返回按钮
 *
 *  @param image 返回按钮的图片
 */
+ (void)settingBackButtonImageWithImage:(UIImage *)image;

/**
 *  指定的tableView 滑动到最后一行
 *
 *  @param tableView tableView
 *  @param animated  是否动画显示
 */
+ (void)scrollToFootWithTableView:(UITableView *)tableView isAnimated:(BOOL)animated;


/**
 *
 *  @param image     要缩放的image
 *  @param scaleSize 缩放的比例
 *
 *  @return 缩放后的图片
 */
+ (UIImage *)scaleImage:(UIImage *)image withScale:(float)scale;

/**
 *  将UIImage旋转
 *
 *  @param image       要旋转的图片
 *  @param orientation 方向
 *
 *  @return 旋转完成之后的图片
 */
+ (UIImage *)rotateImage:(UIImage *)image rotation:(UIImageOrientation)orientation;


//计算高度
+ (CGFloat)heightForLabel:(UILabel *)label
                 WithText:(NSString *)text
                    width:(CGFloat)width;

/**
 *  自动计算label的高度(宽度可以传)
 */
+ (CGFloat)heightForLabel:(UILabel *)label
                     WithText:(NSString *)text
                     fontName:(NSString *)fontName
                     fontSize:(CGFloat)fontSize
                        width:(CGFloat)width;


/**
 *  显示文字
 *
 *  @param message 要显示的文字
 */
+ (void)showMessage:(NSString *)message;



/**
 *  获取最顶端当前屏幕显示的viewcontroller
 *
 *  @return viewcontroller
 */
+ (UIViewController *)getCurrentVC;

+ (UIViewController *)getPresentedViewController;



@end
