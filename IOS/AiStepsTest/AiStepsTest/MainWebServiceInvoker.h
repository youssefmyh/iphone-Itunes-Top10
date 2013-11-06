//
//  MainWebServiceInvokder.h
//  Test
//
//  Created by youssef hanna on 9/24/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainWebServiceInvoker : NSObject
{
    
    id parsingObject;
    NSURLConnection *theConnection;
    NSMutableData *webData;           /**<Used to hold  the repsonse of rsent request in  XML format*/
    NSXMLParser *xmlParser;
    
}
@property(retain,nonatomic)NSURLConnection *theConnection;

@property(retain,nonatomic)id parsingObject;

/*
 initalize MainInvoker
 @param parsingObject this a Object that will be called when loading finish to parse Entries Objects 
 */
-(id)init:(id)parsingObject;

/*
 doRequest this method used to perform the Web service Request 
 @param Url request URL if it nil it will loaded from ApplicationConstant.WEBSERVICE_URL
 */
-(void)doRequest:(NSString*)url;
@end
