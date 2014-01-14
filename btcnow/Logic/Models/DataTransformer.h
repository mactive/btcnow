//
//  DataTransformer.h
//  btcnow
//
//  Created by Mactive on 1/7/14.
//  Copyright (c) 2014 thinktube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTransformer : NSObject

// exchanger
+ (NSString *)getID:(id)jsonData;
+ (NSString *)getName:(id)jsonData;
+ (NSString *)getShortname:(id)jsonData;
+ (NSInteger)getStatusInt:(id)jsonData;
+ (NSString *)getCurrency:(id)jsonData;
+ (NSString *)getUrl:(id)jsonData;

// ticker
+ (NSDecimalNumber *)getVol:(id)jsonData;
+ (NSDecimalNumber *)getHigh:(id)jsonData;
+ (NSDecimalNumber *)getLow:(id)jsonData;
+ (NSDecimalNumber *)getSell:(id)jsonData;
+ (NSDecimalNumber *)getBuy:(id)jsonData;
+ (NSDecimalNumber *)getLast:(id)jsonData;





+ (NSString *)datetimeStrfromNSDate:(NSDate *)date;
+ (NSString *)dateStrfromNSDate:(NSDate *)date;
+ (NSDate *)dateFromNSDatetimeStr:(NSString *)dateStr;

+(NSString *)getStringObj:(id)jsonData byName:(id)name;
+(NSNumber *)getNumberObj:(id)jsonData byName:(id)name;


// comment postData and NSError
+ (NSDictionary *)makePostDict:(NSDictionary *)params;
+ (void)showErrorWithUrl:(NSString *)url data:(NSDictionary *)responseObject andBlock:(void (^)(id, NSError *))block;
+ (void)showFontAwesomeWithTitle:(NSString *)title andCheatsheet:(NSString *)Cheatsheet;


+ (NSInteger)getIntStatus:(id)jsonData;
+ (NSString *)getString:(NSString *)str byMax:(NSInteger)max;
+ (NSInteger)getCountFromString:(NSString *)source useSubString:(NSString *)subString;



@end
