//
//  DLTimeSelectController.m
//  整理
//
//  Created by 周冰烽 on 2020/7/16.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLTimeSelectController.h"

@interface DLTimeSelectController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, weak) UIPickerView * timePickerView;

@property(nonatomic, strong) NSMutableArray * hourArr;

@property(nonatomic, strong) NSMutableArray * minuteArr;

@property(nonatomic, strong) NSMutableArray * secondArr;

@property(nonatomic, assign) NSInteger hour;

@property(nonatomic, assign) NSInteger minute;

@property(nonatomic, assign) NSInteger second;

@end

@implementation DLTimeSelectController

#pragma mark -
#pragma mark - clickEvent

- (void)clickCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickConfirm {
    NSArray *arr = [NSArray arrayWithObjects:@(self.hour), @(self.minute), @(self.second), nil];
    !_selectValue ?: _selectValue(arr);
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -
#pragma mark - UI

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor screenColor];
    self.view.layer.cornerRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOpacity = 0.3f;
    self.view.layer.shadowOffset = CGSizeMake(3.0, -2.0);
    CALayer *lineLayer = [[CALayer alloc] init];
    lineLayer.backgroundColor = [UIColor lineColor].CGColor;
    lineLayer.frame = CGRectMake(0, 44, self.view.width - 60, 1);
    [self.view.layer addSublayer:lineLayer];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor normalTextColor];
    titleLabel.text = @"选择日期";
    titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(12);
    }];
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor dl_redColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.centerY.equalTo(titleLabel);
    }];
    [cancelBtn addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confirmBtn = [[UIButton alloc] init];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor themeColor] forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.centerY.equalTo(titleLabel);
    }];
    [confirmBtn addTarget:self action:@selector(clickConfirm) forControlEvents:UIControlEventTouchUpInside];
    
    UIPickerView *timePicker = [[UIPickerView alloc] init];
    timePicker.showsSelectionIndicator = YES;
    timePicker.delegate = self;
    timePicker.dataSource = self;
    [self.view addSubview:timePicker];
    [timePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(45);
    }];
    self.timePickerView = timePicker;
    
    [self setupInitialTime];
}


#pragma mark -
#pragma mark - private methods

- (void)setupInitialTime {
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlag = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlag fromDate:date];
    self.hour = [components hour];
    self.minute = [components minute];
    self.second = [components second];
    
    __block NSInteger hourRow = 0;
    __block NSInteger minuteRow = 0;
    __block NSInteger secondRow = 0;
    
    [self.hourArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.hour == [obj integerValue]) {
            hourRow = idx;
            *stop = YES;
        }
    }];
    
    [self.minuteArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.minute == [obj integerValue]) {
            minuteRow = idx;
            *stop = YES;
        }
    }];
    
    [self.secondArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.second == [obj integerValue]) {
            secondRow = idx;
            *stop = YES;
        }
    }];
    
    [self.timePickerView selectRow:hourRow inComponent:0 animated:YES];
    [self.timePickerView selectRow:minuteRow inComponent:1 animated:YES];
    [self.timePickerView selectRow:secondRow inComponent:2 animated:YES];
}

#pragma mark -
#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return self.hourArr.count;
            break;
        case 1:
            return self.minuteArr.count;
            break;
        default:
            return self.secondArr.count;
            break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *customLabel = (UILabel *)view;
    if (!customLabel) {
        customLabel = [[UILabel alloc] init];
        customLabel.textAlignment = NSTextAlignmentCenter;
        [customLabel setBackgroundColor:[UIColor clearColor]];
    }
    NSString *title;
    if (component==0) {
        title = self.hourArr[row];
    }
    if (component==1) {
        title = self.minuteArr[row];
    }
    if (component==2) {
        title = self.secondArr[row];
    }
    customLabel.text = title;
    customLabel.textColor = [UIColor blackColor];
    customLabel.font = [UIFont systemFontOfSize:16.0f];
    return customLabel;
}

#pragma mark -
#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        id obj = self.hourArr[row];
        self.hour = [obj integerValue];
    } else if (component == 1) {
        id obj = self.minuteArr[row];
        self.minute = [obj integerValue];
    } else {
        id obj = self.secondArr[row];
        self.second = [obj integerValue];
    }
}

#pragma mark - LazyLoad

- (NSMutableArray *)hourArr {
    if (!_hourArr) {
        _hourArr = [NSMutableArray array];
        for (int i = 1; i <= 24; i++) {
            [_hourArr addObject:[NSString stringWithFormat:@"%d时",i]];
        }
    }
    return _hourArr;
}

- (NSMutableArray *)minuteArr {
    if (!_minuteArr) {
        _minuteArr = [NSMutableArray array];
        for (int i = 1; i <= 60; i++) {
            [_minuteArr addObject:[NSString stringWithFormat:@"%d分",i]];
        }
    }
    return _minuteArr;
}

- (NSMutableArray *)secondArr {
    if (!_secondArr) {
        _secondArr = [NSMutableArray array];
        for (int i = 1; i <= 60; i++) {
            [_secondArr addObject:[NSString stringWithFormat:@"%d分",i]];
        }
    }
    return _secondArr;
}


@end
