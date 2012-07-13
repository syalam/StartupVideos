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
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.hidden = YES;
    [self performSelector:@selector(fadeOut:) withObject:nil afterDelay:1.0];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)fadeOut:(id)sender
{
    CategoryViewController *cvc = [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
    cvc.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:cvc animated:YES];
}

@end
