//
//  CWebViewController.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/8/10.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "CWebViewController.h"

@interface CWebViewController () <UIWebViewDelegate> {

    NSString *webTitle;
    NSString *webUrl;

}

@end

@implementation CWebViewController

- (instancetype)initWithTitle:(NSString *)title URL:(NSString *)url {

    if ([super init]) {
        webTitle = title;
        webUrl = url;
    }
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    title.text = webTitle;
    title.font = [UIFont boldSystemFontOfSize:19];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    webView.scalesPageToFit = YES;//允许缩放
    [self.view addSubview:webView];
    
    //加载网络url
    NSURL *url = [[NSURL alloc] initWithString:webUrl];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    //添加WebView的代理
    webView.delegate = self;

    


}




#pragma mark - webview代理方法
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"开始加载页面");
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"页面加载完毕");
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"页面加载失败");
    
}




































@end
