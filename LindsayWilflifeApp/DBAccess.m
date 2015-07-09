//
//  DBAccess.m
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "DBAccess.h"
#import "Animal_Full.h"
#import "LWMStyle.h"
#import <SystemConfiguration/SystemConfiguration.h>

@implementation DBAccess

-(id) init{
    self=[super init];
    
    NSString *docsDir;
    NSArray *dirPaths;
    if (self) {
        // Get the documents directory
        dirPaths = NSSearchPathForDirectoriesInDomains(
                                                       NSDocumentDirectory, NSUserDomainMask, YES);
        
        docsDir = dirPaths[0];
        
        // Build the path to the database file
        _databasePath = [[NSString alloc]
                         initWithString: [docsDir stringByAppendingPathComponent:
                                          @"LWMNotes2.db"]];
        
        NSFileManager *filemgr = [NSFileManager defaultManager];
       
        
        if ([filemgr fileExistsAtPath: _databasePath ] == NO)
        {
            const char *dbpath = [_databasePath UTF8String];
            
            if (sqlite3_open(dbpath, &_notes_db) == SQLITE_OK)
            {
                char *errMsg;
                const char *sql_stmt =
                "CREATE TABLE IF NOT EXISTS Notes_Table (key text primary key, date text, imgReference text, latitude text, longitude text, location text, name text, note text, tags text, thum text)";
                
                
                
                if (sqlite3_exec(_notes_db, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
                {
                    NSLog(@"Failed to create table");
                }
                sqlite3_close(_notes_db);
            } else {
                NSLog(@"Failed to open/create database");
            }
        }
    }
    
    return self;
}

-(NSArray *) getAniamls
{
    sqlite3 *database;
    NSURL *dbPath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Animals" ofType:@"sqlite3"]];
    
    sqlite3_open([[dbPath absoluteString] UTF8String], &database);
    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    NSString *sql = @"SELECT common_Name, scientific_Name, animal_group, subgroup, habitat, taxonomical_order, key_characteristics, encounters, image FROM animal_entities";
    sqlite3_stmt *statement;
    
    int sqlResult = sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL);
    
    if(sqlResult == SQLITE_OK)
    {
        while(sqlite3_step(statement) == SQLITE_ROW)
        {
            Animal_Full *a = [[Animal_Full alloc]init];
            [a setCommonName: [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)]];
            [a setScientificName:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 1)]];
            [a setAnimalType:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 2)]];
            [a setAnimalSubType:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 3)]];
            [a setHabitatType:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 4)]];
            [a setTaxOrder: [[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 5)] intValue]];
            [a setFullDiscription:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 6)]];
            [a setAnimalSos:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 7)]];
            [a setLargeImagePath:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 8)]];
            [a setSmallImagePath:[NSString stringWithFormat:@"tm%@", a.largeImagePath]];
            [result addObject:a];
        }
    }
    
    else
    {
        result = nil;
        NSLog(@"could not prepare statement: %s", sqlite3_errmsg(database));
    }
    
    sqlite3_reset(statement);
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    return result;
    
}

-(NSArray *) getAbout
{
    sqlite3 *database;
    NSURL *dbPath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Animals" ofType:@"sqlite3"]];
    
    sqlite3_open([[dbPath absoluteString] UTF8String], &database);
    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    NSString *sql = @"SELECT aboutText FROM information";
    sqlite3_stmt *statement;
    
    int sqlResult = sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL);
    
    if(sqlResult == SQLITE_OK)
    {
        while(sqlite3_step(statement) == SQLITE_ROW)
        {
            About *i = [[About alloc] init];
            
            NSString *answer = [[NSString alloc] initWithString:[[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)] stringByReplacingOccurrencesOfString: @"\\n" withString: @"\n"]];
            
            [i setInfo:answer];
            
            [result addObject:i];
        }
        
        
    }
    else
    {
        result = nil;
        NSLog(@"could not prepare statement: %s", sqlite3_errmsg(database));
    }
    
    sqlite3_reset(statement);
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    return result;
}

