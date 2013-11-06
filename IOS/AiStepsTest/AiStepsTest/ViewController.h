//
//  ViewController.h
//  Test
//
//  Created by youssef hanna on 9/24/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntryParser.h"
#import "EntryTableCell.h"
#import "SongDetailsViewer.h"
@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    //Entry ParsingObject
    EntryParser *entryParserObject;                     /*Parser Object used to parse Data using Xparser */
    NSManagedObjectModel *mangedObject;                 /*Manged Object used to mange entity  */
    NSManagedObjectContext *mangedObjectContext;        /*MangedContext a layer used to insert ,Fetch*/
    NSPersistentStoreCoordinator *presisitenStoreCoordinator; /*Coordinator layer used to connect MangedContect                                                with SQL Lite (DataBase)-- DataBaseConnection */
    NSFetchRequest *fetchRequest;                                   //Fetch Request 
    NSArray *fetchedEntryList;                          //FetchedData Object
    NSMutableArray *displayedEntriesList;  //Entries List filled from fetchedEntryList  
    IBOutlet UITableView *songsTableView;
    MainWebServiceInvoker *invoker;
    SongDetailsViewer *songDetails;
    
}
@property(nonatomic,retain)SongDetailsViewer *songDetails;
@property(nonatomic,retain)MainWebServiceInvoker *invoker;
@property(nonatomic,retain)NSArray *fetchedEntryList;
@property(nonatomic,retain)IBOutlet UITableView *songsTableView;
@property(nonatomic,retain)NSMutableArray *displayedEntriesList;
@property(nonatomic,retain)NSFetchRequest *fetchRequest;
@property(nonatomic,retain)NSPersistentStoreCoordinator *presisitenStoreCoordinator;
@property(nonatomic,retain)NSManagedObjectContext *mangedObjectContext;
@property(nonatomic,retain)NSManagedObjectModel *mangedObject;
@property(nonatomic,retain)EntryParser *entryParserObject;



/*------------------------METHODS----------------------------*/
- (NSString *)applicationDocumentsDirectory;

-(void)initCoreDataObjects;
-(BOOL)addEntryToDataBase:(Entry*)entry;
-(void)loadingFinish;
-(void)fetchEntriesFromDataBase;


@end
