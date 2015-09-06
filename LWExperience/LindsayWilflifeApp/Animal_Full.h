//
//  Animal_Full.h
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>



@interface Animal_Full : NSObject

@property (nonatomic, retain) NSString * commonName;
@property (nonatomic, retain) NSString * fullDiscription;
@property (nonatomic, retain) NSString * habitatType;
@property (nonatomic, retain) NSString * animalType;
@property (nonatomic, retain) NSString * animalSubType;
@property int taxOrder;
@property (nonatomic, retain) NSString * largeImagePath;
@property (nonatomic, retain) NSString * smallImagePath;
@property (nonatomic, retain) NSString * scientificName;
@property (nonatomic, retain) NSString * animalSos;


@end
