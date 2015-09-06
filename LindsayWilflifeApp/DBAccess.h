//
//  DBAccess.h
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import "About.h"
#import "Programs.h"
#import "Note.h"


@interface DBAccess : NSObject
@property NSString *databasePath;
@property sqlite3 *database;
@property sqlite3 *notes_db;
-(NSArray *) getAniamls;
-(NSArray *) getPrograms;
-(NSArray *) getFaqs;
-(NSArray *) getAbout;
-(NSArray *) getNotes;
-(NSArray *) getNoteswithLoc;
-(NSArray *) getNotesbyTag: (NSString *)fortag;
-(NSArray *) getTags;
-(void) saveNote:(Note *)new_note;
-(void) deleteNote:(NSString *)old_note;
@end
