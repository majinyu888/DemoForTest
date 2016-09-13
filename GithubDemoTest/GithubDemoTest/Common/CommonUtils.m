//
//  CommonUtils.m
//  Utils
//
//  Created by typc on 15/10/11.
//  Copyright © 2015年 tianyuanshihua. All rights reserved.
//

#import "CommonUtils.h"
#import "SDImageCache.h"

@implementation CommonUtils


+ (CGFloat)checkSystemVersion
{
    static dispatch_once_t onceToken;
    __block float systemVersion = 0;
    dispatch_once(&onceToken, ^{
        systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    return systemVersion;
}

+ (NSString *)checkAPPVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
    return appVersion;
}

/**
 *  检查对象是不是null
 *
 *  @param imgStr 被检查的对象
 *
 *  @return 是 或者 不是 null
 */
+ (BOOL)checkImageURLIsNULL:(NSString *)imgStr
{
    if (imgStr == nil || [imgStr isKindOfClass:[NSNull class]]) {
        return YES;
    } else if (![imgStr isKindOfClass:[NSString class]]){
        return YES;
    } else {
        if ([imgStr isEqualToString:@"<null>"]) {
            return YES;
        } else if ([imgStr isEqualToString:@"<NULL>"]) {
            return YES;
        } else if ([imgStr isEqualToString:@"NULL"]) {
            return YES;
        } else if ([imgStr isEqualToString:@"null"]) {
            return YES;
        } else if ([imgStr isEqualToString:@""]) {
            return YES;
        } else {
            return NO;
        }
    }
}

+ (NSString*)fuckNULL:(NSObject*)obj
{
    if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
        return @"";
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",obj];
    } else if(![obj isKindOfClass:[NSString class]]) {
        return @"";
    } else if ([obj isKindOfClass:[NSString class]]) {
        if ([(NSString *)obj isEqualToString:@"<null>"]) {
            return @"";
        } else if ([(NSString *)obj isEqualToString:@"<NULL>"]) {
            return @"";
        } else if ([(NSString *)obj isEqualToString:@"NULL"]) {
            return @"";
        } else if ([(NSString *)obj isEqualToString:@"null"]) {
            return @"";
        } else {
            return [NSString stringWithFormat:@"%@",obj];
        }
    } else {
        return @"";
    }
}

//单个文件的大小
+ (long long)fileSizeAtPath:(NSString*) filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}


//遍历文件夹获得文件夹大小，返回多少M
+ (float )folderSizeAtPath:(NSString*) folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

/**
 *  清理缓存
 *
 *  @param path 路径
 */
+ (void)clearCache:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}

/**
 *  获取Document路径
 *
 *  @return 路径
 */
+ (NSString *)pathForDoucument
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths[0];
}

/**
 *  获取Document路径
 *
 *  @return 路径
 */
+ (NSString *)pathForCaches
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return paths[0];
}

+ (NSString *)pathForTemp
{
    NSString *tmpDir =  NSTemporaryDirectory();
    return tmpDir;
}

//消息推送是否开启
+ (BOOL)isAllowedNotification
{
    //iOS8 check if user allow notification
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (UIUserNotificationTypeNone != setting.types) {
        return YES;
    }
    return NO;
}

/**
 *  根据车牌号获取管局的信息
 *
 *  @param lsnum 车牌号
 *
 *  @return 管局的字符串信息
 */
+ (NSString *)getCarorgWithLsnum:(NSString *)lsnum
{
    NSString *city;//城市
    NSString *carorg;//管局
    
    if(lsnum && lsnum.length>=1)  {
        city = [lsnum substringToIndex:1];
        if ([@"沪" isEqualToString:city]) {
            carorg = @"shanghai";
        } else if ([@"渝" isEqualToString:city]) {
            carorg = @"chongqing";
        } else if ([@"渝" isEqualToString:city]) {
            carorg = @"chongqing";
        } else if ([@"冀" isEqualToString:city]) {
            carorg = @"hebei";
        } else if ([@"晋" isEqualToString:city]) {
            carorg = @"shanxi";
        } else if ([@"辽" isEqualToString:city]) {
            carorg = @"liaoning";
        } else if ([@"吉" isEqualToString:city]) {
            carorg = @"jilin";
        } else if ([@"黑" isEqualToString:city]) {
            carorg = @"heilongjiang";
        } else if ([@"浙" isEqualToString:city]) {
            carorg = @"zhejiang";
        } else if ([@"皖" isEqualToString:city]) {
            carorg = @"anhui";
        } else if ([@"鲁" isEqualToString:city]) {
            carorg = @"shandong";
        } else if ([@"豫" isEqualToString:city]) {
            carorg = @"henan";
        } else if ([@"鄂" isEqualToString:city]) {
            carorg = @"hubei";
        } else if ([@"湘" isEqualToString:city]) {
            carorg = @"hunan";
        } else if ([@"粤" isEqualToString:city]) {
            carorg = @"guangdong";
        } else if ([@"琼" isEqualToString:city]) {
            carorg = @"hainan";
        } else if ([@"川" isEqualToString:city]) {
            carorg = @"sichuan";
        } else if ([@"贵" isEqualToString:city]) {
            carorg = @"guizhou";
        } else if ([@"云" isEqualToString:city]) {
            carorg = @"yunnan";
        } else if ([@"陕" isEqualToString:city]) {
            carorg = @"shanxi";
        } else if ([@"甘" isEqualToString:city]) {
            carorg = @"gansu";
        } else if ([@"青" isEqualToString:city]) {
            carorg = @"qinghai";
        } else if ([@"内" isEqualToString:city]) {
            carorg = @"neimenggu";
        } else if ([@"藏" isEqualToString:city]) {
            carorg = @"xizang";
        } else if ([@"宁" isEqualToString:city]) {
            carorg = @"ningxia";
        } else if ([@"新" isEqualToString:city]) {
            carorg = @"xijiang";
        }
        return carorg;
    } else {
        return @"";
    }
}

