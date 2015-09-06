//
//  LWMAbout_SegVC.m
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMAbout_SegVC.h"
#import "LWMStyle.h"

@interface LWMAbout_SegVC ()

@end

@implementation LWMAbout_SegVC

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
    /*UIImage *btnImage1 = [UIImage imageNamed:@"look.png"];
    UIImage *btnImage2 = [UIImage imageNamed:@"bees.png"];
    UIImage *btnImage3 = [UIImage imageNamed:@"eyes.png"];
    [_Image1 setImage:btnImage1 forState:UIControlStateNormal];
    [_Image2 setImage:btnImage2 forState:UIControlStateNormal];
    [_Image3 setImage:btnImage3 forState:UIControlStateNormal];
    [_History setImage:btnImage1 forState:UIControlStateNormal];*/
	// Do any additional setup after loading the view.
    
    //DBAccess *dba = [[DBAccess alloc] init];

    //About *i = dba.getAbout[0];
    //_aboutText = i.info;
    
    /*_aboutDescription.backgroundColor = [LWMStyle setDetailBackgroundColor:@"light"];
    _aboutDescription.textAlignment = NSTextAlignmentNatural;
    _aboutDescription.layer.cornerRadius = 20.0;
    
    _aboutTitle.textColor = [LWMStyle setTextColor:@"yellow"];
    _aboutTitle.font = [LWMStyle setFont:@"title"];
    _aboutTitle.text = @"Museum History and Mission";
    
    _aboutImage.image = [UIImage imageNamed:@"Lindsay Front.png"];
  
    _aboutDescriptionBackground.backgroundColor = [LWMStyle setDetailBackgroundColor:@"light"];
    _aboutDescriptionBackground.layer.cornerRadius = 20.0;*/
    
    //self.view.backgroundColor = [LWMStyle setBackgroundColor:@"dark"];
    
    
    /*NSMutableDictionary *attributes = [[NSMutableDictionary alloc]init];

    NSMutableParagraphStyle *hyphenation = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [hyphenation setHyphenationFactor:1.0];
    attributes[NSParagraphStyleAttributeName] = hyphenation;
    
    attributes[NSFontAttributeName] = [LWMStyle setFont:@"description"];
    attributes[NSForegroundColorAttributeName] = [LWMStyle setTextColor:@"dark"];
    
    _aboutDescription.attributedText = [[NSAttributedString alloc] initWithString:_aboutText attributes:attributes];
     
    CGSize sizeThatShouldFitTheContent = [_aboutDescription sizeThatFits:_aboutDescription.frame.size];
    _frontHeightConstraint.constant = sizeThatShouldFitTheContent.height;*/
    
}

/*- (void)viewDidLayoutSubviews {
    _scroll.contentSize=CGSizeMake(320,_aboutImage.frame.size.height + _frontHeightConstraint.constant + 30);
}*/


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (IBAction)directions:(id)sender {
    
    NSString *examplecurrentloc = @"http://maps.apple.com/?daddr=1931+1st+Avenue+Walnut+Creek,+CA&saddr=Current+Location";
    NSURL *mapurl = [NSURL URLWithString:examplecurrentloc];
    [[UIApplication sharedApplication] openURL:mapurl];
}*/
@end
