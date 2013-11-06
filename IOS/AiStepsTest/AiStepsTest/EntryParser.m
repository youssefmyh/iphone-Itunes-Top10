//
//  EntryParser.m
//  Test
//
//  Created by youssef hanna on 9/25/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EntryParser.h"

@implementation EntryParser
@synthesize entriesArray;

- (id)init:(id)_id {
    
    self = [super init];
    if (self) {
        entriesArray=[[NSMutableArray alloc]init];
        requestController=_id;
    }
    return self;
}

/*Parser Element start and this used to initalize the Entry Object*/
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    
    if([elementName isEqualToString:IMAGELINK_TAG]
       ||[elementName isEqualToString:TITLE_TAG]
      )
    {
        if(!soapResults)
        {
            soapResults = [[NSMutableString alloc] init];
        }
        isRecordInitalized=TRUE;
    }
    
    if( [elementName isEqualToString:ENTRY_TAG])
    {
        Entry *entry=[[Entry alloc]init];
        [entriesArray addObject:entry];
        [entry release];
    }
    if([entriesArray lastObject]&&[elementName isEqualToString:ENTRYID_TAG])
    {
        [[entriesArray lastObject] setSongId:[attributeDict valueForKey:@"im:id"]];
    }
    if([entriesArray lastObject]&&[elementName isEqualToString:WEBLINK_TAG])
    {
        [[entriesArray lastObject] setWebLink:[attributeDict valueForKey:@"href"]];

    }

}
/*Parser Append Parsed Data */

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
   	if( isRecordInitalized )
	{
		[soapResults appendString: string];
	}
}


/*set parsed data to Entry Object*/
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
  
        if([elementName isEqualToString:TITLE_TAG])
        {
            if([entriesArray lastObject]){
                [[entriesArray lastObject] setTitle:soapResults];
            }
            
            [self resetParserData];
        }else

    if([elementName isEqualToString:IMAGELINK_TAG])
    {
        if([entriesArray lastObject]){
        [[entriesArray lastObject] setImageLink:soapResults];
        }

        [self resetParserData];
    }
    else
    if([elementName isEqualToString:FEED_TAG])
    {
        [self loadingFinish];
    }

}


/*
 this method used at the end of parser
 */
-(void)loadingFinish
{
    NSLog(@"Loaing Finish");
    [requestController performSelector:@selector(loadingFinish)];
}

/*reset Parsed data and make it ready for new parsing
 */
-(void)resetParserData
{
        isRecordInitalized = FALSE;
        [soapResults release];
        soapResults = nil;
    
}


- (void)dealloc {
    [entriesArray release];
    [soapResults release];
    [super dealloc];
}

@end