#pragma mark 匹配账户合法性(3_16位_字母数字和下划线的组合)

//验证用户输入不能为空
+ (BOOL)checkUserInput:(NSString *)input
{
    if ([input length] == 0) {
        return NO;
    }
    
    int length = (int)[input stringByReplacingOccurrencesOfString:@" " withString:@""].length;
    
    if (length==0) {
        return NO;
    }
    
    return YES;
}

//验证用户名
+ (BOOL)checkUserName:(NSString *)username
{
    if ([username length] == 0) {
        return NO;
    }
    
    NSString *regex = @"^[a-zA-Z][a-zA-Z0-9_]{3,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:username];
    
    if (!isMatch) {
        return NO;
    }
    
    return YES;
}


//验证密码
+ (BOOL)checkPassWord:(NSString *)password
{
    if ([password length] == 0) {
        return NO;
    }
    
    NSString *regex = @"^[a-zA-Z0-9_]{6,17}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:password];
    
    if (!isMatch) {
        return NO;
    }
    
    return YES;
}


//验证验证码格式
+ (BOOL)checkVerifyCode:(NSString *)code
{
    if ([code length] == 0) {
        return NO;
    }
    
    NSString *regex = @"[0-9]{6}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:code];
    
    if (!isMatch) {
        return NO;
    }
    
    return YES;
    
}

//验证QQ
+ (BOOL)checkQQ:(NSString *)qq
{
    if ([qq length] == 0) {
        return NO;
    }
    
    NSString *regex = @"[0-9]{4,15}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:qq];
    
    if (!isMatch) {
        return NO;
    }
    
    return YES;
}

//验证手机格式
+ (BOOL)checkTel:(NSString *)tel
{
    if ([tel length] == 0) {
        return NO;
    }
    
    NSString *regex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:tel];
    
    if (!isMatch) {
        return NO;
    }
    
    return YES;
}

//验证座机格式
+ (BOOL)checkTellandline:(NSString *)telland
{
    if ([telland length] == 0)
    {
        return NO;
    }
    
    NSString *regex = @"\\d{2,5}-\\d{7,8}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:telland];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
}

//验证邮箱
+ (BOOL)checkEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 *
 *
 *  @param personID 身份证号
 *
 *  @return 是否匹配
 */
+ (BOOL)checkPersonID:(NSString *)personID
{
    NSString *personIDRegex = @"^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$";
    NSPredicate *personIDTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", personIDRegex];
    return [personIDTest evaluateWithObject:personID];
}



/**
 *  将tel替换为****
 *
 *  @param tel 电话号码
 *
 *  @return 替换完的tel
 */
+ (NSString *)telForStartWithTelNum:(NSString *)tel
{
    if (tel.length<11)
    {
        return @"格式错误";
    }
    
    return [tel stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}

/**
 *  随机数
 *
 *  @param from 开始
 *  @param to   结束
 *
 *  @return 随机数
 */
+ (NSInteger)getRandomNumberFrom:(NSInteger)from to:(NSInteger)to
{
    return (long)(from + (arc4random() % (to -from + 1)));
}

/**
 *  把时间转化成字符串  YYYY - MM - DD
 *
 *  @param date 时间
 *
 *  @return 字符串时间
 */
+ (NSString *)dateStringFromDate:(NSDate *)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    return [format stringFromDate:date];
}


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
+ (NSString *)dateStringFromDate:(NSDate *)date withDataFormat:(NSString *)format
{
    if (!format) {
        return [self dateStringFromDate:date];
    } else {
        
        NSDateFormatter *ft = [[NSDateFormatter alloc] init];
        ft.dateFormat = format;
        return [ft stringFromDate:date];
    }
}







