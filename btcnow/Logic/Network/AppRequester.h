//
//  AppRequester.h
//  btcnow
//
//  Created by Mactive on 1/2/14.
//  Copyright (c) 2014 thinktube. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

//#define API_BASE            @"http://d.bitjin.com"
#define API_BASE            @"http://localhost:8866"
#define API_TICKER_PATH     @"/ticker"
#define API_INFO_PATH       @"/exchanger"

@interface AppRequester : AFHTTPRequestOperationManager

+ (AppRequester *)sharedManager;

- (void)getTickerDataWithBlock:(void (^)(id responseObject, NSError *error))block;
- (void)getExchangerInfoWithBlock:(void (^)(id responseObject, NSError *error))block;


@end
