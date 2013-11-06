//
//  MainWebServiceInvokder.m
//  Test
//
//  Created by youssef hanna on 9/24/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MainWebServiceInvoker.h"

@implementation MainWebServiceInvoker

@synthesize parsingObject;
@synthesize theConnection;
/*
 init method used to initialize web service Invoker and 
 @param parsingObject  after finish calling we are calling LoadingFinish in this Object
 */
-(id)init:(id)_parsingObject;
{
    self=[super init];
    self.parsingObject=_parsingObject;
    return self;
}

/*
 dorequest method used to perfom request operation 
 @param url this param used if you have multiple call for different url 
 @if you send it null it will take the Value from WEBSERVICE_URL param iniside application constant 
 */

-(void)doRequest:(NSString*)url
{
    NSURL *request_url=nil;
    
    if(url==nil)
    {
        request_url=[NSURL URLWithString:WEBSERICE_URL];
    }else
    {
        request_url=[NSURL URLWithString:url];

    } 
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:request_url];
	[theRequest setHTTPMethod:@"GET"];

    
    theConnection=[[NSURLConnection alloc]initWithRequest:theRequest delegate:self startImmediately:TRUE];
    
    if( theConnection )
	{
		webData = [[NSMutableData data] retain];
		
	}
	else
	{
        
		NSLog(@"theConnection is NULL");
		NSLog(@"theConnection is NULL");
	}
    
}

/*
 *didReceiveData its called while receiving data
 from connection and used to append received data to webdata
 */
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   	[webData appendData:data];
}

//Fail  
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR IN LOADING DATA");
}

/* Data Recieved completed */
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
	[xmlParser setDelegate: parsingObject];
	if(![xmlParser parse])
        NSLog(@"start Parsing");
}

- (void)dealloc {
    [xmlParser release];
    [parsingObject release];
    [theConnection release];
    [webData release];

    [super dealloc];
}

@end
