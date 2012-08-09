//
//  AppDelegate.h
//  StartupVideos
//
//  Created by Sheehan Alam on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdWhirlView.h"
#import "CategoryViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, AdWhirlDelegate> {
    CategoryViewController *homeViewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *homeNavController;
@property (strong, nonatomic) AdWhirlView *adWhirlView;

@end
