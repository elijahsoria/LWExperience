//
//  LWMInteractionsDetailViewController.m
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMInteractionsDetailViewController.h"
#import "LWMStyle.h"
#import <QuartzCore/QuartzCore.h>


@interface LWMInteractionsDetailViewController ()

@end

@implementation LWMInteractionsDetailViewController


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
    
        
    /*_name.text = _detailName;
    _picture.image = [UIImage imageNamed:_detailPicture];
    
    
    [_scroll setContentSize:CGSizeMake(320, 568)];
    [_scroll setFrame:CGRectMake(0, 0, 320, 568)];
    
    _urlName = @"http://www.wildlife-museum.org";
    
    _websiteLink.backgroundColor = [LWMStyle setBackgroundColor:@"light"];
    _websiteLink.tintColor = [LWMStyle setTextColor:@"light"];
    
    ////
    _descript.backgroundColor = [LWMStyle setDetailBackgroundColor:@"light"];
    _descript.layer.cornerRadius = 20.0;
    _descript.textAlignment = NSTextAlignmentNatural;
    ////
    
    _name.textColor = [LWMStyle setTextColor:@"yellow"];
    _name.font = [LWMStyle setFont:@"title"];

    _descriptionBackground.backgroundColor = [LWMStyle setDetailBackgroundColor:@"light"];
    _descriptionBackground.layer.cornerRadius = 20.0;
    
    self.view.backgroundColor = [LWMStyle setBackgroundColor:@"dark"];
    
    
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc]init];
    
    NSMutableParagraphStyle *hyphenation = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [hyphenation setHyphenationFactor:1.0];
    attributes[NSParagraphStyleAttributeName] = hyphenation;
    
    attributes[NSFontAttributeName] = [LWMStyle setFont:@"description"];
    attributes[NSForegroundColorAttributeName] = [LWMStyle setTextColor:@"dark"];
    
    ////
    _descript.attributedText = [[NSAttributedString alloc] initWithString:_detailDescription attributes:attributes];
    
    CGSize sizeThatShouldFitTheContent = [_descript sizeThatFits:_descript.frame.size];
    if (sizeThatShouldFitTheContent.height < 210.0f) {
        sizeThatShouldFitTheContent.height = 210.0f;
    }
    ////
    
    //_frontHeightConstraint.constant = sizeThatShouldFitTheContent.height;
     */
    
}

/*- (void) viewDidLayoutSubviews{
    CGFloat totalHeight = 0.0f;
    totalHeight = _frontHeightConstraint.constant + _picture.frame.size.height + 40.0f;
    [_scroll setContentSize:(CGSizeMake(320, totalHeight))];
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (IBAction)url:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_urlName]];
}*/
@end
