//
//  LWMSecondViewController.m
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMCameraVC.h"

@interface LWMCameraVC ()

@end

@implementation LWMCameraVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _note=[[Note alloc] init];
    _location=[[NSString alloc] init];
    _location=@"Unknown";
    _isConnectionAvailable=0;
    
    _date_label.backgroundColor=[UIColor whiteColor];
    _location_labelCity.backgroundColor=[UIColor whiteColor];
    _location_labelState.backgroundColor=[UIColor whiteColor];
    
    self.view.backgroundColor = [LWMStyle setCellColor:@"light"];
    
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

    
    if (_isConnectionAvailable) {
        _locManager = [[CLLocationManager alloc] init];
        [_locManager setDelegate:self];
        [_locManager setDistanceFilter:kCLDistanceFilterNone];
        [_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [_locManager startUpdatingLocation];
    }
    
    
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
         BOOL connectionRequired = [reachability connectionRequired];
        
        
        if (connectionRequired)
        {
            _isConnectionAvailable=NO;
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    _currentLocation = [locations lastObject];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)selectPhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    navigationController.navigationBar.barStyle = UIBarStyleBlack;
    navigationController.navigationBar.translucent=NO;
    navigationController.view.backgroundColor = [LWMStyle setDetailBackgroundColor:@"light"];
}

