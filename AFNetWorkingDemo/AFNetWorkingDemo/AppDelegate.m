//
//  AppDelegate.m
//  AFNetWorkingDemo
//
//  Created by uen on 16/12/1.
//  Copyright © 2016年 UEN. All rights reserved.
//

#import "AppDelegate.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor clearColor];
    [self.window makeKeyAndVisible];
    [self createRoot];
    return YES;
}

-(void)createRoot
{
    NSArray *nameVc=@[@"JsonGetViewController",@"JsonPostViewController"];//要复制不能错
    NSDictionary *dic1=@{@"title":@"JsonGet",@"tabImage":@"tabbar_account"};
    NSDictionary *dic2=@{@"title":@"JsonPost",@"tabImage":@"tabbar_appfree"};
    NSArray *dicArray=@[dic1,dic2];
    
    NSMutableArray *viewControllers=[NSMutableArray new];
    for (NSInteger i=0; i<nameVc.count; i++) {
        //Class 认为是一个装类的盒子，NSClassFromString()在运行时告诉class中装的是哪个类
        Class class=NSClassFromString(nameVc[i]);
        UIViewController *vc=[[class alloc]init];
        
        //vc.title = [dicArray[i] objectForKey:@"title"];
        vc.title = dicArray[i][@"title"];
        vc.tabBarItem.image=[UIImage imageNamed:[dicArray[i] objectForKey:@"tabImage"]];
        vc.tabBarItem.selectedImage=[UIImage imageNamed:[NSString stringWithFormat:@"%@_press",[dicArray[i] objectForKey:@"tabImage"]]];
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
        [viewControllers addObject:nav];
    }
    UITabBarController *tab=[[UITabBarController alloc]init];
    tab.viewControllers=viewControllers;
    self.window.rootViewController=tab;
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
