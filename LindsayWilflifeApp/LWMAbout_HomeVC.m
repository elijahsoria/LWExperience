//
//  LWMAbout_HomeVC.m
//  LindsayWildlifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMAbout_HomeVC.h"
#import "LWMStyle.h"

@interface LWMAbout_HomeVC ()

@end

@implementation LWMAbout_HomeVC

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
    self.view.backgroundColor = [LWMStyle setCellColor:@"light"];
    _leftText.textColor = [LWMStyle setTextColor:@"dark"];
    _rightText.textColor = [LWMStyle setTextColor:@"dark"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button_pressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
