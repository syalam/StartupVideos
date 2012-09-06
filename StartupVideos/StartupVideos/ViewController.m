//
//  ViewController.m
//  StartupVideos
//
//  Created by Sheehan Alam on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "CategoryViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     if (![[NSUserDefaults standardUserDefaults]boolForKey:@"proPackage"]) {
         appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
         [appDelegate.adWhirlView removeFromSuperview];
     }
	// Do any additional setup after loading the view, typically from a nib.
    [self loadSplash];
    self.navigationController.navigationBar.hidden = YES;
    [self performSelector:@selector(fadeOut:) withObject:nil afterDelay:2.0];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewDidDisappear:(BOOL)animated {
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"proPackage"]) {
        
        [appDelegate.window.rootViewController.view addSubview:appDelegate.adWhirlView];
    }

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)loadSplash {
    UIImage *image1 = [UIImage imageNamed:@"splash"];
    UIImage *image2 = [UIImage imageNamed:@"splash2"];
    UIImage *image3 = [UIImage imageNamed:@"splash3"];
    UIImage *image4 = [UIImage imageNamed:@"splash4"];
    UIImage *image5 = [UIImage imageNamed:@"splash5"];
    UIImage *image6 = [UIImage imageNamed:@"splash6"];
    UIImage *image7 = [UIImage imageNamed:@"splash7"];
    UIImage *image8 = [UIImage imageNamed:@"splash8"];
    
    NSArray *splashArray = [[NSArray alloc]initWithObjects:image1, image2, image3, image4, image5, image6, image7, image8, nil];
    int index = arc4random()%8;
    
    UIImage *selectedImage = [splashArray objectAtIndex:index];
    [splash setImage:selectedImage];
}

-(void)fadeOut:(id)sender
{
    CategoryViewController *cvc = [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
    cvc.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:cvc animated:YES];
}

@end
