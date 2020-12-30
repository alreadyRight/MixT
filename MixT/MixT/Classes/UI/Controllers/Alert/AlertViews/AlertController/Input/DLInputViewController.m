//
//  DLInputViewController.m
//  MixT
//
//  Created by 周冰烽 on 2020/10/26.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLInputViewController.h"

@interface DLInputViewController ()<UITextFieldDelegate>

@property(nonatomic, weak) UITextField * textField;

@end

@implementation DLInputViewController

- (void)confirmClick {
    !_pinValue ?: _pinValue(self.textField.text);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.cornerRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOpacity = 0.3f;
    self.view.layer.shadowOffset = CGSizeMake(3.0, -2.0);
    CALayer *lineLayer = [[CALayer alloc] init];
    lineLayer.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:240/255.0 alpha:1.0].CGColor;
    lineLayer.frame = CGRectMake(0, 50, self.view.width - 70, 1);
    [self.view.layer addSublayer:lineLayer];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = self.title;
    titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(12);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:240/255.0 alpha:1.0];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-50);
        make.height.mas_equalTo(@1);
    }];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = @"请输入验证码";
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.delegate = self;
    [self.view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    self.textField = textField;
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:240/255.0 alpha:1.0];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.bottom.equalTo(self.view);
        make.width.mas_equalTo(@1);
        make.centerX.equalTo(self.view);
    }];
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.right.equalTo(line2.mas_left);
        make.top.equalTo(line.mas_bottom);
    }];
    
    UIButton *confirmBtn = [[UIButton alloc] init];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor colorWithRed:58/255.0 green:144/255.0 blue:246/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.view);
        make.left.equalTo(line2.mas_right);
        make.top.equalTo(line.mas_bottom);
    }];
    [confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.textField) {
        // 这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (range.length == 1 && string.length == 0) {
            return YES;
        }  else if (self.textField.text.length >= 4) {
            self.textField.text = [textField.text substringToIndex:4];
            [self.textField resignFirstResponder];
            return NO;
        }
    }
    return YES;
}

@end
