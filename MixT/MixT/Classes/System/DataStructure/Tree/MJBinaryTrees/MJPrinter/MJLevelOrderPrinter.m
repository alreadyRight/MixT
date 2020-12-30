//
//  MJLevelOrderPrinter.m
//  BinaryTreePrinterOC
//
//  Created by MJ Lee on 2019/5/1.
//  Copyright © 2019 MJ Lee. All rights reserved.
//

#import "MJLevelOrderPrinter.h"
#import "NSString+Trees.h"

/******* MJLOPNode begin *******/
@interface MJLOPNode : NSObject {
@public
    NSUInteger _x;
    NSUInteger _y;
    NSUInteger _width;
    NSUInteger _treeHeight;
    NSString *_string;
    __weak id _btNode;
    MJLOPNode *_left;
    MJLOPNode *_right;
    __weak MJLOPNode *_parent;
}
- (NSUInteger)rightBound;
- (NSUInteger)leftBound;
@end
/******* MJLOPNode end *******/

/******* MJLOPLevelInfo begin *******/
@interface MJLOPLevelInfo : NSObject {
@public
    NSUInteger _leftX;
    NSUInteger _rightX;
}
@end

@implementation MJLOPLevelInfo
+ (instancetype)levelInfoWithLeft:(MJLOPNode *)left right:(MJLOPNode *)right {
    MJLOPLevelInfo *info = [[self alloc] init];
    info->_leftX = [left leftBound];
    info->_rightX = [right rightBound];
    return info;
}
@end
/******* MJLOPLevelInfo end *******/

/******* MJLOPNode begin *******/
@implementation MJLOPNode
static NSUInteger const TOP_LINE_SPACE = 1;

+ (instancetype)nodeWithString:(NSString *)string {
    string = !string ? @"null" : string;
    string = string.length ? string : @" ";
    
    MJLOPNode *node = [[self alloc] init];
    node->_string = string;
    node->_width = string.length;
    return node;
}

+ (instancetype)nodeWithBtNode:(id)btNode tree:(id<MJBinaryTreeInfo>)tree {
    MJLOPNode *node = [self nodeWithString:[[tree string:btNode] description]];
    node->_btNode = btNode;
    return node;
}


/// 尾字符的下一个位置
- (NSUInteger)rightX{
    return _x + _width;
}

/// 顶部方向字符的X（极其重要）
- (NSUInteger)topLineX {
    // 宽度的一半
    NSUInteger delta = _width;
    if (delta % 2 == 0) {
        delta--;
    }
    delta = delta >> 1;
    
    if (_parent && self == _parent->_left) {
        return [self rightX] - 1 - delta;
    } else {
        return _x + delta;
    }
}

/**
 * 右边界的位置（rightX 或者 右子节点topLineX的下一个位置）（极其重要）
 */
- (NSUInteger)rightBound {
    if (!_right) return [self rightX];
    return [_right topLineX] + 1;
}

/**
 * 左边界的位置（x 或者 左子节点topLineX）（极其重要）
 */
- (NSUInteger)leftBound {
    if (!_left) return _x;
    return [_left topLineX];
}

/**
 * x ~ 左边界之间的长度（包括左边界字符）
 */
- (NSUInteger)leftBoundLength {
    return _x - [self leftBound];
}

/**
 * rightX ~ 右边界之间的长度（包括右边界字符）
 */
- (NSUInteger)rightBoundLength {
    return [self rightBound] - [self rightX];
}

/**
 * 左边界可以清空的长度
 */
- (NSUInteger)leftBoundEmptyLength {
    return [self leftBoundLength] - 1 - TOP_LINE_SPACE;
}

/**
 * 右边界可以清空的长度
 */
- (NSUInteger)rightBoundEmptyLength {
    return [self rightBoundLength] - 1 - TOP_LINE_SPACE;
}

- (void)translateX:(NSUInteger)deltaX {
    if (!deltaX) return;
    _x += deltaX;
    
    // 如果是LineNode
    if (!_btNode) return;
    
    if (_left) {
        [_left translateX:deltaX];
    }
    if (_right) {
        [_right translateX:deltaX];
    }
}

/**
 * 让left和right基于this对称
 */
