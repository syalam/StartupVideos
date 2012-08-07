//
//  CategoryViewController.h
//  StartupVideos
//
//  Created by Sheehan Alam on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewController : UITableViewController
{
    NSMutableArray* _categories;
    NSMutableArray* _counts;
}

- (void)upgradeButtonClicked;
@end