//--------------------------------UI
//隐藏tableView多余的分割线
+ (void)hiddleExtendCellForTableView:(UITableView *)tableView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

//拨打电话
+ (void)callPhone:(NSString *)phoneNumber withSuperView:(UIView *)view
{
    UIWebView *phoneWebView;
    for (UIView *subV in view.subviews){
        if ([subV isKindOfClass:[UIWebView class]]){
            phoneWebView = (UIWebView *)subV;
            break;
        }
    }
    if (!phoneWebView){
        //如果没有的话就添加一个webView
        phoneWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        [view addSubview:phoneWebView];
    }
    //否则就不用添加了,直接用已经存在的webView来加载就可以了
    NSURL *url = [NSURL URLWithString:[@"tel://" stringByAppendingString:phoneNumber]];
    [phoneWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

//统一返回按钮
+ (void)settingBackButtonImageWithImage:(UIImage *)image
{
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
}

//滑动到最后一行
+ (void)scrollToFootWithTableView:(UITableView *)tableView isAnimated:(BOOL)animated
{
    NSInteger s = [tableView numberOfSections];
    if (s<1) return;
    NSInteger r = [tableView numberOfRowsInSection:s-1];
    if (r<1) return;
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];
    
    [tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    
}


//等比缩放UIImage
+ (UIImage *)scaleImage:(UIImage *)image withScale:(float)scale
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scale, image.size.height * scale));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scale, image.size.height * scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

//图片旋转
+ (UIImage *)rotateImage:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

//计算高度
+ (CGFloat)heightForLabel:(UILabel *)label
                 WithText:(NSString *)text
                 fontName:(NSString *)fontName
                 fontSize:(CGFloat)fontSize
                    width:(CGFloat)width
{
    if (!text) {
        return 0;
    } else {
        if (!fontName) {
            //系统默认的字体
            fontName = @"Helvetica";
        }
        
        //创建字体信息
        UIFont *textFont = [UIFont fontWithName:fontName size:fontSize];
        //字体字典信息
        NSDictionary *fontDict =[NSDictionary dictionaryWithObject:textFont forKey:NSFontAttributeName];
        
        //设置label的属性
        label.numberOfLines = 0 ;
        label.lineBreakMode = NSLineBreakByCharWrapping;//以字符为显示单位显示，后面部分省略不显示。
        label.backgroundColor = [UIColor clearColor];
        label.font = textFont;
        
        
        CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                      attributes:fontDict
                                         context:nil];
        
        return rect.size.height+10;
    }
    
}

//计算高度
+ (CGFloat)heightForLabel:(UILabel *)label
                 WithText:(NSString *)text
                    width:(CGFloat)width
{
    //创建字体信息
    UIFont *textFont = label.font;
    //字体字典信息
    NSDictionary *fontDict =[NSDictionary dictionaryWithObject:textFont forKey:NSFontAttributeName];
    
    //设置label的属性
    label.numberOfLines = 0 ;
    label.lineBreakMode = NSLineBreakByCharWrapping;//以字符为显示单位显示，后面部分省略不显示。
    label.backgroundColor = [UIColor clearColor];
    label.font = textFont;
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                  attributes:fontDict
                                     context:nil];
    return rect.size.height+1;
}

//显示提示信息
+ (void)showMessage:(NSString *)message
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    //创建字体信息
    UIFont *textFont = [UIFont systemFontOfSize:17];
    //字体字典信息
    NSDictionary *fontDict =[NSDictionary dictionaryWithObject:textFont forKey:NSFontAttributeName];
    CGRect rect = [message boundingRectWithSize:CGSizeMake(280, MAXFLOAT)
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes:fontDict
                                        context:nil];
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = rect.size;
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake((screenWidth - LabelSize.width - 20)/2, screenHeight - 100, LabelSize.width+20, LabelSize.height+10);
    [UIView animateWithDuration:1.5 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}


//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController * vc =  [self getPresentedViewController];
    if (vc) {
        return vc;
    } else {
        UIViewController *result = nil;
        UIWindow * window = [[UIApplication sharedApplication] keyWindow];
        if (window.windowLevel != UIWindowLevelNormal) {
            NSArray *windows = [[UIApplication sharedApplication] windows];
            for(UIWindow * tmpWin in windows) {
                if (tmpWin.windowLevel == UIWindowLevelNormal) {
                    window = tmpWin;
                    break;
                }
            }
        }
        UIView *frontView = [[window subviews] objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
            result = nextResponder;
        else
            result = window.rootViewController;
        return result;
    }
}

+ (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}



@end
