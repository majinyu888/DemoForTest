//
//  WebViewVC.m
//  GithubDemoTest
//
//  Created by hb on 2016/10/12.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import "WebViewVC.h"

#import "NJKWebViewProgress.h"

@interface WebViewVC ()<
UIWebViewDelegate,
NJKWebViewProgressDelegate
>{
    UIWebView *_webView;
    UIProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
    UIScrollView *_scrollView;
}


@end

@implementation WebViewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
    [self.view addSubview:_scrollView];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    _webView.scrollView.scrollEnabled = NO;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    [_scrollView addSubview:_webView];
    
    _progressView = [[UIProgressView alloc] init];
    _progressView.frame = CGRectMake(0, 0, ScreenWidth, 10);
    [self.view addSubview:_progressView];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 一般获取网页高度会在这个方法里获取
    // 但这里获取的高度未必就是web页面的真实高度，因为web中图片未加载完有可能导致web界面不真实，或长或短
    // 你能可能用到下面的js方法去获取，但其实都没用
    /**
     1、document.documentElement.offsetHeight;
     2、document.body.clientHeight;
     3、document.documentElement.scrollHeight
     4、
     CGRect frame = webView.frame;
     CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
     frame.size = fittingSize;
     webView.frame = frame;
     5、getBodyHeight() // 网页用js实现好的方法
     6、CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.clientHeight"] floatValue];
     */
    // 所以必须要找到能完全确定web加载，才能确定web高度
    // 在网上找了个工具 NJKWebViewProgress
    
    
}

#pragma mark - NJKWebViewProgressDelegate

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if (progress == 0.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        _progressView.progress = 0;
        [UIView animateWithDuration:0.27 animations:^{
            _progressView.alpha = 1.0;
        }];
    }
    
    if (progress == 1.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [UIView animateWithDuration:0.27 delay:progress - _progressView.progress options:0 animations:^{
            _progressView.alpha = 0.0;
            
            // webView彻底加载完
            CGFloat height = [[_webView stringByEvaluatingJavaScriptFromString:@"document.body.clientHeight"] floatValue];
            CGRect frame = _webView.frame;
            frame.size.height = height;
            _webView.frame = frame;
            _scrollView.contentSize = CGSizeMake(ScreenWidth, frame.size.height);
            
        } completion:nil];
    }
    
    [_progressView setProgress:progress animated:NO];
}




@end
