//
//  AppRequester.m
//  btcnow
//
//  Created by Mactive on 1/2/14.
//  Copyright (c) 2014 thinktube. All rights reserved.
//

#import "AppRequester.h"

#import "DDLog.h"

#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_OFF;
#endif
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

- (void)getNewsWithStrat:(NSInteger)start length:(NSInteger)length andBlock:(void (^)(id responseObject, NSError *error))block
{
    NSString * startString = [NSString stringWithFormat:@"%i",start];
    NSString * lengthString = [NSString stringWithFormat:@"%i",length];
    
    NSDictionary *getDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              startString, @"start",
                              lengthString, @"length",
                              nil];
    
    [[AppRequester sharedManager]GET:API_NEWS_PATH parameters:getDict success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(responseObject != nil) {
            if (block) {
                block(responseObject , nil);
            }
        }else{
            [DataTransformer showErrorWithUrl:API_BASE data:responseObject andBlock:block];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLogError(@"login error: %@",error);
        if (block) {
            block(nil , error);
        }
    }];
}


@end
