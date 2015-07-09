//
//  LWMPictureViewController.h
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWMPictureViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *Picture;
@property (strong, nonatomic) IBOutlet UILabel *Name;
@property (strong, nonatomic) IBOutlet UILabel *Habitat;
@property (strong, nonatomic) IBOutlet UIScrollView *PicScroll;

@property (strong, nonatomic) IBOutlet UIButton *BackButton;
- (IBAction)Back:(id)sender;
@property UIImage *image;
@property NSAttributedString *NameText;
@property NSAttributedString *HabText;

@end
