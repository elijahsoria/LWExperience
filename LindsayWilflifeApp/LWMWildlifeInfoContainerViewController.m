//
//  LWMWildlifeInfoContainerViewController.m
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMWildlifeInfoContainerViewController.h"
#import "LWMWildlifeDetailViewController.h"
#import "LWMStyle.h"
#import "LWMPictureViewController.h"

@interface LWMWildlifeInfoContainerViewController ()

@end

@implementation LWMWildlifeInfoContainerViewController

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
	
    
    _infoName.attributedText = _name;
    _infoName.backgroundColor = [LWMStyle setDetailBackgroundColor:@"black"];
    _infoName.textColor = [LWMStyle setTextColor:@"light"];

    
    _infoDescription.backgroundColor = [LWMStyle setDetailBackgroundColor:@"light"];
    _infoDescription.layer.cornerRadius = 20.0;
    _infoDescription.textAlignment = NSTextAlignmentNatural;
    
    _infoDescriptionBackground.backgroundColor = [LWMStyle setDetailBackgroundColor:@"light"];
    _infoDescriptionBackground.layer.cornerRadius = 20.0;
    
    _infoPicture.image = [UIImage imageNamed:_picture];
    
    
    self.view.backgroundColor = [LWMStyle setBackgroundColor:@"dark"];

    
    _infoDescription.attributedText = _descr;
    
    CGSize sizeThatShouldFitTheContent = [_infoDescription sizeThatFits:_infoDescription.frame.size];
    if (sizeThatShouldFitTheContent.height < 150.0f) {
        sizeThatShouldFitTheContent.height = 150.0f;
    }
    _frontHeightConstraint.constant = sizeThatShouldFitTheContent.height;
    
}



-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"show_picture"])
    {
        LWMPictureViewController *detail = segue.destinationViewController;
        detail.image=_infoPicture.image;
        detail.NameText=_lab1;
        detail.HabText=_lab2;
    }
}

- (void) viewDidLayoutSubviews{
    CGFloat totalHeight = 0.0f;
    totalHeight = _frontHeightConstraint.constant + _infoPicture.frame.size.height + 150.0f;
    [_scroll setContentSize:(CGSizeMake(320, totalHeight))];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)expand:(id)sender {
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"Read more about this animal on Wikipedia" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:@"Cancel", nil];
    [myAlertView show];
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSString *urlName=[[NSString alloc] initWithFormat:@"http://en.wikipedia.org/wiki/Special:Search/%@", [_name string]];
        urlName = [urlName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlName]];
    }
    
    
    
}
@end
