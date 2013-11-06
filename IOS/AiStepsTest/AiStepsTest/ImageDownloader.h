//
//  ImageDownloader.h
//  Aisteps
//
//  Created by youssef hanna on 9/26/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDownloader : NSObject
{
    NSObject *requestedObject;
    NSURLConnection *theConnection;
    NSMutableData *imageData;     /*Loaded imageData*/

    
}
@property(nonatomic,retain)NSObject *requestedObject;



-(id)init:(NSObject*)requestedObject;
-(void)loadImage:(NSString*)url;

@end
