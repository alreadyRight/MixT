//
//  DLTreeSetTest.m
//  MixTTests
//
//  Created by 周冰烽 on 2020/10/9.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface DLTreeSetTest : XCTestCase

@end

@implementation DLTreeSetTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testSet {
    NSString *path = @"/Users/Devil/Desktop/personal/Git/practice/MixT";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *directoryEnumerator = [fileManager enumeratorAtPath:path];
    BOOL isDir = NO;
    BOOL isExist = NO;

    //列举目录内容，可以遍历子目录
    for (NSString *subPath in directoryEnumerator.allObjects) {
        NSLog(@"%@", subPath);  // 所有路径
        isExist = [fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/%@", path, subPath] isDirectory:&isDir];
        if (isDir) {
            NSLog(@"%@", subPath);    // 目录路径
        } else {
            // 文件绝对路径
            NSString *fileFullPath = [NSString stringWithFormat:@"%@/%@", path, subPath];
            NSString *content = [NSString stringWithContentsOfFile:fileFullPath encoding:NSUTF8StringEncoding error:nil];
            NSMutableArray *words = [NSMutableArray array];
            [content enumerateSubstringsInRange:NSMakeRange(0, content.length) options:NSStringEnumerationByWords usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                [words addObject:substring];
            }];
            NSLog(@"%ld", words.count);
        }
    }
}

@end
