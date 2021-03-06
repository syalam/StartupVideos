//
//  ViewController.m
//  StartupVideos
//
//  Created by Sheehan Alam on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "CategoryViewController.h"
#import "AdViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"proPackage"]) {
        [appDelegate.adWhirlView removeFromSuperview];
    }
	// Do any additional setup after loading the view, typically from a nib.
    [self loadSplash];
    self.navigationController.navigationBar.hidden = YES;
    appDelegate.isMovieView = NO;
    [self performSelector:@selector(fadeOut:) withObject:nil afterDelay:2.0];

}

-(void)viewWillDisappear:(BOOL)animated {
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"proPackage"]) {
        
        [appDelegate.window.rootViewController.view addSubview:appDelegate.adWhirlView];
    }

}

/*- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}*/
-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)loadSplash {
    //UIImage *image1 = [UIImage imageNamed:@"splash"];
    UIImage *image2 = [UIImage imageNamed:@"splash2"];
    UIImage *image3 = [UIImage imageNamed:@"splash3"];
    UIImage *image4 = [UIImage imageNamed:@"splash4"];
    UIImage *image5 = [UIImage imageNamed:@"splash5"];
    UIImage *image6 = [UIImage imageNamed:@"splash6"];
    UIImage *image7 = [UIImage imageNamed:@"splash7"];
    UIImage *image8 = [UIImage imageNamed:@"splash8"];
    
    NSArray *splashArray = [[NSArray alloc]initWithObjects:image2, image3, image4, image5, image6, image7, image8, nil];
    int index = arc4random()%7;
    
    UIImage *selectedImage = [splashArray objectAtIndex:index];
    [splash setImage:selectedImage];
}

-(void)fadeOut:(id)sender
{
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"proPackage"]) {
        AdViewController *avc = [[AdViewController alloc]initWithNibName:@"AdViewController" bundle:nil];
        avc.isLaunch = YES;
        [self.navigationController pushViewController:avc animated:YES];
        
    }
    else {
        CategoryViewController *cvc = [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
        cvc.navigationItem.hidesBackButton = YES;
        [self.navigationController pushViewController:cvc animated:YES];
    }
    
}

@end
