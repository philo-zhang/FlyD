//
//  AppDelegate.m
//  FlyDJI
//
//  Created by zhangzhe on 15/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:1.0];
    // Override point for customization after application launch.
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    NSFileManager *fileMgr = [[NSFileManager alloc] init];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *fileArray = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
    NSError *error;
    
    for (NSString *filename in fileArray) {
        [fileMgr removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:&error];
    }
    
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    fileArray = [fileMgr contentsOfDirectoryAtPath:cachesDirectory error:nil];
    for (NSString *filename in fileArray) {
        [fileMgr removeItemAtPath:[cachesDirectory stringByAppendingPathComponent:filename] error:&error];
    }
    
    fileArray = [fileMgr contentsOfDirectoryAtPath:NSTemporaryDirectory() error:nil];
    for (NSString *filename in fileArray) {
        [fileMgr removeItemAtPath:[NSTemporaryDirectory() stringByAppendingPathComponent:filename] error:&error];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Enter Background" object:nil];
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
    /*
    NSFileManager *fileMgr = [[NSFileManager alloc] init];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *fileArray = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
    NSError *error;
    for (NSString *filename in fileArray) {
        [fileMgr removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:&error];
    }
    
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    fileArray = [fileMgr contentsOfDirectoryAtPath:cachesDirectory error:nil];
    for (NSString *filename in fileArray) {
        [fileMgr removeItemAtPath:[cachesDirectory stringByAppendingPathComponent:filename] error:&error];
    }
    
    fileArray = [fileMgr contentsOfDirectoryAtPath:NSTemporaryDirectory() error:nil];
    for (NSString *filename in fileArray) {
        [fileMgr removeItemAtPath:[NSTemporaryDirectory() stringByAppendingPathComponent:filename] error:&error];
    }
     */
}

@end