- (void)balance:(MJLOPNode *)left right:(MJLOPNode *)right {
    if (!left || !right) return;
    // 【this的尾字符】与【this的首字符】之间的间距
    NSUInteger deltaLeft = _x - [left rightX];
    // 【this的尾字符】与【this的首字符】之间的间距
    NSUInteger deltaRight = right->_x - [self rightX];
    
    NSUInteger delta = MAX(deltaLeft, deltaRight);
    NSUInteger newRightX = [self rightX] + delta;
    [right translateX:newRightX - right->_x];
    
    NSUInteger newLeftX = _x - delta - left->_width;
    [left translateX:newLeftX - left->_x];
}

- (NSUInteger)treeHeight:(MJLOPNode *)node {
    if (!node) return 0;
    if (node->_treeHeight) return node->_treeHeight;
    node->_treeHeight = 1 + MAX([self treeHeight:node->_left], [self treeHeight:node->_right]);
    return node->_treeHeight;
}

- (MJLOPLevelInfo *)levelInfo:(NSUInteger)level {
    if (level < 0) return nil;
    NSUInteger levelY = _y + level;
    if (level >= [self treeHeight:self]) return nil;
    
    NSMutableArray *list = [NSMutableArray array];
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:self];
    
    // 层序遍历找出第level行的所有节点
    while (queue.count) {
        MJLOPNode *node = queue.firstObject;
        [queue removeObjectAtIndex:0];
        if (levelY == node->_y) {
            [list addObject:node];
        } else if (node->_y > levelY) break;
        
        if (node->_left) {
            [queue addObject:node->_left];
        }
        if (node->_right) {
            [queue addObject:node->_right];
        }
    }
    
    MJLOPNode *left = list.firstObject;
    MJLOPNode *right = list.lastObject;
    return [MJLOPLevelInfo levelInfoWithLeft:left right:right];
}

/**
 * 和右节点之间的最小层级距离
 */
- (NSUInteger)minLevelSpaceToRight:(MJLOPNode *)right {
    NSUInteger thisHeight = [self treeHeight:self];
    NSUInteger rightHeight = [self treeHeight:right];
    NSUInteger minSpace = NSUIntegerMax;
    for (NSUInteger i = 0; i < thisHeight && i < rightHeight; i++) {
        NSUInteger space = [right levelInfo:i]->_leftX - [self levelInfo:i]->_rightX;
        minSpace = MIN(minSpace, space);
    }
    return minSpace;
}
@end
/******* MJLOPNode end *******/

@interface MJLevelOrderPrinter() {
@public
    MJLOPNode *_root;
    NSUInteger _maxWidth;
    NSUInteger _minX;
    NSMutableArray<NSMutableArray<MJLOPNode *> *> *_nodes;
}
@end

@implementation MJLevelOrderPrinter

static NSUInteger const MIN_SPACE = 1;

+ (instancetype)printerWithTree:(id<MJBinaryTreeInfo>)tree
{
    MJLevelOrderPrinter *printer = [super printerWithTree:tree];
    printer->_root = [MJLOPNode nodeWithBtNode:[tree root] tree:tree];
    printer->_maxWidth = printer->_root->_width;
    return printer;
}

/// 构建所有节点的位置和内容
- (NSString *)printString {
    _nodes = [NSMutableArray array];
    // 遍历所有节点, 添加到nodes中
    [self _fillNodes];
    [self _cleanNodes];
    [self _compressNodes];
    [self _addLineNodes];
    
    NSUInteger rowCount = _nodes.count;
    
    // 构建字符串
    NSMutableString *string = [NSMutableString string];
    for (NSUInteger i = 0; i < rowCount; i++) {
        if (i) {
            [string appendString:@"\n"];
        }
        
        NSMutableArray *rowNodes = _nodes[i];
        NSMutableString *rowString = [NSMutableString string];
        for (MJLOPNode *node in rowNodes) {
            NSUInteger leftSpace = node->_x - rowString.length - _minX;
            [rowString appendString:[NSString mj_blank:leftSpace]];
            [rowString appendString:node->_string];
        }
        
        [string appendString:rowString];
    }
    
    return string;
}

