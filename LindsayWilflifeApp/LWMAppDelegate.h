//
//  LWMAppDelegate.h
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
<<<<<<< HEAD
#import "Note.h"
#import "DBAccess.h"
=======
>>>>>>> origin/master

@interface LWMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
<<<<<<< HEAD
@property (strong, nonatomic) NSMutableArray *notesArray;


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
@property DBAccess *dba;
=======



>>>>>>> origin/master
@end
