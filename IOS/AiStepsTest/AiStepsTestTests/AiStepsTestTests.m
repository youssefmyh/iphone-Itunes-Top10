//
//  AiStepsTestTests.m
//  AiStepsTestTests
//
//  Created by youssef hanna on 9/27/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AiStepsTestTests.h"
#import "Entry.h"
#import "ViewController.h"
@implementation AiStepsTestTests

- (void)setUp
{
    [super setUp];
 
    // Set-up code here.
}





- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


-(void)testAddingEntryAndFetchit
{
    Entry *entry=[[Entry alloc]init];
    [entry setTitle:@"TEST _TITLE"];
    [entry setWebLink:@"http://google.com"];    
    [entry setImageLink:nil];
    [entry setSongId:nil];
    ViewController *controller=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [controller initCoreDataObjects];
    if(![controller addEntryToDataBase:entry])
    {
        STFail(@"ENTRY FAILED");
    }
    
    [controller fetchEntriesFromDataBase];
    if([controller.fetchedEntryList count]<=0)
    {
        STFail(@"ENTRY FAILED");
        
    }
    
}




-(void)testAddingEntryWithFullDataToDataBase
{
    Entry *entry=[[Entry alloc]init];
    [entry setTitle:@"TEST _TITLE"];
    [entry setWebLink:@"http://google.com"];    
    [entry setImageLink:@"http://google.com"];
    [entry setSongId:@"122222"];
    ViewController *controller=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [controller initCoreDataObjects];
    if(![controller addEntryToDataBase:entry])
    {
        STFail(@"ENTRY FAILED");
    }
    
}



-(void)testAddingEntryWithTitleAndWebLinkToDataBase
{
    Entry *entry=[[Entry alloc]init];
    [entry setTitle:@"TEST _TITLE"];
    [entry setWebLink:@"http://google.com"];    
    [entry setImageLink:nil];
    [entry setSongId:nil];
    ViewController *controller=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [controller initCoreDataObjects];
    if(![controller addEntryToDataBase:entry])
    {
        STFail(@"ENTRY FAILED");
    }
    
    [controller fetchEntriesFromDataBase];
    if([controller.fetchedEntryList count]<=0)
    {
        STFail(@"ENTRY FAILED");
 
    }
    
}

-(void)testAddingEntryWithNullTitleNullWebLinkToDataBaseShouldFail
{
    Entry *entry=[[Entry alloc]init];
    [entry setTitle:nil];
    [entry setWebLink:nil];    
    [entry setImageLink:nil];
    [entry setSongId:nil];
    ViewController *controller=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [controller initCoreDataObjects];
    if([controller addEntryToDataBase:entry])
    {
        STFail(@"ENTRY FAILED");
    }
    
}



@end
