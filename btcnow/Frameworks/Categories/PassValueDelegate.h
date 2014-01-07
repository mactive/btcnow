//
//  PassValueDelegate.h
//  btcnow
//
//  Created by Mactive on 1/7/14.
//  Copyright (c) 2014 thinktube. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PassValueDelegate <NSObject>

@optional
-(void)passStringValue:(NSString *)value andIndex:(NSUInteger )index;
-(void)passNumberValue:(NSNumber *)value andIndex:(NSUInteger )index;
-(void)passNSDateValue:(NSDate *)value andIndex:(NSUInteger)index;

@end

