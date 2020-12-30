//
//  DLUMLImageViewController.m
//  MixT
//
//  Created by 周冰烽 on 2020/12/29.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLUMLImageViewController.h"
#import "UIButton+DLAdaptiveButton.h"
#import "UIImage+DLRotate.h"
@interface DLUMLImageViewController ()

@end

@implementation DLUMLImageViewController

- (void)clickBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor screenColor];
    UIButton *leftButton = [[UIButton alloc] initHorizontalWithTitle:@"返回" image:[UIImage backIcon]];
    [leftButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(40);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@40);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:self.imageName];
    imageView.image = [image imageRotatedByDegrees:90.0f];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(leftButton.mas_bottom);
    }];
    
    
}

@end