#pragma mark - private methods
- (MJLOPNode *)_addNode:(NSMutableArray *)nodes btNode:(id)btNode {
    MJLOPNode *node = nil;
    if (btNode) {
        node = [MJLOPNode nodeWithBtNode:btNode tree:self.tree];
        _maxWidth = MAX(_maxWidth, node->_width);
        [nodes addObject:node];
    } else {
        [nodes addObject:@"null"];
    }
    return node;
}

/**
 以满二叉树的形式来获取所有节点,如果中间有节点为空,则插入@"null"字符串,
 最后node的形式为[[38], [18, 69], [4, 34, null, 85], [null, null, 29, 36, null, null, 71, 100]]
 */
/// 遍历所有节点, 添加到nodes中
- (void)_fillNodes {
    // 第一行
    NSMutableArray *firstRowNodes = [NSMutableArray array];
    [firstRowNodes addObject:_root];
    [_nodes addObject:firstRowNodes];
    
    // 其他行
    while (YES) {
        NSMutableArray *preRowNodes = _nodes.lastObject;
        NSMutableArray *rowNodes = [NSMutableArray array];
        
        BOOL notNull = NO;
        for (MJLOPNode *node in preRowNodes) {
            if ([node isEqual:@"null"]) {
                [rowNodes addObject:@"null"];
                [rowNodes addObject:@"null"];
            } else {
                MJLOPNode *left = [self _addNode:rowNodes btNode:[self.tree left:node->_btNode]];
                if (left) {
                    node->_left = left;
                    left->_parent = node;
                    notNull = YES;
                }
                
                MJLOPNode *right = [self _addNode:rowNodes btNode:[self.tree right:node->_btNode]];
                if (right) {
                    node->_right = right;
                    right->_parent = node;
                    notNull = YES;
                }
            }
        }
        
        // 全是null，就退出
        if (!notNull) break;
        [_nodes addObject:rowNodes];
    }
}

/// 整理nodes,求出每个节点的x,y,width,清除所有的null元素
- (void)_cleanNodes {
    NSUInteger rowCount = _nodes.count;
    if (rowCount < 2) return;
    
    // 最后一行的节点数量
    NSUInteger lastRowNodeCount = _nodes.lastObject.count;
    
    // 每个节点之间的间距(每个节点内容的最大长度+2)
    NSUInteger nodeSpace = _maxWidth + 2;
    
    // 最后一行的长度
    NSUInteger lastRowLength = lastRowNodeCount * _maxWidth + nodeSpace * (lastRowNodeCount - 1);
    
    // 空集合
    for (NSUInteger i = 0; i < rowCount; i++) {
        NSMutableArray *rowNodes = _nodes[i];
        
        NSUInteger rowNodeCount = rowNodes.count;
        // 节点左右两边的间距
        NSUInteger allSpace = lastRowLength - (rowNodeCount - 1) * nodeSpace;
        NSUInteger cornerSpace = allSpace / rowNodeCount - _maxWidth;
        cornerSpace = cornerSpace >> 1;
        
        NSUInteger rowLength = 0;
        for (NSUInteger j = 0; j < rowNodeCount; j++) {
            if (j) {
                // 每个节点之间的间距
                rowLength += nodeSpace;
            }
            rowLength += cornerSpace;
            MJLOPNode *node = rowNodes[j];
            if (node) {
                // 居中（由于奇偶数的问题，可能有1个符号的误差）
                NSUInteger deltaX = (_maxWidth - node->_width) >> 1;
                node->_x = rowLength + deltaX;
                node->_y = i;
            }
            rowLength += _maxWidth;
            rowLength += cornerSpace;
        }
        // 删除所有的null
        [rowNodes removeObject:@"null"];
//        NSMutableArray *copyArr = [NSMutableArray arrayWithArray:rowNodes];
//        for (id object in copyArr) {
//            if ([object isEqual:@"null"]) {
//                [rowNodes removeObject:object];
//            }
//        }
//        NSLog(@"%@",rowNodes);
    }
}

