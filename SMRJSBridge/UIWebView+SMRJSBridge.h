//
//  UIWebView+SMRJSBridge.h
//  SMRJSBridge
//
//  Created by 丁治文 on 2018/6/13.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SMRCompletionHandlerBlock)(NSURLRequest *request);

@interface UIWebView (SMRJSBridge)

/// 可以初始化一个scheme
- (void)smr_registWithScheme:(NSString *)scheme;

/// JS调用Native:本质是url为 smr_js_bridge://<JSFunctionName>
- (void)smr_registNativeWithJSFunctionName:(NSString *)JSFunctionName completionHandler:(SMRCompletionHandlerBlock)completionHandler;

/// Native调用JS,如:msr_call_back_js('%@','%@','%@')
- (NSString *)smr_stringByCallbackWithJSFunctionName:(NSString *)JSFunctionName, ...;

/// 需要在web的代理方法中调用此方法
- (BOOL)smr_checkNeedsCallNativeWhenWebViewShouldStartLoadWithRequest:(NSURLRequest *)request;

@end