-(NSArray *) getFaqs
{
    sqlite3 *database;
    NSURL *dbPath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Animals" ofType:@"sqlite3"]];
    
    sqlite3_open([[dbPath absoluteString] UTF8String], &database);
    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    NSString *sql = @"SELECT questions, answers FROM questionAndAnswers";
    sqlite3_stmt *statement;
    
    int sqlResult = sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL);
    
    if(sqlResult == SQLITE_OK)
    {
        NSMutableAttributedString *fullText = [[NSMutableAttributedString alloc] init];
        while(sqlite3_step(statement) == SQLITE_ROW)
        {
            NSString *question = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)];
            NSMutableString *answer = [NSMutableString stringWithUTF8String:(char *) sqlite3_column_text(statement, 1)];
            answer = [[NSMutableString alloc] initWithString:[answer stringByReplacingOccurrencesOfString: @"\\n" withString: @"\n"]];
            
            const CGFloat fontSize = 17;
            UIFont *boldFont = [UIFont boldSystemFontOfSize:fontSize];
            
            
            // Create the attributes
            NSDictionary *boldAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                    boldFont, NSFontAttributeName,
                                    [LWMStyle setTextColor:@"dark"], NSForegroundColorAttributeName, nil];
            NSDictionary *subAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [LWMStyle setFont:@"description"], NSFontAttributeName,
                                      [LWMStyle setTextColor:@"dark"], NSForegroundColorAttributeName, nil];
            
            const NSRange q_range = NSMakeRange(0, 9);
            
            NSMutableAttributedString *attrQuestion =
            [[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"QUESTION:\n%@\n\n", question]
                                                   attributes:subAttrs];
            [attrQuestion setAttributes:boldAttrs range:q_range];
            
            const NSRange a_range = NSMakeRange(0,7);

            NSMutableAttributedString *attrAnswer =
            [[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"ANSWER:\n%@\n\n", answer]
                                                   attributes:subAttrs];
            [attrAnswer setAttributes:boldAttrs range:a_range];
            
            
            
            [fullText appendAttributedString:attrQuestion];
            [fullText appendAttributedString:attrAnswer];
        }
        About *q = [[About alloc] init];
        [q setFaq:fullText];
        [result addObject:q];
    }
    else
    {
        result = nil;
        NSLog(@"could not prepare statement: %s", sqlite3_errmsg(database));
    }
    
    sqlite3_reset(statement);
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    return result;
}


-(NSArray *) getPrograms
{
    sqlite3 *database;
    NSURL *dbPath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Animals" ofType:@"sqlite3"]];
    
    sqlite3_open([[dbPath absoluteString] UTF8String], &database);
    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    NSString *sql = @"SELECT title, description, url, image_path FROM programs";
    sqlite3_stmt *statement;
    
    int sqlResult = sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL);
    
    if(sqlResult == SQLITE_OK)
    {
        while(sqlite3_step(statement) == SQLITE_ROW)
        {
            Programs *p = [[Programs alloc] init];
            [p setTitle:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)]];
            NSString *answer = [[NSString alloc] initWithString:[[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 1)] stringByReplacingOccurrencesOfString: @"\\n" withString: @"\n"]];
            NSLog(@"%@", answer);
            [p setDescr:answer];
            [p setUrl:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 2)]];
            [p setImage_path:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 3)]];
            
            [result addObject:p];
        }
    }
    else
    {
        result = nil;
        NSLog(@"could not prepare statement: %s", sqlite3_errmsg(database));
    }
    
    sqlite3_reset(statement);
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    return result;
}

-(NSArray *) getTags
{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    if (sqlite3_open([_databasePath UTF8String], &_notes_db) == SQLITE_OK)
    {
        NSString *sql = @"SELECT tags FROM Notes_Table";
        sqlite3_stmt *statement;
        
        int sqlResult = sqlite3_prepare_v2(_notes_db, [sql UTF8String], -1, &statement, NULL);
        
        if(sqlResult == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                if (![[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)] isEqualToString:@""]) {
                    NSArray *tags=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)] componentsSeparatedByString:@", "];
                    [result addObjectsFromArray:tags];
                    result=[NSMutableArray arrayWithArray:[[NSSet setWithArray:result] allObjects]];
                }
               
                
            }
        }
        else
        {
            result = nil;
            NSLog(@"Can't get: %s", sqlite3_errmsg(_notes_db));
        }
        
        
        sqlite3_finalize(statement);
        sqlite3_close(_notes_db);
        
    }
    
    return result;
    
}

-(NSArray *) getNotesbyTag:(NSString *)fortag{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    if (sqlite3_open([_databasePath UTF8String], &_notes_db) == SQLITE_OK)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Notes_Table WHERE tags LIKE '%%%@%%'", fortag];

        sqlite3_stmt *statement;
        
        int sqlResult = sqlite3_prepare_v2(_notes_db, [sql UTF8String], -1, &statement, NULL);
        
        if(sqlResult == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                
                Note *p = [[Note alloc] init];
                
                [p setKey:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)]];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 1)] doubleValue]];
                [p setDate:date];
                [p setImgReference:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 2)]];
                [p setLatitude:[[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 3)] doubleValue]];
                [p setLongitude:[[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 4)] doubleValue]];
                [p setLocation:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 5)]];
                [p setName:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 6)]];
                [p setNote:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 7)]];
                [p setTags:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 8)]];
                [p setThum_path:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 9)]];
                [result addObject:p];
                
            }
        }
        else
        {
            result = nil;

        }

        sqlite3_finalize(statement);
        sqlite3_close(_notes_db);
        
    }

    
    return result;
}


