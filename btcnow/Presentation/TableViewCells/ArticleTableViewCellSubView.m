//
//  ArticleTableViewCellSubView.m
//  bitmedia
//
//  Created by meng qian on 14-1-16.
//  Copyright (c) 2014年 thinktube. All rights reserved.
//

#import "ArticleTableViewCellSubView.h"
#import "UIImageView+AFNetworking.h"

@interface ArticleTableViewCellSubView()

@property(nonatomic, strong)UIImageView *coverImage;
@property(nonatomic, strong)NSDictionary *data;

@end

@implementation ArticleTableViewCellSubView
@synthesize data;
@synthesize coverImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.coverImage = nil;
    }
    return self;
}

#define AVA_W       75.0f
#define AVA_H       50.0f
#define AVA_X       5.0f
#define AVA_Y       5.0f

#define MIDDLE_COLUMN_OFFSET 20.0
#define MIDDLE_COLUMN_WIDTH 300.0

#define SUMMARY_PADDING     10.0
#define SUMMARY_WIDTH       300.0
#define ORIGIN_W            85.0

#define MAIN_FONT_SIZE      14.0
#define SUMMARY_FONT_SIZE   12.0

- (void)setNewData:(NSDictionary *)_data
{
    self.data = _data;
    
    self.coverImage = [[UIImageView alloc]initWithFrame:CGRectMake(AVA_X, AVA_Y, AVA_W, AVA_H)];
//    [self addSubview:self.coverImage];
    
    [self.coverImage setImageWithURL:[NSURL URLWithString:[DataTransformer getArticleCover:self.data]]
                    placeholderImage:[UIImage imageNamed:@"avatar_l.png"]];
    
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // title
    UIColor *nameMagentaColor = RGBCOLOR(107, 107, 107);
    [nameMagentaColor set];
    UIFont *nameFont = [UIFont boldSystemFontOfSize:MAIN_FONT_SIZE];
    CGRect nameRect = CGRectMake(MIDDLE_COLUMN_OFFSET, (CELL_HEIGHT - AVA_H)/2.0+2, MIDDLE_COLUMN_WIDTH, LABEL_HEIGHT);
    CGRect genderRect;
    CGRect friendRect;
    NSString *nameString = [DataTransformer getArticleTitle:self.data];
    
    if ([nameString length] != 0) {
        CGSize nameMaxSize = CGSizeMake(MIDDLE_COLUMN_WIDTH, LABEL_HEIGHT);
        CGSize nameSize = [[DataTransformer getArticleTitle:self.data] sizeWithFont:nameFont constrainedToSize:nameMaxSize lineBreakMode:NSLineBreakByTruncatingTail];
        nameRect = CGRectMake(MIDDLE_COLUMN_OFFSET, 7, nameSize.width + SUMMARY_PADDING, nameSize.height);
        genderRect = CGRectMake(MIDDLE_COLUMN_OFFSET + nameSize.width +10, 10.5, 15, 15);
        friendRect = CGRectMake(MIDDLE_COLUMN_OFFSET + nameSize.width +30, 10.5, 30, 15);
        [nameString drawInRect:nameRect withFont:nameFont];
    }
    
    
    UIFont *smallFont = [UIFont systemFontOfSize:SUMMARY_FONT_SIZE];
    UIFont *smallBoldFont = [UIFont boldSystemFontOfSize:SUMMARY_FONT_SIZE];
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    // summary
    NSString * signatureString = [DataTransformer getArticleSummary:self.data];
    signatureString = [DataTransformer getString:signatureString byMax:60];
    UIColor *signatureMagentaColor = GRAYCOLOR;
    [signatureMagentaColor set];
    
    if ([signatureString length] != 0 && signatureString != nil ) {
        CGSize summaryMaxSize = CGSizeMake(SUMMARY_WIDTH, LABEL_HEIGHT*4);
        CGFloat _labelHeight = 45.0f;
//        CGSize signatureSize = [signatureString sizeWithAttributes:];
        CGRect signatureSize = [signatureString boundingRectWithSize:summaryMaxSize  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]} context:nil];
        
        NSLog(@"signatureSize %f, %f:",signatureSize.size.height, signatureSize.size.width);
        
        CGRect signRect = CGRectMake(MIDDLE_COLUMN_OFFSET, _labelHeight, signatureSize.size.width, 60);
        [signatureString drawInRect:signRect withAttributes:@{NSFontAttributeName:smallFont,
                                                              NSParagraphStyleAttributeName: paragraphStyle}];
    }
    
    // origin
    NSString * originString = [DataTransformer getArticleOrigin:self.data];
    UIColor *originMagentaColor = GRAYCOLOR;
    [originMagentaColor set];
    CGRect originRect = CGRectMake(TOTAL_WIDTH - ORIGIN_W - SUMMARY_PADDING, 25, ORIGIN_W, LABEL_HEIGHT);
    [originString drawInRect:originRect withFont:smallBoldFont lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentRight];
    
}

@end