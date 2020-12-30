//
//  NumberTextField.m
//  设计模式-01
//
//  Created by 周冰烽 on 2020/12/20.
//

#import "NumberTextField.h"
#import <Masonry/Masonry.h>
@interface NumberTextField()<UITextFieldDelegate>

@property(nonatomic, weak) UITextField * field;

@property(nonatomic, assign) BOOL isFloat;

@property(nonatomic, assign) BOOL isZeroFirst;

@end

@implementation NumberTextField

#pragma mark - UI
- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UITextField *field = [[UITextField alloc] init];
    field.keyboardType = UIKeyboardTypeNumberPad;
    field.borderStyle = UITextBorderStyleRoundedRect;
    field.delegate = self;
    [self addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        [make edges];
    }];
    self.field = field;
}


#pragma mark - Getter && Setter

- (void)setPlaceholder:(NSString *)placeholder {
    self.field.placeholder = placeholder;
}

- (CGFloat)res {
    return [self.field.text floatValue];
}

- (void)setText:(NSString *)text {
    self.field.text = text;
}

- (NSString *)text {
    return self.field.text;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        _isFloat = NO;
    }
    if ([string length]>0){
            unichar single=[string characterAtIndex:0];//当前输入的字符
            if ((single >='0' && single<='9') || single=='.'){ //数据格式正确
                //首字母不能为0和小数点
                if(textField.text.length == 0) {
                    if (single =='0') {
                        _isZeroFirst = YES;
                    }
                }
                if (textField.text.length == 1) {
                    if (single == '.') {
                        _isZeroFirst = NO;
                    } else if(_isZeroFirst) {
                        _isZeroFirst = YES;
                    }
                }
                if (single=='.'){ // 输入的是小数点
                    if(!_isFloat) { //text中还没有小数点
                        _isFloat = YES;
                        return YES;
                    } else { //text中已经输入过小数点
                        NSLog(@"提示，您已经输入过小数点了");
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                if (single == '0') {
                    if (_isZeroFirst) { // 首位为0, 第一位不为小数点, 不能再次输入0
                        NSLog(@"提示，您已经在首位输入为0, 第一位不为小数点, 不能再次输入0");
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
            } else {//输入的数据格式不正确
                NSLog(@"提示，您输入的格式不正确");
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        } else {
            return YES;
        }
        return YES;
}


@end
