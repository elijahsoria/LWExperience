//
//  LWMSpecialCell.m
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMSpecialCell.h"

@implementation LWMSpecialCell

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

-(void) layoutSubviews
{
    [super layoutSubviews];
    

    self.imageView.bounds = CGRectMake(10, 8, 86, 63);
    self.imageView.frame = CGRectMake(10, 8, 86, 63);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.backgroundColor=[UIColor whiteColor];
    self.textLabel.frame = CGRectMake(110, 0, 185, 62);
    self.textLabel.bounds = CGRectMake(110, 0, 185, 62);
    self.detailTextLabel.frame =CGRectMake(110, 50, 185, 15);
    self.detailTextLabel.bounds =CGRectMake(110, 50, 185, 15);
    
    
    UILabel *bglable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 94, 67)];
    bglable.backgroundColor=[UIColor whiteColor];
    [self addSubview:bglable];
    [self sendSubviewToBack:bglable];
}

@end
