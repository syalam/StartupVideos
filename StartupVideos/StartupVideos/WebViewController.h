//
//  HelpViewController.h
//  iBoom
//
//  Created by Brian Stormont on 1/30/09.
//  Copyright 2009 Stormy Productions. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WebViewController
@optional
- (void) dismissWebView;
@end

@interface WebViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate> {
	IBOutlet UIWebView *webView;
	IBOutlet UIActivityIndicatorView *busyWebIcon;
	IBOutlet UIBarButtonItem *webForward;	
	IBOutlet UIToolbar *toolBar;
	id delegate;
}
@property (nonatomic,retain) id delegate;

- (void) showNoNetworkAlert;
- (IBAction) browseBack: (id) sender;
- (IBAction) browseForward: (id) sender;
- (IBAction) stopOrReLoadWeb: (id) sender;
- (IBAction) launchSafari: (id) sender;
- (void) loadBrowser: (NSURL *) url;
-(IBAction)done: (id)sender;



@end
