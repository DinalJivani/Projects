//
//  AppDelegate.m
//  BackgroundTaskDemo
//
//  Created by EbitM02 on 11/10/18.
//  Copyright © 2018 Krishna. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
{
    UIBackgroundTaskIdentifier bgTask;
    NSMutableArray *arr;
    NSTimer *timer;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)])
    {
        bgTask = UIBackgroundTaskInvalid;
        [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(doBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
}

- (void)doBackground:(NSNotification *)aNotification {
    UIApplication *app = [UIApplication sharedApplication];
    
    if ([app respondsToSelector:@selector(beginBackgroundTaskWithExpirationHandler:)]) {
        
        arr = [NSMutableArray new];
        timer = [NSTimer scheduledTimerWithTimeInterval:179.0 target:self selector:@selector(appendData) userInfo:nil repeats:YES];
        
        bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
              dispatch_async(dispatch_get_main_queue(), ^{
                      if (bgTask != UIBackgroundTaskInvalid){
                          [app endBackgroundTask:bgTask];
                          bgTask = UIBackgroundTaskInvalid;
                      }
                  });
           }];
    }
}

-(void)appendData {
    [arr addObject:[self getRecordFromrandomPosition]];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    UIApplication *app = [UIApplication sharedApplication];
    if ([app respondsToSelector:@selector(endBackgroundTask:)])
    {
        if (bgTask != UIBackgroundTaskInvalid)
        {
            [app endBackgroundTask:bgTask];
            bgTask = UIBackgroundTaskInvalid;
            [timer invalidate];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"%@", [arr componentsJoinedByString:@"\n"]] preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive
                handler:^void (UIAlertAction *action) {
            }]];
            
            UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            alertWindow.rootViewController = [UIViewController new];
            alertWindow.windowLevel = UIWindowLevelAlert + 1;
            [alertWindow makeKeyAndVisible];
            [alertWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}

- (void)applicationWillTerminate:(UIApplication *)application {
   
}

-(NSString *)getRecordFromrandomPosition {
    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:@"Krishna", @"Ajay", @"Hardik", @"Vivek", @"Jay", @"Sandeep", @"jdf", nil];
    return [arr objectAtIndex:[self randomNumberBetween:0 maxNumber:arr.count - 1]];
}

- (NSInteger)randomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max {
    return min + arc4random_uniform((uint32_t)(max - min + 1));
}

@end
