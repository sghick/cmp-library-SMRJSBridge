//
//  SMRWebController.m
//  SMRJSBridge
//
//  Created by 丁治文 on 2018/6/13.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import "SMRWebController.h"
#import "UIWebView+SMRJSBridge.h"

@interface SMRWebController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation SMRWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.webView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.webView];
    NSString *urlStr = @"https://www.baidu.com";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    [self.webView smr_registNativeWithJSFunctionName:@"native_share" completionHandler:^(NSURLRequest *request) {
        NSLog(@"js_call_native");
    }];
    
    NSString *a = @"a";
    NSString *b = @"b";
    NSString *c = @"c";
    NSString *d = [self.webView smr_stringByCallbackWithJSFunctionName:@"__nativeInvokeJS", a, b, c, nil];
    
    NSLog(@"%@", d);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([webView smr_checkNeedsCallNativeWhenWebViewShouldStartLoadWithRequest:request]) {
        return NO;
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_webView smr_registWithScheme:@"smr_scheme"];
        _webView.delegate = self;
    }
    return _webView;
}

@end
