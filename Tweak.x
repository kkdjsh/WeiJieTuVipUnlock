%hook WXResourceRequestHandlerDefaultImpl

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {

  @try {
    NSString *urlStr = [[[dataTask originalRequest] URL] absoluteString];

    if ([urlStr containsString:@"getUserInfo"] || [urlStr containsString:@"getWalletInfo"]) {
      NSLog(@"[WeiJieTuVip] 鎷︽埅: %@", urlStr);

      NSString *origStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
      if (!origStr) {
        %orig;
        return;
      }

      NSError *error = nil;
      NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];

      if (!error && json) {
        NSMutableDictionary *respData = json[@"data"];
        if (respData) {
          respData[@"perpetual"] = @(1);
          respData[@"perpetualCard"] = @(1);
          respData[@"dueDate"] = @"2099-12-31 23:59:59";
          respData[@"monthCard"] = @(1);
          respData[@"yearCard"] = @(1);
          respData[@"seasonCard"] = @(1);
          respData[@"halfYearCard"] = @(1);
          respData[@"status"] = @(1);
          respData[@"usable"] = @(1);

          NSData *modifiedData = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
          if (modifiedData) {
            NSLog(@"[WeiJieTuVip] 宸蹭慨鏀逛负姘镐箙浼氬憳");
            %orig(session, dataTask, modifiedData);
            return;
          }
        }
      }
    }
  } @catch (NSException *e) {
    NSLog(@"[WeiJieTuVip] 寮傚父: %@", e);
  }

  %orig;

  }

  %end

  %ctor {

  NSLog(@"[WeiJieTuVip] Tweak 鎻掍欢鍔犺浇鎴愬姛锛?);

  }
