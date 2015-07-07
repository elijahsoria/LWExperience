//
//  LWMWildlifeVC2.m
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMWildlifeVC.h"
#import "LWMStyle.h"

@interface LWMWildlifeVC ()

@end

@implementation LWMWildlifeVC

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
    self.habitatView.hidden = YES;
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [LWMStyle setBackgroundColor:@"dark"];
    self.SrchBar.hidden = true;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SrchAction:(UIBarButtonItem *)sender {
    self.SrchBar.hidden = false;
}

- (IBAction)Wildlife_switch:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.animalView.hidden = NO;
            self.habitatView.hidden = YES;
            break;
            
        case 1:
            self.animalView.hidden = YES;
            self.habitatView.hidden = NO;
            break;
            
        default:
            break;
    }
}
@end
