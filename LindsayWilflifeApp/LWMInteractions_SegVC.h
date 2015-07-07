//
//  LWMInteractions_SegVC.h
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWMSpecialTableView.h"
#import "DBAccess.h"
#import "Programs.h"


@interface LWMInteractions_SegVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet LWMSpecialTableView *interactionsTable;
@property NSMutableArray *interactionsDetailArray;
@property NSArray *programsArray;


@end
