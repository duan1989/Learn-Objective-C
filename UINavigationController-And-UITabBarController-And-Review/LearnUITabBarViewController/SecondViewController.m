//
//  SecondViewController.m
//  LearnUITabBarViewController
//
//  Created by 李恺 on 13-1-8.
//  Copyright (c) 2013年 likai. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Second";
        self.tabBarItem.image = [UIImage imageNamed: @"help_30.png"];
        
        NSArray *actions = [NSArray arrayWithObjects: @"Add", @"Edit", nil];
        UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems: actions];
        segment.segmentedControlStyle = UISegmentedControlStyleBar;
        self.navigationItem.titleView = segment;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
