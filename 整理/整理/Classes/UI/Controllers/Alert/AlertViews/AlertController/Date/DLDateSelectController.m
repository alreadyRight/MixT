//
//  DLTimeSelectController.m
//  整理
//
//  Created by 周冰烽 on 2020/7/13.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#define MAXYEAR 2099
#define MINYEAR 1000

#import "DLDateSelectController.h"

@interface DLDateSelectController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, strong) NSMutableArray * yearArr;

@property(nonatomic, strong) NSMutableArray * monthArr;

@property(nonatomic, strong) NSMutableArray * dayArr;

@property(nonatomic, weak) UIPickerView * datePickerView;

@property(nonatomic, assign) NSInteger selectYear;

@property(nonatomic, assign) NSInteger selectMonth;

@property(nonatomic, assign) NSInteger selectDay;

@end

@implementation DLDateSelectController

#pragma mark -
#pragma mark - clickEvent

- (void)clickCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickConfirm {
    NSArray *arr = [NSArray arrayWithObjects:@(self.selectYear), @(self.selectMonth), @(self.selectDay), nil];
    !_selectDate ?: _selectDate(arr);
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
    
    UIPickerView *datePicker = [[UIPickerView alloc] init];
    datePicker.showsSelectionIndicator = YES;
    datePicker.delegate = self;
    datePicker.dataSource = self;
    [self.view addSubview:datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(45);
    }];
    self.datePickerView = datePicker;
    
    [self setupInitialData];
}

- (void)setupInitialData {
    // 获取当前年月日
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponents = [calendar components:unitFlag fromDate:date];
    self.selectYear = [dateComponents year];
    self.selectMonth = [dateComponents month];
    self.selectDay = [dateComponents day];
    
    __block NSInteger yearRow = 0;
    __block NSInteger monthRow = 0;
    __block NSInteger dayRow = 0;
    [self.yearArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.selectYear == [obj integerValue]) {
            yearRow = idx;
            *stop = YES;
        }
    }];
    [self.monthArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.selectMonth == [obj integerValue]) {
            monthRow = idx;
            *stop = YES;
        }
    }];
    [self setupDayArr];
    [self.dayArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.selectDay == [obj integerValue]) {
            dayRow = idx;
            *stop = YES;
        }
    }];
    
    [self.datePickerView selectRow:yearRow inComponent:0 animated:NO];
    [self.datePickerView selectRow:monthRow inComponent:1 animated:NO];
    [self.datePickerView selectRow:dayRow inComponent:2 animated:NO];
}


#pragma mark -
#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.yearArr.count;
    } else if (component == 1) {
        return self.monthArr.count;
    } else {
        return self.dayArr.count;
    }
}

#pragma mark -
#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
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
        title = self.yearArr[row];
    }
    if (component==1) {
        title = self.monthArr[row];
    }
    if (component==2) {
        title = self.dayArr[row];
    }
    customLabel.text = title;
    customLabel.textColor = [UIColor blackColor];
    customLabel.font = [UIFont systemFontOfSize:16.0f];
    return customLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectYear = [self.yearArr[row] integerValue];
    }
    if (component == 1) {
        self.selectMonth = [self.monthArr[row] integerValue];
    }
    if (component == 0 || component == 1) {
        [self setupDayArr];
    }
    if (component == 2) {
        self.selectDay = [self.dayArr[row] integerValue];
    }
    [pickerView reloadAllComponents];
}




#pragma mark -
#pragma mark - private method

- (void)setupDayArr {
    if (self.selectMonth == 2) {
        // 判断是否是闰年,闰年返回29天,不是闰年返回28天
        if (self.selectYear % 100 == 0) {
            if (self.selectYear % 4 == 0) {
                [self setupDayArrWithNum:29];
            } else {
                [self setupDayArrWithNum:28];
            }
        } else {
            if (self.selectYear % 4 == 0) {
                [self setupDayArrWithNum:29];
            } else {
                [self setupDayArrWithNum:28];
            }
        }
    } else if (self.selectMonth == 1 || self.selectMonth == 3 || self.selectMonth == 5 || self.selectMonth == 7 || self.selectMonth == 8 || self.selectMonth == 10 || self.selectMonth == 12) {
        // 31天
        [self setupDayArrWithNum:31];
    } else {
        // 30天
        [self setupDayArrWithNum:30];
    }
}

- (void)setupDayArrWithNum:(NSUInteger)num {
    if (self.dayArr.count == 0) {
        for (int i = 1; i <= num; i++) {
            if (i < 10) {
                [self.dayArr addObject:[NSString stringWithFormat:@"0%d日",i]];
            } else {
                [self.dayArr addObject:[NSString stringWithFormat:@"%d日",i]];
            }
        }
    } else {
        NSInteger poor = num - self.dayArr.count;
        if (poor > 0) {
            for (int i = (int)self.dayArr.count + 1; i <= num; i++) {
                [self.dayArr addObject:[NSString stringWithFormat:@"%d日",i]];
            }
        } else {
            for (int i = 0; i < -poor; i++) {
                [self.dayArr removeLastObject];
            }
        }
    }
}

#pragma mark -
#pragma mark - LazyLoad

- (NSMutableArray *)yearArr {
    if (!_yearArr) {
        _yearArr = [NSMutableArray array];
        for (int i = MINYEAR; i <= MAXYEAR; i++) {
            [_yearArr addObject:[NSString stringWithFormat:@"%d年",i]];
        }
        
    }
    return _yearArr;
}

- (NSMutableArray *)monthArr {
    if (!_monthArr) {
        _monthArr = [NSMutableArray array];
        for (int i = 1; i <= 12; i++) {
            if (i < 10) {
                [_monthArr addObject:[NSString stringWithFormat:@"0%d月",i]];
            } else {
                [_monthArr addObject:[NSString stringWithFormat:@"%d月",i]];
            }
        }
    }
    return _monthArr;
}

- (NSMutableArray *)dayArr {
    if (!_dayArr) {
        _dayArr = [NSMutableArray array];
    }
    return _dayArr;
}

@end
