//
//  LWMHabitatTableViewController.m
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMHabitatTableViewController.h"
#import "LWMWildlifeDetailViewController.h"
#import "Animal_Full.h"
#import "LWMStyle.h"


@interface LWMHabitatTableViewController ()

@end

@implementation LWMHabitatTableViewController

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
	// Do any additional setup after loading the view.
    
    self.title = _habitatTitle;
    
    self.habitatTable.backgroundView = nil;
    
    self.habitatTable.backgroundColor = [LWMStyle setBackgroundColor:@"dark"];
    
    self.habitatTable.separatorColor = [UIColor clearColor];
    
    self.searchResults = [[NSMutableArray alloc] init];
    
    self.isSearching = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Search Bar

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.isSearching = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //NSLog(@"Text change - %d", self.isSearching);
    
    //Remove all objects first.
    [self.searchResults removeAllObjects];
    
    if([searchText length] != 0) {
        self.isSearching = YES;
        [self filterContentForSearchText:searchText];
    }
    else {
        self.isSearching = NO;
    }
    // [self.tblContentList reloadData];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    // NSLog(@"Cancel clicked");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //NSLog(@"Search Clicked");
    [self filterContentForSearchText:self.searchBar.text];
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isSearching) {
        return 1;
    }
    else{
        return _habitatArray.count;
    }
    
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *object = [_habitatArray objectAtIndex:section];
    NSArray *myarray = [object objectForKey:@"subgroupobjects"];
    
    
    if (self.isSearching) {
        if(_searchResults.count < 7){
            return 7;
        }
        
        else{
            return _searchResults.count+2;
        }
    }
    else{
        if (_habitatArray.count==1 && myarray.count<7) {
            return 7;
        }
        else{
            if(section < _habitatArray.count-1)
                return myarray.count;
            else
                return myarray.count+2;
        }
    }
    
    
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    static NSString *nonsimpleTableIdentifier = @"NonCell";
    
    if (self.isSearching)
    {
        BOOL isClickable = (indexPath.row <_searchResults.count);
        
        NSString *usedCellIdentifier = isClickable ? simpleTableIdentifier : nonsimpleTableIdentifier;
        
        UITableViewCell *cell = [_habitatTable dequeueReusableCellWithIdentifier: usedCellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:usedCellIdentifier];
            if (indexPath.row <_searchResults.count){
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }

        if (indexPath.row < _searchResults.count) {
            for (NSMutableDictionary *group in _habitatArray){
                for (Animal_Full *animal in [group objectForKey:@"subgroupobjects"]) {
                    if ([animal.commonName isEqualToString:[_searchResults objectAtIndex:indexPath.row]])
                    {
                        
                        
                        UIFont* font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
                        
                        NSDictionary *attrs = @{
                                                NSFontAttributeName : font};
                        
                        NSAttributedString* attrString = [[NSAttributedString alloc]
                                                          initWithString:animal.commonName
                                                          attributes:attrs];
                        
                        cell.textLabel.attributedText = attrString;
                        
                        
                        
                        const CGFloat fontSize = 12;
                        UIFont *boldFont = [UIFont boldSystemFontOfSize:fontSize];
                        UIFont *regularFont = [UIFont systemFontOfSize:fontSize];
                        UIColor *foregroundColor = [UIColor whiteColor];
                        
                        // Create the attributes
                        NSDictionary *attrs2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                                boldFont, NSFontAttributeName,
                                                foregroundColor, NSForegroundColorAttributeName, nil];
                        NSDictionary *subAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                                  regularFont, NSFontAttributeName, nil];
                        const NSRange range = NSMakeRange(0,11);
                        

                        NSMutableAttributedString *attributedText =
                        [[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"Animal Type: %@", animal.animalType]
                                                               attributes:subAttrs];
                        [attributedText setAttributes:attrs2 range:range];
                        
                        
                        cell.detailTextLabel.attributedText=attributedText;
                        

                        cell.imageView.image = [UIImage imageNamed:animal.smallImagePath];
                        
                        
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        break;
                    }
                }
                
                
            }
            
            
        }
        else {
            cell.textLabel.text = @"";

            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.userInteractionEnabled = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
        
        
        
    }
    else{
        NSArray *animalsubgroup = [[_habitatArray objectAtIndex:indexPath.section] objectForKey:@"subgroupobjects"];
        
        BOOL isClickable = (indexPath.row <animalsubgroup.count);
        
        NSString *usedCellIdentifier = isClickable ? simpleTableIdentifier : nonsimpleTableIdentifier;
        
        UITableViewCell *cell = [_habitatTable dequeueReusableCellWithIdentifier: usedCellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:usedCellIdentifier];
            if (indexPath.row <animalsubgroup.count){
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
        
        if(animalsubgroup.count < 7 && indexPath.row >= animalsubgroup.count)
        {
            cell.textLabel.text = @"";
            cell.detailTextLabel.text = @"";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = NO;
            cell.imageView.image = nil;
        }
        
        if(animalsubgroup.count >= 7 && indexPath.row >= animalsubgroup.count && indexPath.row < animalsubgroup.count+2)
        {
            cell.textLabel.text = @"";
            cell.detailTextLabel.text = @"";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = NO;
            cell.imageView.image = nil;
        }
        else if (indexPath.row < animalsubgroup.count)
        {
            
            Animal_Full *animal = [animalsubgroup objectAtIndex:indexPath.row];
            
            UIFont* font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
            
            NSDictionary *attrs = @{
                                    NSFontAttributeName : font};
            
            NSAttributedString* attrString = [[NSAttributedString alloc]
                                              initWithString:animal.commonName
                                              attributes:attrs];
            
            cell.textLabel.attributedText = attrString;
            
            
            
            const CGFloat fontSize = 12;
            UIFont *boldFont = [UIFont boldSystemFontOfSize:fontSize];
            UIFont *regularFont = [UIFont systemFontOfSize:fontSize];
            UIColor *foregroundColor = [UIColor whiteColor];
            
            // Create the attributes
            NSDictionary *attrs2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                    boldFont, NSFontAttributeName,
                                    foregroundColor, NSForegroundColorAttributeName, nil];
            NSDictionary *subAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                      regularFont, NSFontAttributeName, nil];
            const NSRange range = NSMakeRange(0,11);
            NSMutableAttributedString *attributedText =
            [[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"Animal Type: %@", animal.animalType]
                                                   attributes:subAttrs];
            [attributedText setAttributes:attrs2 range:range];
            
            
            cell.detailTextLabel.attributedText=attributedText;
            
            cell.imageView.image = [UIImage imageNamed:animal.smallImagePath];
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row %2 == 0)
    {
        cell.backgroundColor = [LWMStyle setCellColor:@"light"];
        cell.textLabel.textColor = [LWMStyle setTextColor:@"dark"];
        cell.detailTextLabel.textColor = [LWMStyle setTextColor:@"dark"];
    }
    
    if (indexPath.row % 2 == 1)
    {
        cell.backgroundColor = [LWMStyle setCellColor:@"dark"];
        cell.textLabel.textColor = [LWMStyle setTextColor:@"light"];
        cell.detailTextLabel.textColor = [LWMStyle setTextColor:@"light"];
    }
}



