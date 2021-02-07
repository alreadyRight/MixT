//
//  DLCashReturn.h
//  MixT
//
//  Created by mintai on 2021/2/5.
//  Copyright © 2021 周冰烽. All rights reserved.
//

#import "DLCashSuper.h"

NS_ASSUME_NONNULL_BEGIN

@interface DLCashReturn : DLCashSuper

- (instancetype)initWithAmount:(CGFloat)amount reduce:(CGFloat)reduce;

@end

NS_ASSUME_NONNULL_END
