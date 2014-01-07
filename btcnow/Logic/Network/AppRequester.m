//
//  AppRequester.m
//  btcnow
//
//  Created by Mactive on 1/2/14.
//  Copyright (c) 2014 thinktube. All rights reserved.
//

#import "AppRequester.h"

@implementation AppRequester

+ (AppRequester *)sharedManager
{
    static AppRequester *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[AppRequester alloc]
                          initWithBaseURL:[NSURL URLWithString:API_BASE]];
    });

    return _sharedManager;
}


- (void)getTickerDataWithBlock:(void (^)(id , NSError *))block
{
    
    
    [[AppRequester sharedManager]GET:API_TICKER_PATH parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        if (responseObject != nil) {
            NSLog(@"%@",responseObject);
            block(responseObject,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        block(nil, error);
    }];
}

- (void)getExchangerInfoWithBlock:(void (^)(id, NSError *))block
{
    [[AppRequester sharedManager]GET:API_INFO_PATH parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        if (responseObject != nil) {
            block(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, block);
    }];
}

@end