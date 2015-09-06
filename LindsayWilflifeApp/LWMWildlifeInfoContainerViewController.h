//
//  LWMWildlifeInfoContainerViewController.h
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LWMWildlifeInfoContainerViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *infoExpand;
- (IBAction)expand:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *infoNameBg;

@property (weak, nonatomic) IBOutlet UIImageView *infoPicture;
@property (weak, nonatomic) IBOutlet UILabel *infoName;
@property (weak, nonatomic) IBOutlet UITextView *infoDescription;
@property (weak, nonatomic) IBOutlet UITextView *infoDescriptionBackground;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *frontHeightConstraint;

@property NSString *picture;
@property NSMutableAttributedString *name;
@property NSMutableAttributedString *descr;
@property NSAttributedString *lab1;
@property NSAttributedString *lab2;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;

@end
