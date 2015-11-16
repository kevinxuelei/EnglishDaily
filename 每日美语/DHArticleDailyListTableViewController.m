//
//  DHArticleDailyListTableViewController.m
//  每日美语
//
//  Created by lanou3g on 15/10/24.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "DHArticleDailyListTableViewController.h"
#import "NetWorkHandle.h"
#import "HDAllUse.h"
#import "ArticleDailyListModel.h"
#import "DHArticleDailyDetailTableViewController.h"


@interface DHArticleDailyListTableViewController ()

@property (nonatomic, strong) NSArray *dailyListData;
@property (nonatomic,retain) MBProgressHUD * hud;
@end

@implementation DHArticleDailyListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.nightBackgroundColor = UIColorFromRGB(0x343434);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"dailyListCell"];
    
    [self loadData];
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
    
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    self.hud.frame = self.view.bounds;
    self.hud.minSize = CGSizeMake(100, 100);
    self.hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:self.hud];
    self.hud.dimBackground = YES;
    self.hud.labelText = @"loading";
    [self.hud show:YES];
}

-(void)loadData{
    
    [NetWorkHandle getDataWithUrlString:KArticleDailyListUrl compare:^(id object) {
        
        [self.hud hide:YES];
        
        NSArray *array = [object objectForKey:@"dailylist"];
        NSMutableArray *arrayData = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            ArticleDailyListModel *model = [[ArticleDailyListModel alloc] initWithDict:dict];
            [arrayData addObject:model];
        }
        self.dailyListData = arrayData;
        [self.tableView reloadData];
    }];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dailyListData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dailyListCell" forIndexPath:indexPath];
    ArticleDailyListModel *model = self.dailyListData[indexPath.row];
    cell.textLabel.nightTextColor = [UIColor whiteColor];
    cell.textLabel.text = model.newstime;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.nightBackgroundColor = UIColorFromRGB(0x343434);

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DHArticleDailyDetailTableViewController *dailyDetailVC = [[DHArticleDailyDetailTableViewController alloc] init];
    ArticleDailyListModel  *model = self.dailyListData[indexPath.row];
    dailyDetailVC.timeurl = model.timeurl;
    if (![model.timeurl isEqualToString:@""]) {
           [self.navigationController pushViewController:dailyDetailVC animated:YES];
    }
 
}



@end
