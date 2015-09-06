//
//  LWMCreateNoteVC.h
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "LWMAddTagsVC.h"
#import "LWMTagsDelegate.h"
#import "LWMCreateNoteDelegate.h"
#import "Note.h"
#import "Reachability.h"

@interface LWMCreateNoteVC : UIViewController <LWMTagsDelegate, CLLocationManagerDelegate, UITextViewDelegate>


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *textheigh;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property NSString *caller;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UITextView *tags;
@property (strong, nonatomic) IBOutlet UITextView *notes;
@property (weak, nonatomic) IBOutlet UITextView *notesBackground;
@property (strong, nonatomic) IBOutlet UILabel *date_title;

@property (strong, nonatomic) IBOutlet UITextField *location;

@property (strong, nonatomic) IBOutlet UILabel *location_title;
@property (strong, nonatomic) IBOutlet UILabel *tags_title;
@property (strong, nonatomic) IBOutlet UILabel *title_title;
@property (strong, nonatomic) IBOutlet UIImageView *image;

@property (strong, nonatomic) IBOutlet UIView *lightview;
@property (strong, nonatomic) IBOutlet UIScrollView *darkview;
@property NSString *date_key;
@property NSString *date_name;
@property NSString *date_notes;
@property NSDate *date_date;
@property NSString *date_location;
@property NSString *date_tags;
@property NSString *date_img;
@property Note *note;
@property CLLocationManager *locManager;

@property double longitude;
@property double latitude;
@property (nonatomic, weak) id<LWMCreateNoteDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *save;
- (IBAction)save_note:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *Cancel;
- (IBAction)cancel_note:(id)sender;
@property CGFloat animatedDistance;
@property BOOL isConnectionAvailable;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *wifiReachability;

@end
