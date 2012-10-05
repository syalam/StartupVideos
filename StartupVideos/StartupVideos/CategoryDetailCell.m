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
        
        self.playicon = [[UIImageView alloc]initWithFrame:CGRectMake(33, 32, 17, 19)];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 7, 200, 50)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        //[self.titleLabel setEditable:NO];
        self.titleLabel.textColor = [UIColor colorWithRed:0.137 green:0.137 blue:0.137 alpha:1];
        
        self.duration = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 200, 32)];
        self.duration.backgroundColor = [UIColor clearColor];
        self.duration.font = [UIFont fontWithName:@"Helvetica" size:12];
        self.duration.textColor = [UIColor grayColor];
        
    }
    
    [self.contentView addSubview:self.thumbnailImage];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.duration];
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
