//
//  LWMAbout_HomeVC.h
//  LindsayWildlifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWMAbout_HomeVC : UIViewController
- (IBAction)button_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *leftText;
@property (strong, nonatomic) IBOutlet UITextView *rightText;

@end
