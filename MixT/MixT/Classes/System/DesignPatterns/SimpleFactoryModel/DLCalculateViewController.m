//
//  DLCalculateViewController.m
//  MixT
//
//  Created by 周冰烽 on 2020/12/29.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLCalculateViewController.h"
#import "NumberTextField.h"
#import "CalculateFactory.h"
#import "DLUMLImageViewController.h"
@interface DLCalculateViewController ()

@property(nonatomic, weak) NumberTextField * num1;

@property(nonatomic, weak) NumberTextField * num2;

@property(nonatomic, weak) UITextField * symbol;

@property(nonatomic, weak) UIButton * caculateBtn;

@property(nonatomic, weak) UILabel * resultL;

@end

@implementation DLCalculateViewController

- (void)showImage {
    DLUMLImageViewController *umlVC = [[DLUMLImageViewController alloc] init];
    umlVC.modalPresentationStyle = UIModalPresentationFullScreen;
    umlVC.imageName = @"SimpleFactory";
    [self presentViewController:umlVC animated:YES completion:nil];
}

- (void)caculate {
    CGFloat num1 = self.num1.res;
    CGFloat num2 = self.num2.res;
    NSString *symbol = self.symbol.text;
    CalculateFactory *factory = [[CalculateFactory alloc] init];
    CalculateTool *tool = [factory calculateWithOperation:symbol];
    tool.num1 = num1;
    tool.num2 = num2;
    self.resultL.text = [NSString stringWithFormat:@"%.2f",[tool calculateToolResult]];
}


- (void)setupUI {
    [super setupUI];
    self.title = @"简单工厂模式";
    [super setupTitleAndBackNaviBar];
    NumberTextField *num1 = [[NumberTextField alloc] init];
    num1.placeholder = @"请输入第一个数字";
    [self.view addSubview:num1];
    [num1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(80);
        make.top.equalTo(self.view).offset(120);
        make.right.equalTo(self.view).offset(-80);
        make.height.mas_equalTo(@40);
    }];
    self.num1 = num1;
    
    
    NumberTextField *num2 = [[NumberTextField alloc] init];
    num2.placeholder = @"请输入第二个数字";
    [self.view addSubview:num2];
    [num2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(num1.mas_bottom).offset(40);
        make.left.equalTo(self.view).offset(80);
        make.right.equalTo(self.view).offset(-80);
        make.height.mas_equalTo(@40);
    }];
    self.num2 = num2;
    
    UITextField *symbol = [[UITextField alloc] init];
    symbol.borderStyle = UITextBorderStyleRoundedRect;
    symbol.placeholder = @"请输入运算符号(+, -, *, /)";
    [self.view addSubview:symbol];
    [symbol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(num2.mas_bottom).offset(40);
        make.left.equalTo(self.view).offset(80);
        make.right.equalTo(self.view).offset(-80);
        make.height.mas_equalTo(@40);
    }];
    self.symbol = symbol;
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"计算" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(caculate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(symbol.mas_bottom).offset(40);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@40);
    }];
    self.caculateBtn = btn;
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(btn.mas_bottom).offset(40);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@40);
    }];
    self.resultL = label;
    
    UIButton *showImgBtn = [[UIButton alloc] init];
    [showImgBtn setTitle:@"显示UML图" forState:UIControlStateNormal];
    [showImgBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [showImgBtn addTarget:self action:@selector(showImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showImgBtn];
    [showImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(label.mas_bottom).offset(40);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(@40);
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 收起键盘
    [self.view endEditing:YES];
}

@end
