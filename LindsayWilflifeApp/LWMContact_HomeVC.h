//
//  LWMContact_HomeVC.h
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LWMStyle.h"

@interface LWMContact_HomeVC : UIViewController <UIAlertViewDelegate>
//@property (strong, nonatomic) CLLocationManager *locationManager;
- (IBAction)buttonPressed:(UIButton *)sender;
- (IBAction)backbutton:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *RightPane;
@property (strong, nonatomic) IBOutlet UIButton *LeftButton;

@end
