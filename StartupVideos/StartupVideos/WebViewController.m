//
//  HelpViewController.m
//  iBoom
//
//  Created by Brian Stormont on 1/30/09.
//  Copyright 2009 Stormy Productions. All rights reserved.
//

#import "WebViewController.h"
//#import "reachability.h"

@implementation WebViewController
@synthesize delegate;

- (void) loadBrowser: (NSURL *) url
{
	// Check for network connectivity
	//if (isNetReachable(@"0.0.0.0")){
		
		webView.delegate = self;
		
		[webView loadRequest:[NSURLRequest requestWithURL:url]];
						
		// Disable forward button
		webForward.enabled = NO;
	//}else{
		//[self showNoNetworkAlert];
	//}
}

- (IBAction) browseBack: (id) sender
{
	if ([webView canGoBack]){
		[webView goBack];
		// Enable the forward button
		webForward.enabled = YES;
	}else{
		[delegate dismissWebView];
	}
	
}

- (IBAction) browseForward: (id) sender
{
	if ([webView canGoForward]){
		[webView goForward];
		
		if (![webView canGoForward]){
			// disable the forward button
			webForward.enabled = NO;
		}
	}else{
		webForward.enabled = NO;
	}	
	
}

- (IBAction) stopOrReLoadWeb: (id) sender
{
	// NOTE: stop is not implemented.  Only reload is implemented.
	/*
	 if ([webView isLoading]){
	 [webView stopLoading];
	 }else*/{
		 [webView reload];
	 }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0){	
		[[UIApplication sharedApplication] openURL:[[webView request] URL]];
	}
	
}

- (IBAction) launchSafari: (id) sender{
	
	UIActionSheet *menu = [[UIActionSheet alloc]
						   initWithTitle: nil
						   delegate:self
						   cancelButtonTitle:@"Cancel"
						   destructiveButtonTitle:nil
						   otherButtonTitles:@"View in Safari", nil];
	[menu showFromToolbar:toolBar];
}



- (void) showNoNetworkAlert
{
	UIAlertView *baseAlert = [[UIAlertView alloc] 
							  initWithTitle:@"No Network" message:@"A network connection is required.  Please verifiy your network settings and try again." 
							  delegate:nil cancelButtonTitle:nil 
							  otherButtonTitles:@"OK", nil];	
	[baseAlert show];
}

//
#pragma mark UIWebView delegate methods
//

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // starting the load, show the activity indicator in the status bar
	[busyWebIcon startAnimating];				
	
}

- (void)webViewDidFinishLoad:(UIWebView *)webView1
{
    // finished loading, hide the activity indicator
 	[busyWebIcon stopAnimating];	
	
	if (![webView1 canGoForward]){
		// disable the forward button
		webForward.enabled = NO;
	}
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // load error, hide the activity indicator in the status bar
	[busyWebIcon stopAnimating];				
}

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
	// Check for network connectivity
	//if (isNetReachable(@"0.0.0.0")){
		return YES;
	//}else{
		//[self showNoNetworkAlert];
		//return NO;
	//}
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // We support any orientation
    return (YES);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

-(IBAction)back: (id)sender
{
	//  If we go back past the first web page in the cache, then dismiss the web view
	
	if ([webView canGoBack]){
		[webView goBack];
	}else{	
		[delegate dismissWebView];
	}
}

-(IBAction)done: (id)sender
{
	[delegate dismissWebView];
}




@end
