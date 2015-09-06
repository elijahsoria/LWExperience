//
//  LWMTutorialViewController.m
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMTutorialViewController.h"

@interface LWMTutorialViewController ()

@end

@implementation LWMTutorialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = _scroll.frame.size.width;
    int page_num = floor((_scroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _page.currentPage = page_num;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
    //Put the names of our image files in our array.
    
    
    
    //if(IsIphone5)
    //{
        _tutorialArray = [[NSArray alloc] initWithObjects:@"6t1.png", @"6t2.png", @"6t3.png", @"6t4.png", @"6t5.png", @"6t6.png", @"6t7.png", @"6t8.png", @"6t10.png", @"6t9.png", @"6t11.png", @"6t12.png", @"6t13.png", @"6t14.png", @"6t15.png", nil];
    //}
    //else
    //{
    //    _tutorialArray = [[NSArray alloc] initWithObjects:@"4t1.png", @"4t2.png", @"4t3.png", @"4t4.png", @"4t5.png", @"4t6.png", @"4t7.png", @"4t8.png", @"4t10.png", @"4t9.png", @"4t11.png", @"4t12.png", @"4t13.png", @"4t14.png", @"4t15.png", nil];
    //}
    
    for (int i = 0; i <[_tutorialArray count]; i++) {
        //We'll create an imageView object in every 'page' of our scrollView.
        CGRect frame;
        frame.origin.x = _scroll.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = _scroll.frame.size;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:[_tutorialArray objectAtIndex:i]];
        [_scroll addSubview:imageView];
    }
    //Set the content size of our scrollview according to the total width of our imageView objects.
    _scroll.contentSize = CGSizeMake(_scroll.frame.size.width * [_tutorialArray count], _scroll.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
