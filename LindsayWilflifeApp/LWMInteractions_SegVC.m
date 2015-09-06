//
//  LWMInteractions_SegVC.m
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMInteractions_SegVC.h"
#import "LWMInteractionsDetailViewController.h"
#import "LWMStyle.h"


@interface LWMInteractions_SegVC ()

@end

@implementation LWMInteractions_SegVC

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
    
    /*DBAccess *dba = [[DBAccess alloc]init];
    _programsArray = dba.getPrograms;
    _interactionsDetailArray = [[NSMutableArray alloc] init];
    for (Programs *p in _programsArray)
    {
        
        NSDictionary *program = [NSDictionary dictionaryWithObjectsAndKeys: p.title, @"name", p.descr, @"description", p.url, @"url",
                                 p.url, @"tagline",
                                 [NSString stringWithFormat:@"PROGRAMS_education.png"], @"picture",
                                 nil];
        
        [_interactionsDetailArray addObject:program];
    }

    
    _interactionsTable.backgroundView = nil;
    
    self.interactionsTable.backgroundColor = [LWMStyle setBackgroundColor:@"dark"];
    
    _interactionsTable.separatorColor = [UIColor clearColor];*/
    
    self.title = @"Interactions";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}*/


/*-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_interactionsDetailArray.count < 7)
    {
        return 7;
    }
    else
    {
    return _interactionsDetailArray.count;
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    static NSString *nonsimpleTableIdentifier = @"NonCell";
    
    
    
    bool isClickable = (_interactionsDetailArray.count < 7 && indexPath.row >= _interactionsDetailArray.count);
    
    NSString *usedCellIdentifier = isClickable ? nonsimpleTableIdentifier : simpleTableIdentifier;
    
    UITableViewCell *cell = [_interactionsTable dequeueReusableCellWithIdentifier: usedCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:usedCellIdentifier];
        if (!(_interactionsDetailArray.count < 7 && indexPath.row >= _interactionsDetailArray.count)){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    if(_interactionsDetailArray.count < 7 && indexPath.row >= _interactionsDetailArray.count)
    {
        cell.textLabel.text = @"";
        cell.detailTextLabel.text = @"";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = NO;
    }
    
    else
    {
    
    NSDictionary *information = [_interactionsDetailArray objectAtIndex:indexPath.row];
        
        const CGFloat fontSize = 17;
        UIFont *boldFont = [UIFont boldSystemFontOfSize:fontSize];
        
        // Create the attributes
        NSDictionary *boldAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                   boldFont, NSFontAttributeName,
                                   [LWMStyle setTextColor:@"dark"], NSForegroundColorAttributeName, nil];
        
        NSMutableAttributedString *attrTitle =
        [[NSMutableAttributedString alloc] initWithString:[information objectForKey:@"name"]
                                               attributes:boldAttrs];

        
    cell.textLabel.attributedText = attrTitle;
    cell.detailTextLabel.text = [information objectForKey:@"tagline"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
    
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
        cell.textLabel.textColor = [LWMStyle setTextColor:@"dark"];
        cell.detailTextLabel.textColor = [LWMStyle setTextColor:@"dark"];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"interactionsDetailSegue"])
    {
        NSArray *pictures = [[NSArray alloc] initWithObjects:@"PROGRAMS_education", @"PROGRAMS_interpretive guide", @"PROGRAMS_wildlife hospital", @"LWM volunteer", nil];
        NSIndexPath *indexPath = [_interactionsTable indexPathForSelectedRow];
        LWMInteractionsDetailViewController *detail = segue.destinationViewController;
        
        NSDictionary *information = [_interactionsDetailArray objectAtIndex:indexPath.row];
        
        detail.detailName = [information objectForKey:@"name"];
        NSLog([information objectForKey:@"description"]);
        detail.detailDescription = [information objectForKey:@"description"];
        detail.detailPicture = [pictures objectAtIndex:indexPath.row];
        detail.urlName = [information objectForKey:@"url"];
    }
    
    
}*/






@end
