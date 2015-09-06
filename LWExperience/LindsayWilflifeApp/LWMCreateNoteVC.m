//
//  LWMCreateNoteVC.m
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMCreateNoteVC.h"
#import "LWMStyle.h"
#import "DBAccess.h"
#import "Note.h"
#import "Animal_Full.h"
#import "LWMDetail_SegVC.h"
#import <Foundation/Foundation.h>
#import "SystemConfiguration/SystemConfiguration.h"

@interface LWMCreateNoteVC ()

@end

@implementation LWMCreateNoteVC
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.userInteractionEnabled=YES;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isConnectionAvailable=0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.internetReachability = [Reachability reachabilityForInternetConnection];
	[self.internetReachability startNotifier];
	[self configure:self.internetReachability];
    NSString *remoteHostName = @"www.apple.com";
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
	[self.hostReachability startNotifier];
    [self configure:self.internetReachability];
    self.wifiReachability = [Reachability reachabilityForLocalWiFi];
	[self.wifiReachability startNotifier];
    [self configure:self.internetReachability];
    
    
    if ([_caller isEqual:@"Detail"]) {
        self.title=@"EDIT";
    }
    if ([_caller isEqual:@"Camera"]) {
        self.title=@"CREATE";
    }
    
    if (_isConnectionAvailable) {
        _locManager = [[CLLocationManager alloc] init];
        [_locManager setDelegate:self];
        [_locManager setDistanceFilter:kCLDistanceFilterNone];
        [_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [_locManager startUpdatingLocation];
    }
    
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
   
    
    [self.view addGestureRecognizer:tapGesture];
    
    _name.text=_note.name;
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *tag_attributes = [[NSMutableDictionary alloc]init];
    
    NSMutableParagraphStyle *hyphenation = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [hyphenation setHyphenationFactor:1.0];
    attributes[NSParagraphStyleAttributeName] = hyphenation;
    
    attributes[NSFontAttributeName] = [LWMStyle setFont:@"description"];
    attributes[NSForegroundColorAttributeName] = [LWMStyle setTextColor:@"dark"];
    tag_attributes[NSForegroundColorAttributeName] = [LWMStyle setTextColor:@"dark"];
    if (_note.note) {
        _notes.attributedText = [[NSAttributedString alloc] initWithString:_note.note attributes:attributes];
    }
    else{
        _notes.attributedText = [[NSAttributedString alloc] initWithString:@"" attributes:attributes];
    }
    

    _location.text=_date_location;

    
    
    if (_note.tags) {
        _tags.attributedText = [[NSAttributedString alloc] initWithString:_note.tags attributes:tag_attributes];
    }
    else{
        _tags.attributedText = [[NSAttributedString alloc] initWithString:@"" attributes:tag_attributes];
    }
    
    
    
    //Setting Date---------------------------------------------
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    _date.text = [formatter stringFromDate:_note.date];
    
    //Setting Image--------------------------------------------
    if (_note.imgReference) {
        NSURL *url = [[NSURL alloc] initWithString:_note.imgReference];
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library assetForURL:url resultBlock:^(ALAsset *asset){
            ALAssetRepresentation *rep = [asset defaultRepresentation];
            CGImageRef iref = [rep fullScreenImage];
            if (iref) {
                _image.image = [UIImage imageWithCGImage:iref];
            }
            else {
                //Error or Default image
            }
        }failureBlock:^(NSError *error){
            //Error handling
        }];
    }
   
    _location.text = _note.location;

    
    //Text colors
    [_name setTextColor:[LWMStyle setTextColor:@"dark"]];
    [_date setTextColor:[LWMStyle setTextColor:@"dark"]];
    [_date_title setTextColor:[LWMStyle setTextColor:@"dark"]];
    [_location setTextColor:[LWMStyle setTextColor:@"dark"]];
    [_location_title setTextColor:[LWMStyle setTextColor:@"dark"]];
    [_tags_title setTextColor:[LWMStyle setTextColor:@"dark"]];
    [_title_title setTextColor:[LWMStyle setTextColor:@"dark"]];
    
    //Background colors
    [_tags setBackgroundColor:[LWMStyle setCellColor:@"light"]];
    [_lightview setBackgroundColor:[LWMStyle setCellColor:@"light"]];
    [_darkview setBackgroundColor:[LWMStyle setBackgroundColor:@"dark"]];
    _notes.backgroundColor = [UIColor whiteColor];
    _notesBackground.backgroundColor = [UIColor whiteColor];
    
    _notesBackground.layer.cornerRadius = 20.0;
	// Do any additional setup after loading the view.
    
    CGSize sizeThatShouldFitTheContent = [_notesBackground sizeThatFits:_notesBackground.frame.size];
    
    if (sizeThatShouldFitTheContent.height < 250.0f) {
        sizeThatShouldFitTheContent.height = 250.0f;
    }

    _textheigh.constant = sizeThatShouldFitTheContent.height;

}



