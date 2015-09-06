//
//  LWMFaqDetails.m
//  Lindsay Wildlife
//
//  Created by Weiwei Pan on 8/31/15.
//  Copyright (c) 2015 Anthony Braddick. All rights reserved.
//

#import "LWMFaqDetails.h"

@interface LWMFaqDetails ()

@end

@implementation LWMFaqDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)web:(id)sender {
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"Discover more at the Lindsay website." delegate:self cancelButtonTitle:@"Let's Go" otherButtonTitles:@"Later", nil];
    myAlertView.tag = 0;
    [myAlertView show];
    
}



- (IBAction)call:(id)sender {
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"This will call Lindsay Wildlife" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:@"Cancel", nil];
    myAlertView.tag = 1;
    [myAlertView show];
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ((buttonIndex == 0) && (alertView.tag == 1)){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:9259351978"]];
    }

    if ((buttonIndex == 0) && (alertView.tag == 0)){
        NSString *urlName=@"http://lindsaywildlife.org/";
        urlName = [urlName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlName]];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
