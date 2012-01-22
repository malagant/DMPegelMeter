//
//  AppDelegate.h
//  DMPegelMeter
//
//  Created by Michael Johann on 22.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

+(void)setSettingsBundleDefaultsForFile:(NSString*)plistFileName;
+(void)setSettingsBundleDefaults;

@end
