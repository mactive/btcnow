//
//  AppDefs.h
//  bitmedia
//
//  Created by meng qian on 13-12-24.
//  Copyright (c) 2013年 thinktube. All rights reserved.
//

#ifndef bitmedia_AppDefs_h
#define bitmedia_AppDefs_h


#define XAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define CODE_OK                     @"10000"
#define ERROR_TOKEN_OVERDUE         @"21315"
#define ERROR_PARAM_ERROR           @"10008"
#define ERROR_GUID_REPEAT           @"20017"
#define ERROR_NEED_LOGIN            @"20003"


#define PRODUCT_NAME T(@"PRODUCT_NAME")
#define M_APPLEID 790061023
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define TOTAL_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define API_ADDRESS @"http://api.bitjin.net"
#define APITEST_ADDRESS @"http://apitest.bitjin.net"


#define SBUTTON_TAG 10


#pragma mark - mactive

#define T(a)    NSLocalizedString((a), nil)

#define INT(a)  [NSNumber numberWithInt:(a)]
#define FLOAT(a)  [NSNumber numberWithFloat:(a)]
#define STR(a)  [NSString stringWithFormat:@"%@", (a)]
#define STR_INT(a)  [NSString stringWithFormat:@"%d", (a)]
#define STR_NUM(a)  [NSString stringWithFormat:@"%.0f", (a)]

#define NUMBER_OR_NIL(a)	\
(((a) && [(a) isKindOfClass:[NSNumber class]]) ? (a) : nil)

#define STRING_OR_NIL(a)	\
(((a) && [(a) isKindOfClass:[NSString class]]) ? (a) : nil)

#define STRING_OR_EMPTY(a)	\
(((a) && [(a) isKindOfClass:[NSString class]]) ? (a) : @"")

#define kDateFormat  @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z"

// font
#define CUSTOMFONT [UIFont fontWithName:@"Museo" size:16.0f]
#define LITTLECUSTOMFONT [UIFont fontWithName:@"Museo" size:13.0f]
#define TINYCUSTOMFONT [UIFont fontWithName:@"Museo" size:11.0f]
// font Gotham Family
#define FONT_BOLD_15 [UIFont fontWithName:@"Gotham-Bold" size:15.0f]
#define FONT_BLACK_15 [UIFont fontWithName:@"Gotham-Black" size:15.0f]
#define FONT_MEDIUM_12 [UIFont fontWithName:@"Gotham-Medium" size:12.0f]
#define FONT_MEDIUM_9 [UIFont fontWithName:@"Gotham-Medium" size:9.0f]
#define FONT_MEDIUM_40 [UIFont fontWithName:@"Gotham-Medium" size:40.0f]
#define FONT_BOOK_12 [UIFont fontWithName:@"Gotham-Book" size:12.0f]
#define FONT_BOOK_40 [UIFont fontWithName:@"Gotham-Book" size:40.0f]

#define FONT_LIGHT_15 [UIFont fontWithName:@"Gotham-Light" size:15.0f]
#define FONT_LIGHT_12 [UIFont fontWithName:@"Gotham-Light" size:12.0f]
#define FONT_AWESOME_15 [UIFont fontWithName:@"FontAwesome" size:15.0f]
#define FONT_AWESOME_24 [UIFont fontWithName:@"FontAwesome" size:24.0f]
#define FONT_AWESOME_30 [UIFont fontWithName:@"FontAwesome" size:30.0f]

// font awesome
#define ICON_GITHUB     @"\uf113"
#define ICON_WEIBO      @"\uf18a"
#define ICON_DRIBBBLE   @"\uf17d"
#define ICON_TWITTER    @"\uf099"
#define ICON_TUMBLR     @"\uf173"
#define ICON_THUMBSUP   @"\uf164"
#define ICON_COLLECT    @"\uf005"
#define ICON_COMMENTS   @"\uf086"
#define ICON_TIMES_CIRCLE @"\uf057"
#define ICON_FLAG       @"\uf024"
#define ICON_CHECK      @"\uf00c"
#define ICON_LIST       @"\uf0c9"
#define ICON_FLAG       @"\uf024"
#define ICON_SEARCH     @"\uf002"
#define ICON_DOWNLOAD   @"\uf019"
#define ICON_SETTING    @"\uf013"
#define ICON_FEEDBACK   @"\uf0e5"
#define ICON_MINE       @"\uf058"

// NSARRAY
#define IOS7_CONTENT_OFFSET_Y 64.0f
#define STATUS_BAR_HEIGHT   20.0f
#define TOP_HEIGHT          44.0f
#define TABBAR_HEIGHT       44.0f
#define SECTION_HEADER_HEIGHT 20.0f
#define SECTION_FOOTER_HEIGHT 40.0f
#define LABEL_HEIGHT        20.0f

