//
//  DataTransformer.m
//  btcnow
//
//  Created by Mactive on 1/7/14.
//  Copyright (c) 2014 thinktube. All rights reserved.
//

#import "DataTransformer.h"

#define DATETIME_FORMATE @"yyyy-MM-dd hh:mm:ss"
#define DATE_FORMATE @"yyyy-MM-dd"


@interface DataTransformer ()

+ (NSString *)convertNumberToStringIfNumber:(id)obj;

@end


@implementation DataTransformer


+ (NSString *)getID:(id)jsonData
{
    return [DataTransformer getStringObjFromServerJSON:jsonData byName:@"id"];
}

+ (NSString *)getName:(id)jsonData
{
    return [DataTransformer getStringObjFromServerJSON:jsonData byName:@"name"];
}

+ (NSString *)getShortname:(id)jsonData
{
    return [DataTransformer getStringObjFromServerJSON:jsonData byName:@"short_name"];
}

+ (NSInteger)getStatusInt:(id)jsonData
{
    return [DataTransformer getIntegerFromServerJSON:jsonData byName:@"status"];
}
+ (NSString *)getCurrency:(id)jsonData
{
    return [DataTransformer getStringObjFromServerJSON:jsonData byName:@"currency"];
}

+ (NSString *)getUrl:(id)jsonData
{
    return [DataTransformer getStringObjFromServerJSON:jsonData byName:@"url"];
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



+(NSString *)getStringObjFromServerJSON:(id)jsonData byName:(id)name
{
    id obj = [jsonData valueForKey:name];
    if (obj == nil) return @"";
    
    return [self convertNumberToStringIfNumber:obj];
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


@end
