//
//  LWMSecondViewController.h
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWMCreateNoteVC.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import "LWMCreateNoteDelegate.h"
#import "LWMStyle.h"
#import "Note.h"
#import "Reachability.h"

@interface LWMCameraVC : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, LWMCreateNoteDelegate>
- (IBAction)Reset:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *SelectButton;
@property (strong, nonatomic) IBOutlet UIButton *TakeButton;

@property (strong, nonatomic) IBOutlet UIImageView *cameraView;
- (IBAction)selectPhoto:(UIButton *)sender;
- (IBAction)takePhoto:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imageBox;
@property (weak, nonatomic) IBOutlet UITextField *date_label;
@property (weak, nonatomic) IBOutlet UITextField *location_labelCity;
@property (weak, nonatomic) IBOutlet UITextField *location_labelState;
@property (weak, nonatomic) IBOutlet UITextField *name_label;
@property NSURL *referenceURL;
@property NSDictionary *metadata;
@property NSString *location;
@property NSDate *selectedDate;
@property CLLocation *selectedLocation;
@property CLLocation *currentLocation;
@property CLLocationManager *locManager;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property NSString *meta_location;
@property Note *note;
@property UIImage *adj_img;
@property BOOL changed_loc;
@property NSString *city;
@property NSString *state;
@property BOOL isConnectionAvailable;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *wifiReachability;
@end
