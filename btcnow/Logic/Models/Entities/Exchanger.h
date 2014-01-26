//
//  Exchanger.h
//  btcnow
//
//  Created by Mactive on 1/26/14.
//  Copyright (c) 2014 thinktube. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Exchanger : NSManagedObject

@property (nonatomic, retain) NSString * currency;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * shortname;
@property (nonatomic) u_int16_t  status;
@property (nonatomic, retain) NSString * url;
@property (nonatomic) BOOL    selected;

@end
