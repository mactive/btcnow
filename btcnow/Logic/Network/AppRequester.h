//
//  AppRequester.h
//  btcnow
//
//  Created by Mactive on 1/2/14.
//  Copyright (c) 2014 thinktube. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

#define API_BASE            @"http://localhost:8866"
//#define API_BASE            @"http://www.ydkcar.com"


#define API_TICKER_PATH     @"/btcnow/ticker"
#define API_INFO_PATH       @"/btcnow/exchanger"
#define API_NEWS_PATH       @"/btcnow/news"
#define API_STATS_PATH      @"/btcnow/stats"

@interface AppRequester : AFHTTPRequestOperationManager

+ (AppRequester *)sharedManager;

- (void)getTickerDataWithBlock:(void (^)(id responseObject, NSError *error))block;
- (void)getStatsDataWithBlock:(void (^)(id responseObject, NSError *error))block;
- (void)getExchangerInfoWithBlock:(void (^)(id responseObject, NSError *error))block;
- (void)getNewsWithStrat:(NSInteger)start length:(NSInteger)length andBlock:(void (^)(id responseObject, NSError *error))block;


@end
