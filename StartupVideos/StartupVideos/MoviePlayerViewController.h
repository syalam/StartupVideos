//
//  MoviePlayerViewController.h
//  StartupVideos
//
//  Created by Rashaad Sidique on 9/9/12.
//
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


@interface MoviePlayerViewController : MPMoviePlayerViewController {
}

@property int category;
@property int videoNumber;
@property NSString *videoUrl;

@end
