//
//  DLQueueTest.m
//  MixTTests
//
//  Created by 周冰烽 on 2020/8/14.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DLQueue.h"
#import "DLDeque.h"
@interface DLQueueTest : XCTestCase

@property(nonatomic, strong) DLQueue * queue1;

@property(nonatomic, strong) DLDeque * queue2;

@end

@implementation DLQueueTest

- (void)setUp {
    self.queue1 = [[DLQueue alloc] init];
    for (int i = 0; i < 10; i++) {
        [self.queue1 enQueue:@(i)];
    }
    // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    self.queue2 = [[DLDeque alloc] init];
    for (int i = 0; i < 10; i++) {
        [self.queue2 enQueueRear:@(i)];
    }
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testSize {
    XCTAssertEqual(self.queue1.size, 10);
    XCTAssertEqual(self.queue2.size, 10);
}

- (void)testIsEmpty {
    XCTAssertFalse(self.queue1.isEmpty);
    XCTAssertFalse(self.queue2.isEmpty);
}

- (void)testEnQueue {
    XCTAssertNoThrow([self.queue1 enQueue:@(11)]);
    XCTAssertNoThrow([self.queue2 enQueueFront:@(11)]);
}

- (void)testDequeue {
    for (int i = 0; i < 10; i++) {
        XCTAssertTrue([[self.queue1 deQueue] isEqual:@(i)]);
        XCTAssertTrue([[self.queue2 deQueueFront] isEqual:@(i)]);
    }
}

- (void)testDequeueRear {
    for (int i = 0; i < 10; i++) {
        XCTAssertTrue([[self.queue2 deQueueRear] isEqual:@(9 - i)]);
    }
}

- (void)testFront {
    XCTAssertTrue([[self.queue1 front] isEqual:@0]);
    XCTAssertTrue([[self.queue2 front] isEqual:@0]);
}

- (void)testRear {
    XCTAssertTrue([[self.queue2 rear] isEqual:@9]);
}

@end
