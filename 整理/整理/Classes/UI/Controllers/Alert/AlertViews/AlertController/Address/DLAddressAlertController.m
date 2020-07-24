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
#define textItemID @"textItemID"
#define addressCellID @"addressCellID"

@interface DLAddressAlertController () <UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property(nonatomic, strong) NSMutableArray * hotCityArray;

@property(nonatomic, strong) NSMutableArray * provinceArray;

@property(nonatomic, strong) NSMutableArray * cityArray;

@property(nonatomic, strong) NSMutableArray * areaArray;

@property(nonatomic, weak) UICollectionView * pageCollectionView;

@property(nonatomic, weak) UICollectionView * hotCityCollectionView;

@property(nonatomic, weak) UITableView * provinceTableView;

@property(nonatomic, weak) UITableView * cityTableView;

@property(nonatomic, weak) UITableView * areaTableView;

@property(nonatomic, weak) UIButton * provinceBtn;

@property(nonatomic, weak) UIButton * cityBtn;

@property(nonatomic, weak) UIButton * areaBtn;

@property(nonatomic, strong) NSDictionary * selectProvince;

@property(nonatomic, strong) NSDictionary * selectCity;

@property(nonatomic, strong) NSDictionary * selectArea;

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
    self.hotCityArray = [NSMutableArray arrayWithArray:[self getDataFromPathName:@"hotCity"]];
}

- (void)loadProvinceData {
    self.provinceArray = [NSMutableArray arrayWithArray:[self getDataFromPathName:@"province"]];
}

- (NSDictionary *)loadCityData {
    return [self getDataFromPathName:@"city"];
}

- (NSDictionary *)loadAreaData {
    return [self getDataFromPathName:@"area"];
}


#pragma mark - UI

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor screenColor];
    self.view.layer.cornerRadius = 15.0f;
    [self setupUI];
    [self loadProvinceData];
    [self loadHotCityData];
}

- (void)setupUI {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"请选择所在地区";
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.textColor = [UIColor boldBlackTextColor];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(15);
    }];
    
    UIButton *provinceBtn = [[UIButton alloc] init];
    [provinceBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [provinceBtn setTitleColor:[UIColor normalTextColor] forState:UIControlStateNormal];
    provinceBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:provinceBtn];
    [provinceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(titleLabel.mas_bottom).offset(30);
    }];
    self.provinceBtn = provinceBtn;
    
    UIButton *cityBtn = [[UIButton alloc] init];
    [cityBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [cityBtn setTitleColor:[UIColor normalTextColor] forState:UIControlStateNormal];
    cityBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:cityBtn];
    [cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(provinceBtn.mas_right).offset(20);
        make.centerY.equalTo(provinceBtn);
    }];
    self.cityBtn = cityBtn;
    self.cityBtn.hidden = YES;
    
    UIButton *areaBtn = [[UIButton alloc] init];
    [areaBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [areaBtn setTitleColor:[UIColor normalTextColor] forState:UIControlStateNormal];
    areaBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:areaBtn];
    [areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cityBtn.mas_right).offset(20);
        make.top.equalTo(titleLabel.mas_bottom).offset(30);
    }];
    self.areaBtn = areaBtn;
    self.areaBtn.hidden = YES;
    // masonry为异步,控件frame不会立即刷新,手动调用setNeedsLayout和layoutIfNeeded使控件frame立即刷新
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    CGFloat y = CGRectGetMaxY(provinceBtn.frame) + 10.0f;
    
    
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
    fl.itemSize = CGSizeMake(self.view.width, kScreenHeight * 0.8 - y);
    fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    fl.collectionView.showsHorizontalScrollIndicator = NO;
    fl.minimumLineSpacing = 0;
    fl.minimumInteritemSpacing = 0;
    UICollectionView *pageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, y, self.view.width, kScreenHeight * 0.8 - y) collectionViewLayout:fl];
    [self.view addSubview:pageCollectionView];
    pageCollectionView.delegate = self;
    pageCollectionView.dataSource = self;
    [pageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:pageCellID];

    pageCollectionView.pagingEnabled = YES;
    self.pageCollectionView = pageCollectionView;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.pageCollectionView) {
        if (self.areaArray.count > 0) {
            // 有区数据时,collectionView返回3个页面
            return 3;
        }
        if (self.cityArray.count > 0) {
            // 有城市数据时,collectionView返回2个页面
            return 2;
        }
        // 默认一个页面
        return 1;
    } else {
        return self.hotCityArray.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.pageCollectionView) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:pageCellID forIndexPath:indexPath];
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, cell.width, cell.height) style:UITableViewStyleGrouped];
        tableView.backgroundColor = [UIColor screenColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[DLAddressSelectCell class] forCellReuseIdentifier:addressCellID];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [cell addSubview:tableView];
        if (indexPath.row == 0) {
            self.provinceTableView = tableView;
        } else if(indexPath.row == 1) {
            self.cityTableView = tableView;
        } else {
            self.areaTableView = tableView;
        }
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:textItemID forIndexPath:indexPath];
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = self.hotCityArray[indexPath.row][@"cityName"];
        nameLabel.textColor = [UIColor normalTextColor];
        nameLabel.font = [UIFont systemFontOfSize:14.0f];
        [cell addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            [make edges];
        }];
        return cell;
    }
}

