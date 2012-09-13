//
//  MoviePlayerViewController.m
//  StartupVideos
//
//  Created by Rashaad Sidique on 9/9/12.
//
//

#import "MoviePlayerViewController.h"
#import "AdViewController.h"

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
    // Do any additional setup after loading the view from its nib.
    didExit = NO;
    ad = arc4random()%2;
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
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

#pragma mark - Notification Handlers
-(void)moviePlayBackStateDidChange:(id)sender
{
    if (self.moviePlayer.currentPlaybackTime != self.moviePlayer.duration) {

        [[NSUserDefaults standardUserDefaults]setFloat:self.moviePlayer.currentPlaybackTime forKey:[NSString stringWithFormat:@"%d-%d startTime",self.category, self.videoNumber]];
        
    }
    else {
        [[NSUserDefaults standardUserDefaults]setFloat:0 forKey:[NSString stringWithFormat:@"%d-%d startTime",self.category, self.videoNumber]];
    }
    if (didExit) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"exitDuringVideo"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSUserDefaults standardUserDefaults]setValue:self.videoUrl forKey:@"videoUrl"];
        [[NSUserDefaults standardUserDefaults]setInteger:self.videoNumber forKey:@"videoNumber"];
        [[NSUserDefaults standardUserDefaults]setInteger:self.category forKey:@"category"];
    }

}
-(void)exitDuringVideo:(id)sender {
    didExit = YES;
    
}
/*- (void)MPMoviePlayerDidFinish:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}*/

@end
