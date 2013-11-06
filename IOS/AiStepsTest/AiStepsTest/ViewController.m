//
//  ViewController.m
//  Test
//
//  Created by youssef hanna on 9/24/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize entryParserObject;
@synthesize mangedObject,presisitenStoreCoordinator,mangedObjectContext,fetchRequest,displayedEntriesList,songsTableView,fetchedEntryList,invoker,songDetails;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"AiSteps Test"];

    displayedEntriesList=[[NSMutableArray alloc]init];
    [self initCoreDataObjects];
    [self fetchEntriesFromDataBase];
    
    entryParserObject=[[EntryParser alloc]init:self];
	// Do any additional setup after loading the view, typically from a nib.
    invoker=[[MainWebServiceInvoker alloc]init:entryParserObject];
    [invoker doRequest:nil];
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


/*
 initalize core data Objects Model ,Coordinator , MangedObjectContext
 */
-(void)initCoreDataObjects
{
    mangedObject=[[NSManagedObjectModel mergedModelFromBundles:nil] retain];
    
    presisitenStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel:[self mangedObject]];
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"aiptest.sqlite"]];

    NSError *error = nil;
    if([presisitenStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                 configuration:nil URL:storeUrl options:nil error:&error])
    {
        NSPersistentStoreCoordinator *coordinator = [self presisitenStoreCoordinator];
        if (coordinator != nil) {
            mangedObjectContext = [[NSManagedObjectContext alloc] init];
            [mangedObjectContext setPersistentStoreCoordinator: coordinator];
        }

    }
    
    

}


/*
 Adding Entry to DataBase 
 */
-(BOOL)addEntryToDataBase:(Entry*)entry
{
    
    NSManagedObject *entryMangedObject=[NSEntityDescription insertNewObjectForEntityForName:ENTRY inManagedObjectContext:self.mangedObjectContext];
    [entryMangedObject setValue:entry.title forKey:TITLE];
    [entryMangedObject setValue:entry.imageLink forKey:IMAGELINK];
    [entryMangedObject setValue:entry.webLink forKey:WEBLINK];
    [entryMangedObject setValue:entry.songId forKey:SONGID];
    
    NSError *error;
    if([self.mangedObjectContext save:&error])
    {
        NSLog(@"Entry Saved");
        return TRUE;
    }else
    {
        NSLog(@"Error in saving %@",[error localizedDescription]);
        return FALSE;
    }
}


/*Fetch Entries from database using FetchRequest */
-(void)fetchEntriesFromDataBase
{
    NSError *error;
    fetchRequest=[[NSFetchRequest alloc] init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:ENTRY inManagedObjectContext:mangedObjectContext];
    [fetchRequest setEntity:entity];
    fetchedEntryList=[mangedObjectContext executeFetchRequest:fetchRequest error:&error];
    [displayedEntriesList removeAllObjects];
    for (int i=0; i<[fetchedEntryList count]; i++)
    {
       NSManagedObject *MangedObject=[fetchedEntryList objectAtIndex:i];
        Entry *entry=[[Entry alloc] init];
        [entry setTitle:[MangedObject valueForKey:TITLE]];
        [entry setImageLink:[MangedObject valueForKey:IMAGELINK]];
        [entry setWebLink:[MangedObject valueForKey:WEBLINK]];
        [entry setSongId:[MangedObject valueForKey:SONGID]];
        [displayedEntriesList addObject:entry];
    }
    [self.songsTableView reloadData];
    
  //  [entity release];
}



- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}





//---------------------Loading Finish ---------------------------------------//

/*
 this method called after parsing finish from Entry Parser
 */
-(void)loadingFinish
{
if(entryParserObject)
{
    if(entryParserObject.entriesArray)
    {
        for(int i=0;i<[entryParserObject.entriesArray count];i++)
        {
            [self addEntryToDataBase:[entryParserObject.entriesArray objectAtIndex:i]];
        }
    }
    [self fetchEntriesFromDataBase];
}
    
    
}


//------------------------------------------------------------//


//------------------------------------SONGS TABLE -------------------------------------------------//







-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([displayedEntriesList count]<=0)
        return 0;
        
    return [displayedEntriesList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Entry *entry=nil;
    if([displayedEntriesList count]>0)
    entry=[displayedEntriesList objectAtIndex:indexPath.row];
    else
    {
        entry=[[Entry alloc] init];
        [entry setTitle:LOADING];
    } 
    EntryTableCell *tableCell=nil;
    if (tableCell == nil) {
        tableCell = [[EntryTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELL_IDENT];
    }
    [tableCell setEntry:entry];
    return tableCell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:FALSE];
    
    if(songDetails)
    {
        songDetails=nil;
    }
    
    songDetails=[[SongDetailsViewer alloc] initWithNibName:@"SongDetailsViewer" bundle:nil];
    [songDetails setSelectedEntry:[displayedEntriesList objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:songDetails animated:YES];


}

//------------------------------------SONGS TABLE -------------------------------------------------//


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)dealloc {
    [songDetails release];
    [invoker release];
    [entryParserObject release];
    [mangedObject release];
    [mangedObjectContext release];
    [presisitenStoreCoordinator release];
    [fetchedEntryList release];
    
    [super dealloc];
}

@end
