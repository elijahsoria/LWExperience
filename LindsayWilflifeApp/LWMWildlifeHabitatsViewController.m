//
//  LWMWildlifeHabitatsViewController.m
//  LindsayWilflifeApp
//
//  Created by Marco Avalos, Elliott Battle, Anthony Braddick, Katy Duran,
//  Weiwei Pan, John Spalluzzi on 12/10/13.
//  Copyright (c) 2013 Lindsay Wildlife Museum. All rights reserved.
//

#import "LWMWildlifeHabitatsViewController.h"
#import "LWMHabitatTableViewController.h"
#import "Animal_Full.h"
#import "LWMStyle.h"
#import "DBAccess.h"

@interface LWMWildlifeHabitatsViewController ()

@end

@implementation LWMWildlifeHabitatsViewController

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
    
    self.view.backgroundColor = [LWMStyle setBackgroundColor:@"dark"];
    
    DBAccess *dba = [[DBAccess alloc]init];
    _animalsArray = dba.getAniamls;
    
    _labelOne.text = @"WATER";
    _labelTwo.text = @"PARK";
    _labelThree.text = @"OPEN SPACE";
    _labelFour.text = @"BACKYARD";
    
    //_labelOne.textColor = [LWMStyle setTextColor:@"light"];
    //_labelTwo.textColor = [LWMStyle setTextColor:@"light"];
    //_labelThree.textColor = [LWMStyle setTextColor:@"light"];
    //_labelFour.textColor = [LWMStyle setTextColor:@"light"];

    
    _waterArray=[[NSMutableArray alloc] init];
    _openSpaceArray=[[NSMutableArray alloc] init];
    _parkArray=[[NSMutableArray alloc] init];
    _backyardArray=[[NSMutableArray alloc] init];
    NSMutableArray *tempwaterArray=[[NSMutableArray alloc] init];
    NSMutableArray *tempopenSpaceArray=[[NSMutableArray alloc] init];
    NSMutableArray *tempparkArray=[[NSMutableArray alloc] init];
    NSMutableArray *tempbackyardArray=[[NSMutableArray alloc] init];
    
    for (Animal_Full *animal in _animalsArray)
    {
        if ([animal.habitatType hasPrefix:@"Water"] || [animal.habitatType hasSuffix:@"Water"])
        {
            [tempwaterArray addObject:animal];
        }
        
        if ([animal.habitatType hasPrefix:@"Backyard"] || [animal.habitatType hasSuffix:@"Backyard"])
        {
            [tempbackyardArray addObject:animal];
        }
        
        if ([animal.habitatType hasPrefix:@"Open space"] || [animal.habitatType hasSuffix:@"Open space"])
        {
            [tempopenSpaceArray addObject:animal];
        }
        
        if ([animal.habitatType hasPrefix:@"Park"] || [animal.habitatType hasSuffix:@"Park"])
        {
            [tempparkArray addObject:animal];
        }

    }
    BOOL new=1;
    
    for (Animal_Full *animal in tempwaterArray)
    {
        
        for (NSMutableDictionary *group in _waterArray) {
            if ([animal.animalSubType isEqualToString:[group objectForKey:@"subgroupname"]])
            {
                [[group objectForKey:@"subgroupobjects"] addObject:animal];
                new=0;
                
            }
            
        }
        if (new==1)
        {
            NSMutableArray *subgroupobj =[[NSMutableArray alloc] initWithObjects:animal, nil];
            
            int taxorder = -2;
            if ([animal.animalSubType isEqualToString:@"Invertebrate"] || [animal.animalSubType isEqualToString:@"Invertebrates"]) {
                taxorder = -2;
            }
            else if ([animal.animalSubType isEqualToString:@"Amphibians"]) {
                taxorder = -1;
            }
            else if ([animal.animalSubType isEqualToString:@"Reptiles"]) {
                taxorder = 0;
            }
            else if ([animal.animalSubType isEqualToString:@"Waterbirds, Shorebirds"]) {
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
            else if ([animal.animalSubType isEqualToString:@"Mammals"]){
                taxorder = 14;
            }
            
            NSMutableDictionary *subgroup = [[NSMutableDictionary alloc]
                                             initWithObjectsAndKeys:animal.animalSubType, @"subgroupname",
                                             subgroupobj, @"subgroupobjects",
                                             [NSNumber numberWithInteger:taxorder], @"subgrouporder", nil];
            [_waterArray addObject:subgroup];
            
        }
        new=1;
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"subgrouporder" ascending: YES];
    NSArray *sortedArray = [_waterArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    _waterArray= [NSMutableArray arrayWithArray:sortedArray];
    
    for (NSMutableDictionary *subgroup in _waterArray) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"taxOrder" ascending: YES];
        NSArray *sortedArray = [[subgroup objectForKey:@"subgroupobjects"] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        [subgroup setObject:[NSMutableArray arrayWithArray:sortedArray] forKey:@"subgroupobjects"]  ;
    }
    
    new=1;
    
    for (Animal_Full *animal in tempbackyardArray)
    {
        
        for (NSMutableDictionary *group in _backyardArray) {
            if ([animal.animalSubType isEqualToString:[group objectForKey:@"subgroupname"]])
            {
                [[group objectForKey:@"subgroupobjects"] addObject:animal];
                new=0;
                
            }
            
        }
        if (new==1)
        {
            NSMutableArray *subgroupobj =[[NSMutableArray alloc] initWithObjects:animal, nil];
            int taxorder = -2;
            if ([animal.animalSubType isEqualToString:@"Invertebrate"] || [animal.animalSubType isEqualToString:@"Invertebrates"]) {
                taxorder = -2;
            }
            else if ([animal.animalSubType isEqualToString:@"Amphibians"]) {
                taxorder = -1;
            }
            else if ([animal.animalSubType isEqualToString:@"Reptiles"]) {
                taxorder = 0;
            }
            else if ([animal.animalSubType isEqualToString:@"Waterbirds, Shorebirds"]) {
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
            else if ([animal.animalSubType isEqualToString:@"Mammals"]){
                taxorder = 14;
            }
            
            NSMutableDictionary *subgroup = [[NSMutableDictionary alloc]
                                             initWithObjectsAndKeys:animal.animalSubType, @"subgroupname",
                                             subgroupobj, @"subgroupobjects",
                                             [NSNumber numberWithInteger:taxorder], @"subgrouporder", nil];
            [_backyardArray addObject:subgroup];
            
        }
        new=1;
    }
    
    sortedArray = [_backyardArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    _backyardArray= [NSMutableArray arrayWithArray:sortedArray];
    
    for (NSMutableDictionary *subgroup in _backyardArray) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"taxOrder" ascending: YES];
        NSArray *sortedArray = [[subgroup objectForKey:@"subgroupobjects"] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        [subgroup setObject:[NSMutableArray arrayWithArray:sortedArray] forKey:@"subgroupobjects"]  ;
    }
    
    for (Animal_Full *animal in tempopenSpaceArray)
    {
        
        for (NSMutableDictionary *group in _openSpaceArray) {
            if ([animal.animalSubType isEqualToString:[group objectForKey:@"subgroupname"]])
            {
                [[group objectForKey:@"subgroupobjects"] addObject:animal];
                new=0;
                
            }
            
        }
        if (new==1)
        {
            NSMutableArray *subgroupobj =[[NSMutableArray alloc] initWithObjects:animal, nil];
            int taxorder = -2;
            if ([animal.animalSubType isEqualToString:@"Invertebrate"] || [animal.animalSubType isEqualToString:@"Invertebrates"]) {
                taxorder = -2;
            }
            else if ([animal.animalSubType isEqualToString:@"Amphibians"]) {
                taxorder = -1;
            }
            else if ([animal.animalSubType isEqualToString:@"Reptiles"]) {
                taxorder = 0;
            }
            else if ([animal.animalSubType isEqualToString:@"Waterbirds, Shorebirds"]) {
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
            else if ([animal.animalSubType isEqualToString:@"Mammals"]){
                taxorder = 14;
            }
            
            NSMutableDictionary *subgroup = [[NSMutableDictionary alloc]
                                             initWithObjectsAndKeys:animal.animalSubType, @"subgroupname",
                                             subgroupobj, @"subgroupobjects",
                                             [NSNumber numberWithInteger:taxorder], @"subgrouporder", nil];
            [_openSpaceArray addObject:subgroup];
            
        }
        new=1;
    }

    sortedArray = [_openSpaceArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    _openSpaceArray= [NSMutableArray arrayWithArray:sortedArray];
    
    for (NSMutableDictionary *subgroup in _openSpaceArray) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"taxOrder" ascending: YES];
        NSArray *sortedArray = [[subgroup objectForKey:@"subgroupobjects"] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        [subgroup setObject:[NSMutableArray arrayWithArray:sortedArray] forKey:@"subgroupobjects"]  ;
    }
    
    for (Animal_Full *animal in tempparkArray)
    {
        
        for (NSMutableDictionary *group in _parkArray) {
            if ([animal.animalSubType isEqualToString:[group objectForKey:@"subgroupname"]])
            {
                [[group objectForKey:@"subgroupobjects"] addObject:animal];
                new=0;
                
            }
            
        }
        if (new==1)
        {
            NSMutableArray *subgroupobj =[[NSMutableArray alloc] initWithObjects:animal, nil];
            int taxorder = -2;
            if ([animal.animalSubType isEqualToString:@"Invertebrate"] || [animal.animalSubType isEqualToString:@"Invertebrates"]) {
                taxorder = -2;
            }
            else if ([animal.animalSubType isEqualToString:@"Amphibians"]) {
                taxorder = -1;
            }
            else if ([animal.animalSubType isEqualToString:@"Reptiles"]) {
                taxorder = 0;
            }
            else if ([animal.animalSubType isEqualToString:@"Waterbirds, Shorebirds"]) {
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
            else if ([animal.animalSubType isEqualToString:@"Mammals"]){
                taxorder = 14;
            }
            
            NSMutableDictionary *subgroup = [[NSMutableDictionary alloc]
                                             initWithObjectsAndKeys:animal.animalSubType, @"subgroupname",
                                             subgroupobj, @"subgroupobjects",
                                             [NSNumber numberWithInteger:taxorder], @"subgrouporder", nil];
            [_parkArray addObject:subgroup];
            
        }
        new=1;
    }
    
    sortedArray = [_parkArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    _parkArray= [NSMutableArray arrayWithArray:sortedArray];
    
    for (NSMutableDictionary *subgroup in _parkArray) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"taxOrder" ascending: YES];
        NSArray *sortedArray = [[subgroup objectForKey:@"subgroupobjects"] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        [subgroup setObject:[NSMutableArray arrayWithArray:sortedArray] forKey:@"subgroupobjects"]  ;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LWMHabitatTableViewController *table = segue.destinationViewController;
    
    if([segue.identifier isEqualToString:@"waterSegue"])
    {
        table.habitatArray = _waterArray;
        table.habitatTitle = @"WATER";
    }
    
    if([segue.identifier isEqualToString:@"openSpaceSegue"])
    {
        table.habitatArray = _openSpaceArray;
        table.habitatTitle = @"OPEN SPACE";
    }
    
    if([segue.identifier isEqualToString:@"urbanSegue"])
    {
        table.habitatArray = _parkArray;
        table.habitatTitle = @"PARK";
    }
    
    if([segue.identifier isEqualToString:@"backyardSegue"])
    {
        table.habitatArray = _backyardArray;
        table.habitatTitle = @"BACKYARD";
    }
}

@end
