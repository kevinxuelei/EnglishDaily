//
//  DHRecommendDetailViewController.m
//  每日美语
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "DHRecommendDetailViewController.h"
#import "NetWorkHandle.h"
#import "AlbumContentsModel.h"
#import "AlbumContentTableViewCell.h"
#import "HDAllUse.h"
#import "DictionaryViewController.h"

@interface DHRecommendDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *recommandDetailData;

@end

@implementation DHRecommendDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     self.navigationItem.title = self.RLModel.title_en;
    
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

-(void)loadData{
    
    [NetWorkHandle getDataWithUrlString:[NSString stringWithFormat:@"http://mryyydjava.duapp.com/getArticleJson?id=%@",self.RLModel.articleId] compare:^(id object) {
        
        NSDictionary *dict = object;
        NSArray *arrayData =  [dict objectForKey:@"content"];
        
        NSMutableArray *arrData = [NSMutableArray array];
        for (NSDictionary *dict in arrayData) {
            AlbumContentsModel *model = [AlbumContentsModel AlbumContentsModelWithDict:dict];
            [arrData addObject:model];
        }
        self.recommandDetailData = [NSArray arrayWithArray:arrData];
        [self.tableView reloadData];
    }];
}

-(void)loadTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 110) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.nightBackgroundColor = UIColorFromRGB(0x343434);
    self.tableView.nightSeparatorColor = UIColorFromRGB(0x313131);
    
    UIButton *deepLearnView = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 110, self.view.frame.size.width, 50)];
    deepLearnView.backgroundColor = [UIColor grayColor];
    deepLearnView.nightBackgroundColor =  [UIColor grayColor];
    [deepLearnView setTitle:@"查词" forState:UIControlStateNormal];
    [deepLearnView addTarget:self action:@selector(learnDeep:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deepLearnView];

}

-(void)learnDeep:(UIButton *)sender{
    
    DictionaryViewController *dictionaryVC =[[DictionaryViewController alloc] init];
    [self.navigationController pushViewController:dictionaryVC animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.recommandDetailData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AlbumContentTableViewCell *cell = [AlbumContentTableViewCell AlbumContentTableViewCell:tableView];
    cell.contentModel = self.recommandDetailData[indexPath.row];
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AlbumContentsModel *model = self.recommandDetailData[indexPath.row];
    NSString *content = [model.cn stringByAppendingString:model.en];
    CGFloat height = [self cellHeight:content];
    
    return height + 40 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 30)];
    titleLabel.text  = self.RLModel.title_cn;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor orangeColor];
    
    return titleLabel;
    
}

-(CGFloat)cellHeight:(NSString *)stringValue{
    
    CGRect stringRect = [stringValue boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 20, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil];
    
    return stringRect.size.height;
}

@end
