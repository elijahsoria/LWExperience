//
//  LWMMap_SegVC.h
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LWMAnnotation.h"
#import "Note.h"
#import "DBAccess.h"
#import "Reachability.h"

@interface LWMMap_SegVC : UIViewController <UIApplicationDelegate, CLLocationManagerDelegate,MKMapViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property NSArray *geo_locations;
@property NSMutableArray *annotations;
@property NSString *clickedannotation;
-(void) refresh;
@property BOOL isConnectionAvailable;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *wifiReachability;
@end