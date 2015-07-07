//
//  LWMSpecialSegmentedControl.m
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMSpecialSegmentedControl.h"
#import "LWMStyle.h"

@implementation LWMSpecialSegmentedControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    //Defining images
    UIImage *div_left = [[UIImage imageNamed:@"seg_sep_right_select.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 13)];
    UIImage *div_right = [[UIImage imageNamed:@"seg_sep_left_select.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 13)];
    UIImage *div_both = [[UIImage imageNamed:@"seg_sep_none_select.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 13)];
    UIImage *normalBackgroundImage = [[UIImage imageNamed:@"seg_mid.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 13)];
    UIImage *selectedBackgroundImage = [[UIImage imageNamed:@"seg_mid_select.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 13)];
    UIImage *div_none = [[UIImage imageNamed:@"seg_sep_both_select.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 13)];
    
    //Setting divider images
    [self setDividerImage:div_both forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    [self setDividerImage:div_left forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self setDividerImage:div_right forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    [self setDividerImage:div_right forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    [self setDividerImage:div_both forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    [self setDividerImage:div_left forLeftSegmentState:UIControlStateHighlighted rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self setDividerImage:div_both forLeftSegmentState:UIControlStateHighlighted rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    [self setDividerImage:div_none forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    
    
    [self setBackgroundImage:normalBackgroundImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    [self setBackgroundImage:selectedBackgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self setBackgroundImage:normalBackgroundImage
                            forState:UIControlStateSelected
                          barMetrics:UIBarMetricsDefault];
    
    [self setBackgroundImage:normalBackgroundImage
                            forState:UIControlStateHighlighted
                          barMetrics:UIBarMetricsDefault];
    
    [self setBackgroundImage:selectedBackgroundImage
                            forState:UIControlStateNormal
                          barMetrics:UIBarMetricsDefault];
    
    //Setting fonts
    UIFont *font = [UIFont fontWithName:@"Helvetica-Light" size:18.0f];
    
    NSDictionary * selectedAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                         [LWMStyle setTextColor:@"dark"],
                                         NSForegroundColorAttributeName,
                                         font, NSFontAttributeName,
                                         nil];
    
    NSDictionary * deselectedAttributes= [NSDictionary dictionaryWithObjectsAndKeys:
                                          [LWMStyle setTextColor:@"light"],
                                          NSForegroundColorAttributeName,
                                          font, NSFontAttributeName,
                                          nil];
    
    
    [self setTitleTextAttributes:selectedAttributes forState:UIControlStateHighlighted];
    
    [self setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
    
    [self setTitleTextAttributes:deselectedAttributes forState:UIControlStateNormal];
    

    
    
}


@end
