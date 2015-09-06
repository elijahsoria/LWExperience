//
//  LWMAppDelegate.m
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMAppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "Note.h"


@implementation LWMAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //[self initializeStoryBoardBasedOnScreenSize];
    
    
    // Override point for customization after application launch.
    
    
    
    //UIColor *myColor = [UIColor colorWithRed:(224.0/255.0) green:(224.0/255.0) blue:(224.0/255.0) alpha:1];
    
    UIColor *myColor = [UIColor colorWithRed:(251.0/255.0) green:(255.0/255.0) blue:(210.0/255.0) alpha:1];
    [[UINavigationBar appearance] setTintColor:myColor];
    //UIColor *selectColor = [UIColor colorWithRed:(255.0/255.0) green:(255.0/255.0) blue:(255.0/255.0) alpha:1];
    [[UINavigationBar appearance] setTintColor:myColor];
    UIColor *textColor = [UIColor colorWithRed:(251.0/255.0) green:(255.0/255.0) blue:(210.0/255.0) alpha:1];
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      textColor,
      NSForegroundColorAttributeName,
      [UIColor whiteColor],
      NSForegroundColorAttributeName,
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
      NSForegroundColorAttributeName,
      [UIFont fontWithName:@"Helvetica Neue" size:0.0],
      NSFontAttributeName,
      nil]];
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [[UITabBar appearance] setTintColor:myColor];
    //[[UITabBar appearance] setTintColor:selectColor];
    
    [[UIToolbar appearance] setTintColor:[UIColor blackColor]];
    [[UIToolbar appearance] setBarStyle:UIBarStyleDefault];
    
    UITabBarController *tabBarController = (UITabBarController *) self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    tabBar.translucent = NO;
    
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    UITabBarItem *tabBarItem5 = [tabBar.items objectAtIndex:4];
    
    /*tabBarItem1.title = @"HOME";
    tabBarItem2.title = @"MY NOTES";
    tabBarItem3.title = @"PICTURE";
    tabBarItem4.title = @"WILDLIFE";
    tabBarItem5.title = @"LINDSAY";*/
    tabBarItem1.selectedImage = [[UIImage imageNamed:@"House.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem1.image = [[UIImage imageNamed:@"House2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem2.selectedImage = [[UIImage imageNamed:@"Notepad.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem2.image = [[UIImage imageNamed:@"Notepad2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem3.selectedImage = [[UIImage imageNamed:@"Camera.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem3.image = [[UIImage imageNamed:@"Camera2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem4.selectedImage = [[UIImage imageNamed:@"Paw.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem4.image = [[UIImage imageNamed:@"Paw2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem5.image = [[UIImage imageNamed:@"lwm logo grey.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem5.selectedImage = [[UIImage imageNamed:@"lwm logo dark2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    _dba = [[DBAccess alloc]init];
   
   /*_model = [NSManagedObjectModel mergedModelFromBundles:[NSBundle allBundles]];
   _psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
   
   _url = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"Database.sqlite"];
   
   NSDictionary *options = @{NSPersistentStoreFileProtectionKey: NSFileProtectionComplete,
                             NSMigratePersistentStoresAutomaticallyOption:@YES};
   NSError *error = nil;
   
   NSPersistentStore *store = [_psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:_url options:options error:&error];
   if (!store)
   {
      NSLog(@"Error adding persistent store. Error %@",error);
      
      NSError *deleteError = nil;
      if ([[NSFileManager defaultManager] removeItemAtURL:_url error:&deleteError])
      {
         error = nil;
         store = [_psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:_url options:options error:&error];
      }
      
      if (!store)
      {
         // Also inform the user...
         NSLog(@"Failed to create persistent store. Error %@. Delete error %@",error,deleteError);
         abort();
      }
   }

   
   _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
   _managedObjectContext.persistentStoreCoordinator = _psc;*/
   //_model = [self managedObjectModel];
   //_psc = [self persistentStoreCoordinator];
   //_managedObjectContext = [self managedObjectContext];
   
   
   
    // fetch
   [self db_pull];
   if ([_notesArray count] == 0) {
      NSError *error = nil;
      
      NSManagedObjectContext *context = self.managedObjectContext;
      NSFetchRequest *fetchAllObjects = [[NSFetchRequest alloc] init];
      [fetchAllObjects setEntity:[NSEntityDescription entityForName:@"NoteClass" inManagedObjectContext:context]];
      [fetchAllObjects setIncludesPropertyValues:YES]; //only fetch the managedObjectID
      
      NSArray *allObjects = [context executeFetchRequest:fetchAllObjects error:&error];
      
      [self db_clear];
      // uncomment next line if you're NOT using ARC
      // [allObjects release];
      
      
      Note *note = [[Note alloc]init];
      
      for (NSManagedObject *object in allObjects) {
         note.key = [object valueForKey:@"key"];
         note.date = [object valueForKey:@"date"];
         note.imgReference = [object valueForKey:@"imageReference"];
         note.longitude = [[object valueForKey:@"longitude"] doubleValue];
         note.latitude = [[object valueForKey:@"latitude"] doubleValue];
         note.location = [object valueForKey:@"location"];
         note.name = [object valueForKey:@"name"];
         note.note = [object valueForKey:@"note"];
         note.tags = [object valueForKey:@"tags"];
         note.thum_path = [object valueForKey:@"thum_path"];
         [_dba saveNote:note];
      }
   }
   
    
    
    /*NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"FailedBankInfo" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchedObjects) {
        NSLog(@"Name: %@", [info valueForKey:@"name"]);
        NSManagedObject *details = [info valueForKey:@"details"];
        NSLog(@"Zip: %@", [details valueForKey:@"zip"]);
    }*/
    
    return YES;
}

- (void)saveContext
{
   NSError *error = nil;
   NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
   if (managedObjectContext != nil) {
      if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
         // Replace this implementation with code to handle the error appropriately.
         // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
         abort();
      }
   }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
   if (_managedObjectContext != nil) {
      return _managedObjectContext;
   }
   
   NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
   if (coordinator != nil) {
      _managedObjectContext = [[NSManagedObjectContext alloc] init];
      [_managedObjectContext setPersistentStoreCoordinator:coordinator];
   }
   return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
   if (_managedObjectModel != nil) {
      return _managedObjectModel;
   }
   NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LindsayWildlife" withExtension:@"momd"];
   _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
   return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
   if (_persistentStoreCoordinator != nil) {
      return _persistentStoreCoordinator;
   }
   
   NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LindsayWildlife.sqlite"];
   
   NSError *error = nil;
   _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
   if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
      /*
       Replace this implementation with code to handle the error appropriately.
       
       abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
       
       Typical reasons for an error here include:
       * The persistent store is not accessible;
       * The schema for the persistent store is incompatible with current managed object model.
       Check the error message to determine what the actual problem was.
       
       
       If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
       
       If you encounter schema incompatibility errors during development, you can reduce their frequency by:
       * Simply deleting the existing store:
       [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
       
       * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
       @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
       
       Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
       
       */
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
   }
   
   return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
   return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(void) db_clear{
    for (Note *note in _notesArray){
        [_dba deleteNote:note.key];
    }
}

/*-(void)initializeStoryBoardBasedOnScreenSize {
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {    // The iOS device = iPhone or iPod Touch
        
        
        CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        
        if (iOSDeviceScreenSize.height == 480)
        {   // iPhone 3GS, 4, and 4S and iPod Touch 3rd and 4th generation: 3.5 inch screen (diagonally measured)
            
            // Instantiate a new storyboard object using the storyboard file named Storyboard_iPhone35
            UIStoryboard *iPhone35Storyboard = [UIStoryboard storyboardWithName:@"Alt4S" bundle:nil];
            
            // Instantiate the initial view controller object from the storyboard
            UIViewController *initialViewController = [iPhone35Storyboard instantiateInitialViewController];
            
            // Instantiate a UIWindow object and initialize it with the screen size of the iOS device
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            
            // Set the initial view controller to be the root view controller of the window object
            self.window.rootViewController  = initialViewController;
            
            // Set the window object to be the key window and show it
            [self.window makeKeyAndVisible];
        }
        
        if (iOSDeviceScreenSize.height == 568)
        {   // iPhone 5 and iPod Touch 5th generation: 4 inch screen (diagonally measured)
            
            // Instantiate a new storyboard object using the storyboard file named Storyboard_iPhone4
            UIStoryboard *iPhone4Storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            // Instantiate the initial view controller object from the storyboard
            UIViewController *initialViewController = [iPhone4Storyboard instantiateInitialViewController];
            
            // Instantiate a UIWindow object and initialize it with the screen size of the iOS device
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            
            // Set the initial view controller to be the root view controller of the window object
            self.window.rootViewController  = initialViewController;
            
            // Set the window object to be the key window and show it
            [self.window makeKeyAndVisible];
        }
        
    } else if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
        
    {   // The iOS device = iPad
        
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
        
    }
}*/
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
   [self clearEntity:@"NoteClass"];
   [self db_pull];
   
   // insert
   NSManagedObjectContext *context = self.managedObjectContext;
   
   for (Note *note in self.notesArray)
   {
      NSManagedObject *fieldNote = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"NoteClass"
                                    inManagedObjectContext:context];
      [fieldNote setValue:note.date forKey:@"date"];
      [fieldNote setValue:note.imgReference forKey:@"imageReference"];
      [fieldNote setValue:note.key forKey:@"key"];
      [fieldNote setValue:[NSNumber numberWithDouble:note.latitude] forKey:@"latitude"];
      [fieldNote setValue:note.location forKey:@"location"];
      [fieldNote setValue:[NSNumber numberWithDouble:note.longitude]  forKey:@"longitude"];
      [fieldNote setValue:note.name forKey:@"name"];
      [fieldNote setValue:note.note forKey:@"note"];
      [fieldNote setValue:note.tags forKey:@"tags"];
      [fieldNote setValue:note.thum_path forKey:@"thum_path"];
      [self saveContext];
   }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self clearEntity:@"NoteClass"];
    [self db_pull];
    
    // insert
    NSManagedObjectContext *context = self.managedObjectContext;
    
    for (Note *note in self.notesArray)
    {
        NSManagedObject *fieldNote = [NSEntityDescription
                                     insertNewObjectForEntityForName:@"NoteClass"
                                     inManagedObjectContext:context];
        [fieldNote setValue:note.date forKey:@"date"];
        [fieldNote setValue:note.imgReference forKey:@"imageReference"];
        [fieldNote setValue:note.key forKey:@"key"];
        [fieldNote setValue:[NSNumber numberWithDouble:note.latitude] forKey:@"latitude"];
        [fieldNote setValue:note.location forKey:@"location"];
        [fieldNote setValue:[NSNumber numberWithDouble:note.longitude]  forKey:@"longitude"];
        [fieldNote setValue:note.name forKey:@"name"];
        [fieldNote setValue:note.note forKey:@"note"];
        [fieldNote setValue:note.tags forKey:@"tags"];
        [fieldNote setValue:note.thum_path forKey:@"thum_path"];
        [self saveContext];
    }
}

-(void)db_pull{
    _notesArray = [[NSMutableArray alloc] initWithArray:[_dba getNotes]];
    
}

- (BOOL)clearEntity:(NSString *)entity
{
    NSManagedObjectContext *context = self.managedObjectContext;
    NSFetchRequest *fetchAllObjects = [[NSFetchRequest alloc] init];
    [fetchAllObjects setEntity:[NSEntityDescription entityForName:entity inManagedObjectContext:context]];
    [fetchAllObjects setIncludesPropertyValues:NO]; //only fetch the managedObjectID

    NSError *error = nil;
    NSArray *allObjects = [context executeFetchRequest:fetchAllObjects error:&error];
// uncomment next line if you're NOT using ARC
// [allObjects release];
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

    for (NSManagedObject *object in allObjects) {
        [context deleteObject:object];
    }

    NSError *saveError = nil;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

    return (saveError == nil);
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    // You can add your app-specific url handling code here if needed
    
    return wasHandled;
}

@end
