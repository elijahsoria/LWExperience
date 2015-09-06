//
//  Note.h
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject
@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * imgReference;
@property (nonatomic, retain) NSString * location;
@property double latitude;
@property double longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * tags;
@property (nonatomic, retain) NSString * thum_path;
@end
