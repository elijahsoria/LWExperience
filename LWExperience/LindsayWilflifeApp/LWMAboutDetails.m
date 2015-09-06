//
//  LWMAboutDetails.m
//  Lindsay Wildlife
//
//  Created by Weiwei Pan on 8/30/15.
//  Copyright (c) 2015 Anthony Braddick. All rights reserved.
//

#import "LWMAboutDetails.h"

@interface LWMAboutDetails ()

@end

@implementation LWMAboutDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)expand:(id)sender {
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"Discover more at the Lindsay website." delegate:self cancelButtonTitle:@"Let's Go" otherButtonTitles:@"Later", nil];
    [myAlertView show];
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
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
