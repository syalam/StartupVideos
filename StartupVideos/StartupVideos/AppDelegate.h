//
//  AppDelegate.h
//  StartupVideos
//
//  Created by Sheehan Alam on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class ViewController;

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AdWhirlView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MoviePlayerViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, AdWhirlDelegate> {
    
}
-(void)startPlayerAfterDelayPause;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) AdWhirlView *adWhirlView;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
@property (strong, nonatomic) MoviePlayerViewController *mpController;
@property BOOL isMovieView;

@end
