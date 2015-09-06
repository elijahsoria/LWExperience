//
//  LWMAddTagsVC.h
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWMCreateNoteVC.h"
#import "LWMTagsDelegate.h"
#import "LWMTagCell.h"

@interface LWMAddTagsVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tags_table;
@property NSMutableArray *all_tags;
@property NSArray *tags_passed;
@property NSArray *tags_stored;
@property (nonatomic, weak) id<LWMTagsDelegate> delegate;
@property NSMutableDictionary *tagsDict;
@property NSMutableArray *tagsPassedChecked;
@property NSMutableArray *allDicts;
@property UITextField *active_field;
@end