//
//  AdViewController.h
//  StartupVideos
//
//  Created by Rashaad Sidique on 9/9/12.
//
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "WebViewController.h"

@interface AdViewController : UIViewController {
    IBOutlet UIImageView *adImage;
    AppDelegate *appDelegate;
    int index;
    NSArray *urlArray;
    IBOutlet UIButton *adButton;
    IBOutlet UIButton *closeButton;
    BOOL wasClicked;
    IBOutlet WebViewController *webViewController;
}
-(IBAction)adButtonClicked:(id)sender;
-(IBAction)closeButtonClicked:(id)sender;

@property BOOL moreClicked;
@property BOOL isLaunch;

@end
