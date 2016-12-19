//
//  PhotoListVC2.m
//  GithubDemoTest
//
//  Created by hb on 2016/12/16.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import "PhotoListVC2.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PBViewController.h"

@interface PhotoListVC2 ()<
PBViewControllerDataSource,
PBViewControllerDelegate
>

@property (nonatomic, strong) UIBarButtonItem *itemShow;
@property (nonatomic, strong) NSMutableArray *imageURLs;
@property (nonatomic, assign) BOOL thumb;

@end

@implementation PhotoListVC2


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.itemShow = [[UIBarButtonItem alloc] initWithTitle:@"显示" style: UIBarButtonItemStylePlain target:self action:@selector(_showPhotoBrowser)];
    self.navigationItem.rightBarButtonItem = self.itemShow;
    self.thumb = YES;
    self.imageURLs = [@[
                        @"http://img3.yxlady.com/yl/UploadFiles_5361/20150726/20150726123338633.jpg",
                        @"http://img3.doubanio.com/view/group_topic/large/public/p42077906.jpg",
                        @"http://www.ijiangyin.com/data/attachment/forum/201511/22/152838oydd6s76kttybyzk.jpg",
                        @"http://mm.xmeise.com/uploads/allimg/150904/1-150Z4101936.jpg",
                        @"http://a.hiphotos.baidu.com/image/pic/item/4610b912c8fcc3ceab079c399045d688d53f20f0.jpg",
                        @"http://a.hiphotos.baidu.com/image/pic/item/4610b912c8fcc3ceab079c399045d688d53f20f0.jpg",
                        @"http://a.hiphotos.baidu.com/image/pic/item/4610b912c8fcc3ceab079c399045d688d53f20f0.jpg",
                        @"http://a.hiphotos.baidu.com/image/pic/item/4610b912c8fcc3ceab079c399045d688d53f20f0.jpg",
                        @"http://a.hiphotos.baidu.com/image/pic/item/4610b912c8fcc3ceab079c399045d688d53f20f0.jpg",
                        ] mutableCopy];
    
    UIBarButtonItem *clear = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(_clear)];
    UIBarButtonItem *thumb = [[UIBarButtonItem alloc] initWithTitle:@"Don't Use Thumb" style:UIBarButtonItemStylePlain target:self action:@selector(_thumb:)];
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - 44 - 64, CGRectGetWidth(self.view.bounds), 44);
    [toolbar setItems:@[clear, thumb] animated:NO];
    [self.view addSubview:toolbar];
}

- (void)_showPhotoBrowser
{
    PBViewController *pbViewController = [PBViewController new];
    pbViewController.pb_dataSource = self;
    pbViewController.pb_delegate = self;
    pbViewController.pb_startPage = 0;
    [self presentViewController:pbViewController animated:YES completion:nil];
}


- (void)_clear {
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        NSLog(@"Cache clear complete.");
    }];
}

- (void)_thumb:(UIBarButtonItem *)sender {
    self.thumb = !self.thumb;
    sender.title = !self.thumb ? @"Use Thumb" : @"Don't Use Thumb";
}

#pragma mark - PBViewControllerDataSource

- (NSInteger)numberOfPagesInViewController:(PBViewController *)viewController {
    return self.imageURLs.count;
}

- (void)viewController:(PBViewController *)viewController
      presentImageView:(UIImageView *)imageView
        forPageAtIndex:(NSInteger)index
       progressHandler:(void (^)(NSInteger, NSInteger))progressHandler {
    
    NSString *url = self.imageURLs[index];
    UIImage *placeholder = [UIImage imageNamed:@"img"];
    [imageView sd_setImageWithURL:[NSURL URLWithString:url]
                 placeholderImage:placeholder
                          options:0
                         progress:progressHandler
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        }];
}

- (UIView *)thumbViewForPageAtIndex:(NSInteger)index {
    return nil;
}

#pragma mark - PBViewControllerDelegate

- (void)viewController:(PBViewController *)viewController didSingleTapedPageAtIndex:(NSInteger)index presentedImage:(UIImage *)presentedImage {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewController:(PBViewController *)viewController didLongPressedPageAtIndex:(NSInteger)index presentedImage:(UIImage *)presentedImage {
    NSLog(@"didLongPressedPageAtIndex: %@", @(index));
}


@end
