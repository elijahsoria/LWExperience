//
//  LWMAbout_HomeVC2.m
//  Lindsay Wildlife
//
//  Created by Elijah Soria on 7/13/15.
//  Copyright (c) 2015 Anthony Braddick. All rights reserved.
//

#import "LWMAbout_HomeVC2.h"
#import "LWMStyle.h"

@interface LWMAbout_HomeVC2 ()

@end

@implementation LWMAbout_HomeVC2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _TopText.backgroundColor = [LWMStyle setDetailBackgroundColor:@"dark"];
    _TopText.textColor = [LWMStyle setTextColor:@"dark"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)GoBack:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
