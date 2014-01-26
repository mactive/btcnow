//
//  DataTransformer.m
//  btcnow
//
//  Created by Mactive on 1/7/14.
//  Copyright (c) 2014 thinktube. All rights reserved.
//

#import "DataTransformer.h"
#import <HTProgressHUD/HTProgressHUD.h>
#import <HTProgressHUD/HTProgressHUDIndicatorView.h>
#import "AppDelegate.h"

#import "DDLog.h"
// Log levels: off, error, warn, info, verbose
#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_OFF;
#endif

#define DATETIME_FORMATE @"yyyy-MM-dd hh:mm:ss"
#define DATE_FORMATE @"yyyy-MM-dd"


@interface DataTransformer ()

+ (NSString *)convertNumberToStringIfNumber:(id)obj;

@end


@implementation DataTransformer

+ (NSString *)getID:(id)jsonData
{
    return [DataTransformer getStringObj:jsonData byName:@"id"];
}

+ (NSString *)getName:(id)jsonData
{
    return [DataTransformer getStringObj:jsonData byName:@"name"];
}

+ (NSString *)getShortname:(id)jsonData
{
    return [DataTransformer getStringObj:jsonData byName:@"short_name"];
}

+ (NSInteger)getStatusInt:(id)jsonData
{
    return [DataTransformer getIntegerFromServerJSON:jsonData byName:@"status"];
}
+ (NSString *)getCurrency:(id)jsonData
{
    return [DataTransformer getStringObj:jsonData byName:@"currency"];
}

+ (NSString *)getUrl:(id)jsonData
{
    return [DataTransformer getStringObj:jsonData byName:@"url"];
}


+ (NSDecimalNumber *)getVol:(id)jsonData
{
    return [DataTransformer getDecimalNumberFromServerJSON:jsonData byName:@"vol"];

}
+ (NSDecimalNumber *)getHigh:(id)jsonData
{
    return [DataTransformer getDecimalNumberFromServerJSON:jsonData byName:@"high"];

}
+ (NSDecimalNumber *)getLow:(id)jsonData
{
    return [DataTransformer getDecimalNumberFromServerJSON:jsonData byName:@"low"];

}
+ (NSDecimalNumber *)getSell:(id)jsonData
{
    return [DataTransformer getDecimalNumberFromServerJSON:jsonData byName:@"sell"];

}
+ (NSDecimalNumber *)getBuy:(id)jsonData
{
    return [DataTransformer getDecimalNumberFromServerJSON:jsonData byName:@"buy"];

}
+ (NSDecimalNumber *)getLast:(id)jsonData
{
    return [DataTransformer getDecimalNumberFromServerJSON:jsonData byName:@"last"];

}


#pragma mark - article

+ (NSString *)getArticleID:(id)jsonData
{
    return [DataTransformer getStringObj:jsonData byName:@"id"];
}

+ (NSString *)getArticleURL:(id)jsonData{
    return [DataTransformer getStringObj:jsonData byName:@"url"];
}

+ (NSString *)getArticleTitle:(id)jsonData
{
    return [DataTransformer getStringObj:jsonData byName:@"title"];
}

+ (NSString *)getArticleCover:(id)jsonData
{
    return [DataTransformer getStringObj:jsonData byName:@"cover"];
}

+ (NSString *)getArticleSummary:(id)jsonData
{
    return [DataTransformer getStringObj:jsonData byName:@"intro"];
}

+ (NSString *)getString:(NSString *)str byMax:(NSInteger)max
{
    if (str.length < max) {
        return str;
    }
    NSString *result = [str substringToIndex:str.length-(str.length-max)];
    return result;
}

+ (NSInteger)getCountFromString:(NSString *)source useSubString:(NSString *)subString
{
    NSScanner *mainScanner = [NSScanner scannerWithString:source];
    NSString *temp;
    NSInteger numberOfChar = 0;
    while(![mainScanner isAtEnd])
    {
        [mainScanner scanUpToString:subString intoString:&temp];
        if(![mainScanner isAtEnd]) {
            numberOfChar++;
            [mainScanner scanString:subString intoString:nil];
        }
    }
    //
    //    NSInteger count = [[source componentsSeparatedByString:subString] count];
    //    return count;
    return numberOfChar;
}



+ (NSDate *)getArticleDate:(id)jsonData
{
    NSString *dataString = [DataTransformer getStringObj:jsonData byName:@"time"];
    return [DataTransformer dateFromNSDateStr:dataString];
}


