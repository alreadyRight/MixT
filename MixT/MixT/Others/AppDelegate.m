//
//  AppDelegate.m
//  整理
//
//  Created by 周冰烽 on 2020/6/1.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "AppDelegate.h"
#import "DLMainViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - map init
- (void)initMap {
    // BaiduMapManager initialize
    BMKMapManager *mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [mapManager start:@"VVC1RE6x40vH7F6fM5Sd8OmwDNMZZ5lI" generalDelegate:nil];
    if (!ret) {
        NSLog(@"启动失败");
    }
    // 设置全局坐标系
    [BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_COMMON];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [self initMap];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    DLMainViewController *main = [[DLMainViewController alloc] init];
    self.window.rootViewController = main;
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark - UISceneSession lifecycle


@end
