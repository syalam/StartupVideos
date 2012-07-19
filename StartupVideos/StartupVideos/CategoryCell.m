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
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableviewbg"]];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        self.thumbnailImage = [[TCImageView alloc] initWithFrame:CGRectMake(10, 15, 50, 50)];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 200, 32)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
        self.titleLabel.textColor = [UIColor colorWithRed:26/255 green:26/255 blue:26/255 alpha:1];
        
        self.videoCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, 200, 32)];
        self.videoCountLabel.backgroundColor = [UIColor clearColor];
        self.videoCountLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        self.videoCountLabel.textColor = [UIColor colorWithRed:106/255 green:106/255 blue:106/255 alpha:1];
        
        self.chapterLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 200, 32)];
        self.chapterLabel.backgroundColor = [UIColor clearColor];
        self.chapterLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        self.chapterLabel.textColor = [UIColor colorWithRed:0 green:113/255 blue:181/255 alpha:1];
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
