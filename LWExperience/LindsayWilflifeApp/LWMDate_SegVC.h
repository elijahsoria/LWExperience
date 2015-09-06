//
//  LWMDate_SegVC.h
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWMDetail_SegVC.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "LWMSpecialTableView.h"
#import "DBAccess.h"

@interface LWMDate_SegVC : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *dateTable;

@property NSArray *arrayTitles;
@property NSArray *arraySubtitles;
@property NSArray *arrayDates;
@property NSArray *arrayLocations;
@property NSArray *arrayTags;
@property NSArray *arrayNotes;
@property (strong, nonatomic) NSMutableArray *notesArray;
@property BOOL table_editing;
@end
