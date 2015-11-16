//
//  DHAlbumViewController.m
//  每日美语
//
//  Created by lanou3g on 15/10/21.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "DHAlbumViewController.h"
#import "NetWorkHandle.h"
#import "HDAllUse.h"
#import "AlbumListModel.h"
#import "Colours.h"
#import "AlbumListTableViewCell.h"
#import "DHAlbumDetailViewController.h"
#import "ImageModel.h"

@interface DHAlbumViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *albumdDataArr;
@property (nonatomic, strong) NSArray *headerImagesData;
@property (nonatomic,retain) MBProgressHUD * hud;
@end

@implementation DHAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = KTabBarColor;

    [self loadData];
    [self loadTableView];
    [self p_setupProgressHud];
    [self loadRefresh];
}
-(void)loadRefresh{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
    }];
    self.tableView.footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
    }];
    
}
-(void)p_setupProgressHud{
    
    self.hud = [[MBProgressHUD alloc] initWithView:self.tableView];
    self.hud.frame = self.view.bounds;
    self.hud.minSize = CGSizeMake(100, 100);
    self.hud.mode = MBProgressHUDModeIndeterminate;
    [self.tableView addSubview:self.hud];
    self.hud.dimBackground = YES;
    self.hud.labelText = @"loading";
    [self.hud show:YES];
}

-(void)loadData{
    
    [NetWorkHandle getDataWithUrlString:KAlbumListUrl compare:^(id object) {
        
        [self.hud hide:YES];
        NSArray *array = [object objectForKey:@"data"];
        
        NSMutableArray *arrayData = [NSMutableArray array];
  
            for (NSDictionary *dict in array) {
                AlbumListModel *model = [[AlbumListModel alloc] initWithDict:dict];
                [arrayData addObject:model];
            }
        self.albumdDataArr = arrayData;
        [self.tableView reloadData];
    }];
    
  
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"date2.txt" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

    NSMutableArray *arrImages = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        
        ImageModel *modelImg = [[ImageModel alloc] init];
        [modelImg setValuesForKeysWithDictionary:dict];
        [arrImages addObject:modelImg];
        
    }
    self.headerImagesData = arrImages;

}
-(void)loadTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.albumdDataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AlbumListTableViewCell *cell = [AlbumListTableViewCell AlbumListTableViewCellWith:tableView];
    AlbumListModel *model = self.albumdDataArr[indexPath.row];
    ImageModel *modelImg = self.headerImagesData[indexPath.row];
    model.image = modelImg.image;
    cell.ALModel = model;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DHAlbumDetailViewController *albumDetailVC = [[DHAlbumDetailViewController alloc] init];
    AlbumListModel *model = self.albumdDataArr[indexPath.row];
    albumDetailVC.headerModel = model;

    [self.navigationController pushViewController:albumDetailVC animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
         self.navigationController.navigationBar.nightBarTintColor = UIColorFromRGB(0x444444);
    }else{
           self.navigationController.navigationBar.barTintColor = KTabBarColor;
    }
}

@end
