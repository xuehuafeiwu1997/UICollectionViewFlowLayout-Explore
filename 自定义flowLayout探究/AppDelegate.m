//
//  AppDelegate.m
//  自定义flowLayout探究
//
//  Created by 许明洋 on 2020/9/28.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
//    FirstViewController *vc = [[FirstViewController alloc] init];
//    SecondViewController *vc = [[SecondViewController alloc] init];
    ThirdViewController *vc = [[ThirdViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    return YES;
}

@end
