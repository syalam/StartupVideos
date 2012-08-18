//
//  CategoryCell.h
//  StartupVideos
//
//  Created by Sheehan Alam on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCImageView.h"

@interface CategoryCell : UITableViewCell
{

}
-(void) changeBackground;

@property(nonatomic,retain)    TCImageView* thumbnailImage;
@property(nonatomic,retain)    UILabel* titleLabel;
@property(nonatomic,retain)    UILabel* videoCountLabel;
@property(nonatomic,retain)    UILabel* chapterLabel;

@end
