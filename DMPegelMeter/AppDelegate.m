//
//  AppDelegate.m
//  DMPegelMeter
//
//  Created by Michael Johann on 22.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <RestKit/RKObjectManager.h>
#import "AppDelegate.h"

#import "ViewController.h"
#import "PegelMessung.h"
#import "RKXMLParserLibXML.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

+ (void)setSettingsBundleDefaults {
    [AppDelegate setSettingsBundleDefaultsForFile:@"Root.plist"];
}

+ (void)setSettingsBundleDefaultsForFile:(NSString *)plistFileName {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];

    //bundle path
    NSString *bPath = [[NSBundle mainBundle] bundlePath];
    NSString *settingsPath = [bPath stringByAppendingPathComponent:@"Settings.bundle"];
    NSString *plistFile = [settingsPath stringByAppendingPathComponent:plistFileName];

    //preferences
    NSDictionary *settingsDictionary = [NSDictionary dictionaryWithContentsOfFile:plistFile];
    NSArray *preferencesArray = [settingsDictionary objectForKey:@"PreferenceSpecifiers"];

    //loop thru prefs
    NSDictionary *item;
    for (item in preferencesArray) {
        //get the key
        NSString *keyValue = [item objectForKey:@"Key"];

        //get the default
        id defaultValue = [item objectForKey:@"DefaultValue"];

        // if we have both, set in defaults
        if (keyValue && defaultValue)
            [standardUserDefaults setObject:defaultValue forKey:keyValue];

        //get the file item if any - (recurse thru the other settings files)
        NSString *fileValue = [item objectForKey:@"File"];
        if (fileValue)
            [AppDelegate setSettingsBundleDefaultsForFile:[fileValue stringByAppendingString:@".plist"]];

    }
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    [standardUserDefaults synchronize];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];

    if (nil == [preferences valueForKey:@"host_ip"]) {
        [AppDelegate setSettingsBundleDefaults];
    }

    [[RKParserRegistry sharedRegistry] setParserClass:[RKXMLParserLibXML class] forMIMEType:@"application/xhtml+xml"];

    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
