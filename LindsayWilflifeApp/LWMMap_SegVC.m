//
//  LWMMap_SegVC.m
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMMap_SegVC.h"
#import "LWMDetail_SegVC.h"
#import <SystemConfiguration/SystemConfiguration.h>

#define METERS_PER_MILE 1609.344

@interface LWMMap_SegVC ()
@property bool doneonce;
@end

@implementation LWMMap_SegVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
<<<<<<< HEAD

=======
>>>>>>> origin/master
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
<<<<<<< HEAD
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if ([self isConnectionAvailable] && ((status==kCLAuthorizationStatusAuthorizedAlways) || (status==kCLAuthorizationStatusAuthorizedWhenInUse))) {
=======
    
    if ([self isConnectionAvailable]) {
>>>>>>> origin/master
        [self removeAllPinsButUserLocation];
        [self db_pull];
    }

}

<<<<<<< HEAD
-(void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse){
            id userLocation = [_mapView userLocation];
            if (userLocation != nil ) {
                [_mapView setShowsUserLocation:YES];
        }
    }
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    [_locationManager requestAlwaysAuthorization];
    [_locationManager startUpdatingLocation];
}

=======
>>>>>>> origin/master
-(void) refresh{
    
    if ([self isConnectionAvailable]) {
        [self removeAllPinsButUserLocation];
        [self db_pull];
    }
    
}

- (void)removeAllPinsButUserLocation
{
    id userLocation = [_mapView userLocation];
    [_mapView removeAnnotations:[_mapView annotations]];
    
    if (userLocation != nil ) {
       [_mapView setShowsUserLocation:YES];
    }
}

-(void)db_pull{

    
    
    
    DBAccess *dba = [[DBAccess alloc]init];
    _geo_locations = dba.getNoteswithLoc;

    
    
    
    _annotations = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in _geo_locations) {
        CLLocation *loc =[dict objectForKey:@"loc"];
        if (loc.coordinate.longitude==0.0f && loc.coordinate.latitude==0.0f) {
            if ([self isConnectionAvailable]) {
                CLGeocoder *geo = [[CLGeocoder alloc] init];
                [geo geocodeAddressString:[dict objectForKey:@"location"] completionHandler:^(NSArray *placemarks, NSError *error) {
                    if(!error){
                        if (placemarks.count) {
                            CLPlacemark *mark = [placemarks objectAtIndex:0];
                            LWMAnnotation *annotation = [[LWMAnnotation alloc] initWithCoordinates:mark.location.coordinate title:[dict objectForKey:@"name"] subTitle:[dict objectForKey:@"date"]];
                            [_mapView addAnnotation:annotation];
                            [_annotations addObject:annotation];
                            Note *n = [dict objectForKey:@"note"];
                            [n setLatitude:mark.location.coordinate.latitude];
                            [n setLongitude:mark.location.coordinate.longitude];
                            [dba deleteNote:n.key];
                            [dba saveNote:n];
                        }
                        
                    }
                }];
            }
        }
        
        else{
            LWMAnnotation *annotation = [[LWMAnnotation alloc] initWithCoordinates:loc.coordinate title:[dict objectForKey:@"name"] subTitle:[dict objectForKey:@"date"]];
            [_mapView addAnnotation:annotation];
            [_annotations addObject:annotation];
        }
        
    }
    
    [_mapView setShowsUserLocation:YES];
    if (_annotations.count>0) {
        MKMapRect zoomRect = MKMapRectNull;
        for (id <MKAnnotation> annotation in _mapView.annotations)
        {
            MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
            MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.2, 0.2);
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
        MKCoordinateRegion region = MKCoordinateRegionForMapRect(zoomRect);

        region.span.latitudeDelta  *= 1.5;
        region.span.longitudeDelta *= 1.5;

        if( region.span.latitudeDelta > 360 ) { region.span.latitudeDelta  = 360; }
        if( region.span.longitudeDelta > 360 ){ region.span.longitudeDelta = 360; }
        MKMapPoint a = MKMapPointForCoordinate(CLLocationCoordinate2DMake(
                                                                          region.center.latitude + region.span.latitudeDelta / 2,
                                                                          region.center.longitude - region.span.longitudeDelta / 2));
        MKMapPoint b = MKMapPointForCoordinate(CLLocationCoordinate2DMake(
                                                                          region.center.latitude - region.span.latitudeDelta / 2,
                                                                          region.center.longitude + region.span.longitudeDelta / 2));
        
        [_mapView setVisibleMapRect: MKMapRectMake(MIN(a.x,b.x), MIN(a.y,b.y), ABS(a.x-b.x), ABS(a.y-b.y)) animated:YES];
    }
    else{
        [_mapView setCenterCoordinate:_mapView.userLocation.coordinate];
    }
    

}



- (void)viewDidLoad
{
    [super viewDidLoad];
<<<<<<< HEAD
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
        //[_locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startUpdatingLocation];
    
    if ([self isConnectionAvailable]) {
        //_locationManager = [[CLLocationManager alloc] init];
        //[_locationManager requestAlwaysAuthorization];
        //[_locationManager setDelegate:self];
=======
    _mapView.delegate = self;
    if ([self isConnectionAvailable]) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDelegate:self];
>>>>>>> origin/master
        
        [_locationManager setDistanceFilter:kCLDistanceFilterNone];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
        [_mapView setShowsUserLocation:YES];
    }
    else{
        [_mapView setShowsUserLocation:NO];
    }
    
    

    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([self isConnectionAvailable]) {
        if ([annotation isKindOfClass:[MKUserLocation class]]) {
            return nil;
        }
        static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
        MKPinAnnotationView* pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
        pinView.animatesDrop=YES;
        pinView.canShowCallout=YES;
        pinView.pinColor=MKPinAnnotationColorGreen;
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton setTitle:annotation.title forState:UIControlStateNormal];
        pinView.rightCalloutAccessoryView = rightButton;
        return pinView;
    }
    else{
        return nil;
    }
    
    
    
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{

    _clickedannotation = view.annotation.title;

    [self performSegueWithIdentifier:@"Details" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Details"]) {
        LWMDetail_SegVC *detail = segue.destinationViewController;

        for(NSDictionary *dict in _geo_locations) {
            if ([[dict objectForKey:@"name"] isEqualToString:_clickedannotation]) {
                detail.note = [dict objectForKey:@"note"];
            }
        }
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
    }
}
@end
