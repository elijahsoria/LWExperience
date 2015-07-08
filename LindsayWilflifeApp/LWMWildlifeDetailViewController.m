//
//  LWMWildlifeDetailViewController.m
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMWildlifeDetailViewController.h"
#import "LWMWildlifeInfoContainerViewController.h"
#import "LWMWildlifeSosContainerViewController.h"
#import "LWMStyle.h"

@interface LWMWildlifeDetailViewController ()

@end

@implementation LWMWildlifeDetailViewController


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
    _sosView.hidden = YES;
    
    self.view.backgroundColor = [LWMStyle setBackgroundColor:@"dark"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)wildlifeDetailSwitch:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.infoView.hidden = NO;
            self.sosView.hidden = YES;
            break;
            
        case 1:
            self.infoView.hidden = YES;
            self.sosView.hidden = NO;
            break;
            
        default:
            break;
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"infoSegue"])
    {
        LWMWildlifeInfoContainerViewController *detail = segue.destinationViewController;
        detail.picture = _detailPicture;
        detail.name = _detailName;
        detail.descr = _detailDescription;
        detail.lab1=_lab1;
        detail.lab2=_lab2;
        
    }
    
    if([segue.identifier isEqualToString:@"sosSegue"])
    {
        LWMWildlifeSosContainerViewController *detail_2 = segue.destinationViewController;
        detail_2.name = _detailName;
        detail_2.picture = _detailPicture;
        detail_2.help = _detailHelp;
        detail_2.lab1=_lab1;
        detail_2.lab2=_lab2;
    }
}

@end
