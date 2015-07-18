//
//  LWMSpecialTableViewController.m
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMSpecialTableViewController.h"
#import "LWMStyle.h"

@implementation LWMSpecialTableViewController

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row %2 == 0)
    {
        cell.backgroundColor = [LWMStyle setCellColor:@"light"];
        cell.textLabel.textColor = [LWMStyle setTextColor:@"dark"];
        cell.detailTextLabel.textColor = [LWMStyle setTextColor:@"dark"];
    }
    
    if (indexPath.row % 2 == 1)
    {
        cell.backgroundColor = [LWMStyle setCellColor:@"dark"];
        cell.textLabel.textColor = [LWMStyle setTextColor:@"light"];
        cell.detailTextLabel.textColor = [LWMStyle setTextColor:@"light"];
    }
}


@end
