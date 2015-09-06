//
//  LWMWildlifeTableViewController.h
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "LWMSpecialTableView.h"

<<<<<<< HEAD
@interface LWMWildlifeTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate, UISearchBarDelegate>
=======
@interface LWMWildlifeTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
>>>>>>> origin/master
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet LWMSpecialTableView *wildlifeTable;
@property NSMutableArray *wildlifeArray;
@property NSString *wildlifeTitle;
<<<<<<< HEAD
@property NSMutableArray *searchResults;
@property (strong, nonatomic) UISearchController *searchController;
@property BOOL isSearching;
=======
@property NSArray *searchResults;

>>>>>>> origin/master
@end
