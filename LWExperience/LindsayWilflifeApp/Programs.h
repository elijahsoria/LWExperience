//
//  Programs.h
//  TxtFileToJson
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Programs : NSObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * image_path;

@end
