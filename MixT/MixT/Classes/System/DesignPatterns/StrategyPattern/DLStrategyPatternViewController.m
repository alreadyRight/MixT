//
//  DLStrategyPatternViewController.m
//  MixT
//
//  Created by 周冰烽 on 2020/12/29.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLStrategyPatternViewController.h"
#import "NumberTextField.h"
#import "DLCustomAlertController.h"
#import "DLDateAnimation.h"
#import "UIViewController+DLPresent.h"
@interface DLStrategyPatternViewController ()

@property(nonatomic, strong) NSDictionary * insertDict;

@property(nonatomic, strong) NSMutableString * insertWord;

@property(nonatomic, copy) NSString * total;

@property(nonatomic, weak) UITextView * tv;

@property(nonatomic, weak) NumberTextField * priceFL;

@property(nonatomic, weak) NumberTextField * numberFL;

@property(nonatomic, copy) NSString *discountStr;

@end

@implementation DLStrategyPatternViewController

- (void)clickSelect:(UIButton *)sender {
    NSArray *arr = @[@[@"正常收费", @"打9.8折", @"打9折", @"打8折", @"打6折", @"满300减20", @"满500减50", @"满1000减100"]];
    DLCustomAlertController *customAlertC = [[DLCustomAlertController alloc] init];
    customAlertC.title = @"单选框";
    customAlertC.pickerDatas = arr;
    DLBaseAnimation *animation = [[DLDateAnimation alloc] init];
    [self presentViewController:customAlertC animation:animation completion:nil];
    customAlertC.selectValues = ^(NSArray * _Nonnull selectValues) {
        [sender setTitle:selectValues[0] forState:UIControlStateNormal];
        self.discountStr = selectValues[0];
    };
}

- (void)clickReset {
    // 清空输入值
    self.numberFL.text = @"";
    self.priceFL.text = @"";
}

- (void)clickSubmit {
    // 判断单价和数量是否有值
    if ([self.numberFL.text isEqualToString:@""] || [self.priceFL.text isEqualToString:@""]) {
        NSLog(@"请输入单价和数量");
        return;
    }
    
    // 获取当前时间
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-DD hh:mm:ss"];
    NSString *time = [dateFormatter stringFromDate:currentDate];
    
    // 获取收入
    CGFloat price = self.priceFL.res; // 单价
    CGFloat number = self.numberFL.res; // 数量
    CGFloat total = price * number; // 原总价
    total = [self calculatePriceWithtotal:total];
    NSString *totalString = [NSString stringWithFormat:@"%.2f", total];
    NSString *insertWord = [NSString stringWithFormat:@"\n收入:%.2f\n时间:%@\n", total, time];
    self.insertDict = @{@"total": totalString, @"insert": insertWord};
}

// 获取折扣值
- (CGFloat)calculatePriceWithtotal:(CGFloat)total {
    // @"正常收费", @"打9.8折", @"打9折", @"打8折", @"打6折", @"满300减20", @"满500减50", @"满1000减100"
    if ([self.discountStr isEqualToString:@"打9.8折"]) {
        return total * 0.98;
    } else if ([self.discountStr isEqualToString:@"打9折"]) {
        return total * 0.90;
    } else if ([self.discountStr isEqualToString:@"打8折"]) {
        return total * 0.80;
    } else if ([self.discountStr isEqualToString:@"打6折"]) {
        return total * 0.60;
    } else if ([self.discountStr isEqualToString:@"满300减20"]) {
        if (total > 300) {
            int multiple = (int)total / 300;
            return total - multiple * 20;
        } else {
            return total;
        }
    } else if ([self.discountStr isEqualToString:@"满500减50"]) {
        if (total > 500) {
            int multiple = (int)total / 500;
            return total - multiple * 50;
        } else {
            return total;
        }
    } else if ([self.discountStr isEqualToString:@"满1000减100"]) {
        if (total > 1000) {
            int multiple = (int)total / 1000;
            return total - multiple * 100;
        } else {
            return total;
        }
    } else {
        return total;
    }
}

- (void)setInsertDict:(NSDictionary *)insertDict {
    // 计算总价
    NSString *currentPrice = [insertDict objectForKey:@"total"];
    CGFloat total = [currentPrice floatValue] + [self.total floatValue];
    NSString *totalString = [NSString stringWithFormat:@"%.2f", total];
    self.total = totalString;
    
    if (!self.insertWord) {
        self.insertWord = [[NSMutableString alloc] init];
    }
    [self.insertWord appendString:[insertDict objectForKey:@"insert"]];
    
    self.tv.text = [NSString stringWithFormat:@"日志:\n%@\n总计: %@", self.insertWord, self.total];
    
}

- (void)setupUI {
    [super setupUI];
    self.title = @"策略模式";
    [super setupTitleAndBackNaviBar];
    
    NumberTextField *priceFL = [[NumberTextField alloc] init];
    priceFL.placeholder = @"请输入商品单价";
    [self.view addSubview:priceFL];
    [priceFL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-60);
        make.top.equalTo(self.view).offset(100);
    }];
    self.priceFL = priceFL;
    
    
    NumberTextField *numberFL = [[NumberTextField alloc] init];
    numberFL.placeholder = @"请输入商品数量";
    [self.view addSubview:numberFL];
    [numberFL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-60);
        make.top.equalTo(priceFL.mas_bottom).offset(30);
    }];
    self.numberFL = numberFL;
    
    UIButton *selectBtn = [[UIButton alloc] init];
    [selectBtn setTitle:@"请选择优惠选项" forState:UIControlStateNormal];
    [selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(clickSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(numberFL.mas_bottom).offset(40);
    }];
    
    UIButton *resetBtn = [[UIButton alloc] init];
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [resetBtn addTarget:self action:@selector(clickReset) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetBtn];
    [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(70);
        make.top.equalTo(numberFL.mas_bottom).offset(40);
    }];
    
    UIButton *submitBtn = [[UIButton alloc] init];
    [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(clickSubmit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-90);
        make.top.equalTo(numberFL.mas_bottom).offset(40);
    }];
    
    UITextView *tv = [[UITextView alloc] init];
    tv.editable = NO;
    tv.backgroundColor = [UIColor blackColor];
    tv.textColor = [UIColor whiteColor];
    tv.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:tv];
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-60);
        make.top.equalTo(submitBtn.mas_bottom).offset(40);
        make.height.mas_equalTo(@300);
    }];
    self.tv = tv;
    self.tv.text = @"日志:\n";
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 收起键盘
    [self.view endEditing:YES];
}

@end
