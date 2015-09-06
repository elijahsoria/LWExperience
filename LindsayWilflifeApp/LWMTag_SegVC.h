//
//  LWMTag_SegVC.h
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWMDetail_SegVC.h"
#import "LWMTagDetail_SegVC.h"
#import "LWMSpecialTableView.h"
#import "Note.h"
#import "DBAccess.h"

@interface LWMTag_SegVC : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tagTable;

@property NSArray *notesArray;

@property NSArray *tagsArray;
@property NSArray *subtagsArray;
@property NSMutableArray *searchResults;
@property (strong, nonatomic) UISearchController *searchController;
@property BOOL isSearching;

-(void)refresh;
@end
