//
//  DLAddressAlertController.m
//  整理
//
//  Created by 周冰烽 on 2020/7/21.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLAddressAlertController.h"
#import "DLAddressSelectCell.h"

#define pageCellID @"pageCellID"
#define addressCellID @"addressCellID"

@interface DLAddressAlertController () <UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSMutableArray * hotCityArray;

@property(nonatomic, strong) NSMutableArray * selectValues;

@property(nonatomic, strong) NSMutableArray * provinceArray;

@property(nonatomic, strong) NSMutableArray * dataSource;

@property(nonatomic, weak) UICollectionView * pageCollectionView;

@property(nonatomic, weak) UIButton * provinceBtn;

@property(nonatomic, weak) UIButton * cityBtn;

@property(nonatomic, weak) UIButton * areaBtn;

@end

@implementation DLAddressAlertController

#pragma mark -
#pragma mark - private method

- (id)getDataFromPathName:(NSString *)pathName {
    NSString *path = [[NSBundle mainBundle] pathForResource:pathName ofType:@"json"];
    if (path == nil) {
        NSLog(@"路径解析出现错误");
    } else {
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSError *error = nil;
        id temp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error) {
            NSLog(@"%@",error);
        }
        return temp;
    }
    return nil;
}

- (void)loadHotCityData {
    NSArray *tempArr = [self getDataFromPathName:@"hotCity"];
    self.hotCityArray = [NSMutableArray arrayWithArray:tempArr];
    self.dataSource = self.hotCityArray;
}

- (void)loadProvinceData {
    NSArray *tempArr = [self getDataFromPathName:@"province"];
    self.provinceArray = [NSMutableArray arrayWithArray:tempArr];
    self.dataSource = self.provinceArray;
}

- (void)loadCityData {
    
}

- (void)loadAreaData {
    
}


#pragma mark - UI

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor screenColor];
    self.view.layer.cornerRadius = 15.0f;
    [self setupUI];
    [self loadProvinceData];
}

- (void)setupUI {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"请选择所在地区";
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.textColor = [UIColor normalTextColor];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(15);
    }];
    UIButton *provinceBtn = [[UIButton alloc] init];
    [provinceBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [provinceBtn setTitleColor:[UIColor normalTextColor] forState:UIControlStateNormal];
    provinceBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:provinceBtn];
    [provinceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(titleLabel.mas_bottom).offset(30);
    }];
    self.provinceBtn = provinceBtn;
    // masonry为异步,控件frame不会立即刷新,手动调用setNeedsLayout和layoutIfNeeded使控件frame立即刷新
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    CGFloat y = CGRectGetMaxY(provinceBtn.frame) + 10.0f;
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
    fl.itemSize = CGSizeMake(self.view.width, kScreenHeight * 0.8 - y);
    fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    fl.collectionView.showsHorizontalScrollIndicator = NO;
    UICollectionView *pageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, y, self.view.width, kScreenHeight * 0.8 - y) collectionViewLayout:fl];
    [self.view addSubview:pageCollectionView];
    pageCollectionView.delegate = self;
    pageCollectionView.dataSource = self;
    [pageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:pageCellID];
    pageCollectionView.backgroundColor = [UIColor greenColor];
    self.pageCollectionView = pageCollectionView;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kScreenHeight * 0.8 - y)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[DLAddressSelectCell class] forCellReuseIdentifier:addressCellID];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.pageCollectionView addSubview:tableView];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.selectValues.count == 0) {
        return 1;
    }
    return self.selectValues.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.pageCollectionView) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:pageCellID forIndexPath:indexPath];
        
        return cell;
    }
    
    return nil;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.provinceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLAddressSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCellID];
    
    cell.addressName = self.provinceArray[indexPath.row][@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark -
#pragma mark - LazyLoad

- (NSMutableArray *)selectValues {
    if (!_selectValues) {
        _selectValues = [NSMutableArray array];
    }
    return _selectValues;
}

- (NSMutableArray *)provinceArray {
    if (!_provinceArray) {
        _provinceArray = [NSMutableArray array];
    }
    return _provinceArray;
}

- (NSMutableArray *)hotCityArray {
    if (!_hotCityArray) {
        _hotCityArray = [NSMutableArray array];
    }
    return _hotCityArray;
}

@end
