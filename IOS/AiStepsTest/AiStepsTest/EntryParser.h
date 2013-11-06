//
//  EntryParser.h
//  Test
//
//  Created by youssef hanna on 9/25/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entry.h"
@interface EntryParser : NSObject
{
    NSMutableArray *entriesArray;
    NSMutableString *soapResults;
    BOOL isRecordInitalized;
    id requestController;
    
    
}
@property(nonatomic,retain)NSMutableArray *entriesArray;


//---------------METHODS------------------//
-(void)resetParserData;
-(void)loadingFinish;
- (id)init:(id)_id;

@end
