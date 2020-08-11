//
//  DLMainTableViewCell.m
//  整理
//
//  Created by 周冰烽 on 2020/7/7.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLMainTableViewCell.h"

@interface DLMainTableViewCell ()

@property(nonatomic, weak) UILabel * dl_textLabel;

@property(nonatomic, weak) UILabel * dl_detailTextLabel;

@end

@implementation DLMainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    // text
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = [UIFont systemFontOfSize:16.0f];
    textLabel.textColor = [UIColor normalTextColor];
    [self addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
    }];
    self.dl_textLabel = textLabel;
    
    // detailText
    UILabel *detailTextLabel = [[UILabel alloc] init];
    detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
    detailTextLabel.textColor = [UIColor detailTextColor];
    [self addSubview:detailTextLabel];
    [detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
    }];
    self.dl_textLabel = textLabel;
    
    // 设置两个控件隐藏,设置值后才显示,防止显示错误信息
    self.dl_textLabel.hidden = YES;
    self.dl_detailTextLabel.hidden = YES;
}

- (void)setTitleText:(NSString *)titleText {
    if (titleText && ![titleText isEqualToString:@"(null)"]) {
        self.dl_textLabel.hidden = NO;
        self.dl_textLabel.text = titleText;
    }
}

- (void)setDetailText:(NSString *)detailText {
    if (detailText && ![detailText isEqualToString:@"(null)"]) {
        self.dl_detailTextLabel.hidden = NO;
        self.dl_detailTextLabel.text = detailText;
    }
}

@end
