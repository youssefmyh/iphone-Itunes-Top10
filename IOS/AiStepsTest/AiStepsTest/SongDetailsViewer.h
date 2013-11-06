//
//  SongDetailsViewer.h
//  Aisteps
//
//  Created by youssef hanna on 9/26/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"
@interface SongDetailsViewer : UIViewController
{
    IBOutlet UIWebView *webView; ///web view controler show Song Detail
    Entry     *selectedEntry;  //Selected Entry need to displayed 
    NSURL *webLinkUrl; //requestURL
}

@property(nonatomic,retain)IBOutlet UIWebView *webView;
@property(nonatomic,retain)Entry *selectedEntry;


@end
