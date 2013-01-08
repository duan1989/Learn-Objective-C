//
//  FirstViewController.m
//  LearnUITabBarViewController
//
//  Created by 李恺 on 13-1-8.
//  Copyright (c) 2013年 likai. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"First";
        self.tabBarItem.image = [UIImage imageNamed:@"home_30.png"];
        
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(leftButtonPress:)];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightButtonPress:)];
        self.navigationItem.leftBarButtonItem = leftButton;
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    return self;
}

- (void)leftButtonPress: (UIBarButtonItem *)sender {
    UIViewController *viewController = [[UIViewController alloc] initWithNibName: nil bundle: nil];
    viewController.title = @"Edit";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(gotoRoot:)];
    viewController.navigationItem.rightBarButtonItem = rightButton;
    
    [self.navigationController pushViewController: viewController animated: YES];
}

- (void)rightButtonPress: (UIBarButtonItem *)sender {
    UIViewController *viewController = [[UIViewController alloc] initWithNibName: nil bundle: nil];
    viewController.title = @"Add";
    [self.navigationController pushViewController: viewController animated: YES];
}

- (void)gotoRoot: (UIBarButtonItem *)sender {
    [self.navigationController popToRootViewControllerAnimated: YES];
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
