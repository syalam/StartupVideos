//
//  CategoryDetailCell.h
//  StartupVideos
//
//  Created by Rashaad Sidique on 9/10/12.
//
//

#import <UIKit/UIKit.h>
#import "TCImageView.h"

@interface CategoryDetailCell : UITableViewCell
-(void) changeBackground;

@property(nonatomic,retain)    TCImageView* thumbnailImage;
@property(nonatomic,retain)    UILabel* titleLabel;
@property(nonatomic,retain)    UILabel* videoCountLabel;
@property(nonatomic,retain)    UILabel* chapterLabel;
@property(nonatomic,retain) UIImageView *playicon;

@property(nonatomic, retain) UILabel* titleLabel2;
@property(nonatomic, retain) UILabel* duration;


@end
