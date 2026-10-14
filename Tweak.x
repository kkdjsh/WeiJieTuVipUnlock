// WeiJieTuVipUnlock Tweak
// 为截图 v2.4.7 永久会员解锁
// Hook WXResourceRequestHandlerDefaultImpl 拦截 getUserInfo / getWalletInfo 响应

#import <Foundation/Foundation.h>

%hook WXResourceRequestHandlerDefaultImpl

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    @try {
        NSString *urlStr = [[[dataTask originalRequest] URL] absoluteString];
        
        if ([urlStr containsString:@"getUserInfo"] || [urlStr containsString:@"getWalletInfo"]) {
            NSLog(@"[WeiJieTuVip] 拦截: %@", urlStr);
            
            NSString *origStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (!origStr) {
                %orig;
                return;
            }
            
            NSLog(@"[WeiJieTuVip] 原始响应: %@", origStr);
            
            // 解析JSON
            NSError *error = nil;
            NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            if (!error && json) {
                NSMutableDictionary *respData = json[@"data"];
                if (respData) {
                    // 永久会员字段
                    respData[@"perpetual"] = @(1);
                    respData[@"perpetualCard"] = @(1);
                    respData[@"dueDate"] = @"2099-12-31 23:59:59";
                    respData[@"monthCard"] = @(1);
                    respData[@"yearCard"] = @(1);
                    respData[@"seasonCard"] = @(1);
                    respData[@"halfYearCard"] = @(1);
                    respData[@"status"] = @(1);
                    respData[@"usable"] = @(1);
                    
                    // 重新序列化
                    NSData *modifiedData = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
                    if (modifiedData) {
                        NSLog(@"[WeiJieTuVip] 已修改为永久会员");
                        %orig(session, dataTask, modifiedData);
                        return;
                    }
                }
            }
        }
    } @catch (NSException *e) {
        NSLog(@"[WeiJieTuVip] 异常: %@", e);
    }
    
    %orig;
}

%end
