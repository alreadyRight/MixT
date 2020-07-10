//
//  DLNavigationController.m
//  整理
//
//  Created by 周冰烽 on 2020/6/12.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLNavigationController.h"

@interface DLNavigationController ()

@end

@implementation DLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}



#pragma mark - LazyLoad


@end
