//
//  LWMWildlifeAnimalsViewController.h
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWMWildlifeAnimalsViewController : UIViewController

@property NSMutableArray *birdArray;
@property NSMutableArray *mammalArray;
@property NSMutableArray *reptileArray;
@property NSMutableArray *amphibianArray;
@property NSArray *animalsArray;

@property (weak, nonatomic) IBOutlet UIButton *birdButton;
@property (weak, nonatomic) IBOutlet UIButton *mammalButton;
@property (weak, nonatomic) IBOutlet UIButton *reptileButton;
@property (weak, nonatomic) IBOutlet UIButton *amphibianButton;

@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelThree;
@property (weak, nonatomic) IBOutlet UILabel *labelFour;



@end
