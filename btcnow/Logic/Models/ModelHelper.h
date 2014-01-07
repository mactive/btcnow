//
//  ModelHelper.h
//  btcnow
//
//  Created by Mactive on 1/7/14.
//  Copyright (c) 2014 thinktube. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Exchanger.h"
#import "Ticker.h"

@interface ModelHelper : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

+ (ModelHelper *)sharedHelper;

- (Exchanger *)findExchangerWithID:(NSString *)exchangerID;
- (Exchanger *)findExchangerWithShortname:(NSString *)shortname;

- (void)populateExchanger:(Exchanger *)exchanger withJSONData:(id)json;
- (void)saveAllExchangers:(NSArray *)dataArray;

- (void)populateTicker:(Ticker *)ticker withJSONData:(id)json;
- (void)saveAllTickers:(NSArray *)dataArray;



- (void)clearAllObjects;

@end
