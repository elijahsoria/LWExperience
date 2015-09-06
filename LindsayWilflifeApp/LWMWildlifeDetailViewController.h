//
//  LWMWildlifeDetailViewController.h
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWMWildlifeDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *wildlifeDetailSeg;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIView *sosView;
- (IBAction)wildlifeDetailSwitch:(id)sender;

@property NSMutableAttributedString *detailName;
@property NSString *detailPicture;
@property NSMutableAttributedString *detailDescription;
@property NSString *detailHelp;
@property NSAttributedString *lab1;
@property NSAttributedString *lab2;



@end
