//
//  LWMWildlifeSosContainerViewController.h
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LWMWildlifeSosContainerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *sosPicture;
@property (weak, nonatomic) IBOutlet UILabel *sosName;
@property (weak, nonatomic) IBOutlet UITextView *sosDescription;
@property (weak, nonatomic) IBOutlet UITextView *sosDescriptionBackground;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *frontHeightConstraint;
@property (strong, nonatomic) IBOutlet UILabel *sosNameBg;
@property (strong, nonatomic) IBOutlet UIButton *sosNameExpand;
- (IBAction)Expand:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *sosExpandedTxt;

@property (strong, nonatomic) IBOutlet UILabel *sosExpandName;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backHeightConstraint;
@property NSAttributedString *name;
@property NSString *picture;
@property NSString *help;
@property NSAttributedString *label;

@property (strong, nonatomic) IBOutlet UIScrollView *scroll;

@end
