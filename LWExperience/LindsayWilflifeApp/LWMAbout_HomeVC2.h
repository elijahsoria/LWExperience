//
//  LWMAbout_HomeVC2.h
//  Lindsay Wildlife
//
//  Created by Elijah Soria on 7/13/15.
//  Copyright (c) 2015 Anthony Braddick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWMAbout_HomeVC2 : UITabBarController
- (IBAction)GoBack:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UITextView *TopText;
@property (strong, nonatomic) IBOutlet UITextView *leftText;
@property (strong, nonatomic) IBOutlet UITextView *centerText;
@property (strong, nonatomic) IBOutlet UITextView *rightText;


@end
