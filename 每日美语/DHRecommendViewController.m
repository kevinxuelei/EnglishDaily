//
//  DHRecommendViewController.m
//  每日美语
//
//  Created by lanou3g on 15/10/21.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "DHRecommendViewController.h"
#import "NetWorkHandle.h"
#import "RecommandListModel.h"
#import "HDAllUse.h"
#import "Colours.h"
#import "DHRecommendDetailViewController.h"
#import "NSString+DateFormatter.h"
#import "RecommandListTableViewCell.h"



@interface DHRecommendViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *recommenddDataArr;
@property (nonatomic, strong) NSMutableArray *arrayInRow;
@property (nonatomic,retain) MBProgressHUD * hud;
@end

@implementation DHRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = KTabBarColor;
    self.tableView.nightBackgroundColor = UIColorFromRGB(0x343434);
    self.navigationController.navigationBar.nightBarTintColor = UIColorFromRGB(0x444444);
    
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
  
    self.recommenddDataArr = [NSMutableArray array];
    [NetWorkHandle getDataWithUrlString:KRecommendListUrl compare:^(id object) {
        
        [self.hud hide:YES];
        NSArray *array = [object objectForKey:@"data"];
        
        for (int i = 0; i < array.count; i++) {
            
          self.arrayInRow = [NSMutableArray array];
            for (NSDictionary *dict in array[i]) {
                
                RecommandListModel *model = [[RecommandListModel alloc] initWithDict:dict];
                [self.arrayInRow addObject:model];
            }
             [self.recommenddDataArr addObject: self.arrayInRow];
        }
      
        [self.tableView reloadData];
    }];
}

-(void)loadTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 80;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.recommenddDataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return [self.recommenddDataArr[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommandListTableViewCell *cell = [RecommandListTableViewCell RecommandListTableViewCellWith:tableView];
    RecommandListModel *model = self.recommenddDataArr[indexPath.section][indexPath.row];
    cell.model = model;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   if (indexPath.row != 0) {
        
        DHRecommendDetailViewController *recommandDetailVC = [[DHRecommendDetailViewController alloc] init];
        RecommandListModel *model = self.recommenddDataArr[indexPath.section][indexPath.row];
        recommandDetailVC.RLModel = model;
        [self.navigationController pushViewController:recommandDetailVC animated:YES];
    }
    
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    

    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.textColor = [UIColor orangeColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:19];
    
    RecommandListModel *model = self.recommenddDataArr[section][0];
    headerLabel.text = [NSString dataWithString:model.date ];
    headerLabel.nightTextColor = [UIColor orangeColor];
    headerLabel.nightBackgroundColor =  UIColorFromRGB(0x343434);
    return headerLabel;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(void)viewWillAppear:(BOOL)animated{
    
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
        self.navigationController.navigationBar.nightBarTintColor = UIColorFromRGB(0x444444);
    }else{
        self.navigationController.navigationBar.barTintColor = KTabBarColor;
    }
}
@end
