//
//  MoviePlayerViewController.m
//  StartupVideos
//
//  Created by Rashaad Sidique on 9/9/12.
//
//

#import "MoviePlayerViewController.h"
#import "AdViewController.h"
#import "AppDelegate.h"

@interface MoviePlayerViewController ()

@end

@implementation MoviePlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.moviePlayer.useApplicationAudioSession = NO;
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    delegate.moviePlayer = self.moviePlayer;
    delegate.isMovieView = YES;
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:self.moviePlayer];
    
    // Register this class as an observer instead
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPMoviePlayerDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:self.moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(exitDuringVideo:)
                                                 name:UIApplicationWillResignActiveNotification object:nil];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%d-%d startTime",self.category, self.videoNumber]]) {
        self.moviePlayer.initialPlaybackTime = [[NSUserDefaults standardUserDefaults] floatForKey:[NSString stringWithFormat:@"%d-%d startTime",self.category, self.videoNumber]];
    }
    
    /*[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPMoviePlayerDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];*/

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden = YES;
 
}

- (void)viewWillDisappear:(BOOL)animated {

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(NSUInteger) supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskAll;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

#pragma mark - Notification Handlers
-(void)moviePlayBackStateDidChange:(id)sender
{
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"exitDuringVideo"]) {
        if (self.moviePlayer.currentPlaybackTime != self.moviePlayer.duration) {
            
            [[NSUserDefaults standardUserDefaults]setFloat:self.moviePlayer.currentPlaybackTime forKey:[NSString stringWithFormat:@"%d-%d startTime",self.category, self.videoNumber]];
            [[NSUserDefaults standardUserDefaults]setFloat:self.moviePlayer.currentPlaybackTime forKey: @"lastPlayed"];
            self.moviePlayer.initialPlaybackTime = self.moviePlayer.currentPlaybackTime;
            
        }
        else {
            [[NSUserDefaults standardUserDefaults]setFloat:0 forKey:[NSString stringWithFormat:@"%d-%d startTime",self.category, self.videoNumber]];
            self.moviePlayer.initialPlaybackTime = 0;
        }

    }
    
}
-(void)exitDuringVideo:(id)sender {
    //AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    //delegate.playbackTimeBeforeBackground = self.moviePlayer.currentPlaybackTime;
    if (self.moviePlayer.playbackState == MPMoviePlaybackStatePaused) {
        if (self.moviePlayer.currentPlaybackTime != self.moviePlayer.duration) {
            
            [[NSUserDefaults standardUserDefaults]setFloat:self.moviePlayer.currentPlaybackTime forKey:[NSString stringWithFormat:@"%d-%d startTime",self.category, self.videoNumber]];
            [[NSUserDefaults standardUserDefaults]setFloat:self.moviePlayer.currentPlaybackTime forKey: @"lastPlayed"];
            self.moviePlayer.initialPlaybackTime = self.moviePlayer.currentPlaybackTime;
            NSLog(@"playback time %0.00f", self.moviePlayer.initialPlaybackTime);
            
        }
        else {
            [[NSUserDefaults standardUserDefaults]setFloat:0 forKey:[NSString stringWithFormat:@"%d-%d startTime",self.category, self.videoNumber]];
            self.moviePlayer.initialPlaybackTime = 0;
        }

        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"exitDuringVideo"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSUserDefaults standardUserDefaults]setValue:self.videoUrl forKey:@"videoUrl"];
        [[NSUserDefaults standardUserDefaults]setInteger:self.videoNumber forKey:@"videoNumber"];
        [[NSUserDefaults standardUserDefaults]setInteger:self.category forKey:@"category"];
    }
    [self.moviePlayer pause];
    
}
- (void)MPMoviePlayerDidFinish:(NSNotification *)notification
{    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"exitDuringVideo"]) {
        [self dismissModalViewControllerAnimated:YES];
    }
    else {
        
    }
}




@end
