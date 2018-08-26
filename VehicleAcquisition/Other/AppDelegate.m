//
//  AppDelegate.m
//  VehicleAcquisition
//
//  Created by blm on 2018/8/24.
//  Copyright © 2018年 blm. All rights reserved.
//

#import "AppDelegate.h"
#import "VAHomeViewController.h"
#import "VACheckDataViewController.h"
#import "VCPasswordViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setRootVC];
    [self setVendors];
    return YES;
}

- (void)setRootVC {
    self.window = [[UIWindow alloc]init];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.frame = [UIScreen mainScreen].bounds;
    /// 先检查有无基础数据，没有则加载基础数据。有则判断是否密码登录
    // 假数据
    switch ([VCLoginModel sharedLoginModel].isAllBaseData) {
        case 0:
        {
            VACheckDataViewController *checkDataVC = [[VACheckDataViewController alloc]initWithNibName:NSStringFromClass([VACheckDataViewController class]) bundle:nil];
            [self.window setRootViewController:checkDataVC];
           
        }
            break;
            
        case 1:
        {
            if ([VCLoginModel sharedLoginModel].login) {
                VAHomeViewController *homeVC = [[VAHomeViewController alloc]initWithNibName:NSStringFromClass([VAHomeViewController class]) bundle:nil];
                [self.window setRootViewController:homeVC];
            } else {
                VCPasswordViewController *passwordVC = [[VCPasswordViewController alloc]init];
                [self.window setRootViewController:passwordVC];
            }
        }
            break;
    }
    [self.window makeKeyAndVisible];
}

- (void)setVendors {
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