- (IBAction)takePhoto:(UIButton *)sender {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Device has no camera" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [myAlertView show];
    }
    else {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        _referenceURL = [info objectForKey:UIImagePickerControllerReferenceURL];
        
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library assetForURL:_referenceURL resultBlock:^(ALAsset *asset) {
            ALAssetRepresentation *rep = [asset defaultRepresentation];
            
            _metadata = rep.metadata;
            
            
            
            CGImageRef iref = [rep fullScreenImage] ;
            if (iref) {
                _imageBox.image = img;
                
                //Get GPS from
                _selectedLocation = [asset valueForProperty:ALAssetPropertyLocation];
                
                if (_selectedLocation && [self isConnectionAvailable]) {
                    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
                    CLLocation *temploc = _selectedLocation;
                    _selectedLocation=nil;
                    _location_labelCity.text = @"Unknown";
                    _location_labelState.text = @"Unknown";
                    _location=@"Unknown";
                    _meta_location = @"Unknown";
                    //_location_labelCity.enabled = YES;
                    //_location_labelState.enabled = YES;
                    _location_labelCity.backgroundColor=[LWMStyle setCellColor:@"light"];
                    _location_labelState.backgroundColor=[LWMStyle setCellColor:@"light"];
                    
                    [geocoder reverseGeocodeLocation:temploc completionHandler:^(NSArray *placemarks, NSError *error) {
                        
                        if (!error) {
                            if(placemarks.count){
                                NSDictionary *dictionary = [[placemarks objectAtIndex:0] addressDictionary];
                                _selectedLocation=temploc;
                                _location_labelCity.text = [dictionary valueForKey:@"City"];
                                _location_labelState.text = [dictionary valueForKey:@"State"];
                                
                                _location_labelCity.backgroundColor=[LWMStyle setCellColor:@"light"];
                                _location_labelState.backgroundColor=[LWMStyle setCellColor:@"light"];
                                _location=[NSString stringWithFormat:@"%@, %@",_location_labelCity.text,_location_labelState.text];
                                _meta_location = _location;
                                _location_labelCity.enabled = YES;
                                _location_labelState.enabled = YES;

                            }
                        }
                        
                    }];
                }
                else{
                    _selectedLocation=nil;
                    _location_labelCity.text = @"Unknown";
                    _location_labelState.text = @"Unknown";
                    _location=@"Unknown";
                    _meta_location = @"Unknown";
                    //_location_labelCity.enabled = YES;
                    //_location_labelState.enabled = YES;
                    _location_labelCity.backgroundColor=[LWMStyle setCellColor:@"light"];
                    _location_labelState.backgroundColor=[LWMStyle setCellColor:@"light"];
                }
                
                _selectedDate = [asset valueForProperty:ALAssetPropertyDate];
                
                if (_selectedDate) {
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"MM-dd-yyyy"];
                    //Optionally for time zone converstions
                    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
                    
                    _date_label.text = [formatter stringFromDate:_selectedDate];
                    _date_label.backgroundColor=[LWMStyle setCellColor:@"light"];
                }
                else{
                    _date_label.text = @"Unknown";
                    _date_label.backgroundColor=[LWMStyle setCellColor:@"light"];
                }
                
            }
            
            
            
        } failureBlock:^(NSError *error) {
            // error handling
        }];
    }
    
    else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        ALAssetsLibrary *saveLib = [[ALAssetsLibrary alloc] init];
        int exif_orient = [[[info objectForKey:UIImagePickerControllerMediaMetadata] objectForKey:@"Orientation"] intValue];
        UIImageOrientation img_orientation = UIImageOrientationUp;
        switch(exif_orient)
        {
            case 1: img_orientation=UIImageOrientationUp; //NSLog(@"UP");
                break;
            case 2: img_orientation=UIImageOrientationUpMirrored; //NSLog(@"UPM");
                break;
            case 3: img_orientation=UIImageOrientationDown; //NSLog(@"DOWN");
                break;
            case 4: img_orientation=UIImageOrientationDownMirrored; //NSLog(@"DOWNM");
                break;
            case 5: img_orientation=UIImageOrientationLeftMirrored; //NSLog(@"RM");
                break;
            case 6: img_orientation=UIImageOrientationLeft; //NSLog(@"R");
                break;
            case 7: img_orientation=UIImageOrientationRightMirrored; //NSLog(@"LM");
                break;
            case 8: img_orientation=UIImageOrientationRight; //NSLog(@"L");
                break;
        }
        
    
        UIImage *img =
        [UIImage imageWithCGImage:[[info objectForKey:UIImagePickerControllerEditedImage] CGImage]
                            scale:1.0
                      orientation: img_orientation];
        
        _adj_img = [img fixOrientation];

        
        [saveLib writeImageToSavedPhotosAlbum: _adj_img.CGImage metadata:[info objectForKey:UIImagePickerControllerMediaMetadata] completionBlock:^(NSURL *assetURL, NSError *error) {

            _referenceURL = assetURL;
            _imageBox.image = [info objectForKey:UIImagePickerControllerEditedImage];
            
            //Get GPS from
        
            
            _selectedLocation = _currentLocation;
            if (_selectedLocation && [self isConnectionAvailable]) {
                CLGeocoder *geocoder = [[CLGeocoder alloc] init];
                CLLocation *temploc = _selectedLocation;
                _selectedLocation=nil;
                _location_labelCity.text = @"Unknown";
                _location_labelState.text = @"Unknown";
                _meta_location = @"Unknown";
                _location=_meta_location;
                _location_labelCity.backgroundColor=[LWMStyle setCellColor:@"light"];
                _location_labelState.backgroundColor=[LWMStyle setCellColor:@"light"];
               // _location_labelCity.enabled = YES;
                //_location_labelState.enabled = YES;
                
                [geocoder reverseGeocodeLocation:temploc completionHandler:^(NSArray *placemarks, NSError *error) {
                    //10
                    if (!error) {
                        if(placemarks.count){
                            NSDictionary *dictionary = [[placemarks objectAtIndex:0] addressDictionary];
                            _selectedLocation=temploc;
                            _city =[dictionary valueForKey:@"City"];
                            _state =[dictionary valueForKey:@"State"];
                            _location_labelCity.text = [dictionary valueForKey:@"City"];
                            _location_labelState.text = [dictionary valueForKey:@"State"];
                            _meta_location = [NSString stringWithFormat:@"%@, %@",_location_labelCity.text,_location_labelState.text];
                            _location_labelCity.backgroundColor=[LWMStyle setCellColor:@"light"];
                            _location_labelState.backgroundColor=[LWMStyle setCellColor:@"light"];
                            _location = _meta_location;

                        }
                    }
                    
                }];
            }
            else{
                _selectedLocation=nil;
                _location_labelCity.text = @"Unknown";
                _location_labelState.text = @"Unknown";
                _meta_location = @"Unknown";
                _location=_meta_location;
                _location_labelCity.backgroundColor=[UIColor whiteColor];
                _location_labelState.backgroundColor=[UIColor whiteColor];

                //_location_labelCity.enabled = YES;
                //_location_labelState.enabled = YES;
            }
            
            
            _selectedDate = [NSDate date];
            
            if (_selectedDate) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"MM-dd-yyyy"];
                //Optionally for time zone converstions
                //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
                
                _date_label.text = [formatter stringFromDate:_selectedDate];
                _date_label.backgroundColor=[LWMStyle setCellColor:@"light"];
            }
            else{
                _date_label.text = @"Unknown";
                _date_label.backgroundColor=[LWMStyle setCellColor:@"light"];

            }
            
            

        }];
    }
    //Getting metadata for image
    

    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"createNote"]) {
        UINavigationController *nav =segue.destinationViewController;
        LWMCreateNoteVC *newNote = [nav.viewControllers objectAtIndex:(0)];
        newNote.delegate=self;
        newNote.caller=@"Camera";
        

        
        _note.date=_selectedDate;
        _note.name=_name_label.text;
        _note.imgReference=[_referenceURL absoluteString];
        _note.location=_location;
        
        newNote.date_location=_location;
        newNote.date_key=@"";
        newNote.note=_note;

    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if(_referenceURL && ![_name_label.text isEqualToString:@""]) {

        if ([_date_label.text isEqualToString:@"Unknown"] || [_location_labelCity.text isEqualToString:@"Unknown"] || [_location_labelState.text isEqualToString:@"Unknown"] || [_location_labelCity.text isEqualToString:@""] || [_location_labelState.text isEqualToString:@""]) {
            
            
            if (![_location_labelCity.text isEqualToString:@"Unknown"] && ![_location_labelCity.text isEqualToString:@""])
            {

                _location=[NSString stringWithFormat:@"%@, %@",_location_labelCity.text,@"CA"];

                if (![[_meta_location lowercaseString] isEqualToString:[_location lowercaseString]]) {
                    if ([self isConnectionAvailable]) {
                        CLGeocoder *geo = [[CLGeocoder alloc] init];
                        [geo geocodeAddressString:_location completionHandler:^(NSArray *placemarks, NSError *error) {
                            if(!error){
                                if (placemarks.count) {
                                    CLPlacemark *mark = [placemarks objectAtIndex:0];
                                    _selectedLocation = mark.location;
                                    _note.longitude=_selectedLocation.coordinate.longitude;
                                    _note.latitude=_selectedLocation.coordinate.latitude;
                                    _meta_location=_location;

                                }
                                else{
                                    _selectedLocation=nil;
                                    _note.longitude=_selectedLocation.coordinate.longitude;
                                    _note.latitude=_selectedLocation.coordinate.latitude;
                                    _meta_location=_location;
                                }
                            }
                            else{
                                _selectedLocation=nil;
                                _note.longitude=_selectedLocation.coordinate.longitude;
                                _note.latitude=_selectedLocation.coordinate.latitude;
                                _meta_location=_location;
                            }
                        }];
                    }
                    else{
                        _selectedLocation=nil;
                        _note.longitude=_selectedLocation.coordinate.longitude;
                        _note.latitude=_selectedLocation.coordinate.latitude;
                        _meta_location=_location;
                    }
                    
                }
                
            }
            else if (![_location_labelState.text isEqualToString:@"Unknown"] && ![_location_labelState.text isEqualToString:@""]){
                _location=_location_labelState.text;
                _selectedLocation=nil;
                _note.longitude=_selectedLocation.coordinate.longitude;
                _note.latitude=_selectedLocation.coordinate.latitude;
                _meta_location=_location;
            }
            else {
                _location = @"Unknown";
                _selectedLocation=nil;
                _note.longitude=_selectedLocation.coordinate.longitude;
                _note.latitude=_selectedLocation.coordinate.latitude;
                _meta_location=_location;
            }
            
            UIAlertView *dateloc = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Date and/or Location unknown" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
            [dateloc show];
            
            return NO;
        }
        else {
            
            _location = [NSString stringWithFormat:@"%@, %@", _location_labelCity.text, _location_labelState.text];
            
            
            if (![[_meta_location lowercaseString] isEqualToString:[_location lowercaseString]]) {
                
                if ([self isConnectionAvailable]) {

                    CLGeocoder *geo = [[CLGeocoder alloc] init];
                    
                    [geo geocodeAddressString:_location completionHandler:^(NSArray *placemarks, NSError *error) {
                        if(!error){
                            if (placemarks.count) {
                                CLPlacemark *mark = [placemarks objectAtIndex:0];
                                _selectedLocation = mark.location;
                                _note.longitude=_selectedLocation.coordinate.longitude;
                                _note.latitude=_selectedLocation.coordinate.latitude;
                                _meta_location=_location;
                            }
                            else{
                                _selectedLocation=nil;
                                _note.longitude=_selectedLocation.coordinate.longitude;
                                _note.latitude=_selectedLocation.coordinate.latitude;
                                _meta_location=_location;
                                
                            }
                            
                            

                        }
                        else{
                            _selectedLocation=nil;
                            _note.longitude=_selectedLocation.coordinate.longitude;
                            _note.latitude=_selectedLocation.coordinate.latitude;
                            _meta_location=_location;
                        }
                    }];
                }
                else{
                    _selectedLocation=nil;
                    _note.longitude=_selectedLocation.coordinate.longitude;
                    _note.latitude=_selectedLocation.coordinate.latitude;
                    _meta_location=_location;
                }
                
                ALAssetsLibrary *saveLib = [[ALAssetsLibrary alloc] init];

                
                [saveLib writeImageToSavedPhotosAlbum: _adj_img.CGImage metadata:_metadata completionBlock:^(NSURL *assetURL, NSError *error) {

                    _referenceURL = assetURL;

                }];
                return YES;
                
            }
            else{
                _location=[NSString stringWithFormat:@"%@, %@", _location_labelCity.text, _location_labelState.text];

                
                _note.longitude=_selectedLocation.coordinate.longitude;
                _note.latitude=_selectedLocation.coordinate.latitude;
                _meta_location=_location;
                
                
                ALAssetsLibrary *saveLib = [[ALAssetsLibrary alloc] init];

                
                [saveLib writeImageToSavedPhotosAlbum: _adj_img.CGImage metadata:_metadata completionBlock:^(NSURL *assetURL, NSError *error) {

                    _referenceURL = assetURL;

                }];
                return YES;
                
            }
            
            
        }
    }
    
    else {

        UIAlertView *choosePicture = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Picture or No Title" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [choosePicture show];
        return NO;
    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView.title isEqualToString:@"Warning"]) {
        if (buttonIndex == 1) {
            [self performSegueWithIdentifier:@"createNote" sender:self];
        }
        
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [_location_labelCity resignFirstResponder];
    [_location_labelState resignFirstResponder];
    [_name_label resignFirstResponder];
    
    if (([_location_labelCity.text isEqualToString:@"Unknown"] || [_location_labelCity.text isEqualToString:@""]) && ([_location_labelState.text isEqualToString:@"Unknown"]|| [_location_labelState.text isEqualToString:@""])) {
        _location = @"Unknown";
    }
    if (([_location_labelCity.text isEqualToString:@"Unknown"] || [_location_labelCity.text isEqualToString:@""]) && !([_location_labelState.text isEqualToString:@"Unknown"]|| [_location_labelState.text isEqualToString:@""])) {
        _location = _location_labelState.text;
    }
    if (!([_location_labelCity.text isEqualToString:@"Unknown"] || [_location_labelCity.text isEqualToString:@""]) && ([_location_labelState.text isEqualToString:@"Unknown"]|| [_location_labelState.text isEqualToString:@""])) {
        _location = [NSString stringWithFormat:@"%@, CA", _location_labelCity.text];
    }
    if (!([_location_labelCity.text isEqualToString:@"Unknown"] || [_location_labelCity.text isEqualToString:@""]) && !([_location_labelState.text isEqualToString:@"Unknown"]|| [_location_labelState.text isEqualToString:@""])) {
        _location = [NSString stringWithFormat:@"%@, %@", _location_labelCity.text, _location_labelState.text];
    }
    

    
    if (![[_meta_location lowercaseString] isEqualToString:[_location lowercaseString]]) {
        
        if ([self isConnectionAvailable]) {

            CLGeocoder *geo = [[CLGeocoder alloc] init];
            
            [geo geocodeAddressString:_location completionHandler:^(NSArray *placemarks, NSError *error) {
                if(!error){
                    if (placemarks.count) {
                        CLPlacemark *mark = [placemarks objectAtIndex:0];
                        _selectedLocation = mark.location;
                        _note.longitude=_selectedLocation.coordinate.longitude;
                        _note.latitude=_selectedLocation.coordinate.latitude;
                        _meta_location=_location;
                    }
                    else{
                        _selectedLocation=nil;
                        _note.longitude=_selectedLocation.coordinate.longitude;
                        _note.latitude=_selectedLocation.coordinate.latitude;
                        _meta_location=_location;
                        
                    }
                    

                }
                else{
                    _selectedLocation=nil;
                    _note.longitude=_selectedLocation.coordinate.longitude;
                    _note.latitude=_selectedLocation.coordinate.latitude;
                    _meta_location=_location;
                }
            }];
        }
        else{
            _selectedLocation=nil;
            _note.longitude=_selectedLocation.coordinate.longitude;
            _note.latitude=_selectedLocation.coordinate.latitude;
            _meta_location=_location;
        }
        
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [_location_labelCity resignFirstResponder];
    [_location_labelState resignFirstResponder];
    [_name_label resignFirstResponder];
    
    if (([_location_labelCity.text isEqualToString:@"Unknown"] || [_location_labelCity.text isEqualToString:@""]) && ([_location_labelState.text isEqualToString:@"Unknown"]|| [_location_labelState.text isEqualToString:@""])) {
        _location = @"Unknown";
    }
    if (([_location_labelCity.text isEqualToString:@"Unknown"] || [_location_labelCity.text isEqualToString:@""]) && !([_location_labelState.text isEqualToString:@"Unknown"]|| [_location_labelState.text isEqualToString:@""])) {
        _location = _location_labelState.text;
    }
    if (!([_location_labelCity.text isEqualToString:@"Unknown"] || [_location_labelCity.text isEqualToString:@""]) && ([_location_labelState.text isEqualToString:@"Unknown"]|| [_location_labelState.text isEqualToString:@""])) {
        _location = [NSString stringWithFormat:@"%@, CA", _location_labelCity.text];
    }
    
    if (!([_location_labelCity.text isEqualToString:@"Unknown"] || [_location_labelCity.text isEqualToString:@""]) && !([_location_labelState.text isEqualToString:@"Unknown"]|| [_location_labelState.text isEqualToString:@""])) {
        _location = [NSString stringWithFormat:@"%@, %@", _location_labelCity.text, _location_labelState.text];
    }
    
    if (![[_meta_location lowercaseString] isEqualToString:[_location lowercaseString]]) {
        if ([self isConnectionAvailable]) {

            CLGeocoder *geo = [[CLGeocoder alloc] init];
            
            [geo geocodeAddressString:_location completionHandler:^(NSArray *placemarks, NSError *error) {
                if(!error){
                    if (placemarks.count) {
                        CLPlacemark *mark = [placemarks objectAtIndex:0];
                        _selectedLocation = mark.location;
                        _note.longitude=_selectedLocation.coordinate.longitude;
                        _note.latitude=_selectedLocation.coordinate.latitude;
                        _meta_location=_location;
                    }
                    else{
                        _selectedLocation=nil;
                        _note.longitude=_selectedLocation.coordinate.longitude;
                        _note.latitude=_selectedLocation.coordinate.latitude;
                        _meta_location=_location;
                    }

                }
                else{
                    _selectedLocation=nil;
                    _note.longitude=_selectedLocation.coordinate.longitude;
                    _note.latitude=_selectedLocation.coordinate.latitude;
                    _meta_location=_location;
                }
            }];
        }
        else{
            _selectedLocation=nil;
            _note.longitude=_selectedLocation.coordinate.longitude;
            _note.latitude=_selectedLocation.coordinate.latitude;
            _meta_location=_location;
        }
        
    }
    
    return NO;
}

-(void)update:(NSMutableDictionary *)updated_note{
    
}


-(void)reset{
    _referenceURL=nil;
    _note=[[Note alloc] init];
    _location=@"Unknown";
    _imageBox.image=[UIImage imageNamed:@"CameraBigGray.png"];
    _date_label.text=@"";
    _location_labelCity.text=@"";
    _location_labelState.text=@"";
    _name_label.text=@"";
    _date_label.backgroundColor=[UIColor whiteColor];
    _location_labelCity.backgroundColor=[UIColor whiteColor];
    _location_labelState.backgroundColor=[UIColor whiteColor];
}

- (IBAction)Reset:(id)sender {
    [self reset];
}


@end
