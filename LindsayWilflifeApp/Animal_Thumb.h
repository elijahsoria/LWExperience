//
//  Animal_Thumb.h
//  Database
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AnimalGold;

@interface Animal_Thumb : NSManagedObject

@property (nonatomic, retain) NSString * common_name;
@property (nonatomic, retain) NSString * habitat;
@property (nonatomic, retain) NSString * image_path;
@property (nonatomic, retain) AnimalGold *thumbToFull;

@end