-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"habitatDetailSegue"])
    {
        
        LWMWildlifeDetailViewController *detail = segue.destinationViewController;
        
        /*if (self.searchDisplayController.isActive) {
            NSIndexPath *indexpath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            for (NSMutableDictionary *group in _habitatArray)
            {
                for (Animal_Full *animal in [group objectForKey:@"subgroupobjects"]){
                    if ([animal.commonName isEqualToString:[_searchResults objectAtIndex:indexpath.row]]) {
                        const CGFloat fontSize = 17;
                        UIFont *boldFont = [UIFont boldSystemFontOfSize:fontSize];
                        UIFont *italFont = [UIFont italicSystemFontOfSize:fontSize];

                        NSDictionary *attrs2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                                boldFont, NSFontAttributeName,
                                                [LWMStyle setTextColor:@"dark"], NSForegroundColorAttributeName, nil];
                        NSDictionary *subAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                                  [LWMStyle setFont:@"description"], NSFontAttributeName,
                                                  [LWMStyle setTextColor:@"dark"], NSForegroundColorAttributeName, nil];
                        NSDictionary *itAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                                 italFont, NSFontAttributeName,
                                                 [LWMStyle setTextColor:@"dark"], NSForegroundColorAttributeName, nil];
                        const NSRange range = NSMakeRange(0,4);
                        
                        // Create the attributed string (text + attributes)
                        NSMutableAttributedString *attributedText =
                        [[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@" %@ ", animal.commonName]
                                                               attributes:attrs2];
                        [attributedText setAttributes:attrs2 range:range];
                        
                        detail.detailName = attributedText;
                        
                        
                        const NSRange sci_range = NSMakeRange(0,16);
                        // Create the attributed string (text + attributes)
                        NSMutableAttributedString *sci_name =
                        [[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"Scientific Name:\n%@\n\n", animal.scientificName]
                                                               attributes:itAttrs];
                        [sci_name setAttributes:attrs2 range:sci_range];
                        
                        const NSRange hab_range = NSMakeRange(0,8);
                        // Create the attributed string (text + attributes)
                        NSMutableAttributedString *habitat =
                        [[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"Habitat: %@\n\n", animal.habitatType]
                                                               attributes:subAttrs];
                        [habitat setAttributes:attrs2 range:hab_range];
                        
                        const NSRange name_range = NSMakeRange(0,5);
                        // Create the attributed string (text + attributes)
                        NSMutableAttributedString *common_name =
                        [[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"Name: %@, ", animal.commonName]
                                                               attributes:subAttrs];
                        [common_name setAttributes:attrs2 range:name_range];
                        
                        detail.lab1 = common_name;
                        detail.lab2 = habitat;
                        
                        // Create the attributed string (text + attributes)
                        NSMutableAttributedString *key =
                        [[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"Key Characteristics:\n"]
                                                               attributes:attrs2];
                        
                        NSMutableDictionary *attributes = [[NSMutableDictionary alloc]init];
                        
                        NSMutableParagraphStyle *hyphenation = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
                        [hyphenation setHyphenationFactor:31.0];
                        attributes[NSParagraphStyleAttributeName] = hyphenation;

                        
                        attributes[NSFontAttributeName] = [LWMStyle setFont:@"description"];
                        attributes[NSForegroundColorAttributeName] = [LWMStyle setTextColor:@"dark"];

                        
                        [key appendAttributedString:[[NSAttributedString alloc] initWithString:animal.fullDiscription attributes:attributes]];
                        
                        [sci_name appendAttributedString:habitat];
                        [sci_name appendAttributedString:key];

                        
                        detail.detailDescription = sci_name;
                        detail.detailPicture = animal.largeImagePath;
                        detail.detailHelp = animal.animalSos;
                        break;
                    }
                }
            }
        }*/
        //else{
            NSIndexPath *idexPath = [_habitatTable indexPathForSelectedRow];
            Animal_Full *animal = [[[_habitatArray objectAtIndex:idexPath.section] objectForKey:@"subgroupobjects"] objectAtIndex:idexPath.row];
            
            const CGFloat fontSize = 17;
            UIFont *boldFont = [UIFont boldSystemFontOfSize:fontSize];
            UIFont *italFont = [UIFont italicSystemFontOfSize:fontSize];

            
            // Create the attributes
            NSDictionary *attrs2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                    boldFont, NSFontAttributeName,
                                    [LWMStyle setTextColor:@"dark"], NSForegroundColorAttributeName, nil];
            NSDictionary *subAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [LWMStyle setFont:@"description"], NSFontAttributeName,
                                      [LWMStyle setTextColor:@"dark"], NSForegroundColorAttributeName, nil];
            NSDictionary *itAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                     italFont, NSFontAttributeName,
                                     [LWMStyle setTextColor:@"dark"], NSForegroundColorAttributeName, nil];
            const NSRange range = NSMakeRange(0,4);
            
            // Create the attributed string (text + attributes)
            NSMutableAttributedString *attributedText =
            [[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@" %@ ", animal.commonName]
                                                   attributes:attrs2];
            [attributedText setAttributes:attrs2 range:range];
            
            detail.detailName = attributedText;
            
            
            const NSRange sci_range = NSMakeRange(0,16);
            // Create the attributed string (text + attributes)
            NSMutableAttributedString *sci_name =
            [[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"Scientific Name:\n%@\n\n", animal.scientificName]
                                                   attributes:itAttrs];
            [sci_name setAttributes:attrs2 range:sci_range];
            
            const NSRange hab_range = NSMakeRange(0,8);
            // Create the attributed string (text + attributes)
            NSMutableAttributedString *habitat =
            [[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"Habitat: %@\n\n", animal.habitatType]
                                                   attributes:subAttrs];
            [habitat setAttributes:attrs2 range:hab_range];
            
            const NSRange name_range = NSMakeRange(0,5);
            // Create the attributed string (text + attributes)
            NSMutableAttributedString *common_name =
            [[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"Name: %@, ", animal.commonName]
                                                   attributes:subAttrs];
            [common_name setAttributes:attrs2 range:name_range];
            
            
            detail.lab1 = common_name;
            detail.lab2 = habitat;
            
            // Create the attributed string (text + attributes)
            NSMutableAttributedString *key =
            [[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"Key Characteristics:\n"]
                                                   attributes:attrs2];
            
            NSMutableDictionary *attributes = [[NSMutableDictionary alloc]init];
            
            NSMutableParagraphStyle *hyphenation = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            [hyphenation setHyphenationFactor:31.0];
            attributes[NSParagraphStyleAttributeName] = hyphenation;

            
            attributes[NSFontAttributeName] = [LWMStyle setFont:@"description"];
            attributes[NSForegroundColorAttributeName] = [LWMStyle setTextColor:@"dark"];

            
            [key appendAttributedString:[[NSAttributedString alloc] initWithString:animal.fullDiscription attributes:attributes]];
            
            [sci_name appendAttributedString:habitat];
            [sci_name appendAttributedString:key];
            
            
            detail.detailDescription = sci_name;
            detail.detailPicture = animal.largeImagePath;
            detail.detailHelp = animal.animalSos;
        //}
     
    }
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSDictionary *object = [_habitatArray objectAtIndex:section];
    if (_habitatArray.count>1) {
        UILabel *result = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _habitatTable.frame.size.width, 20)];
        result.text = [[NSString alloc] initWithFormat:@"  %@", [object objectForKey:@"subgroupname"]];

        result.backgroundColor = [LWMStyle setDetailBackgroundColor:@"dark"];
        result.textColor = [LWMStyle setTextColor:@"light"];
        [result sizeToFit];
        return result;
    }
    else{
        UILabel *result = nil;
        return result;
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.isSearching) {
        return 0;
    }
    else{
        if (_habitatArray.count>1) {
            return 30.f;
        }
        else{
            return 0;
        }
    }

    
}

- (void)filterContentForSearchText:(NSString*)searchText
{

    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    NSMutableArray *wildlifeArrayNames = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary *group in _habitatArray){
        for (Animal_Full *animal in [group objectForKey:@"subgroupobjects"]) {
            [wildlifeArrayNames addObject:animal.commonName];
        }
        
    }
    
    _searchResults = [NSMutableArray arrayWithArray:[wildlifeArrayNames filteredArrayUsingPredicate:resultPredicate]];

}

/*-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    return YES;
}*/


@end
