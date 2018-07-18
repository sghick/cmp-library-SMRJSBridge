//
//  UIWebView+SMRJSBridge.m
//  SMRJSBridge
//
//  Created by 丁治文 on 2018/6/13.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import "UIWebView+SMRJSBridge.h"
#import "SMRJSBridge.h"
#import <objc/runtime.h>

@interface UIWebView ()

@property (strong, nonatomic) SMRJSBridge *smr_jsbridge;

@end

@implementation UIWebView (SMRJSBridge)

#pragma mark - JSBridge
static const char SMRJSBridgeKey = '\0';
- (void)setSmr_jsbridge:(SMRJSBridge *)smr_jsbridge {
    if (smr_jsbridge != self.smr_jsbridge) {
        // 删除旧的，添加新的
        self.smr_jsbridge = smr_jsbridge;
        
        // 存储新的
        [self willChangeValueForKey:@"smr_jsbridge"]; // KVO
        objc_setAssociatedObject(self, &SMRJSBridgeKey,
                                 smr_jsbridge, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"smr_jsbridge"]; // KVO
    }
}

- (SMRJSBridge *)smr_jsbridge {
    return objc_getAssociatedObject(self, &SMRJSBridgeKey);
}

- (SMRJSBridge *)smr_get_jsbridge {
    if (self.smr_jsbridge == nil) {
        self.smr_jsbridge = [[SMRJSBridge alloc] init];
    }
    return self.smr_jsbridge;
}

#pragma mark - Public

- (void)smr_registWithScheme:(NSString *)scheme {
    self.smr_jsbridge.scheme = scheme;
}

- (void)smr_registNativeWithJSFunctionName:(NSString *)JSFunctionName completionHandler:(SMRCompletionHandlerBlock)completionHandler {
    [self.smr_jsbridge smr_registNativeWithJSFunctionName:JSFunctionName completionHandler:completionHandler];
}

- (NSString *)smr_stringByCallbackWithJSFunctionName:(NSString *)JSFunctionName, ... {
    NSString *jscode = [self.smr_jsbridge smr_stringByCallbackWithJSFunctionName:JSFunctionName, nil];
    return [self stringByEvaluatingJavaScriptFromString:jscode];
}

- (BOOL)smr_checkNeedsCallNativeWhenWebViewShouldStartLoadWithRequest:(NSURLRequest *)request {
    return [self.smr_jsbridge smr_checkNeedsCallNativeWhenWebViewShouldStartLoadWithRequest:request];
}

@end