- (void)viewDidLayoutSubviews {
    _darkview.contentSize=CGSizeMake(320,_textheigh.constant+282.0f+300.0f);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) textViewDidBeginEditing:(UITextView *)textView {
    
    CGRect textFieldRect = [self.view.window convertRect:textView.bounds fromView:textView];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if(heightFraction < 0.0){
        
        heightFraction = 0.0;
        
    }else if(heightFraction > 1.0){
        
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if(orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown){
        
        _animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
        
    }else{
        
        _animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= _animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += _animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [_name resignFirstResponder];
    [_location resignFirstResponder];
    [_notes resignFirstResponder];
    if ([segue.identifier isEqualToString:@"show_tags"]) {
        LWMAddTagsVC *tags = segue.destinationViewController;
        tags.delegate = self;
        
        if (_tags.text.length!=0) {
            tags.tags_passed = [_tags.text componentsSeparatedByString:@", "];
        }
        else {
            tags.tags_passed = nil;
        }
    }
}

-(void)addedTags:(NSArray *)newTags {
    
    NSMutableDictionary *tag_attributes = [[NSMutableDictionary alloc]init];
    tag_attributes[NSForegroundColorAttributeName] = [LWMStyle setTextColor:@"dark"];
    
    _note.tags = _tags.text;

    
    if (_note.tags) {
        _tags.attributedText = [[NSAttributedString alloc] initWithString:[[newTags valueForKey:@"description"] componentsJoinedByString:@", "] attributes:tag_attributes];
    }
    else{
        _tags.attributedText = [[NSAttributedString alloc] initWithString:@"" attributes:tag_attributes];
    }
    
}

-(void)hideKeyBoard {
    [_notes resignFirstResponder];
    _note.note=_notes.text;
}


- (IBAction)save_note:(id)sender {
    DBAccess *dba = [[DBAccess alloc]init];
    
    
    if (![[_date_location lowercaseString] isEqualToString:[_location.text lowercaseString]]) {
        if ([_location.text isEqualToString:@""]) {
            _note.location=@"Unknown";
            _note.longitude=0.0f;

            _note.latitude=0.0f;
            if ([_tags.text isEqualToString: @""]) {
                _note.tags=@"";
            }
            else{
                _note.tags=_tags.text;
            }
            if ([_notes.text isEqualToString: @""]) {
                _note.note=@"";
            }
            else{
                _note.note=_notes.text;
            }
            _note.name=_name.text;

            
            NSString *key = [NSString stringWithFormat:@"%@_%@_%f_%f_%f_%@", _note.name, _note.imgReference, [_note.date timeIntervalSince1970], _note.latitude, _note.longitude, _note.tags];
            key=[key stringByReplacingOccurrencesOfString:@"'" withString:@"_"];
            _note.key=key;

            
            if (![_date_key isEqualToString:@""]) {

                [dba deleteNote:_date_key];
                [dba saveNote:_note];
            }
            else{
                NSString *curDate=[NSString stringWithFormat:@"%ldl", (long)[[NSDate date] timeIntervalSince1970]];
                
                [NSDateFormatter localizedStringFromDate:[NSDate date]
                                               dateStyle:NSDateFormatterShortStyle
                                               timeStyle:NSDateFormatterFullStyle];
                NSString *thumPath = [NSString stringWithFormat:@"%@.png", curDate];
                [_note setThum_path: thumPath];
                
                [self saveImage:[self imageWithImage:[UIImage imageWithCGImage:_image.image.CGImage] scaledToSize:CGSizeMake(140, 110)] :thumPath];
                
                [dba saveNote:_note];
            }

            if ([_caller isEqualToString:@"Detail"]) {

                
                [_delegate update:_note];

                
            }
            else{
                [_delegate reset];
            }
            
            UIAlertView *save_alert = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Your note is saved. View it in the My Notes tab." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [save_alert show];
            

        }
        else{
            if ([self isConnectionAvailable]) {
                CLGeocoder *geo = [[CLGeocoder alloc] init];
                [geo geocodeAddressString:_location.text completionHandler:^(NSArray *placemarks, NSError *error) {
                    if(!error){
                        if (placemarks.count) {
                            CLPlacemark *mark = [placemarks objectAtIndex:0];
                            _note.longitude=mark.location.coordinate.longitude;

                            _note.latitude=mark.location.coordinate.latitude;

                            
                            if ([_tags.text isEqualToString: @""]) {
                                _note.tags=@"";
                            }
                            else{
                                _note.tags=_tags.text;
                            }
                            if ([_notes.text isEqualToString: @""]) {
                                _note.note=@"";
                            }
                            else{
                                _note.note=_notes.text;
                            }
                            _note.name=_name.text;
                            _note.location=_location.text;
                            
                            NSString *key = [NSString stringWithFormat:@"%@_%@_%f_%f_%f_%@", _note.name, _note.imgReference, [_note.date timeIntervalSince1970], _note.latitude, _note.longitude, _note.tags];
                            key=[key stringByReplacingOccurrencesOfString:@"'" withString:@"_"];
                            _note.key=key;

                            
                            if (![_date_key isEqualToString:@""]) {

                                [dba deleteNote:_date_key];
                                [dba saveNote:_note];
                            }
                            else{
                                NSString *curDate=[NSString stringWithFormat:@"%ldl", (long)[[NSDate date] timeIntervalSince1970]];
                                
                                [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                               dateStyle:NSDateFormatterShortStyle
                                                               timeStyle:NSDateFormatterFullStyle];
                                NSString *thumPath = [NSString stringWithFormat:@"%@.png", curDate];
                                [_note setThum_path: thumPath];

                                [self saveImage:[self imageWithImage:[UIImage imageWithCGImage:_image.image.CGImage] scaledToSize:CGSizeMake(140, 110)] :thumPath];
                                
                                [dba saveNote:_note];
                            }
                            

                            if ([_caller isEqualToString:@"Detail"]) {

                                [_delegate update:_note];

                                
                            }
                            else{
                                [_delegate reset];
                            }
                            
                            UIAlertView *save_alert = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Your note is saved. View it in the My Notes tab." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                            [save_alert show];

                        }
                        else{
                            _note.longitude=0.0f;
                            _note.latitude=0.0f;
                            if ([_tags.text isEqualToString: @""]) {
                                _note.tags=@"";
                            }
                            else{
                                _note.tags=_tags.text;
                            }
                            if ([_notes.text isEqualToString: @""]) {
                                _note.note=@"";
                            }
                            else{
                                _note.note=_notes.text;
                            }
                            _note.name=_name.text;
                            _note.location=_location.text;
                            
                            NSString *key = [NSString stringWithFormat:@"%@_%@_%f_%f_%f_%@", _note.name, _note.imgReference, [_note.date timeIntervalSince1970], _note.latitude, _note.longitude, _note.tags];
                            
                            key=[key stringByReplacingOccurrencesOfString:@"'" withString:@"_"];
                            
                            _note.key=key;

                            
                            if (![_date_key isEqualToString:@""]) {

                                [dba deleteNote:_date_key];
                                [dba saveNote:_note];
                            }
                            else{
                                NSString *curDate=[NSString stringWithFormat:@"%ldl", (long)[[NSDate date] timeIntervalSince1970]];
                                
                                [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                               dateStyle:NSDateFormatterShortStyle
                                                               timeStyle:NSDateFormatterFullStyle];
                                NSString *thumPath = [NSString stringWithFormat:@"%@.png", curDate];
                                
                                [_note setThum_path: thumPath];

                                [self saveImage:[self imageWithImage:[UIImage imageWithCGImage:_image.image.CGImage] scaledToSize:CGSizeMake(140, 110)] :thumPath];
                                
                                [dba saveNote:_note];
                            }

                            if ([_caller isEqualToString:@"Detail"]) {

                                
                                [_delegate update:_note];

                                
                            }
                            else{
                                [_delegate reset];
                            }
                            
                            UIAlertView *save_alert = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Your note is saved. View it in the My Notes tab." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                            [save_alert show];
                        }

                        
                    }
                    else{
                        _note.longitude=0.0f;
                        _note.latitude=0.0f;
                        if ([_tags.text isEqualToString: @""]) {
                            _note.tags=@"";
                        }
                        else{
                            _note.tags=_tags.text;
                        }
                        if ([_notes.text isEqualToString: @""]) {
                            _note.note=@"";
                        }
                        else{
                            _note.note=_notes.text;
                        }
                        _note.name=_name.text;
                        _note.location=_location.text;
                        
                        NSString *key = [NSString stringWithFormat:@"%@_%@_%f_%f_%f_%@", _note.name, _note.imgReference, [_note.date timeIntervalSince1970], _note.latitude, _note.longitude, _note.tags];
                        key=[key stringByReplacingOccurrencesOfString:@"'" withString:@"_"];
                        _note.key=key;

                        
                        if (![_date_key isEqualToString:@""]) {

                            [dba deleteNote:_date_key];
                            [dba saveNote:_note];
                        }
                        else{
                            NSString *curDate=[NSString stringWithFormat:@"%ldl", (long)[[NSDate date] timeIntervalSince1970]];
                            
                            [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                           dateStyle:NSDateFormatterShortStyle
                                                           timeStyle:NSDateFormatterFullStyle];
                            NSString *thumPath = [NSString stringWithFormat:@"%@.png", curDate];
                            [_note setThum_path: thumPath];
                            
                            [self saveImage:[self imageWithImage:[UIImage imageWithCGImage:_image.image.CGImage] scaledToSize:CGSizeMake(140, 110)] :thumPath];
                            
                            [dba saveNote:_note];
                        }
                        

                        
                        if ([_caller isEqualToString:@"Detail"]) {

                            
                            [_delegate update:_note];

                            
                        }
                        else{
                            [_delegate reset];
                        }
                        
                        UIAlertView *save_alert = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Your note is saved. View it in the My Notes tab." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                        [save_alert show];
                        
                    }
                }];
            }
            else{
                _note.longitude=0.0f;
                _note.latitude=0.0f;
                if ([_tags.text isEqualToString: @""]) {
                    _note.tags=@"";
                }
                else{
                    _note.tags=_tags.text;
                }
                if ([_notes.text isEqualToString: @""]) {
                    _note.note=@"";
                }
                else{
                    _note.note=_notes.text;
                }
                _note.name=_name.text;
                _note.location=_location.text;
                
                NSString *key = [NSString stringWithFormat:@"%@_%@_%f_%f_%f_%@", _note.name, _note.imgReference, [_note.date timeIntervalSince1970], _note.latitude, _note.longitude, _note.tags];
                key=[key stringByReplacingOccurrencesOfString:@"'" withString:@"_"];
                _note.key=key;

                
                if (![_date_key isEqualToString:@""]) {

                    [dba deleteNote:_date_key];
                    [dba saveNote:_note];
                }
                else{
                    NSString *curDate=[NSString stringWithFormat:@"%ldl", (long)[[NSDate date] timeIntervalSince1970]];
                    
                    [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                   dateStyle:NSDateFormatterShortStyle
                                                   timeStyle:NSDateFormatterFullStyle];
                    NSString *thumPath = [NSString stringWithFormat:@"%@.png", curDate];
                    [_note setThum_path: thumPath];
                    
                    [self saveImage:[self imageWithImage:[UIImage imageWithCGImage:_image.image.CGImage] scaledToSize:CGSizeMake(140, 110)] :thumPath];
                    
                    [dba saveNote:_note];
                }
                

                
                if ([_caller isEqualToString:@"Detail"]) {

                    
                    [_delegate update:_note];

                    
                }
                else{
                    [_delegate reset];
                }
                
                UIAlertView *save_alert = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Your note is saved. View it in the My Notes tab." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [save_alert show];

            }

            
        }
        
        
        
    }
    else{
        if ([_tags.text isEqualToString: @""]) {
            _note.tags=@"";
        }
        else{
            _note.tags=_tags.text;
        }
        if ([_notes.text isEqualToString: @""]) {
            _note.note=@"";
        }
        else{
            _note.note=_notes.text;
        }
        _note.name=_name.text;
        _note.location=_location.text;
        
        NSString *key = [NSString stringWithFormat:@"%@_%@_%f_%f_%f_%@", _note.name, _note.imgReference, [_note.date timeIntervalSince1970], _note.latitude, _note.longitude, _note.tags];
        key=[key stringByReplacingOccurrencesOfString:@"'" withString:@"_"];
        _note.key=key;

        
        if (![_date_key isEqualToString:@""]) {

            [dba deleteNote:_date_key];
            [dba saveNote:_note];
        }
        else{
            NSString *curDate=[NSString stringWithFormat:@"%ldl", (long)[[NSDate date] timeIntervalSince1970]];
            
            [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                             dateStyle:NSDateFormatterShortStyle
                                                             timeStyle:NSDateFormatterFullStyle];
            NSString *thumPath = [NSString stringWithFormat:@"%@.png", curDate];
            [_note setThum_path: thumPath];
            
            [self saveImage:[self imageWithImage:[UIImage imageWithCGImage:_image.image.CGImage] scaledToSize:CGSizeMake(140, 110)] :thumPath];
            
            [dba saveNote:_note];
        }

        
        if ([_caller isEqualToString:@"Detail"]) {

            
            [_delegate update:_note];

            
        }
        else{
            [_delegate reset];
        }
        
        UIAlertView *save_alert = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Your note is saved. View it in the My Notes tab." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [save_alert show];

        
    }
    
    
    
}

- (void)saveImage: (UIImage*)image : (NSString*)file_path
{
    if (image != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          file_path];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
    }
}


- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView.title isEqualToString:@"Warning"]) {
        if (buttonIndex == 1) {
            
            if (![_caller isEqualToString:@"Detail"]){
                [_delegate reset];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }
    
    if([alertView.title isEqualToString:@"Saved"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }


}

- (IBAction)cancel_note:(id)sender {
    
    UIAlertView *cancel_alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Changes you made have not been saved! Do you want to really want to cancel?" delegate:self cancelButtonTitle:@"Go Back" otherButtonTitles:@"Don't Save", nil];
    [cancel_alert show];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [_name resignFirstResponder];
    [_location resignFirstResponder];
    
    if (![[_date_location lowercaseString] isEqualToString:[_location.text lowercaseString]]) {
        if ([self isConnectionAvailable]) {
            CLGeocoder *geo = [[CLGeocoder alloc] init];
            
            [geo geocodeAddressString:_location.text completionHandler:^(NSArray *placemarks, NSError *error) {
                if(!error){
                    if (placemarks.count) {
                        CLPlacemark *mark = [placemarks objectAtIndex:0];
                        _note.longitude=mark.location.coordinate.longitude;
                        _note.latitude=mark.location.coordinate.latitude;
                    }
                    else{
                        _note.longitude=0.0f;
                        _note.latitude=0.0f;
                    }
                }
                else{
                    _note.longitude=0.0f;
                    _note.latitude=0.0f;
                }
            }];
        }
        else{
            _note.longitude=0.0f;
            _note.latitude=0.0f;
        }
        
    }
    
    return NO;
}

/*!
 * Called by Reachability whenever status changes.
 */
- (void) reachabilityChanged:(NSNotification *)note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
	[self updateInterfaceWithReachability:curReach];
}


- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    if (reachability == self.hostReachability)
	{
        //NetworkStatus netStatus = [reachability currentReachabilityStatus];
        BOOL connectionRequired = [reachability connectionRequired];
        
        
        if (connectionRequired)
        {
            _isConnectionAvailable=NO;
        }
        else
        {
           // _isConnectionAvailable=YES;
        }
        
    }
    
	if (reachability == self.internetReachability || reachability == self.wifiReachability)
	{
		[self configure:reachability];
	}
    
}


- (void)configure: (Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    //NSString* statusString = @"";
    
    switch (netStatus)
    {
        case NotReachable:        {
            /*
             Minor interface detail- connectionRequired may return YES even when the host is unreachable. We cover that up here...
             */
            _isConnectionAvailable=NO;
            connectionRequired = NO;
            break;
        }
            
        case ReachableViaWWAN:        {
            _isConnectionAvailable=YES;
            break;
        }
        case ReachableViaWiFi:        {
            _isConnectionAvailable=YES;
            break;
        }
    }
    
    if (connectionRequired)
    {
        _isConnectionAvailable=NO;
    }
}

@end
