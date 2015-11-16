//
//  DHArticleDailyDetailTableViewController.m
//  每日美语
//
//  Created by lanou3g on 15/10/24.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "DHArticleDailyDetailTableViewController.h"
#import "NetWorkHandle.h"
#import "ArticleListModel.h"
#import "HDAllUse.h"
#import "ArticleTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DHArticleContentsViewController.h"

@interface DHArticleDailyDetailTableViewController ()

@property (nonatomic, strong) NSArray *dailyDetailArr;

@end

@implementation DHArticleDailyDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.tableView.nightBackgroundColor = UIColorFromRGB(0x343434);
    self.tableView.rowHeight = 100;
    
    [self loadData];
  
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
    
    
    [NetWorkHandle SynchronouspostDataWithUrlString:KArticleDailyDetailUrl andBodyString:[NSString stringWithFormat:@"timeurl=%@",self.timeurl]  compare:^(id object) {
        
        if ([object[@"daily"] isEqual:[NSNull null]]) {
            [self NODataAlter];
            return ;
        }
            NSArray *array = [object objectForKey:@"daily"];
            
            NSMutableArray *arrayData = [NSMutableArray array];
            for (NSDictionary *dict in array) {
                ArticleListModel *model = [[ArticleListModel alloc] initWithDict:dict];
                [arrayData addObject:model];
            }
            self.dailyDetailArr = arrayData;
            [self.tableView reloadData];

    }];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dailyDetailArr.count -1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   ArticleTableViewCell *cell = [ArticleTableViewCell ArticleTableViewCellWith:tableView];
    NSInteger count = indexPath.row;
    cell.model = self.dailyDetailArr[count+1];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 200;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    ArticleListModel *model = self.dailyDetailArr[0];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIImageView *headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 150)];
    headerImage.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapGR =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [headerImage addGestureRecognizer:tapGR];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, self.view.frame.size.width - 20, 20)];

    [headerImage sd_setImageWithURL:[NSURL URLWithString:model.titlepic]];
    titleLabel.text = model.title;
    [headerView addSubview:titleLabel];
    [headerView addSubview:headerImage];
    
    return headerView;
    
}
-(void)tapAction:(UITapGestureRecognizer *)sender{
    
        DHArticleContentsViewController *contentVC = [[DHArticleContentsViewController alloc] init];
         ArticleListModel *model = self.dailyDetailArr[0];
        contentVC.ALModel = model;
    
    [self.navigationController pushViewController:contentVC animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DHArticleContentsViewController *contentVC = [[DHArticleContentsViewController alloc] init];
    NSInteger count = indexPath.row;
    ArticleListModel *model = self.dailyDetailArr[count + 1];
     contentVC.ALModel = model;
    
    [self.navigationController pushViewController:contentVC animated:YES];
}
-(void)NODataAlter{
    
    UIAlertView *NOLoginAlterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，正在更新中，敬请期待" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [NOLoginAlterView show];
    
}

@end
