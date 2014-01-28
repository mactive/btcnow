//
//  ArticleTableViewCell.m
//  bitmedia
//
//  Created by meng qian on 14-1-6.
//  Copyright (c) 2014年 thinktube. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "ArticleTableViewCellSubView.h"

@interface ArticleTableViewCell()

@property(nonatomic, strong)NSDictionary *data;
@property(nonatomic, strong)ArticleTableViewCellSubView *subView;

@end

@implementation ArticleTableViewCell
@synthesize data;
@synthesize subView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        self.subView = [[ArticleTableViewCellSubView alloc]initWithFrame:CGRectMake(0, 0, TOTAL_HEIGHT, CELL_HIGH_HEIGHT)];
        [self.contentView addSubview:self.subView];
    }
    return self;
}

- (void)setNewData:(NSDictionary *)_data
{
    [self.subView setNewData:_data];
}


@end
