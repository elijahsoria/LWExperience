//
//  LWMWildlifeVC2.h
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWMWildlifeVC : UIViewController
@property (weak, nonatomic) IBOutlet UIView *animalView;
@property (weak, nonatomic) IBOutlet UIView *habitatView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *SrchButton;
- (IBAction)SrchAction:(UIBarButtonItem *)sender;
- (IBAction)Wildlife_switch:(id)sender;
@property (strong, nonatomic) IBOutlet UISearchBar *SrchBar;
@property NSArray* SrchDict;


@end
