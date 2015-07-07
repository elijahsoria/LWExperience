//
//  LWMFaq_SegVC.h
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "About.h"
#import "DBAccess.h"

@interface LWMFaq_SegVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *faqDescription;
@property (weak, nonatomic) IBOutlet UIImageView *faqImage;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UITextView *faqDescriptionBackground;
@property (weak, nonatomic) IBOutlet UITextView *faqTitle;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *frontHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *faqButton;

- (IBAction)call:(id)sender;

@end
