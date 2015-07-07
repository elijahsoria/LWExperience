//
//  LWMTag_SegVC.m
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMTag_SegVC.h"
#import "LWMMyNotesVC.h"
#import "LWMStyle.h"

@interface LWMTag_SegVC ()

@end

@implementation LWMTag_SegVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

        
    _tagTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchDisplayController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [LWMStyle setBackgroundColor:@"dark"];

   
	// Do any additional setup after loading the view.
    
}

- (void) hideKeyboard {
    [_searchBar resignFirstResponder];
}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self db_pull];
    [_tagTable reloadData];
    
}

-(void) refresh{

    [self db_pull];
    [_tagTable reloadData];
}

-(void)db_pull{
    
    DBAccess *dba = [[DBAccess alloc]init];
    _tagsArray = dba.getTags;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        if (_searchResults.count < 11) {
            return 11;
        }
        else {
            return _searchResults.count+3;
        }

        
    } else {
        if (_tagsArray.count < 11) {
            return 11;
        }
        else {
            return _tagsArray.count+3;
        }
        
    }
}

- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    static NSString *nonsimpleTableIdentifier = @"NonCell";
    
    
    
    bool isClickable = (indexPath.row < _tagsArray.count) || (_searchResults.count >= 11 && indexPath.row >= _searchResults.count && indexPath.row <_searchResults.count+3);
    
    NSString *usedCellIdentifier = isClickable ? simpleTableIdentifier : nonsimpleTableIdentifier;
    
    UITableViewCell *cell = [_tagTable dequeueReusableCellWithIdentifier: usedCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:usedCellIdentifier];
        if ((indexPath.row <_tagsArray.count) || (indexPath.row <_searchResults.count)){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        if (_searchResults.count < 11 && indexPath.row >= _searchResults.count) {
            cell.textLabel.text = @"";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        if (_searchResults.count >= 11 && indexPath.row >= _searchResults.count && indexPath.row <_searchResults.count+3) {
            cell.textLabel.text = @"";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        else if (indexPath.row <_searchResults.count){
            cell.textLabel.text = [_searchResults objectAtIndex:indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    
    else {
        if (_tagsArray.count < 11 && indexPath.row >= _tagsArray.count) {
            cell.textLabel.text = @"";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        if (_tagsArray.count >= 11 && indexPath.row >= _tagsArray.count && indexPath.row <_tagsArray.count+3) {
            cell.textLabel.text = @"";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else if (indexPath.row < _tagsArray.count){
            cell.textLabel.text = [_tagsArray objectAtIndex:indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    return cell;
    
}


- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2 == 0) {
        cell.backgroundColor = [LWMStyle setCellColor:@"light"];
        cell.textLabel.textColor = [LWMStyle setTextColor:@"dark"];
        cell.detailTextLabel.textColor = [LWMStyle setTextColor:@"dark"];
    }
    else {
        cell.backgroundColor = [LWMStyle setCellColor:@"dark"];
        cell.textLabel.textColor = [LWMStyle setTextColor:@"light"];
        cell.detailTextLabel.textColor = [LWMStyle setTextColor:@"light"];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"show_animals"]) {
        if (self.searchDisplayController.isActive) {
            NSIndexPath *indexpath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            LWMTagDetail_SegVC *detail = segue.destinationViewController;
            
            detail.tag=[_searchResults objectAtIndex:indexpath.row];
        }
        else{
            NSIndexPath *indexpath = [_tagTable indexPathForSelectedRow];
            LWMTagDetail_SegVC *detail = segue.destinationViewController;
            
            detail.tag=[_tagsArray objectAtIndex:indexpath.row];
        }
    
    }
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    _searchResults = [_tagsArray filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}




@end
