//
//  LWMPictureViewController.m
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMPictureViewController.h"
#import "LWMStyle.h"

@interface LWMPictureViewController ()

@end

@implementation LWMPictureViewController

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
    
    _Picture.image=_image;
    
    _Name.attributedText=_NameText;
    _Name.textColor=[LWMStyle setTextColor:@"light"];
     //Do any additional setup after loading the view.
    _Habitat.attributedText=_HabText;
    _Habitat.textColor=[LWMStyle setTextColor:@"light"];
}

- (void)viewWillAppear:(BOOL)animated{
    CGAffineTransform landscapeTransform = CGAffineTransformMakeRotation(0.0f * M_PI / 180.0f);
    landscapeTransform = CGAffineTransformTranslate (landscapeTransform, +80.0, +100.0);

    
    [self.view setTransform:landscapeTransform];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
