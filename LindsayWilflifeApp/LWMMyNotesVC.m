//
//  LWMMyNotesVC.m
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMMyNotesVC.h"


@interface LWMMyNotesVC ()

@end

@implementation LWMMyNotesVC


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
    _changed=NO;

    //Hide by default (Date is shown first)
    _mapView.hidden = YES;
    _tagView.hidden = YES;
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = [LWMStyle setBackgroundColor:@"dark"];
    
    }

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"date_segue"]) {
        _dateChild = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"tag_segue"]) {
        _tagChild = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"map_segue"]) {
        _mapChild = segue.destinationViewController;
    }
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    if(editing) {
        _dateChild.dateTable.editing=YES;
        _changed=YES;
        _notes_seg.userInteractionEnabled=NO;

    }
    
    else {
        if(_changed){

            [_tagChild refresh];
            [_mapChild refresh];
            _changed=NO;
        }
        _dateChild.dateTable.editing=NO;
        _notes_seg.userInteractionEnabled=YES;
        //Do something for non-edit mode
    }
    
}


-(IBAction)MyNotes_switch:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            
                _dateView.hidden = NO;
                _mapView.hidden = YES;
                _tagView.hidden = YES;
                self.navigationItem.rightBarButtonItem = self.editButtonItem;
                [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
            
            
            break;
        case 1:
            
                _dateView.hidden = YES;
                _mapView.hidden = NO;
                _tagView.hidden = YES;
                self.navigationItem.rightBarButtonItem = nil;
                [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
            
            break;
        case 2:
            
                _dateView.hidden = YES;
                _mapView.hidden = YES;
                _tagView.hidden = NO;
                self.navigationItem.rightBarButtonItem = nil;
            
            break;
            
        default:
            break;
    }
}

- (IBAction)new_note:(id)sender {
    UIViewController *selectViewController = [self.tabBarController.viewControllers objectAtIndex:2];

    [self.tabBarController setSelectedViewController:selectViewController];
    [self.navigationController popToRootViewControllerAnimated:NO];}
@end
