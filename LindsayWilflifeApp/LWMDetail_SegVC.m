//
//  LWMDetail_SegVC.m
//  LindsayWildlifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMDetail_SegVC.h"
#import <Social/Social.h>
#import <QuartzCore/QuartzCore.h>
#import "LWMStyle.h"
#import "LWMCreateNoteVC.h"
#import "LWMShareNote.h"
#import "DBAccess.h"
#import <SystemConfiguration/SystemConfiguration.h>


@interface LWMDetail_SegVC ()

@end

@implementation LWMDetail_SegVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isConnectionAvailable=0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    NSString *remoteHostName = @"www.apple.com";
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
	[self.hostReachability startNotifier];
    [self configure:self.internetReachability];
    self.internetReachability = [Reachability reachabilityForInternetConnection];
	[self.internetReachability startNotifier];
	[self configure:self.internetReachability];
    self.wifiReachability = [Reachability reachabilityForLocalWiFi];
	[self.wifiReachability startNotifier];
    [self configure:self.internetReachability];
    
    // Do any additional setup after loading the view.
    self.title=_note.name;

    _location.text=_note.location;
    _tags.text=_note.tags;
    
    //Setting Date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    _date.text = [formatter stringFromDate:_note.date];
    
    //Setting Image
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
    
    //Text colors

    _date.TextColor = [LWMStyle setTextColor:@"light"];

    _location.textColor = [LWMStyle setTextColor:@"light"];

    _tagsTitle.textColor = [LWMStyle setTextColor:@"light"];

    
    //Background colors
    _darkView.backgroundColor = [LWMStyle setBackgroundColor:@"dark"];
	
    _notesBackground.textAlignment = NSTextAlignmentNatural;
    _notes.layer.cornerRadius = 20.0;
    _notesBackground.backgroundColor = [LWMStyle setDetailBackgroundColor:@"light"];
    _notesBackground.layer.cornerRadius = 20.0;
    
    _notesContainer.backgroundColor = [LWMStyle setDetailBackgroundColor:@"light"];
    
    self.view.backgroundColor = [LWMStyle setBackgroundColor:@"dark"];
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc]init];
    
    NSMutableParagraphStyle *hyphenation = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [hyphenation setHyphenationFactor:1.0];
    attributes[NSParagraphStyleAttributeName] = hyphenation;
    
    attributes[NSFontAttributeName] = [LWMStyle setFont:@"description"];
    attributes[NSForegroundColorAttributeName] = [LWMStyle setTextColor:@"dark"];
    
    _notesBackground.attributedText = [[NSAttributedString alloc] initWithString:_note.note attributes:attributes];
    
    CGSize sizeThatShouldFitTheContent = [_notesBackground sizeThatFits:_notesBackground.frame.size];
    
    if (sizeThatShouldFitTheContent.height < 180.0f) {
        sizeThatShouldFitTheContent.height = 180.0f;
    }
    
    _textboxheight.constant = sizeThatShouldFitTheContent.height;

    
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGSize sizeThatShouldFitTheContent = [_notesBackground sizeThatFits:_notesBackground.frame.size];
    
    if (sizeThatShouldFitTheContent.height < 180.0f) {
        sizeThatShouldFitTheContent.height = 180.0f;
    }
    
    _textboxheight.constant = sizeThatShouldFitTheContent.height;

    if ([self isConnectionAvailable]) {
        if ((![_note.location hasPrefix:@"Unknown"] && ![_note.location hasSuffix:@"Unknown"]) && (_note.longitude==0.0f && _note.latitude==0.0f)) {
            CLGeocoder *geo = [[CLGeocoder alloc] init];
            DBAccess *dba = [[DBAccess alloc]init];
            [geo geocodeAddressString:_note.location completionHandler:^(NSArray *placemarks, NSError *error) {
                if(!error){
                    if (placemarks.count) {
                        CLPlacemark *mark = [placemarks objectAtIndex:0];
                        _note.longitude=mark.location.coordinate.longitude;
                        _note.latitude=mark.location.coordinate.latitude;
                        [dba deleteNote:_note.key];
                        [dba saveNote:_note];
                    }
                }
            }];
        }
    }
    
}

- (void) viewDidLayoutSubviews{
    CGFloat totalHeight = 0.0f;
    totalHeight = _textboxheight.constant + _lightView.frame.size.height + 40.0f;

    [_darkView setContentSize:(CGSizeMake(320, totalHeight))];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"edit_note"]) {
        UINavigationController *nav =segue.destinationViewController;
        LWMCreateNoteVC *edit = [nav.viewControllers objectAtIndex:(0)];
        
        edit.note=_note;
        edit.date_location=_note.location;
        edit.date_key=_note.key;
        edit.caller=@"Detail";
        edit.delegate = self;

    }
    
    if ([segue.identifier isEqualToString:@"share_note"]) {
        UINavigationController *nav =segue.destinationViewController;
        LWMShareNote *detail = [nav.viewControllers objectAtIndex:(0)];
        detail.post_image = _image.image;
        detail.post_message = _note.note;
        detail.post_name = [[NSString alloc] initWithFormat:@" %@",_note.name];
        detail.PostTags = _note.tags;
        detail.geoloc = [[NSString alloc] initWithFormat:@"%f, %f", _note.latitude, _note.longitude];
        detail.location =_note.location;
    }

}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"share_note"]) {
        
        if (_isConnectionAvailable) {
            return YES;
        }
        else {

            UIAlertView *offline = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Sharing is not enabled in Airplane or offline mode.\n\nCheck your network connection." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [offline show];
            return NO;
        }
        
    }
    else{
        return YES;
    }
    
}

-(void)update:(Note *)updated_note{
    self.title=_note.name;
    
    _note=updated_note;
    
    _location.text=updated_note.location;

    _tags.text=updated_note.tags;
    
    _notesBackground.text=updated_note.note;
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc]init];
    
    NSMutableParagraphStyle *hyphenation = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [hyphenation setHyphenationFactor:1.0];
    attributes[NSParagraphStyleAttributeName] = hyphenation;
    
    attributes[NSFontAttributeName] = [LWMStyle setFont:@"description"];
    attributes[NSForegroundColorAttributeName] = [LWMStyle setTextColor:@"dark"];
    
    _notesBackground.attributedText = [[NSAttributedString alloc] initWithString:updated_note.note attributes:attributes];
    
    
    //Setting Date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    _date.text = [formatter stringFromDate:updated_note.date];
    
    //Setting Image
    if (_date_img) {

        NSURL *url = [[NSURL alloc] initWithString:updated_note.imgReference];
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
    
    _date_key = updated_note.key;
    _longitude = updated_note.longitude;
    _latitude = updated_note.latitude;
    
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
            //_isConnectionAvailable=YES;
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
        //statusString= [NSString stringWithFormat:connectionRequiredFormatString, statusString];
    }
}

-(void)reset{
    
}



@end
