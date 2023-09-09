//
//  DLInputViewController.m
//  MixT
//
//  Created by Aurora on 2023/9/9.
//  Copyright © 2023 周冰烽. All rights reserved.
//

#import "DLTextInputViewController.h"
#import "DLPwdTextField.h"
@interface DLTextInputViewController ()<DLPwdTextFieldDelegate>

@end

@implementation DLTextInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    [super setupUI];
    self.title = @"输入框";
    CGFloat width = self.view.frame.size.width - 80;
    CGFloat height = 60;
    DLPwdTextField *pwdTextField = [[DLPwdTextField alloc] initWithFrame:CGRectMake(40, 120, width, height) gridCount:6];
    pwdTextField.pwdDelegate = self;
    [self.view addSubview:pwdTextField];
}

- (void)textFieldDidFinishEditing:(DLPwdTextField *)textField {
//    [textField clear];
    NSLog(@"textField text is:%@", textField.text);
    
}

@end
