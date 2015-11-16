//
//  DHArticleViewController.m
//  每日美语
//
//  Created by lanou3g on 15/10/21.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "DHArticleViewController.h"
#import "NetWorkHandle.h"
#import "HDAllUse.h"
#import "ArticleListModel.h"
#import "Colours.h"
#import "ArticleTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DHArticleDailyListTableViewController.h"
#import "DHArticleContentsViewController.h"


@interface DHArticleViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *articleDataArr;
@property (nonatomic, strong) NSArray *articleHotArr;
@property (nonatomic, strong) UIScrollView *headScrollView;
@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic,retain) MBProgressHUD * hud;
@property (nonatomic, strong) NSTimer *headerTimer;

@end

@implementation DHArticleViewController

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
    [self loadHeaderTimer];
 
}
-(void)loadHeaderTimer{
    
    self.headerTimer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(changePage) userInfo:nil repeats:YES];
    
}
-(void)changePage{
    
        int page = 0;
        if (self.pageControl.currentPage == self.articleHotArr.count - 1) {
            page = 0;
        }else{
            page = (int)self.pageControl.currentPage + 1;         }
    
        CGFloat kframeW = self.view.frame.size.width;
        CGPoint offset = CGPointMake(kframeW * page , 0);
    
    
    [UIView animateWithDuration:5.0f animations:^{
        [self.headScrollView setContentOffset:offset animated:YES];
    }];
    
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
    
    [NetWorkHandle getDataWithUrlString:KArticleListUrl compare:^(id object) {
        
       [self.hud hide:YES];
        NSArray *array = [object objectForKey:@"dailyEnglish"];
        NSMutableArray *arrayDaily = [NSMutableArray array];
            for (NSDictionary *dict in array) {
                ArticleListModel *model = [[ArticleListModel alloc] initWithDict:dict];
                [arrayDaily addObject:model];
            }
        NSArray *arrayH = [object objectForKey:@"hot"];
        NSMutableArray *arrayhot = [NSMutableArray array];
        for (NSDictionary *dict in arrayH) {
            ArticleListModel *model = [[ArticleListModel alloc] initWithDict:dict];
            [arrayhot addObject:model];
        }
        self.articleHotArr = arrayhot;
        
        NSArray *arrayN = [object objectForKey:@"news"];
        NSMutableArray *arrayNew = [NSMutableArray array];
        for (NSDictionary *dict in arrayN) {
            ArticleListModel *model = [[ArticleListModel alloc] initWithDict:dict];

            [arrayNew addObject:model];
        }

        NSMutableArray *arrAll = [NSMutableArray array];
        [arrAll addObject:arrayDaily];
         [arrAll addObject:arrayNew];
        self.articleDataArr = arrAll;
        [self.tableView reloadData];
    }];
    
}

-(void)loadTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 90;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.articleDataArr.count ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
      return [self.articleDataArr[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ArticleTableViewCell *cell = [ArticleTableViewCell ArticleTableViewCellWith:tableView];
    ArticleListModel *model = self.articleDataArr[indexPath.section][indexPath.row];
    cell.model = model;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DHArticleContentsViewController *contentVC = [[DHArticleContentsViewController alloc] init];
    ArticleListModel *model = self.articleDataArr[indexPath.section][indexPath.row];
    contentVC.ALModel = model;
    
    [self.navigationController pushViewController:contentVC animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 180;
    }else if (section == 1){
        return 80;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
    
    if (section == 0) {
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3, 180 - 20, self.view.frame.size.width / 3, 15)];
        self.pageControl.numberOfPages = self.articleHotArr.count;
        self.pageControl.currentPage = 0;
        self.pageControl.tintColor = [UIColor redColor];
        [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
        self.headScrollView = [[UIScrollView alloc ]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
        self.headScrollView.delegate = self;
        self.headScrollView.pagingEnabled = YES;
        self.headScrollView.showsHorizontalScrollIndicator = NO;
    
        NSMutableArray *images = [NSMutableArray array];
        for (int i=0; i < self.articleHotArr.count ; i++) {
            
            ArticleListModel *model = self.articleHotArr[i];
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.userInteractionEnabled  = YES;
            imageView.frame = CGRectMake(self.view.frame.size.width * i, 0, self.view.frame.size.width , 180);
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 180 - 40, self.view.frame.size.width , 20)];
            label.text = model.title;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:16];
            [imageView addSubview:label];
            [images addObject:imageView];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.titlepic]];
            
            UITapGestureRecognizer * tapGR =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            [imageView addGestureRecognizer:tapGR];
            
            [self.headScrollView addSubview:imageView];
            
        }
        
        self.headScrollView.contentSize = CGSizeMake(self.view.frame.size.width * images.count, 180);
        [headerView addSubview:self.headScrollView];
         [headerView addSubview:self.pageControl];
        return headerView;
    }else if (section == 1){
        
        UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
        UIImageView * imageNext = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_footer"]];
        imageNext.frame =CGRectMake(10, 0, self.view.frame.size.width - 20, 40);
        [newView addSubview:imageNext];
        
        UILabel *labelNext = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, self.view.frame.size.width - 20, 40)];
        labelNext.text = @"最新内容";
        labelNext.textAlignment = NSTextAlignmentCenter;
        labelNext.textColor = [UIColor greenColor];
        labelNext.font = [UIFont systemFontOfSize:18];
        [newView addSubview:labelNext];
        newView.nightBackgroundColor = UIColorFromRGB(0x444444);

        return newView;
    }
    
     return  headerView;
}
-(void)tapAction:(UITapGestureRecognizer *)sender{
    
    DHArticleContentsViewController *contentVC = [[DHArticleContentsViewController alloc] init];
    ArticleListModel *model = self.articleHotArr[self.pageControl.currentPage];
    contentVC.ALModel = model;
    
    [self.navigationController pushViewController:contentVC animated:YES];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }
    return 0;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(20, 10, self.view.frame.size.width - 100, 40)];
    
    UIButton *footerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    footerBtn.layer.masksToBounds = YES;
    footerBtn.layer.cornerRadius = 5;
    footerBtn.layer.borderWidth = 1;
    footerBtn.layer.borderColor = [[UIColor orangeColor] CGColor];
    footerBtn.frame = CGRectMake(8, 0, self.view.frame.size.width - 16, 40);
    
    
    [footerBtn setTitle:@"查看往期" forState:UIControlStateNormal];
     footerBtn.titleLabel.font = [UIFont systemFontOfSize: 17];
    [footerBtn setTitleColor:[UIColor orchidColor] forState:UIControlStateNormal];
    [footerBtn addTarget:self action:@selector(backPrevious:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:footerBtn];
    footer.nightBackgroundColor = UIColorFromRGB(0x444444);

    return footer;
}


-(void)backPrevious:(UIButton *)sender{
    
    DHArticleDailyListTableViewController *dailyListVC = [[DHArticleDailyListTableViewController alloc] init];
    [self.navigationController pushViewController:dailyListVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat scrollW = scrollView.frame.size.width;
    int page = scrollView.contentOffset.x / scrollW;
    self.pageControl.currentPage  = page;
    
    CGFloat sectionHeaderHeight = 180;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

-(void)changePage:(UIPageControl *)sender{


    CGPoint offSet = CGPointMake(sender.currentPage * self.view.frame.size.width, 0);
    [self.headScrollView setContentOffset:offSet animated:YES];
}

- (CGFloat)stringHeightWithString:(NSString *)str fontSize:(CGFloat)fontSize  contentSize:(CGSize)size{
    
    CGRect stringRect = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    
    return stringRect.size.height;
}

@end
