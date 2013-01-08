//
//  AppDelegate.h
//  LearnUITabBarViewController
//
//  Created by 李恺 on 13-1-8.
//  Copyright (c) 2013年 likai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FirstViewController;
@class SecondViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UINavigationController *firstNavigationController;
@property (strong, nonatomic) FirstViewController *firstViewController;
@property (strong, nonatomic) UINavigationController *secondNavigationController;
@property (strong, nonatomic) SecondViewController *secondViewController;

@end
