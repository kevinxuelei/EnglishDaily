//
//  DHAlbumDetailViewController.m
//  每日美语
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "DHAlbumDetailViewController.h"
#import "NetWorkHandle.h"
#import "HDAllUse.h"
#import "AlbumDetailModel.h"
#import "DHAlbumContentViewController.h"
#import "AlbumDetailHeaderView.h"
#import "AlbumListTableViewCell.h"

@interface DHAlbumDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *albumDetailModelArr;

@end

@implementation DHAlbumDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.tableView.nightBackgroundColor = UIColorFromRGB(0x343434);
    
    [self loadData];
    [self loadTableView];
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


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  
    AlbumListTableViewCell *cellView = [AlbumListTableViewCell AlbumListTableViewCellWith:tableView];
    cellView.ALModel = self.headerModel;
    cellView.contentView.backgroundColor = [UIColor orangeColor];
    return cellView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 100;
}

-(void)loadData{
    
    [NetWorkHandle getDataWithUrlString:[NSString stringWithFormat:@"http://mryyydjava.duapp.com/getChapters?id=%@",self.headerModel.id] compare:^(id object) {
        
        NSArray *array = [object objectForKey:@"data"];
        
        NSMutableArray *arrayData = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            AlbumDetailModel *model = [[AlbumDetailModel alloc] initWithDict:dict];
            [arrayData addObject:model];
        }
        
        self.albumDetailModelArr = arrayData;
        [self.tableView reloadData];
    }];
    
}

-(void)loadTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"albumDetailCell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.albumDetailModelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"albumDetailCell" forIndexPath:indexPath];
    cell.contentView.nightBackgroundColor = UIColorFromRGB(0x343434);
    cell.textLabel.nightBackgroundColor = UIColorFromRGB(0x343434);
    AlbumDetailModel *model = self.albumDetailModelArr[indexPath.row];
    if ([model.title_cn containsString:@"\r\n"]) {
        cell.textLabel.text = model.title_en;
    }else{
    cell.textLabel.text = model.title_cn;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DHAlbumContentViewController *albumContentVC = [[DHAlbumContentViewController alloc] init];
    AlbumDetailModel *model = self.albumDetailModelArr[indexPath.row];
    albumContentVC.ADModel = model;
    
    [self.navigationController pushViewController:albumContentVC animated:YES];
}


@end
