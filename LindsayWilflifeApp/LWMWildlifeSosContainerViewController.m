//
//  LWMWildlifeSosContainerViewController.m
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMWildlifeSosContainerViewController.h"
#import "LWMWildlifeDetailViewController.h"
#import "LWMStyle.h"
#import "LWMPictureViewController.h"

@interface LWMWildlifeSosContainerViewController ()

@end

@implementation LWMWildlifeSosContainerViewController

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
    _sosExpandedTxt.hidden=YES;
    _sosExpandName.hidden=YES;
    _sosName.hidden=NO;
    _sosNameBg.hidden=NO;
    
    _sosName.attributedText = _name;
    _sosName.backgroundColor = [LWMStyle setDetailBackgroundColor:@"black"];
    _sosName.textColor = [LWMStyle setTextColor:@"light"];
    
    _sosPicture.image = [UIImage imageNamed:_picture];
    
    _sosDescription.backgroundColor = [LWMStyle setDetailBackgroundColor:@"light"];
    _sosDescription.layer.cornerRadius = 20.0;
    _sosDescription.textAlignment = NSTextAlignmentNatural;
    
    _sosDescriptionBackground.backgroundColor = [LWMStyle setDetailBackgroundColor:@"light"];
    _sosDescriptionBackground.layer.cornerRadius = 20.0;
   
  
    
    self.view.backgroundColor = [LWMStyle setBackgroundColor:@"dark"];
    
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc]init];
    
    NSMutableParagraphStyle *hyphenation = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [hyphenation setHyphenationFactor:1.0];
    attributes[NSParagraphStyleAttributeName] = hyphenation;
    
    attributes[NSFontAttributeName] = [LWMStyle setFont:@"description"];
    attributes[NSForegroundColorAttributeName] = [LWMStyle setTextColor:@"dark"];
    
    _sosDescription.attributedText = [[NSAttributedString alloc] initWithString:_help attributes:attributes];
    
    CGSize sizeThatShouldFitTheContent = [_sosDescription sizeThatFits:_sosDescription.frame.size];
    if (sizeThatShouldFitTheContent.height < 150.0f) {
        sizeThatShouldFitTheContent.height = 150.0f;
    }
    _frontHeightConstraint.constant = sizeThatShouldFitTheContent.height;
    _backHeightConstraint.constant = _frontHeightConstraint.constant + 20.0f;
}

- (void) viewDidLayoutSubviews{
    CGFloat totalHeight = 0.0f;
    totalHeight = _frontHeightConstraint.constant + _sosPicture.frame.size.height + 150.0f;
    [_scroll setContentSize:(CGSizeMake(320, totalHeight))];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Expand:(id)sender {
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"This will call Lindsay Wildlife" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:@"Cancel", nil];
    [myAlertView show];
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:9259351978"]];
    }
    
    
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"show_picture"])
    {
        LWMPictureViewController *detail = segue.destinationViewController;
        detail.image=_sosPicture.image;
        detail.text=_label;
    }
}

@end
