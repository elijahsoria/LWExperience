//
//  LWMMyNotesVC.h
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWMDate_SegVC.h"
#import "LWMTag_SegVC.h"
#import "LWMMap_SegVC.h"
#import "LWMStyle.h"
#import "LWMSpecialSegmentedControl.h"
#import "DBAccess.h"
#import "Note.h"

@interface LWMMyNotesVC : UIViewController

@property (strong, nonatomic) IBOutlet LWMSpecialSegmentedControl *notes_seg;
- (IBAction)new_note:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *dateView;

@property (weak, nonatomic) IBOutlet UIView *mapView;

@property (weak, nonatomic) IBOutlet UIView *tagView;

- (IBAction)MyNotes_switch:(UISegmentedControl *)sender;

@property (strong, nonatomic) IBOutlet UIView *myView;

@property NSMutableArray *notesArray;
@property NSMutableArray *tagsArray;
@property LWMDate_SegVC *dateChild;
@property LWMMap_SegVC *mapChild;
@property LWMTag_SegVC *tagChild;
@property BOOL changed;
@end