-(NSArray *) getNotes
{

    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    if (sqlite3_open([_databasePath UTF8String], &_notes_db) == SQLITE_OK)
    {
        NSString *sql = @"SELECT key, date, imgReference, latitude, longitude, location, name, note, tags, thum FROM Notes_Table";
        sqlite3_stmt *statement;
        
        int sqlResult = sqlite3_prepare_v2(_notes_db, [sql UTF8String], -1, &statement, NULL);
        
        if(sqlResult == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {

                Note *p = [[Note alloc] init];
                
                [p setKey:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)]];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 1)] doubleValue]];

                [p setDate:date];
                [p setImgReference:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 2)]];
                [p setLatitude:[[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 3)] doubleValue]];
                [p setLongitude:[[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 4)] doubleValue]];
                [p setLocation:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 5)]];
                [p setName:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 6)]];
                [p setNote:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 7)]];
                [p setTags:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 8)]];
                [p setThum_path:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 9)]];
                [result addObject:p];
               
            }
        }
        else
        {
            result = nil;
            NSLog(@"Can't get: %s", sqlite3_errmsg(_notes_db));
        }
        
        
        sqlite3_finalize(statement);
        sqlite3_close(_notes_db);
        
    }
    return result;
    
}

-(NSArray *) getNoteswithLoc
{

    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    if (sqlite3_open([_databasePath UTF8String], &_notes_db) == SQLITE_OK)
    {
        NSString *sql = @"SELECT key, date, imgReference, latitude, longitude, location, name, note, tags, thum FROM Notes_Table";
        sqlite3_stmt *statement;
        
        int sqlResult = sqlite3_prepare_v2(_notes_db, [sql UTF8String], -1, &statement, NULL);
        
        if(sqlResult == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                if (![[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 5)] hasPrefix:@"Unknown"] && ![[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 5)] hasSuffix:@"Unknown"]) {
                    Note *p = [[Note alloc] init];
                    
                    [p setKey:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)]];
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 1)] doubleValue]];
                    [p setDate:date];
                    [p setImgReference:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 2)]];
                    [p setLatitude:[[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 3)] doubleValue]];
                    [p setLongitude:[[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 4)] doubleValue]];
                    [p setLocation:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 5)]];
                    [p setName:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 6)]];
                    [p setNote:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 7)]];
                    [p setTags:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 8)]];
                    [p setThum_path:[NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 9)]];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"MM-dd-yyyy"];
                    
                    
                    NSDictionary *note_loc = [NSDictionary dictionaryWithObjectsAndKeys:
                                              p, @"note",
                                              p.name, @"name",
                                              [formatter stringFromDate:p.date], @"date",
                                              p.location, @"location",
                                              [[CLLocation alloc] initWithLatitude:p.latitude longitude:p.longitude], @"loc",
                                              nil];
                    [result addObject:note_loc];
                   
                }
                
                
            }
        }
        else
        {
            result = nil;

        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_notes_db);
        
    }

    return result;
    
}


-(void)saveNote:(Note *)new_note{


    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    int date_stamp = [new_note.date timeIntervalSince1970];

    
    if (sqlite3_open(dbpath, &_notes_db) == SQLITE_OK)
    {
        
        new_note.note=[new_note.note stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
        new_note.name=[new_note.name stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
        
        NSString *insertSQL = [NSString stringWithFormat:@"insert into Notes_Table (key, date, imgReference, latitude, longitude, location, name, note, tags, thum) values ('%@', '%d', '%@', '%f', '%f', '%@', '%@', '%@', '%@', '%@')", new_note.key, date_stamp, new_note.imgReference, new_note.latitude, new_note.longitude, new_note.location, new_note.name, new_note.note, new_note.tags, new_note.thum_path];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_notes_db, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"Saved");
            
        } else {
            NSLog(@"Failed to add");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_notes_db);
    }
    
}

-(void)deleteNote:(NSString *)old_note{
    
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_notes_db) == SQLITE_OK)
    {
        
       NSString *deleteStatements = [NSString stringWithFormat: @"DELETE FROM \"Notes_Table\" WHERE key='%@'", old_note];
        
        const char *del_stmt= [deleteStatements UTF8String];
        sqlite3_prepare_v2(_notes_db, del_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"Deleted");
            
        } else {
            NSLog(@"Failed to delete");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_notes_db);
    }
}
 

@end
