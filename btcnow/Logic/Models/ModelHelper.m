//
//  ModelHelper.m
//  btcnow
//
//  Created by Mactive on 1/7/14.
//  Copyright (c) 2014 thinktube. All rights reserved.
//

#import "ModelHelper.h"
#import "DDLog.h"
// Log levels: off, error, warn, info, verbose
#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_ERROR;
#endif

@implementation ModelHelper

@synthesize managedObjectContext;

+ (ModelHelper *)sharedHelper{
    static ModelHelper *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ModelHelper alloc] init];
    });
    
    return _sharedClient;
}



- (Exchanger *)findExchangerWithID:(NSString *)exchangerID
{
    NSManagedObjectContext *moc = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Exchanger" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set example predicate and sort orderings...
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"(id = %@)", exchangerID];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    if ([array count] == 0)
    {
        DDLogVerbose(@"User doesn't exist: %@", error);
        return nil;
    } else {
        if ([array count] > 1) {
            DDLogError(@"More than one object with same id: %@", exchangerID);
        }
        return [array objectAtIndex:0];
    }
}

- (Exchanger *)findExchangerWithShortname:(NSString *)shortname
{
    NSManagedObjectContext *moc = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Exchanger" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set example predicate and sort orderings...
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"(shortname = %@)", shortname];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    if ([array count] == 0)
    {
        DDLogVerbose(@"User doesn't exist: %@", error);
        return nil;
    } else {
        if ([array count] > 1) {
            DDLogError(@"More than one object with same id: %@", shortname);
        }
        return [array objectAtIndex:0];
    }

}


- (void)populateExchanger:(Exchanger *)exchanger withJSONData:(id)json
{
    exchanger.id = [DataTransformer getID:json];
    exchanger.name = [DataTransformer getName:json];
    exchanger.shortname = [DataTransformer getShortname:json];
    exchanger.url = [DataTransformer getUrl:json];
    exchanger.currency = [DataTransformer getCurrency:json];
    exchanger.status = [DataTransformer getStatusInt:json];
}


- (void)saveAllExchangers:(NSArray *)dataArray
{
    if ([dataArray count] > 0) {
        [dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            Exchanger *theExchanger = [NSEntityDescription insertNewObjectForEntityForName:@"Exchanger"
                                                                    inManagedObjectContext:self.managedObjectContext];
            
            [[ModelHelper sharedHelper]populateExchanger:theExchanger withJSONData:obj];
            
        }];
        
        MOCSave(self.managedObjectContext);
        
    }else{
        DDLogError(@"exchanger json is empty");
    }
}

- (void)populateTicker:(Ticker *)ticker withJSONData:(id)json
{
    ticker.high = [DataTransformer getHigh:json];
    ticker.low = [DataTransformer getLow:json];
    ticker.sell = [DataTransformer getSell:json];
    ticker.buy = [DataTransformer getBuy:json];
    ticker.vol = [DataTransformer getVol:json];
    ticker.last = [DataTransformer getLast:json];

}

- (void)saveAllTickers:(NSArray *)dataArray
{
    if ([dataArray count] > 0) {
        [dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            Ticker *theTicker = [NSEntityDescription insertNewObjectForEntityForName:@"Ticker"
                                                                    inManagedObjectContext:self.managedObjectContext];
            [[ModelHelper sharedHelper]populateTicker:theTicker withJSONData:obj];
            
        }];
        
        MOCSave(self.managedObjectContext);
        
    }else{
        DDLogError(@"exchanger json is empty");
    }
}
@end