+ (NSString *)getArticleOrigin:(id)jsonData
{
    return [DataTransformer getStringObj:jsonData byName:@"origin"];
}


+(NSString *)getStringObj:(id)jsonData byName:(id)name
{
    id obj = [jsonData valueForKey:name];
    if (obj == nil) return @"";
    
    return [self convertNumberToStringIfNumber:obj];
}

+(NSNumber *)getNumberObj:(id)jsonData byName:(id)name
{
    id obj = [jsonData valueForKey:name];
    if (obj == nil) return [[NSNumber alloc]initWithFloat:0.0f];
    return obj;
}


+(NSInteger)getIntegerFromServerJSON:(id)jsonData byName:(id)name
{
    NSNumber * obj = [jsonData valueForKey:name];
    if (obj == nil){
        return 0;
    }else{
        return obj.integerValue;
    }
}

+ (NSDecimalNumber *)getDecimalNumberFromServerJSON:(id)jsonData byName:(id)name
{
    id obj = [jsonData valueForKey:name];
    if (obj == nil) return [NSDecimalNumber zero];
    return [NSDecimalNumber decimalNumberWithString:obj];
}


+ (NSString *)convertNumberToStringIfNumber:(id)obj
{
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [obj stringValue];
    }
    return obj;
}

+ (NSDate *)dateFromNSDatetimeStr:(NSString *)dateStr
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:DATETIME_FORMATE];
    });
    
    return [dateFormatter dateFromString:dateStr];
}
+ (NSDate *)dateFromNSDateStr:(NSString *)dateStr
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:DATE_FORMATE];
    });
    
    return [dateFormatter dateFromString:dateStr];
}


+ (NSString *)datetimeStrfromNSDate:(NSDate *)date
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:DATETIME_FORMATE];
    });
    
    if (date == nil) {
        return @"";
    } else {
        return [dateFormatter stringFromDate:date];
    }
}

+ (NSString *)dateStrfromNSDate:(NSDate *)date
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:DATE_FORMATE];
    });
    
    if (date == nil) {
        return @"";
    } else {
        return [dateFormatter stringFromDate:date];
    }
}


#pragma mark - make data

+ (NSDictionary *)makePostDict:(NSDictionary *)params
{
    NSString *token = @"1024";
    if (!StringHasValue(token)) {
        token = @"1024";
    }
    
    NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              params, @"params",
                              token, @"token",
                              nil];
    return postDict;
}

+ (void)showErrorWithUrl:(NSString *)url data:(NSDictionary *)responseObject andBlock:(void (^)(id, NSError *))block
{
    NSError *error = [[NSError alloc]initWithDomain:url
                                               code:[DataTransformer getIntStatus:responseObject]
                                           userInfo:nil];
    //    block(nil , error);
    
    HTProgressHUD *HUD = [[HTProgressHUD alloc]init];
    HUD.text = [NSString stringWithFormat:@"%@: %@",T(@"错误代码"), [DataTransformer getStatus:responseObject]];
    
    UILabel *indicator = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    indicator.backgroundColor = [UIColor clearColor];
    indicator.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    indicator.text = ICON_TIMES_CIRCLE;
    indicator.font = FONT_AWESOME_30;
    
    HUD.indicatorView = (HTProgressHUDIndicatorView *)indicator;
    [HUD showInView:XAppDelegate.window animated:YES];
    [HUD hideAfterDelay:1];
    
    DDLogError(@"%@",error);
}

+ (void)showFontAwesomeWithTitle:(NSString *)title andCheatsheet:(NSString *)Cheatsheet
{
    HTProgressHUD *HUD = [[HTProgressHUD alloc]init];
    
    UILabel *indicator = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    indicator.backgroundColor = [UIColor clearColor];
    indicator.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    indicator.text = Cheatsheet;
    indicator.font = FONT_AWESOME_30;
    
    HUD.indicatorView = (HTProgressHUDIndicatorView *)indicator;
    HUD.text = title;
    [HUD showInView:XAppDelegate.window animated:YES];
    [HUD hideAfterDelay:1];
}


#pragma mark - status

+ (NSString *)getStatus:(id)jsonData
{
    return [DataTransformer getStringObj:jsonData byName:@"status"];
}

+ (NSInteger)getIntStatus:(id)jsonData
{
    NSNumber *status = [DataTransformer getNumberObj:jsonData byName:@"status"];
    return status.integerValue;
}



@end
