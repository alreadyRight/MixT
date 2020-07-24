//
//  DLAddressSelectCell.m
//  整理
//
//  Created by 周冰烽 on 2020/7/22.
//  Copyright © 2020 周冰烽. All rights reserved.
// 地区选择自定义Cell

#import "DLAddressSelectCell.h"

@interface DLAddressSelectCell ()

@property(nonatomic, weak) UILabel * nameLabel;

@property(nonatomic, weak) UIImageView * selectImageView;

@end

@implementation DLAddressSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor normalTextColor];
    nameLabel.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
    }];
    self.nameLabel = nameLabel;
    
    UIImageView *selectImage = [[UIImageView alloc] init];
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            selectImage.image = [UIImage imageNamed:@"select-light"];
        } else {
            selectImage.image = [UIImage imageNamed:@"select-dark"];
        }
    }  else {
        selectImage.image = [UIImage imageNamed:@"select-light"];
    }
    [self addSubview:selectImage];
    [selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-40);
        make.centerY.equalTo(self);
    }];
    selectImage.hidden = YES;
    self.selectImageView = selectImage;
    
}

- (void)setAddressName:(NSString *)addressName {
    self.nameLabel.text = addressName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectImageView.hidden = !selected;
    if (selected) {
        self.nameLabel.textColor = [UIColor themeColor];
    }
}

@end
