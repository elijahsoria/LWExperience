//
//  LWMHabitatTableViewController.h
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWMSpecialTableView.h"

<<<<<<< HEAD
@interface LWMHabitatTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet LWMSpecialTableView *habitatTable;
@property NSMutableArray *habitatArray;
@property NSString *habitatTitle;
@property NSMutableArray *searchResults;
@property (strong, nonatomic) UISearchController *searchController;
@property BOOL isSearching;
=======
@interface LWMHabitatTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet LWMSpecialTableView *habitatTable;
@property NSArray *habitatArray;
@property NSString *habitatTitle;
@property NSArray *searchResults;

>>>>>>> origin/master
@end