#define BUTTON_OFFSET       10.0f
#define TOTAL_WIDTH         320.0f
#define CELL_HEIGHT         40.0f
#define CELL_HIGH_HEIGHT    110.0f
#define NAV_BAR_HEIGHT      26.0f
#define LEFT_MAX_WIDTH      240.0f
#define RIGHT_MAX_WIDTH     200.0f


// Color helpers

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

#define HSVCOLOR(h,s,v) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:1]
#define HSVACOLOR(h,s,v,a) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:(a)]

#define RGBA(r,g,b,a) (r)/255.0f, (g)/255.0f, (b)/255.0f, (a)


#define BGCOLOR [UIColor colorWithRed:222.0f/255.0 green:222.0f/255.0 blue:222.0f/255.0 alpha:1.0]
#define GREENCOLOR [UIColor colorWithRed:126.0f/255.0f green:211.0f/255.0f blue:33.0f/255.0f alpha:1]
#define REDCOLOR [UIColor colorWithRed:237.0f/255.0f green:28.0f/255.0f blue:36.0f/255.0f alpha:1]
#define GRAYCOLOR [UIColor colorWithRed:158.0f/255.0f green:158.0f/255.0f blue:158.0f/255.0f alpha:1]
#define GRAYLIGHTCOLOR [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1]
#define HANDLEBORDERCOLOR [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1].CGColor
#define HANDLEBGCOLOR [UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1]
#define DARKCOLOR [UIColor colorWithRed:42.0f/255.0f green:43.0f/255.0f blue:49.0f/255.0f alpha:1]

#define ORANGECOLOR [UIColor colorWithRed:255.0f/255.0f green:236.0f/255.0f blue:76.0f/255.0f alpha:1]
#define ORANGE_INNERSHADOW_COLOR [UIColor colorWithRed:239.0f/255.0f green:105.0f/255.0f blue:6.0f/255.0f alpha:1]
#define ORANGE_GLOW_COLOR [UIColor colorWithRed:252.0f/255.0f green:242.0f/255.0f blue:174.0f/255.0f alpha:0.4f]

#define BLUECOLOR [UIColor colorWithRed:74.0f/255.0f green:144.0f/255.0f blue:226.0f/255.0f alpha:1]

#define ORANGE_LINE_COLOR [UIColor colorWithRed:255.0f/255.0f green:198.0f/255.0f blue:0.0f/255.0f alpha:1]
#define YELLOW_DOT_COLOR  [UIColor colorWithRed:251.0f/255.0f green:203.0f/255.0f blue:58.0f/255.0f alpha:1]

#define SEPCOLOR [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1]


// ENUMs
typedef enum _MultilineTextAlign{
    //以下是枚举成员
    AlignLeft = NSTextAlignmentLeft,
    AlignCenter = NSTextAlignmentCenter,
    AlignRight = NSTextAlignmentRight
}MultilineTextAlign;


typedef enum _ExchangerStatus
{
    ExchangerStatusOpen = 1,
    ExchangerStatusBusy  = 2,
    ExchangerStatusClose = 3
} ExchangerStatus;

#define UIKeyboardNotificationsObserve() \
NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter]; \
[notificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];\
[notificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

#define NotificationsUnobserve() \
[[NSNotificationCenter defaultCenter] removeObserver:self];

#pragma mark - Core Data

#define MOCSave(managedObjectContext) { \
NSError __autoreleasing *error = nil; \
NSAssert([managedObjectContext save:&error], @"-[NSManagedObjectContext save] error:\n\n%@", error); }

#define MOCCount(managedObjectContext, fetchRequest) \
NSManagedObjectContextCount(self, _cmd, managedObjectContext, fetchRequest)

#define MOCCountAll(managedObjectContext, entityName) \
MOCCount(_managedObjectContext, [NSFetchRequest fetchRequestWithEntityName:entityName])

NS_INLINE NSUInteger NSManagedObjectContextCount(id self, SEL _cmd, NSManagedObjectContext *managedObjectContext, NSFetchRequest *fetchRequest) {
    NSError __autoreleasing *error = nil;
    NSUInteger objectsCount = [managedObjectContext countForFetchRequest:fetchRequest error:&error];
    NSAssert(objectsCount != NSNotFound, @"-[NSManagedObjectContext countForFetchRequest:error:] error:\n\n%@", error);
    return objectsCount;
}

NS_INLINE BOOL StringHasValue(NSString * str) {
    return (str != nil) && (![str isEqualToString:@""]);
}


#endif
