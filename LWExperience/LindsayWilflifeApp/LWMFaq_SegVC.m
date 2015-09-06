//
//  LWMFaq_SegVC.m
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMFaq_SegVC.h"
#import "LWMStyle.h"

@interface LWMFaq_SegVC ()

@end

@implementation LWMFaq_SegVC


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

    /*DBAccess *dba = [[DBAccess alloc]init];
    About *q = dba.getFaqs[0];
    
    _scroll.scrollEnabled=YES;

    
    _faqDescription.backgroundColor = [LWMStyle setDetailBackgroundColor:@"light"];
    _faqDescription.layer.cornerRadius = 20.0;
    _faqDescription.textAlignment = NSTextAlignmentNatural;
    _faqDescription.font = [LWMStyle setFont:@"description"];
    
    _faqTitle.textColor = [LWMStyle setTextColor:@"yellow"];
    _faqTitle.text = @"Museum Details and Facts";
    _faqTitle.font = [LWMStyle setFont:@"title"];
    
    _faqImage.image = [UIImage imageNamed:@"Lindsay Building.png"];
    
    _faqDescriptionBackground.backgroundColor = [LWMStyle setDetailBackgroundColor:@"light"];
    _faqDescriptionBackground.layer.cornerRadius = 20.0;
    
    self.view.backgroundColor = [LWMStyle setBackgroundColor:@"dark"];
    
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc]init];
    
    NSMutableParagraphStyle *hyphenation = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [hyphenation setHyphenationFactor:1.0];
    attributes[NSParagraphStyleAttributeName] = hyphenation;
    
    attributes[NSFontAttributeName] = [LWMStyle setFont:@"description"];
    attributes[NSForegroundColorAttributeName] = [LWMStyle setTextColor:@"dark"];
    
    _faqDescription.attributedText = q.faq;
    
    CGSize sizeThatShouldFitTheContent = [_faqDescription sizeThatFits:_faqDescription.frame.size];
    _frontHeightConstraint.constant = sizeThatShouldFitTheContent.height;*/
     
    
}

/*- (void)viewDidLayoutSubviews {
    _scroll.contentSize=CGSizeMake(320,_faqImage.frame.size.height + _frontHeightConstraint.constant + 30);
}*/


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (IBAction)call:(id)sender {
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"This will call Lindsay Wildlife" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:@"Cancel", nil];
    [myAlertView show];
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:9259351978"]];
    }
    
    
    
}*/
- (IBAction)push1:(id)sender {
}

- (IBAction)push2:(id)sender {
}

- (IBAction)push3:(id)sender {
}

- (IBAction)push4:(id)sender {
}

- (IBAction)push5:(id)sender {
}

- (IBAction)push6:(id)sender {
}
@end
