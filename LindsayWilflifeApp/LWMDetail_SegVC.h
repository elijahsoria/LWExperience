//
//  LWMDetail_SegVC.h
//  LindsayWildlifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "LWMCreateNoteVC.h"
#import "Note.h"
#import <FacebookSDK/FacebookSDK.h>

@interface LWMDetail_SegVC : UIViewController <LWMCreateNoteDelegate>


@property (strong, nonatomic) IBOutlet UITextView *notesContainer;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UITextView *tags;
@property (strong, nonatomic) IBOutlet UITextView *notes;

@property (strong, nonatomic) IBOutlet UILabel *location;

@property (strong, nonatomic) IBOutlet UILabel *tagsTitle;

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UIButton *share;
@property (weak, nonatomic) IBOutlet UITextView *notesBackground;
@property Note *note;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *textboxheight;
@property (strong, nonatomic) IBOutlet UIView *lightView;
@property (strong, nonatomic) IBOutlet UIScrollView *darkView;
@property NSString *date_key;
@property NSString *date_name;
@property NSString *date_notes;
@property NSDate *date_date;
@property double longitude;
@property double latitude;
@property NSString *date_location;
@property NSString *date_tags;
@property NSString *date_img;
@property BOOL isConnectionAvailable;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *wifiReachability;
@end
