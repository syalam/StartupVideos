//
//  CategoryDetailViewController.h
//  StartupVideos
//
//  Created by Sheehan Alam on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBYouTubePlayerViewController.h"
#import "LBYouTubeExtractor.h"
#import "MoviePlayerViewController.h"
#import "AppDelegate.h"

@interface CategoryDetailViewController : UITableViewController <LBYouTubeExtractorDelegate> {
     NSMutableArray* _videos;
    MoviePlayerViewController *player;
    NSString* videoPath;
    int videoNumber;
    BOOL wasPopped;
    AppDelegate *appDelegate;
    
}
@property (nonatomic) int category;

@end
