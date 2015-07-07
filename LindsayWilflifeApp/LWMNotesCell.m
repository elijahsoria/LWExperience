//
//  LWMNotesCell.m
//  LindsayWildlifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMNotesCell.h"


@implementation LWMNotesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.bounds = CGRectMake(10, 8, 80, 63);
    self.imageView.frame = CGRectMake(10, 8, 80, 63);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.backgroundColor=[UIColor whiteColor];
    self.textLabel.frame = CGRectMake(110, 0, 170, 62);
    self.textLabel.bounds = CGRectMake(110, 0, 170, 62);
    self.detailTextLabel.frame =CGRectMake(110, 50, 170, 15);
    self.detailTextLabel.bounds =CGRectMake(110, 50, 170, 15);
    
    if (![self isEditing]) {
        for (UIView *subview in self.subviews) {
            
            for (UIView *subview2 in subview.subviews) {
                if ([NSStringFromClass([subview2 class]) isEqualToString:@"UILabel"]) {
                    [subview2 removeFromSuperview];
                    
                }
            }
        }
        //_bglable = (LWMBGCellLable *)[[UILabel alloc] initWithFrame:CGRectMake(6, 5, 88, 70)];
        //_bglable.backgroundColor=[UIColor whiteColor];

        //[self addSubview:_bglable];
        //[self sendSubviewToBack:_bglable];
    }
    
    
    for (UIView *subview in self.subviews) {
            
        for (UIView *subview2 in subview.subviews) {
                
            if ([NSStringFromClass([subview2 class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"]) {
                [subview bringSubviewToFront:subview2];
                    
            }
        }
    }
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    if (editing) {
        for (UIView *subview in self.subviews) {
            
            for (UIView *subview2 in subview.subviews) {
                if ([NSStringFromClass([subview2 class]) isEqualToString:@"UILabel"]) {
                    [subview2 removeFromSuperview];
                    _bglable = (LWMBGCellLable *)[[UILabel alloc] initWithFrame:CGRectMake(6, 5, 88, 70)];
                    _bglable.backgroundColor=[UIColor whiteColor];
                    [self addSubview:_bglable];
                    [self sendSubviewToBack:_bglable];
                    
                    
                }
            }
        }
    }
    
}


@end
