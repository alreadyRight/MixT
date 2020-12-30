//
//  CalculateFactory.h
//  设计模式-01
//
//  Created by 周冰烽 on 2020/12/22.
//

#import <Foundation/Foundation.h>
#import "CalculateTool.h"
NS_ASSUME_NONNULL_BEGIN

@interface CalculateFactory : NSObject

- (CalculateTool *)calculateWithOperation:(NSString *)operation;

@end

NS_ASSUME_NONNULL_END
