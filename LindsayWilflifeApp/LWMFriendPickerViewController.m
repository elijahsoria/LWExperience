//
//  LWMFriendPickerViewController.m
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMFriendPickerViewController.h"
#import "LWMStyle.h"

@interface LWMFriendPickerViewController ()

@end

@implementation LWMFriendPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    //do something like background color, title, etc you self
    navbar.tintColor=[LWMStyle setTextColor:@"light"];
    navbar.barStyle=UIBarStyleBlack;
    navbar.translucent=NO;
    UINavigationItem *navItem = [UINavigationItem alloc];
    navItem.title = @"In App Friends";
    
    navItem.rightBarButtonItem=self.doneButton;
    navItem.leftBarButtonItem=self.cancelButton;
    [navbar pushNavigationItem:navItem animated:false];

    [self.view addSubview:navbar];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;

}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [LWMStyle setDetailBackgroundColor:@"light"];
}

-(void)saveAction:(UIBarButtonItem *)sender{
    
    
}

-(void)cancelAction:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
