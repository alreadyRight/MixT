//
//  DLLinkListTest.m
//  整理Tests
//
//  Created by 周冰烽 on 2020/8/10.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DLLinkList.h"
@interface DLLinkListTest : XCTestCase

@property(nonatomic, strong) DLLinkList * list;

@end

@implementation DLLinkListTest

- (void)setUp {
    self.list = [[DLLinkList alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)reset {
    [self.list clear];
    for (NSInteger i = 0; i < 10; i++) {
        [self.list addObject:@(i)];
    }
}

- (void)testgetWithIndex {
    [self reset];
    for (NSInteger i = 0; i < 10; i++) {
        XCTAssertTrue([[self.list getWithIndex:i] isEqual:@(i)]);
    }
}

- (void)testSetIndex {
    [self reset];
    XCTAssertNoThrow([self.list setWithIndex:0 object:@0]);
    XCTAssertNoThrow([self.list setWithIndex:1 object:@1]);
}

- (void)testAddObject {
    [self reset];
    XCTAssertNoThrow([self.list addObject:@8]);
    XCTAssertNoThrow([self.list addObject:@9]);
}

- (void)testRemoveWithIndex {
    [self reset];
    NSInteger i = 9;
    while (i >= 0) {
        XCTAssertTrue([[self.list removeWithIndex:i] isEqual:@(i)]);
        i--;
    }
}

- (void)testIndexOfWithIndex {
    [self reset];
    for (NSInteger i = 0; i < 10; i++) {
        XCTAssertEqual([self.list indexOfObject:@(i)], i);
    }
}

- (void)testSize {
    [self reset];
    XCTAssertEqual([self.list size], 10);
}

- (void)testIsEmpty {
    [self reset];
    XCTAssertFalse([self.list isEmpty]);
    [self.list clear];
    XCTAssertTrue([self.list isEmpty]);
}

- (void)testContainsObject {
    [self reset];
    for (NSInteger i = 0; i < 10; i++) {
        XCTAssertTrue([self.list containsObject:@(i)]);
    }
}



@end
