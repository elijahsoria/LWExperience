//
//  LWMWildlifeAnimalsViewController.m
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMWildlifeAnimalsViewController.h"
#import "LWMWildlifeTableViewController.h"
#import "Animal_Full.h"
#import "LWMStyle.h"
#import "DBAccess.h"

@interface LWMWildlifeAnimalsViewController ()

@end

@implementation LWMWildlifeAnimalsViewController

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
    
    self.view.backgroundColor = [LWMStyle setBackgroundColor:@"dark"];
    
    
	// Do any additional setup after loading the view.
    DBAccess *dba = [[DBAccess alloc]init];
    _animalsArray = dba.getAniamls;
    
    _labelOne.text = @"BIRDS";
    _labelTwo.text = @"MAMMALS";
    _labelThree.text = @"AMPHIBIANS";
    _labelFour.text = @"REPTILES";
    
<<<<<<< HEAD
    //_labelOne.textColor = [LWMStyle setTextColor:@"light"];
    //_labelTwo.textColor = [LWMStyle setTextColor:@"light"];
    //_labelThree.textColor = [LWMStyle setTextColor:@"light"];
    //_labelFour.textColor = [LWMStyle setTextColor:@"light"];
=======
    _labelOne.textColor = [LWMStyle setTextColor:@"light"];
    _labelTwo.textColor = [LWMStyle setTextColor:@"light"];
    _labelThree.textColor = [LWMStyle setTextColor:@"light"];
    _labelFour.textColor = [LWMStyle setTextColor:@"light"];
>>>>>>> origin/master
    
    _birdArray=[[NSMutableArray alloc] init];
    NSMutableArray *tempbirdArray=[[NSMutableArray alloc] init];
    _mammalArray=[[NSMutableArray alloc] init];
    NSMutableArray *tempmammalArray=[[NSMutableArray alloc] init];
    _reptileArray=[[NSMutableArray alloc] init];
    NSMutableArray *tempreptileArray=[[NSMutableArray alloc] init];
    _amphibianArray=[[NSMutableArray alloc] init];
    NSMutableArray *tempamphibianArray=[[NSMutableArray alloc] init];
    BOOL new=1;
    
    for (Animal_Full *animal in _animalsArray)
    {
        if ([animal.animalType isEqual:@"Birds"])
        {
            [tempbirdArray addObject:animal];
        }
        
        
        
        if ([animal.animalType isEqual:@"Mammals"])
        {
            [tempmammalArray addObject:animal];
        }
        
       
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"taxOrder" ascending: YES];
        NSArray *sortedArray = [tempmammalArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        tempmammalArray = [NSMutableArray arrayWithArray:sortedArray];
        
        
        
        if ([animal.animalType isEqual:@"Amphibians"])
        {
            [tempreptileArray addObject:animal];
        }
        
        
        sortedArray = [tempreptileArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        tempreptileArray = [NSMutableArray arrayWithArray:sortedArray];
        
        
        if ([animal.animalType isEqual:@"Reptiles"])
        {
            [tempamphibianArray addObject:animal];
        }
        
        sortedArray = [tempamphibianArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        tempamphibianArray = [NSMutableArray arrayWithArray:sortedArray];
        
        
    }
    
    
    for (Animal_Full *animal in tempbirdArray)
    {
        
        for (NSMutableDictionary *group in _birdArray) {
            if ([animal.animalSubType isEqualToString:[group objectForKey:@"subgroupname"]])
            {
                [[group objectForKey:@"subgroupobjects"] addObject:animal];
                new=0;
                
            }
            
        }
        if (new==1)
        {
            NSMutableArray *subgroupobj =[[NSMutableArray alloc] initWithObjects:animal, nil];
            int taxorder = 1;
            if ([animal.animalSubType isEqualToString:@"Waterbirds, Shorebirds"]) {
                taxorder = 1;
            }
            else if ([animal.animalSubType isEqualToString:@"Herons, Egrets"]){
                taxorder = 2;
            }
            else if ([animal.animalSubType isEqualToString:@"Ducks, Geese"]){
                taxorder = 3;
            }
            else if ([animal.animalSubType isEqualToString:@"Gulls"]){
                taxorder = 4;
            }
            else if ([animal.animalSubType isEqualToString:@"Birds of Prey"]){
                taxorder = 5;
            }
            else if ([animal.animalSubType isEqualToString:@"Quails, Turkeys"]){
                taxorder = 6;
            }
            else if ([animal.animalSubType isEqualToString:@"Doves, Pigeons"]){
                taxorder = 7;
            }
            else if ([animal.animalSubType isEqualToString:@"Hummingbirds"]){
                taxorder = 8;
            }
            else if ([animal.animalSubType isEqualToString:@"Woodpeckers"]){
                taxorder = 9;
            }
            else if ([animal.animalSubType isEqualToString:@"Shrikes"]){
                taxorder = 10;
            }
            else if ([animal.animalSubType isEqualToString:@"Swallows"]){
                taxorder = 11;
            }
            else if ([animal.animalSubType isEqualToString:@"Jays, Crows, Ravens"]){
                taxorder = 12;
            }
            else if ([animal.animalSubType isEqualToString:@"Songbirds"]){
                taxorder = 13;
            }
            
            NSMutableDictionary *subgroup = [[NSMutableDictionary alloc]
                                             initWithObjectsAndKeys:animal.animalSubType, @"subgroupname",
                                             subgroupobj, @"subgroupobjects",
                                             [NSNumber numberWithInteger:taxorder], @"subgrouporder", nil];
            [_birdArray addObject:subgroup];
            
        }
        new=1;
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"subgrouporder" ascending: YES];
    NSArray *sortedArray = [_birdArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    _birdArray= [NSMutableArray arrayWithArray:sortedArray];
    
    for (NSMutableDictionary *subgroup in _birdArray) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"taxOrder" ascending: YES];
        NSArray *sortedArray = [[subgroup objectForKey:@"subgroupobjects"] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        [subgroup setObject:[NSMutableArray arrayWithArray:sortedArray] forKey:@"subgroupobjects"];
    }
    
    NSMutableDictionary *subgroup = [[NSMutableDictionary alloc]
                                     initWithObjectsAndKeys:@"Mammals", @"subgroupname",
                                     tempmammalArray, @"subgroupobjects", nil];
    [_mammalArray addObject:subgroup];

    
    subgroup = [[NSMutableDictionary alloc]
                initWithObjectsAndKeys:@"Amphibians", @"subgroupname",
                tempreptileArray, @"subgroupobjects", nil];
    [_reptileArray addObject:subgroup];
    
    subgroup = [[NSMutableDictionary alloc]
                initWithObjectsAndKeys:@"Reptiles", @"subgroupname",
                tempamphibianArray, @"subgroupobjects", nil];
    [_amphibianArray addObject:subgroup];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LWMWildlifeTableViewController *table = segue.destinationViewController;
    
    if([segue.identifier isEqualToString:@"birdSegue"])
    {
        table.wildlifeArray = _birdArray;
        table.wildlifeTitle = @"BIRDS";
    }
    
    if([segue.identifier isEqualToString:@"mammalSegue"])
    {
        table.wildlifeArray = _mammalArray;
        table.wildlifeTitle = @"MAMMALS";
    }
    
    if([segue.identifier isEqualToString:@"reptileSegue"])
    {
        table.wildlifeArray = _reptileArray;
        table.wildlifeTitle = @"AMPHIBIANS";
    }
    
    if([segue.identifier isEqualToString:@"amphibianSegue"])
    {
        table.wildlifeArray = _amphibianArray;
        table.wildlifeTitle = @"REPTILES";
    }
}



@end
