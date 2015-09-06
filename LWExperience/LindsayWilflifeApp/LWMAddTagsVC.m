//
//  LWMAddTagsVC.m
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMAddTagsVC.h"
#import "LWMStyle.h"

@interface LWMAddTagsVC ()

@end

@implementation LWMAddTagsVC

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
    //Test stored tags
    _tags_table.backgroundColor=[LWMStyle setDetailBackgroundColor:@"light"];
    _tags_table.separatorColor=[LWMStyle setDetailBackgroundColor:@"dark"];
    _tags_stored = @[@"#birds",@"#mammals",@"#invertebrates",@"#amphibian",@"#water",@"#park",@"#openspace",@"#backyard", @"#woodpeckers", @"#waterbird_shorebird", @"#jay_crow_raven", @"#songbird", @"#bird_of_prey", @"#hummingbird", @"#dove_pigeon", @"#swallow", @"#heron_egret", @"#duck_geese", @"#gull", @"#quail_turkey", @"#shrike"];
    _all_tags = [[NSMutableArray alloc]init];
    [_all_tags addObjectsFromArray:_tags_stored];
    _tagsDict = [[NSMutableDictionary alloc] init];
    _allDicts = [[NSMutableArray alloc] init];
    
    //Removes copies from stored tags
    NSString *copyword = [[NSString alloc]init];

    if (_tags_passed) {
        while (copyword!=nil) {
            copyword = [_all_tags firstObjectCommonWithArray:_tags_passed];
            [_all_tags removeObjectIdenticalTo:copyword];
        }
        [_all_tags addObjectsFromArray:_tags_passed];
        for (int i=0; i!=_all_tags.count-_tags_passed.count; i++) {
            _tagsDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[_all_tags objectAtIndex:i],@"tag",@0,@"check", nil];
            [_allDicts addObject:_tagsDict];
        }
        for (int i=(int )(_all_tags.count-_tags_passed.count); i!=_all_tags.count; i++) {
            _tagsDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[_all_tags objectAtIndex:i],@"tag",@1,@"check", nil];
            [_allDicts addObject:_tagsDict];
        }
    }
    else {
        for (int i=0; i!=_all_tags.count; i++) {
            _tagsDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[_all_tags objectAtIndex:i],@"tag",@0,@"check", nil];
            [_allDicts addObject:_tagsDict];
        }
    }

    [_all_tags sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
    [_allDicts sortUsingDescriptors:[NSArray arrayWithObject:descriptor]];

    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else {
        
        return _all_tags.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *AddCellIdentifier = @"newCell";
    

    if (indexPath.section == 0) {
        UITableViewCell *cell = [_tags_table dequeueReusableCellWithIdentifier:AddCellIdentifier];

        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];

        cell.accessoryView = addButton;
        [addButton addTarget: self
                  action: @selector(buttonClicked:)
        forControlEvents: UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else {
        UITableViewCell *cell = [_tags_table dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.textLabel.text = [_all_tags objectAtIndex:indexPath.row];
        if ([[[_allDicts objectAtIndex:indexPath.row] objectForKey:@"check"] isEqual:@1]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [self.view endEditing:YES];
        UITableViewCell *cell = [_tags_table cellForRowAtIndexPath:indexPath];
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [[_allDicts objectAtIndex:indexPath.row] setObject:@0 forKey:@"check"];
           
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [[_allDicts objectAtIndex:indexPath.row] setObject:@1 forKey:@"check"];
        }
        [_tags_table deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (IBAction) buttonClicked: (id)sender
{
    NSArray *paths = [NSArray arrayWithObject:
                      [NSIndexPath indexPathForRow:0 inSection:1]];
    LWMTagCell *cell = (LWMTagCell*)[_tags_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (![cell.createTag.text isEqualToString:@""]) {
        NSMutableString *newtag = [NSMutableString stringWithString:cell.createTag.text];
        
        NSString *firstLetter = [cell.createTag.text substringToIndex:1];
        
        if (![firstLetter isEqualToString:@"#"]) {
            [newtag insertString: @"#" atIndex: 0];
        }
        
        [_all_tags addObject:newtag];
        NSMutableDictionary *newTagdict = [NSMutableDictionary dictionaryWithObjectsAndKeys:newtag, @"tag", @1, @"check", nil];
        [_allDicts addObject:newTagdict];
        
        [_all_tags sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
        [_allDicts sortUsingDescriptors:[NSArray arrayWithObject:descriptor]];
        cell.createTag.text=@"";
        
        [_tags_table beginUpdates];
        [_tags_table insertRowsAtIndexPaths:paths
                           withRowAnimation:UITableViewRowAnimationTop];
        [_tags_table endUpdates];
        [_tags_table reloadData];
    }
}

- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSArray *paths = [NSArray arrayWithObject:
                      [NSIndexPath indexPathForRow:0 inSection:1]];
    
    if (indexPath.section==0) {
        LWMTagCell *cell = (LWMTagCell*)[_tags_table cellForRowAtIndexPath:indexPath];
        if (![cell.createTag.text isEqualToString:@""]) {
            
            NSMutableString *newtag = [NSMutableString stringWithString:cell.createTag.text];
        
            NSString *firstLetter = [cell.createTag.text substringToIndex:1];
            
            if (![firstLetter isEqualToString:@"#"]) {
                [newtag insertString: @"#" atIndex: 0];
            }

            [_all_tags addObject:newtag];
            NSMutableDictionary *newTagdict = [NSMutableDictionary dictionaryWithObjectsAndKeys:newtag, @"tag", @1, @"check", nil];
            [_allDicts addObject:newTagdict];
            
            [_all_tags sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
            [_allDicts sortUsingDescriptors:[NSArray arrayWithObject:descriptor]];
            cell.createTag.text=@"";
            
            [_tags_table beginUpdates];
            [_tags_table insertRowsAtIndexPaths:paths
                                  withRowAnimation:UITableViewRowAnimationTop];
            [_tags_table endUpdates];
            [_tags_table reloadData];
        }
        
        
    }
    
}


-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        if (indexPath.row %2 == 0)
        {
            cell.backgroundColor = [LWMStyle setCellColor:@"light"];
            cell.textLabel.textColor = [LWMStyle setTextColor:@"dark"];
            cell.detailTextLabel.textColor = [LWMStyle setTextColor:@"dark"];
        }
        
        if (indexPath.row % 2 == 1)
        {
            cell.backgroundColor = [LWMStyle setCellColor:@"light"];
            cell.textLabel.textColor = [LWMStyle setTextColor:@"dark"];
            cell.detailTextLabel.textColor = [LWMStyle setTextColor:@"dark"];
        }
    }
    else{
        cell.backgroundColor = [LWMStyle setCellColor:@"dark"];
        cell.textLabel.textColor = [LWMStyle setTextColor:@"light"];
        cell.detailTextLabel.textColor = [LWMStyle setTextColor:@"light"];
    }
    
}


-(void)viewDidDisappear:(BOOL)animated {
    NSMutableArray *checkedTags = [[NSMutableArray alloc] init];
    for (int i=0; i<_allDicts.count; i++) {
        if ([[[_allDicts objectAtIndex:i] objectForKey:@"check"]isEqual:@1]) {
            [checkedTags addObject:[[_allDicts objectAtIndex:i] objectForKey:@"tag"]];
        }
    }
    [_delegate addedTags:checkedTags];
    [super viewWillDisappear:animated];
}
@end
