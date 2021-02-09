//
//  DLDLCashFactoryTest.m
//  MixTTests
//
//  Created by mintai on 2021/2/7.
//  Copyright © 2021 周冰烽. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DLCashContext.h"
#import "DLCashNormal.h"
#import "DLCashRebate.h"
#import "DLCashReturn.h"
@interface DLCashFactoryTest : XCTestCase

@end

@implementation DLCashFactoryTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testCreateCashWithType {
    NSString *res1 = [self cashWithType:@"打8折" amount:100];
    XCTAssertTrue([res1 isEqualToString:@"80.00"]);
    
    NSString *res2 = [self cashWithType:@"满100减30" amount:100];
    XCTAssertTrue([res2 isEqualToString:@"70.00"]);
    
    NSString *res3 = [self cashWithType:@"正常收费" amount:100];
    XCTAssertTrue([res3 isEqualToString:@"100.00"]);
    
    NSString *res4 = [self cashWithType:@"打9.9折" amount:100];
    XCTAssertTrue([res4 isEqualToString:@"99.00"]);
    
    NSString *res5 = [self cashWithType:@"满500减100" amount:100];
    XCTAssertTrue([res5 isEqualToString:@"100.00"]);
    
    NSString *res6 = [self cashWithType:@"大家都去我家大气哦及" amount:100];
    XCTAssertTrue([res6 isEqualToString:@"0.00"]);
    
    NSString *res7 = [self cashWithType:@"打8的折" amount:100];
    XCTAssertTrue([res7 isEqualToString:@"80.00"]);
    
}

- (NSString *)cashWithType:(NSString *)type amount:(CGFloat)amount {
    DLCashContext *cc = [[DLCashContext alloc] initWithType:type];
    NSString *res = [NSString stringWithFormat:@"%.2f",[cc getResultWithAmount:amount]];
    return res;
}

@end
