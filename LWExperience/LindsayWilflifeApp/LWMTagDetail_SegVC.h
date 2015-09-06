//
//  LWMTagDetail_SegVC.h
//  LindsayWildlifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "LWMDetail_SegVC.h"
#import "LWMSpecialTableView.h"
#import "Note.h"
#import "DBAccess.h"

@interface LWMTagDetail_SegVC : UIViewController <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *dsTable;
@property NSArray *tableNames;
@property NSArray *tableNotes;
@property NSArray *tableSubs;
@property NSString *tag;
@property NSMutableArray *notesArray;

@end
