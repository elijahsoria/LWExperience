//
//  LWMFifthViewController.m
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMLindsayVC.h"
#import "LWMStyle.h"

@interface LWMLindsayVC ()

@end

@implementation LWMLindsayVC



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
    self.interactView.hidden = YES;
    self.faqView.hidden = YES;
	// Do any additional setup after loading the view.

    self.view.backgroundColor = [LWMStyle setBackgroundColor:@"dark"];
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Lindsay_switch:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.historyView.hidden = NO;
            self.interactView.hidden = YES;
            self.faqView.hidden = YES;
            break;
        
        case 1:
            self.historyView.hidden = YES;
            self.interactView.hidden = NO;
            self.faqView.hidden = YES;
            break;
            
        case 2:
            self.historyView.hidden = YES;
            self.interactView.hidden = YES;
            self.faqView.hidden = NO;
            break;
            
        default:
            break;
    }

}
@end
