//
//  CategoryDetailCell.m
//  StartupVideos
//
//  Created by Rashaad Sidique on 9/10/12.
//
//

#import "CategoryDetailCell.h"

@implementation CategoryDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableviewbg"]];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        self.thumbnailImage = [[TCImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        self.playicon = [[UIImageView alloc]initWithFrame:CGRectMake(80, 34, 14, 16)];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 200, 32)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        self.titleLabel.textColor = [UIColor colorWithRed:26/255 green:26/255 blue:26/255 alpha:1];
        
        
        self.videoCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, 200, 32)];
        self.videoCountLabel.backgroundColor = [UIColor clearColor];
        self.videoCountLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        self.videoCountLabel.textColor = [UIColor grayColor];
        
        self.chapterLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 45, 200, 32)];
        self.chapterLabel.backgroundColor = [UIColor clearColor];
        self.chapterLabel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:12];
        self.chapterLabel.textColor = [UIColor colorWithRed:0 green:0.525 blue:0.761 alpha:1];
    }
    
    [self.contentView addSubview:self.thumbnailImage];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.videoCountLabel];
    [self.contentView addSubview:self.chapterLabel];
    [self.contentView addSubview:self.playicon];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)changeBackground {
    self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableviewbg2"]];
}

@end
