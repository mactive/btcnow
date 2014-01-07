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

+ (NSString *)getStringObjFromServerJSON:(id)jsonData byName:(NSString *)name;

@end
