//
//  EntryTableCell.m
//  Test
//
//  Created by youssef hanna on 9/26/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EntryTableCell.h"
@implementation EntryTableCell
@synthesize entry,defaultImage,imageDownloader;

#define TITLE_STARTX 70
#define TITLE_STARTY 10
#define MAX_TITLE_WIDTH 240
#define MAX_TITLE_HEIGHT 70



#define IMAGE_STARTY 5
#define IMAGE_STARTX 5
#define IMAGE_WIDTH 50
#define IMAGE_HEIGHT 50



/*
 initalize Defautl Image until we load the Song Image 
 
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        defaultImage=[UIImage imageNamed:@"icon.png"];
        imageDownloader=[[ImageDownloader alloc]init:self];
        [imageDownloader loadImage:entry.imageLink];
        }
    return self;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*Draw Cell Rect */
-(void)drawRect:(CGRect)rect
{
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGRect titleFrame = CGRectMake(TITLE_STARTX, TITLE_STARTY, MAX_TITLE_WIDTH, MAX_TITLE_HEIGHT);
    UIFont *font = [UIFont boldSystemFontOfSize:16];
    //Draw Text 
    [entry.title drawInRect:titleFrame withFont:font lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
    //draw Image
    if(entry.graphicImage){
        [entry.graphicImage drawInRect:CGRectMake(IMAGE_STARTX, IMAGE_STARTY, IMAGE_WIDTH, IMAGE_HEIGHT)];
    }else
    {
        [defaultImage drawInRect:CGRectMake(IMAGE_STARTX, IMAGE_STARTY, IMAGE_WIDTH, IMAGE_HEIGHT)];
        [imageDownloader loadImage:entry.imageLink];

    }

}

/*
 loadingFinish function called when loading Image finish by ImageDownloader 
 */
-(void)loadingFinish:(NSMutableData*)imageData
{
    entry.graphicImage=[UIImage imageWithData:imageData];
    [self setNeedsDisplay];
    }

-(void)dealloc
{
    [super dealloc];
    [defaultImage release];
    [entry release];
}
    

@end
