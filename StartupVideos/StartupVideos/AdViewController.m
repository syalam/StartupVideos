//
//  AdViewController.m
//  StartupVideos
//
//  Created by Rashaad Sidique on 9/9/12.
//
//

#import "AdViewController.h"
#import <Parse/Parse.h>
#import "CategoryViewController.h"
#import "InAppZapIAPHelper.h"
#import "Reachability.h"
#import "SVProgressHUD.h"


@interface AdViewController ()

@end

@implementation AdViewController

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
	// Do any additional setup after loading the view, typically from a nib.
    adImage.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    adImage.contentMode = UIViewContentModeScaleAspectFit;
    [self loadSplash];
    self.navigationController.navigationBar.hidden = YES;
    [self performSelector:@selector(fadeOut:) withObject:nil afterDelay:5.0];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [SVProgressHUD dismiss];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.adWhirlView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productsLoaded:) name:kProductsLoadedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:kProductPurchasedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(productPurchaseFailed:) name:kProductPurchaseFailedNotification object: nil];
    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    if (netStatus == NotReachable) {
        NSLog(@"No internet connection!");
    } else {
                    
    }

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


-(void)viewDidDisappear:(BOOL)animated {
    [appDelegate.window.rootViewController.view addSubview:appDelegate.adWhirlView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)loadSplash {
    UIImage *image1 = [UIImage imageNamed:@"ad1maxcdn"];
    UIImage *image2 = [UIImage imageNamed:@"ad2kissmetrics"];
    UIImage *image3 = [UIImage imageNamed:@"ad3contestdomination"];
    UIImage *image4 = [UIImage imageNamed:@"ad4seomoz"];
    UIImage *image5 = [UIImage imageNamed:@"ad5wistia"];
    UIImage *image6 = [UIImage imageNamed:@"ad6buffer"];
    UIImage *image7 = [UIImage imageNamed:@"ad7spyfu"];
    UIImage *image8 = [UIImage imageNamed:@"ad8slidedeck"];
    
    UIImage *image9 = [UIImage imageNamed:@"Upsell 100"];
    UIImage *image10 = [UIImage imageNamed:@"Upsell 100"];
    UIImage *image11 = [UIImage imageNamed:@"Upsell 100"];
    UIImage *image12 = [UIImage imageNamed:@"Upsell 100"];
    UIImage *image13 = [UIImage imageNamed:@"Upsell 100"];
    UIImage *image14 = [UIImage imageNamed:@"Upsell 100"];
    UIImage *image15 = [UIImage imageNamed:@"Upsell 100"];
    UIImage *image16 = [UIImage imageNamed:@"Upsell 100"];
    
    NSString *url1 = @"http://www.maxcdn.com";
    NSString *url2 = @"http://www.kissmetrics.com";
    NSString *url3 = @"http://contestdomination.com";
    NSString *url4 = @"http://www.seomoz.org/features_e/?utm_source=startup_videos_app&utm_medium=banner&utm_campaign=test&utm_content=seo_social_monitoring_made_simple_e";
    NSString *url5 = @"http://wistia.com";
    NSString *url6 = @"http://bufferapp.com";
    NSString *url7 = @"http://www.spyfu.com";
    NSString *url8 = @"http://slidedeck.com/?utm_source=startup_videos_app&utm_medium=banner&utm_campaign=pr";
    if (_moreClicked || _isLaunch) {
        index = 9;
        [adImage setImage:image9];
    }
    else {
        NSArray *splashArray = [[NSArray alloc]initWithObjects:image1, image2, image3, image4, image5, image6, image7, image8, image9, image10, image11, image12, image13, image14, image15, image16, nil];
        urlArray = [[NSArray alloc]initWithObjects:url1,url2, url3, url4, url5,url6,url7,url8, nil];
        index = arc4random()%16;
        
        UIImage *selectedImage = [splashArray objectAtIndex:index];
        
        [adImage setImage:selectedImage];

    }
}

-(void)fadeOut:(id)sender
{
    if (!wasClicked && !_isLaunch) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (!wasClicked && _isLaunch) {
        CategoryViewController *cvc = [[CategoryViewController alloc]initWithNibName:@"CategoryViewController" bundle:nil];
        cvc.navigationItem.hidesBackButton = YES;
        [self.navigationController pushViewController:cvc animated:YES];
    }
    
}

-(IBAction)adButtonClicked:(id)sender {
    if (index < 8) {
        wasClicked = YES;
        [self presentModalViewController:webViewController animated:YES];
        webViewController.delegate = self;
        [webViewController loadBrowser: [NSURL URLWithString:[urlArray objectAtIndex:index]]];
    }
    else {
        wasClicked = YES;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Upgrade" message:@"Grab 100 new videos now" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alert show];
    }
}
-(IBAction)closeButtonClicked:(id)sender {
    wasClicked = YES;
    if (_isLaunch) {
        CategoryViewController *cvc = [[CategoryViewController alloc]initWithNibName:@"CategoryViewController" bundle:nil];
        cvc.navigationItem.hidesBackButton = YES;
        [self.navigationController pushViewController:cvc animated:YES];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (void) dismissWebView
{
    [self dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        SKProduct *product = [[InAppZapIAPHelper sharedHelper].products objectAtIndex:0];
        
        NSLog(@"Buying %@...", product.productIdentifier);
        //[[InAppZapIAPHelper sharedHelper] buyProductIdentifier:product.productIdentifier];
        InAppZapIAPHelper *purchaseHelper = [[InAppZapIAPHelper alloc]init];
        [purchaseHelper buyProductIdentifier:product.productIdentifier];
        [self performSelector:@selector(timeout:) withObject:nil afterDelay:60*5];
        /*[PFPurchase buyProduct:@"28V8W66Z7L.com.videolark.StartupMarketingVideos.Pro" block:^(NSError *error) {
            if (!error) {
                self.navigationItem.leftBarButtonItem = nil;
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Upgrade Complete" message:@"Upgrade successful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            else {
                NSLog (@"%@",[error localizedDescription]);
            }
         
        }];*/
    }
}
#pragma mark - Helper Methods
- (void)productPurchaseFailed:(NSNotification *)notification {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //[MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [SVProgressHUD dismiss];
    
    SKPaymentTransaction * transaction = (SKPaymentTransaction *) notification.object;
    if (transaction.error.code != SKErrorPaymentCancelled) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                        message:transaction.error.localizedDescription
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
}

- (void)dismissHUD:(id)arg {
    
    ///[MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    //self.hud = nil;
    [SVProgressHUD dismiss];
    
}

- (void)productsLoaded:(NSNotification *)notification {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [SVProgressHUD dismiss];
    
    
}

- (void)timeout:(id)arg {
    
    /*_hud.labelText = @"Timeout!";
     _hud.detailsLabelText = @"Please try again later.";
     _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
     _hud.mode = MBProgressHUDModeCustomView;*/
    [SVProgressHUD dismissWithError:@"Please Try Again Later"];
    [self performSelector:@selector(dismissHUD:) withObject:nil afterDelay:3.0];
    
}

- (void)updateInterfaceWithReachability: (Reachability*) curReach {
    
    
    
}

- (void)productPurchased:(NSNotification *)notification {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //[MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [SVProgressHUD dismiss];
    
    NSString *productIdentifier = (NSString *) notification.object;
    NSLog(@"Purchased: %@", productIdentifier);
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"proPackage"];
    
}


@end