- (void)_compressNodes {
    NSUInteger rowCount = _nodes.count;
    if (rowCount < 2) return;
    
    for (int i = (int) rowCount - 2; i >= 0; i--) {
        NSMutableArray *rowNodes = _nodes[i];
        for (MJLOPNode *node in rowNodes) {
            MJLOPNode *left = node->_left;
            MJLOPNode *right = node->_right;
            if (!left && !right) continue;
            if (left && right) {
                // 让左右节点对称
                [node balance:left right:right];
                
                // left和right之间可以挪动的最小间距
                NSUInteger leftEmpty = [node leftBoundEmptyLength];
                NSUInteger rightEmpty = [node rightBoundEmptyLength];
                NSUInteger empty = MIN(leftEmpty, rightEmpty);
                empty = MIN(empty, (right->_x - [left rightX]) >> 1);
                
                // left、right的子节点之间可以挪动的最小间距
                NSUInteger space = [left minLevelSpaceToRight:right] - MIN_SPACE;
                space = MIN(space >> 1, empty);
                
                // left、right往中间挪动
                if (space > 0) {
                    [left translateX:space];
                    [right translateX:-space];
                }
                
                // 继续挪动
                space = [left minLevelSpaceToRight:right] - MIN_SPACE;
                if (space < 1) continue;
                
                // 可以继续挪动的间距
                leftEmpty = [node leftBoundEmptyLength];
                rightEmpty = [node rightBoundEmptyLength];
                if (leftEmpty < 1 && rightEmpty < 1) continue;
                
                if (leftEmpty > rightEmpty) {
                    [left translateX:MIN(leftEmpty, space)];
                } else {
                    [right translateX:-MIN(rightEmpty, space)];
                }
            } else if (left) {
                [left translateX:[node leftBoundEmptyLength]];
            } else { // right != null
                [right translateX:-[node rightBoundEmptyLength]];
            }
        }
    }
}

- (void)_addXLineNode:(NSMutableArray *)curRow parent:(MJLOPNode *)parent x:(NSUInteger)x {
    MJLOPNode *line = [MJLOPNode nodeWithString:@"─"];
    line->_x = x;
    line->_y = parent->_y;
    [curRow addObject:line];
}

- (MJLOPNode *)_addLineNode:(NSMutableArray *)curRow nextRow:(NSMutableArray *)nextRow
              parent:(MJLOPNode *)parent child:(MJLOPNode *)child {
    if (!child) return nil;
    
    MJLOPNode *top = nil;
    NSUInteger topX = [child topLineX];
    if (child == parent->_left) {
        top = [MJLOPNode nodeWithString:@"┌"];
        [curRow addObject:top];
        
        for (NSUInteger x = topX + 1; x < parent->_x; x++) {
            [self _addXLineNode:curRow parent:parent x:x];
        }
    } else {
        for (NSUInteger x = [parent rightX]; x < topX; x++) {
            [self _addXLineNode:curRow parent:parent x:x];
        }
        
        top = [MJLOPNode nodeWithString:@"┐"];
        [curRow addObject:top];
    }
    
    // 坐标
    top->_x = topX;
    top->_y = parent->_y;
    child->_y = parent->_y + 2;
    _minX = MIN(_minX, child->_x);
    
    // 竖线
    MJLOPNode *bottom = [MJLOPNode nodeWithString:@"│"];
    bottom->_x = topX;
    bottom->_y = parent->_y + 1;
    [nextRow addObject:bottom];
    
    return top;
}

- (void)_addLineNodes {
    NSMutableArray *newNodes = [NSMutableArray array];
    
    NSUInteger rowCount = _nodes.count;
    if (rowCount < 2) return;
    
    _minX = _root->_x;
    
    for (NSUInteger i = 0; i < rowCount; i++) {
        NSMutableArray *rowNodes = _nodes[i];
        if (i == rowCount - 1) {
            [newNodes addObject:rowNodes];
            continue;
        }
        
        NSMutableArray *newRowNodes = [NSMutableArray array];
        [newNodes addObject:newRowNodes];
        
        NSMutableArray *lineNodes = [NSMutableArray array];
        [newNodes addObject:lineNodes];
        for (MJLOPNode *node in rowNodes) {
            [self _addLineNode:newRowNodes nextRow:lineNodes parent:node child:node->_left];
            [newRowNodes addObject:node];
            [self _addLineNode:newRowNodes nextRow:lineNodes parent:node child:node->_right];
        }
    }
    
    [_nodes removeAllObjects];
    [_nodes addObjectsFromArray:newNodes];
}

@end