#pragma mark -
#pragma mark - UICollectionDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.hotCityCollectionView) {
        NSLog(@"1111");
        NSString *provinceCode = self.hotCityArray[indexPath.row][@"provinceCode"];
        NSString *cityCode = self.hotCityArray[indexPath.row][@"cityCode"];
        NSDictionary *cityDict = [self loadCityData];
        NSDictionary *areaDict = [self loadAreaData];
        [cityDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (key == provinceCode) {
                self.cityArray = [NSMutableArray arrayWithArray:obj];
                *stop = YES;
            }
        }];
        [areaDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (key == cityCode) {
                self.areaArray = [NSMutableArray arrayWithArray:obj];
                *stop = YES;
            }
        }];
        [self.pageCollectionView reloadData];
        
        self.selectProvince = @{@"code":self.hotCityArray[indexPath.row][@"provinceCode"], @"name":self.hotCityArray[indexPath.row][@"provinceName"]};
        self.selectCity = @{@"code":self.hotCityArray[indexPath.row][@"cityCode"], @"name":self.hotCityArray[indexPath.row][@"cityName"]};
        [self.provinceBtn setTitle:self.hotCityArray[indexPath.row][@"provinceName"] forState:UIControlStateNormal];
        [self.provinceBtn setTitleColor:[UIColor themeColor] forState:UIControlStateNormal];
        self.cityBtn.hidden = NO;
        [self.cityBtn setTitle:self.hotCityArray[indexPath.row][@"cityName"] forState:UIControlStateNormal];
        [self.cityBtn setTitleColor:[UIColor themeColor] forState:UIControlStateNormal];
        self.areaBtn.hidden = NO;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        [self.pageCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}



#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.provinceTableView) {
        return 200;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.provinceTableView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor screenColor];
        view.userInteractionEnabled = YES;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor detailTextColor];
        titleLabel.text = @"热门城市";
        titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(20);
            make.top.equalTo(view).offset(10);
        }];
        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
        fl.itemSize = CGSizeMake(50, 20);
        fl.minimumLineSpacing = 45.0f;
        fl.minimumInteritemSpacing = 20.0f;
        fl.sectionInset = UIEdgeInsetsMake(20, 40, 20, 20);
        fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:fl];
        collectionView.backgroundColor = [UIColor screenColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:textItemID];
        [view addSubview:collectionView];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(view);
            make.top.equalTo(titleLabel.mas_bottom);
        }];
        self.hotCityCollectionView = collectionView;
        return view;
    }
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.provinceTableView) {
        return self.provinceArray.count;
    }
    if (tableView == self.cityTableView) {
        return self.cityArray.count;
    }
    if (tableView == self.areaTableView) {
        return self.areaArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLAddressSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCellID];
    if (tableView == self.provinceTableView) {
        cell.addressName = self.provinceArray[indexPath.row][@"name"];
    } else if (tableView == self.cityTableView) {
        cell.addressName = self.cityArray[indexPath.row][@"name"];
    } else {
        cell.addressName = self.areaArray[indexPath.row][@"name"];
    }
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 此处可以进行网络请求数据
    if (tableView == self.provinceTableView) {
        self.selectProvince = self.provinceArray[indexPath.row];
        [self.provinceBtn setTitle:self.provinceArray[indexPath.row][@"name"] forState:UIControlStateNormal];
        [self.provinceBtn setTitleColor:[UIColor themeColor] forState:UIControlStateNormal];
        self.cityBtn.hidden = NO;
        // 处理城市数据
        NSDictionary *cityDict = [self loadCityData];
        [cityDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (key == self.provinceArray[indexPath.row][@"code"]) {
                self.cityArray = [NSMutableArray arrayWithArray:obj];
                *stop = YES;
            }
        }];
        [self.pageCollectionView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.pageCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    } else if (tableView == self.cityTableView) {
        self.selectCity = self.cityArray[indexPath.row];
        [self.cityBtn setTitleColor:[UIColor themeColor] forState:UIControlStateNormal];
        [self.cityBtn setTitle:self.cityArray[indexPath.row][@"name"] forState:UIControlStateNormal];
        self.areaBtn.hidden = NO;
        // 处理区数据
        NSDictionary *areaDict = [self loadAreaData];
        [areaDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (key == self.cityArray[indexPath.row][@"code"]) {
                self.areaArray = [NSMutableArray arrayWithArray:obj];
                *stop = YES;
            }
        }];
        [self.pageCollectionView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        [self.pageCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    } else {
        self.selectArea = self.areaArray[indexPath.row];
        [self.areaBtn setTitleColor:[UIColor themeColor] forState:UIControlStateNormal];
        [self.areaBtn setTitle:self.areaArray[indexPath.row][@"name"] forState:UIControlStateNormal];
        NSArray *arr = [NSArray arrayWithObjects:self.selectProvince, self.selectCity, self.selectArea, nil];
        !_selectValues ?: _selectValues(arr);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark -
#pragma mark - LazyLoad

- (NSMutableArray *)provinceArray {
    if (!_provinceArray) {
        _provinceArray = [NSMutableArray array];
    }
    return _provinceArray;
}

- (NSMutableArray *)cityArray {
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}

- (NSMutableArray *)areaArray {
    if (!_areaArray) {
        _areaArray = [NSMutableArray array];
    }
    return _areaArray;
}

- (NSMutableArray *)hotCityArray {
    if (!_hotCityArray) {
        _hotCityArray = [NSMutableArray array];
    }
    return _hotCityArray;
}

@end
