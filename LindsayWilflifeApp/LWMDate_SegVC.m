//
//  LWMDate_SegVC.m
//  LindsayWildlifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMDate_SegVC.h"
#import "LWMStyle.h"
#import "LWMMyNotesVC.h"


@interface LWMDate_SegVC ()

@end

@implementation LWMDate_SegVC


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

    _dateTable.separatorStyle = UITableViewCellSeparatorStyleNone;
	// Do any additional setup after loading the view.
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self db_pull];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"date" ascending: NO];
    NSArray *sortedArray = [_notesArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    _notesArray = [NSMutableArray arrayWithArray:sortedArray];
   
    [_dateTable reloadData];
}

-(void)db_pull{

    
    DBAccess *dba = [[DBAccess alloc]init];
    _notesArray = [[NSMutableArray alloc] initWithArray:[dba getNotes]];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.row > _notesArray.count) {
            return NO;
    }
    return YES;
    
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tv
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _notesArray.count && tv.editing) {
        return UITableViewCellEditingStyleDelete;
    } else {

        return UITableViewCellEditingStyleNone;
    }
    
}

- (void) tableView:(UITableView *)tv
commitEditingStyle:(UITableViewCellEditingStyle) editing
 forRowAtIndexPath:(NSIndexPath *)indexPath {
    if( editing == UITableViewCellEditingStyleDelete ) {

        Note *animal =[_notesArray objectAtIndex:indexPath.row];
        DBAccess *dba = [[DBAccess alloc]init];
        [dba deleteNote:animal.key];
        
        if (_notesArray.count<7) {

            [tv beginUpdates];
            [tv deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                      withRowAnimation:UITableViewRowAnimationLeft];
            [_notesArray removeObjectAtIndex:indexPath.row];

            [tv insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_notesArray.count inSection:0] ]
                      withRowAnimation:UITableViewRowAnimationNone];
            
            [tv endUpdates];
            [tv reloadData];
        }
        else{
            [tv beginUpdates];
            [tv deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                      withRowAnimation:UITableViewRowAnimationLeft];
            [_notesArray removeObjectAtIndex:indexPath.row];
            [tv endUpdates];
            [tv reloadData];
        }

       
        
    }
    else if (editing==UITableViewCellEditingStyleInsert) {

    }
    
}


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (_notesArray.count < 7) {
        return 7;
    }
    else {
        return _notesArray.count+1;
    }
}

- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    static NSString *nonsimpleTableIdentifier = @"NonCell";
    
    
    
    bool isClickable = (indexPath.row >= _notesArray.count);
    
    NSString *usedCellIdentifier = isClickable ? nonsimpleTableIdentifier : simpleTableIdentifier;
    
    UITableViewCell *cell = [_dateTable dequeueReusableCellWithIdentifier: usedCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:usedCellIdentifier];
        if (indexPath.row < _notesArray.count){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    if ((_notesArray.count < 7 && indexPath.row >= _notesArray.count) || (_notesArray.count >= 7 && indexPath.row >= _notesArray.count)) {

        cell.textLabel.text = @"";
        cell.detailTextLabel.text = @"";
    
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.image = nil;
        cell.userInteractionEnabled = NO;

    }

    else {
        //Setting Date
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM.dd.yy"];
        Note *animal =[_notesArray objectAtIndex:indexPath.row];
        
        UIFont* font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        
        NSDictionary *attrs = @{
                                NSFontAttributeName : font};
        
        NSAttributedString* attrString = [[NSAttributedString alloc]
                                          initWithString:animal.name
                                          attributes:attrs];
        
        cell.textLabel.attributedText = attrString;
        

        cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@ (%@)", animal.location, [formatter stringFromDate:animal.date]];
        
        
        //Setting Image
        if (animal.thum_path) {
            cell.imageView.image = [self loadImage:animal.thum_path];
            
        }
       
    }
    return cell;
    
}

- (UIImage*)loadImage: (NSString *)file_path
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [NSString stringWithString: file_path] ];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;
}



-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2) {
        cell.backgroundColor = [LWMStyle setCellColor:@"light"];
        cell.textLabel.textColor = [LWMStyle setTextColor:@"dark"];
        cell.detailTextLabel.textColor = [LWMStyle setTextColor:@"dark"];
            }
    else {
        cell.backgroundColor = [LWMStyle setCellColor:@"dark"];
        cell.textLabel.textColor = [LWMStyle setTextColor:@"dark"];
        cell.detailTextLabel.textColor = [LWMStyle setTextColor:@"dark"];

    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"show_detail"]) {
        NSIndexPath *indexpath = [_dateTable indexPathForSelectedRow];
        LWMDetail_SegVC *detail = segue.destinationViewController;
        Note *animal =[_notesArray objectAtIndex:indexpath.row];
        detail.note = animal;
        
    }
}

@end
