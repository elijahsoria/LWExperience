//
//  LWMStyle.m
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMStyle.h"

@implementation LWMStyle

+ (UIColor *)setCellColor:(NSString *)sender
{
    if ([sender isEqualToString:@"dark"])
        return [UIColor colorWithRed:(196.0/255.0) green:(189.0/255.0) blue:(126.0/255.0) alpha:1];
    
    else if ([sender isEqualToString:@"light"])
        return [UIColor colorWithRed:(255.0/255.0) green:(253.0/255.0) blue:(171.0/255.0) alpha:1];
    
    else
        return nil;
}


+ (UIColor *)setTextColor:(NSString *)sender
{
    if ([sender isEqualToString:@"dark"])
        return [UIColor colorWithRed:(108.0/255.0) green:(107.0/255.0) blue:(101.0/255.0) alpha: 1];
    
    else if ([sender isEqualToString:@"light"])
        return [UIColor colorWithRed:(251.0/255.0) green:(255.0/255.0) blue:(210.0/255.0) alpha:1];
    
    else
        return nil;
}

+ (UIColor *)setDetailBackgroundColor:(NSString *)sender
{
    if ([sender isEqualToString:@"dark"])

        return [UIColor colorWithRed:(170.0/255.0) green:(122.0/255.0) blue:(77.0/255.0) alpha:1];
    
    else if ([sender isEqualToString:@"light"])

        return [UIColor colorWithRed:(244.0/255.0) green:(247.0/255.0) blue:(170.0/255.0) alpha:1];
    
    else
        return nil;
    
}

+ (UIColor *)setBackgroundColor:(NSString *)sender
{
    if ([sender isEqualToString:@"dark"])
        return [UIColor colorWithRed:(61.0 / 255.0) green:(61.0 / 255.0) blue:(58.0 / 255.0) alpha: 1];

    else if ([sender isEqualToString:@"light"])
        return [UIColor colorWithRed:(214.0 / 255.0) green:(217.0 / 255.0) blue:(183.0 / 255.0) alpha: 1];
    else if ([sender isEqualToString:@"black"])
        return [[UIColor blackColor] colorWithAlphaComponent:0.55f];
    else
        return nil;
}

+(UIFont *)setFont:(NSString *)sender
{
    if ([sender isEqualToString:@"title"])
        return [UIFont fontWithName:@"HelveticaNeue" size:20.0];
    
    else if ([sender isEqualToString:@"description"])
        return [UIFont fontWithName:@"HelveticaNeue" size:17.0];
    
    else if ([sender isEqualToString:@"description_bold"])
        return [UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0];
    
    else
        return nil;

}


@end
