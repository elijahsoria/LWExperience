//
//  LWMStyle.h
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWMStyle : NSObject

+ (UIColor *)setCellColor:(NSString *)sender;
+ (UIColor *)setTextColor:(NSString *)sender;
+ (UIColor *)setDetailBackgroundColor:(NSString *)sender;
+ (UIColor *)setBackgroundColor:(NSString *)sender;
+ (UIFont *)setFont:(NSString *)sender;

@end
