//
//  AppRequester.h
//  btcnow
//
//  Created by Mactive on 1/2/14.
//  Copyright (c) 2014 thinktube. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

#define API_BASE            @"http://d.bitjin.com"
#define API_TICKER_PATH     @"/ticker"

@interface AppRequester : AFHTTPRequestOperationManager

+ (AppRequester *)sharedManager;

- (void)getExchangerDataWithBlock:(void (^)(id, NSError *))block;


@end
