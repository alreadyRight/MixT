//
//  DLNameLabelCell.m
//  整理
//
//  Created by 周冰烽 on 2020/7/24.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLNameLabelCell.h"

@interface DLNameLabelCell()

@property(nonatomic, weak) UILabel * nameLabel;

@end

@implementation DLNameLabelCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor normalTextColor];
    nameLabel.font = [UIFont systemFontOfSize:14.0f];
    nameLabel.userInteractionEnabled = YES;
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make edges];
    }];
    self.nameLabel = nameLabel;
}

- (void)setNameText:(NSString *)nameText {
    self.nameLabel.text = nameText;
}

@end
