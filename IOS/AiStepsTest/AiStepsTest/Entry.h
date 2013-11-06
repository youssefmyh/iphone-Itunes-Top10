//
//  Entry.h
//  Test
//
//  Created by youssef hanna on 9/25/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 Entry Object contain 
 SongID and it will added to database to prevent dubplicated Songs 
 title,imageLink,weblink its Songs Data
 
 */

@interface Entry :NSObject 
{
    NSString *songId;
    NSString *title;
    NSString *imageLink;
    NSString *webLink;    
    UIImage *graphicImage;
    

}
@property(nonatomic,retain)UIImage *graphicImage;
@property(nonatomic,retain)NSString *songId;
@property(nonatomic,retain)NSString *title;
@property(nonatomic,retain)NSString *imageLink;
@property(nonatomic,retain)NSString *webLink;
@end
