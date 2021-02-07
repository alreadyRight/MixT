//
//  DLDLCashFactoryTest.m
//  MixTTests
//
//  Created by mintai on 2021/2/7.
//  Copyright © 2021 周冰烽. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DLCashFactory.h"
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
    DLCashFactory *cf = [[DLCashFactory alloc] init];
    XCTAssertTrue([[cf createCashWithType:@"打8折"] isMemberOfClass:[DLCashRebate class]]);
    XCTAssertTrue([[cf createCashWithType:@"正常收费"] isMemberOfClass:[DLCashNormal class]]);
    XCTAssertTrue([[cf createCashWithType:@"满500减100"] isMemberOfClass:[DLCashReturn class]]);
    
}

@end
