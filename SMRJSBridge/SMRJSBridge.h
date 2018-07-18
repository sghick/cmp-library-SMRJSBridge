//
//  SMRJSBridge.h
//  SMRJSBridge
//
//  Created by 丁治文 on 2018/6/13.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SMRCompletionHandlerBlock)(NSURLRequest *request);

@interface SMRJSBridge : NSObject

@property (nonatomic, strong) NSString *scheme;/// default is 'smr_js_bridge'

/// JS调用Native:本质是url为 smr_js_bridge://<JSFunctionName>
- (void)smr_registNativeWithJSFunctionName:(NSString *)JSFunctionName completionHandler:(SMRCompletionHandlerBlock)completionHandler;

/// Native调用JS,如:msr_call_back_js('%@','%@','%@')
- (NSString *)smr_stringByCallbackWithJSFunctionName:(NSString *)JSFunctionName, ... NS_REQUIRES_NIL_TERMINATION;

/// 判断是否需要进行拦截
- (BOOL)smr_checkNeedsCallNativeWhenWebViewShouldStartLoadWithRequest:(NSURLRequest *)request;

@end
