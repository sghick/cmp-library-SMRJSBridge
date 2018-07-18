//
//  SMRJSBridge.m
//  SMRJSBridge
//
//  Created by 丁治文 on 2018/6/13.
//  Copyright © 2018年 dingzhiwen. All rights reserved.
//

#import "SMRJSBridge.h"

@interface SMRJSBridge ()

@property (nonatomic, strong) NSMutableDictionary *nativeHanles;

@end

@implementation SMRJSBridge

/// JS调用Native
- (void)smr_registNativeWithJSFunctionName:(NSString *)JSFunctionName completionHandler:(SMRCompletionHandlerBlock)completionHandler {
    if (!JSFunctionName || !completionHandler) {
        return;
    }
    self.nativeHanles[JSFunctionName] = completionHandler;
}

/// Native调用JS
- (NSString *)smr_stringByCallbackWithJSFunctionName:(NSString *)JSFunctionName, ... {
    NSString *JSFunction = nil;
    NSString *paramBody = @"";
    NSString *param;
    va_list argumentList;
    if (JSFunctionName) {
        va_start(argumentList, JSFunctionName);
        while ((param = va_arg(argumentList, id))) {
            paramBody = [paramBody stringByAppendingFormat:@"'%@',", param];
        }
        va_end(argumentList);
    }
    if (JSFunctionName && paramBody.length > 0) {
        paramBody = [paramBody substringToIndex:paramBody.length - 1];
        JSFunction = [NSString stringWithFormat:@"%@(%@)", JSFunctionName, paramBody];
    }
    return JSFunction;
}

- (BOOL)smr_checkNeedsCallNativeWhenWebViewShouldStartLoadWithRequest:(NSURLRequest *)request {
    NSString *urlScheme = request.URL.scheme;
    if ([self.scheme isEqualToString:urlScheme]) {
        NSString *urlHost = request.URL.host;
        SMRCompletionHandlerBlock block = self.nativeHanles[urlHost];
        if (block) {
            block(request);
            return NO;
        }
    }
    return YES;
}

- (NSMutableDictionary *)nativeHanles {
    if (_nativeHanles == nil) {
        _nativeHanles = [NSMutableDictionary dictionary];
    }
    return _nativeHanles;
}

- (NSString *)scheme {
    if (_scheme == nil) {
        _scheme = @"smr-js-bridge";
    }
    return _scheme;
}

@end
