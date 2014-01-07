//
//  Ticker.h
//  btcnow
//
//  Created by Mactive on 1/7/14.
//  Copyright (c) 2014 thinktube. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Ticker : NSManagedObject

@property (nonatomic, retain) NSString * shortname;
@property (nonatomic, retain) NSDecimalNumber * vol;
@property (nonatomic, retain) NSDecimalNumber * high;
@property (nonatomic, retain) NSDecimalNumber * sell;
@property (nonatomic, retain) NSDecimalNumber * low;
@property (nonatomic, retain) NSDecimalNumber * last;
@property (nonatomic, retain) NSDecimalNumber * buy;
@property (nonatomic, retain) NSString * id;

@end
