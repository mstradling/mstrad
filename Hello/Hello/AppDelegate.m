//
//  AppDelegate.m
//  Hello
//
//  Created by Matthew Frederick Stradling on 5/5/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "MasterViewController.h"
#import "MFSHelloDoc.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    MFSHelloDoc *space1 = [[MFSHelloDoc alloc] initWithTitle:NSLocalizedString(@"World!", nil) rating:3 thumbImage:[UIImage imageNamed:@"earthThumb.jpg"] fullImage:[UIImage imageNamed:@"earth.jpg"]];
    MFSHelloDoc *space2 = [[MFSHelloDoc alloc] initWithTitle:NSLocalizedString(@"Sun!", nil) rating:2 thumbImage:[UIImage imageNamed:@"sunThumb.png"] fullImage:[UIImage imageNamed:@"sun.jpg"]];
    MFSHelloDoc *space3 = [[MFSHelloDoc alloc] initWithTitle:NSLocalizedString(@"Galaxy!", nil) rating:4 thumbImage:[UIImage imageNamed:@"galaxyThumb.jpg"] fullImage:[UIImage imageNamed:@"galaxy.jpg"]];
    
    NSMutableArray *spaces = [NSMutableArray arrayWithObjects:space1, space2, space3, nil];
    
    UINavigationController *navController = (UINavigationController *) self.window.rootViewController;
    MasterViewController *masterController = [navController.viewControllers objectAtIndex:0];
    masterController.spaces = spaces;
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
