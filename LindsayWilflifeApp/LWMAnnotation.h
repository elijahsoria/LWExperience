//
//  LWMAnnotation.h
//  LindsayWildlifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LWMAnnotation : NSObject <MKAnnotation>

@property (nonatomic, copy, readonly) NSString * title;
@property (nonatomic, copy, readonly) NSString * subtitle;
@property (nonatomic, readonly)CLLocationCoordinate2D coordinate;

-(instancetype) initWithCoordinates: (CLLocationCoordinate2D)paramCoordinates
                              title: (NSString *)paramTitle
                           subTitle: (NSString *)paramSubTitle;
@end
