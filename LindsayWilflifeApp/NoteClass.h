//
//  NoteClass.h
//  Lindsay Wildlife
//
//  Created by Weiwei Pan on 8/31/15.
//  Copyright (c) 2015 LWM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NoteClass : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * imageReference;
@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * tags;
@property (nonatomic, retain) NSString * thum_path;

@end
