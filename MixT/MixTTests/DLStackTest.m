//
//  DLStackTest.m
//  MixTTests
//
//  Created by 周冰烽 on 2020/8/13.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DLStack.h"
@interface DLStackTest : XCTestCase

@property(nonatomic, strong) DLStack * stack;

@end

@implementation DLStackTest

- (void)setUp {
    self.stack = [[DLStack alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


- (void)testSize {
    for (NSInteger i = 0; i < 5; i++) {
        [self.stack push:@(i)];
    }
    XCTAssertEqual(self.stack.size, 5);
}

- (void)testIsEmpty {
    for (NSInteger i = 0; i < 5; i++) {
        [self.stack push:@(i)];
    }
    XCTAssertFalse(self.stack.isEmpty);
}

- (void)testPush {
    for (NSInteger i = 0; i < 5; i++) {
        XCTAssertNoThrow([self.stack push:@(i)]);
    }
}

- (void)testPop {
    for (NSInteger i = 0; i < 5; i++) {
        [self.stack push:@(i)];
    }
    for (NSInteger i = 4; i >= 0; i--) {
        XCTAssertTrue([self.stack.pop isEqual:@(i)]);
    }
}

- (void)testPeek {
    for (NSInteger i = 0; i < 5; i++) {
        [self.stack push:@(i)];
    }
    XCTAssertTrue([self.stack.peek isEqual:@4]);
}

@end
