//
//  ImageDownloader.m
//  Aisteps
//
//  Created by youssef hanna on 9/26/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader
@synthesize requestedObject;

- (id)init :(NSObject*)_requestedObject{
    self = [super init];
    if (self) {
        self.requestedObject=_requestedObject;
    }
    return self;
}

/*
 loadImage method used to perfom load Image Data from specific URL operation 
 */

-(void)loadImage:(NSString*)url
{
    
    if(url==nil)
       return;
    imageData = [[NSMutableData data] retain];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];

    theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];


}

/*
 *didReceiveData its called while receiving data
 from connection and used to append received data to webdata
 */
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   	[imageData appendData:data];
}

//Fail  
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR IN LOADING IMAGE %@ ",[error localizedDescription]);
}

/* Data Recieved completed */
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [requestedObject performSelector:@selector(loadingFinish:) withObject:imageData afterDelay:10];
   
}


@end
