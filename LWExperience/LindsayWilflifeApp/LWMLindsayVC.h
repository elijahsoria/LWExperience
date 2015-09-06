//
//  LWMFifthViewController.h
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWMLindsayVC : UIViewController
@property (weak, nonatomic) IBOutlet UIView *historyView;
@property (weak, nonatomic) IBOutlet UIView *interactView;
@property (weak, nonatomic) IBOutlet UIView *faqView;
- (IBAction)Lindsay_switch:(id)sender;

@end
