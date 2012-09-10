//
//  CategoryDetailViewController.h
//  StartupVideos
//
//  Created by Sheehan Alam on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBYouTubePlayerViewController.h"
#import "MoviePlayerViewController.h"

@interface CategoryDetailViewController : UITableViewController <LBYouTubePlayerControllerDelegate> {
     NSMutableArray* _videos;
    MoviePlayerViewController *player;
    NSString* videoPath;
    int videoNumber;
    BOOL wasPopped;
    
    
}
@property (nonatomic) int category;

@end
