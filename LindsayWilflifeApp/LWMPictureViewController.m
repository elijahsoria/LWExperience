//
//  LWMPictureViewController.m
//  Lindsay Wildlife
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMPictureViewController.h"
#import "LWMStyle.h"

@interface LWMPictureViewController ()

@end

@implementation LWMPictureViewController


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
    
    /*Tried to get height of image to change with different images
    float ratio, hgt;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        
        if(result.height == 667)
        {
            ratio = 375 / _image.size.width;
            hgt = _image.size.height * ratio;
            [_Picture setFrame:CGRectMake(0, 129, 375, hgt)];
        } else {
            ratio = 320 / _image.size.width;
            hgt = _image.size.height * ratio;
            [_Picture setFrame:CGRectMake(0, 129, 320, hgt)];
        }
    }*/
    self.PicScroll.minimumZoomScale=0.5;
    
    self.PicScroll.maximumZoomScale=6.0;
    
    self.PicScroll.contentSize=CGSizeMake(320, 220);
    
    self.PicScroll.delegate=self;
    
    _Picture.image=_image;
    
    _Name.attributedText=_NameText;
    _Name.textColor=[LWMStyle setTextColor:@"light"];
     //Do any additional setup after loading the view.
    _Habitat.attributedText=_HabText;
    _Habitat.textColor=[LWMStyle setTextColor:@"light"];
    
}

/*Trying to get the zoom in scroll view to work
 - (CGRect) zoomRectForScrollView:(UIScrollView *)PicScroll withScale:(float)scale withCenter:(CGPoint)center {
    CGRect zoomRect;
    
    zoomRect.size.height = PicScroll.frame.size.height / scale;
    zoomRect.size.width  = PicScroll.frame.size.width  / scale;
    
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}*/

- (void)viewWillAppear:(BOOL)animated{
    CGAffineTransform landscapeTransform = CGAffineTransformMakeRotation(0.0f * M_PI / 180.0f);
    landscapeTransform = CGAffineTransformTranslate (landscapeTransform, +80.0, +100.0);

    
    [self.view setTransform:landscapeTransform];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
