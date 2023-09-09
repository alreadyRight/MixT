//
//  DLMainViewController.m
//  整理
//
//  Created by 周冰烽 on 2020/6/1.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLMainViewController.h"
#import "DLBaseViewController.h"
#import "DLNavigationController.h"
#import "GKNavigationController.h"

//#import <Platform.h>

@interface DLMainViewController ()

@end

@implementation DLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [Platform sharedInstance];
    [self addChildControllerWithTitle:@"UI" clsName:@"DLUIViewController"];
    [self addChildControllerWithTitle:@"DSA" clsName:@"DLSystemViewController"];
    [self addChildControllerWithTitle:@"Network" clsName:@"DLNetworkViewController"];
    [self addChildControllerWithTitle:@"Video" clsName:@"DLVideoViewController"];
}

- (void)addChildControllerWithTitle:(NSString *)title clsName:(NSString *)clsName {
    Class cls = NSClassFromString(clsName);
    DLBaseViewController *vc = [[cls alloc] init];
    vc.title = title;
//    DLNavigationController *navi = [[DLNavigationController alloc] initWithRootViewController:vc];
    GKNavigationController *navi = [[GKNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:navi];
}


@end
