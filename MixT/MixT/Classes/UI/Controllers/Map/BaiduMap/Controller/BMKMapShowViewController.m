//
//  BMKMapShowViewController.m
//  整理
//
//  Created by 周冰烽 on 2020/7/29.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "BMKMapShowViewController.h"

#import "UIButton+DLAdaptiveButton.h"

//#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface BMKMapShowViewController ()<BMKMapViewDelegate>

@property(nonatomic, strong) BMKMapView * mapView;


@end

@implementation BMKMapShowViewController

- (void)changeControl:(UISegmentedControl *)control {
    NSInteger index = control.selectedSegmentIndex;
    switch (index) {
        case 0:
            [self.mapView setMapType:BMKMapTypeStandard];
            break;
        case 1:
            [self.mapView setMapType:BMKMapTypeSatellite];
            break;
        default:
            [self.mapView setMapType:BMKMapTypeNone];
            break;
    }
}

#pragma mark - Life Circle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
}

#pragma mark - UI

- (void)setupUI {
    [super setupUI];
    self.title = @"地图创建";
    UIButton *leftButton = [[UIButton alloc] initHorizontalWithTitle:@"返回" image:[UIImage backIcon]];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:18.0f];
    titleLabel.textColor = [UIColor boldBlackTextColor];
    titleLabel.text = @"地图创建";
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor themeColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [super customNaviBarWithLeftView:leftButton centerView:titleLabel rightView:rightBtn];
    
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems: [NSArray arrayWithObjects:@"标准地图", @"卫星地图", @"空白地图", nil]];
    segmentControl.frame = CGRectMake(20, kNavigationBarHeight + kTopUnSafeAreaHeight + 10, kScreenWidth - 40, 40);
    segmentControl.selectedSegmentIndex = 0;
    [segmentControl addTarget:self action:@selector(changeControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentControl];
    
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(segmentControl.frame) + 10, kScreenWidth, kScreenHeight - CGRectGetMaxY(segmentControl.frame) - 10)];
    self.mapView.delegate = self;
    // 显示比例尺
    self.mapView.showMapScaleBar = YES;
    // 打开实时路况
    [self.mapView setTrafficEnabled:YES];
    //
    [self.mapView setBaiduHeatMapEnabled:YES];
    [self.view addSubview:self.mapView];
    
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
