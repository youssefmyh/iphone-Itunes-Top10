//
//  SongDetailsViewer.m
//  Aisteps
//
//  Created by youssef hanna on 9/26/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SongDetailsViewer.h"

@implementation SongDetailsViewer
@synthesize webView,selectedEntry;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(selectedEntry.webLink)
    {
    webLinkUrl = [NSURL URLWithString:selectedEntry.webLink];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:webLinkUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5000]; //create request
    [webView loadRequest:requestObj] ; //webview load requestObject
 
    }
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"Loading Finish");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Loading Error  %@ ",[error localizedDescription]);

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc
{
    [webLinkUrl release];
    [webView release];
}

@end
