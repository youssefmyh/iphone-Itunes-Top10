//
//  EntryTableCell.h
//  Test
//
//  Created by youssef hanna on 9/26/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"
#import "ImageDownloader.h"
@interface EntryTableCell : UITableViewCell
{
    Entry *entry;
    UIImage *defaultImage;
    ImageDownloader *imageDownloader;
    

}

@property(nonatomic,retain)    ImageDownloader *imageDownloader;
@property(nonatomic,retain)    Entry *entry;
@property(nonatomic,retain)   UIImage *defaultImage;
 
-(void)loadingFinish:(NSMutableData*)imageData;

@end
