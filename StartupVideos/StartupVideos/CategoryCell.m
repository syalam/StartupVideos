//
//  CategoryCell.m
//  StartupVideos
//
//  Created by Sheehan Alam on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

@synthesize thumbnailImage;
@synthesize titleLabel;
@synthesize videoCountLabel;
@synthesize chapterLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.thumbnailImage = [[TCImageView alloc] initWithFrame:CGRectMake(10, 25, 50, 50)];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, 200, 32)];
        self.videoCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 55, 200, 32)];
        self.chapterLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 80, 200, 32)];

    }
    
    [self.contentView addSubview:self.thumbnailImage];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.videoCountLabel];
    [self.contentView addSubview:self.chapterLabel];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
