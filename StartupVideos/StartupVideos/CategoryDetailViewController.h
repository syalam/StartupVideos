//
//  CategoryDetailViewController.h
//  StartupVideos
//
//  Created by Sheehan Alam on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBYouTubePlayerViewController.h"

@interface CategoryDetailViewController : UITableViewController <LBYouTubePlayerControllerDelegate> {
     NSMutableArray* _videos;
    
}
@property (nonatomic) int category;

@end
