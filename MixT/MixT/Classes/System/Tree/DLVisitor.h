//
//  DLVisitor.h
//  MixT
//
//  Created by 周冰烽 on 2020/8/25.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLVisitor : NSObject

@property(nonatomic, assign) BOOL stop;

- (BOOL)visitWithObject:(id)object;

@end

NS_ASSUME_NONNULL_END
