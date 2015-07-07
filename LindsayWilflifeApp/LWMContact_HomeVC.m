//
//  LWMContact_HomeVC.m
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMContact_HomeVC.h"

@interface LWMContact_HomeVC ()

@end

@implementation LWMContact_HomeVC

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

    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    _RightPane.backgroundColor=[LWMStyle setDetailBackgroundColor:@"dark"];
    _LeftButton.backgroundColor=[LWMStyle setDetailBackgroundColor:@"dark"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(UIButton *)sender
{
    if (sender.tag==0) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"This will call Lindsay Wildlife" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:@"Cancel", nil];
        [myAlertView show];
    }
    else if (sender.tag==1) {
        NSString *examplecurrentloc = @"http://maps.apple.com/?daddr=1931+1st+Avenue+Walnut+Creek,+CA&saddr=Current+Location";
        NSURL* mapurl = [[NSURL alloc] initWithString:[examplecurrentloc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

        [[UIApplication sharedApplication] openURL:mapurl];
    }
}

- (IBAction)backbutton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:9259351978"]];
    }
    
    
    
}
@end
