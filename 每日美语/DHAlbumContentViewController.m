//
//  DHAlbumContentViewController.m
//  每日美语
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "DHAlbumContentViewController.h"
#import "NetWorkHandle.h"
#import "AlbumContentsModel.h"
#import "AlbumContentTableViewCell.h"
#import "HDAllUse.h"
#import "DictionaryViewController.h"
#import "UserHandle.h"



@interface DHAlbumContentViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *contentData;
@property (nonatomic, strong) NSMutableArray *AlbumDetailModels;

@end

@implementation DHAlbumContentViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.navigationItem.title = self.ADModel.title_en;
    self.tableView.nightBackgroundColor = UIColorFromRGB(0x343434);
    
    UIImage *saveImage = [UIImage imageNamed:@"star_unfav@2x"];
    UIImage *saveImageReader = [saveImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:saveImageReader style:UIBarButtonItemStylePlain target:self action:@selector(SaveAction:)];
    
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
-(void)loadTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 110) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];

    
    UIButton *deepLearnView = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 110, self.view.frame.size.width, 50)];
    deepLearnView.backgroundColor = [UIColor grayColor];
    deepLearnView.nightBackgroundColor = [UIColor grayColor];
    [deepLearnView setTitle:@"查词" forState:UIControlStateNormal];
    [deepLearnView addTarget:self action:@selector(learnDeep:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deepLearnView];
    
}
-(void)learnDeep:(UIButton *)sender{
    DictionaryViewController *dictionaryVC =[[DictionaryViewController alloc] init];
    [self.navigationController pushViewController:dictionaryVC animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.contentData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    AlbumContentTableViewCell *cell = [AlbumContentTableViewCell AlbumContentTableViewCell:tableView];
    cell.contentModel = self.contentData[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 30)];
    titleLabel.text  = self.ADModel.title_cn;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor orangeColor];
    
    return titleLabel;
    
}

-(void)loadData{
    [NetWorkHandle getDataWithUrlString:[NSString stringWithFormat:@"http://mryyydjava.duapp.com/getArticleJson?id=%@",self.ADModel.id] compare:^(id object) {
     
        NSDictionary *dict = object;
      NSArray *arrayData =  [dict objectForKey:@"content"];
        
        NSMutableArray *arrData = [NSMutableArray array];
        for (NSDictionary *dict in arrayData) {
            AlbumContentsModel *model = [AlbumContentsModel AlbumContentsModelWithDict:dict];
        
            [arrData addObject:model];
        }
        self.contentData = [NSArray arrayWithArray:arrData];
        [self.tableView reloadData];
    }];
    
}

-(void)SaveAction:(UIBarButtonItem *)sender
{
    
    UserHandle *userHandle = [UserHandle shareUserHandle];
    
    if (userHandle.isLogin == NO) {
        
        [self NOLoginAlter];
        DHLoginViewController *loginVC = [[DHLoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
        
    }else{
        
        NSString *documentStr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] ;
        NSString *articleSavePath = [documentStr stringByAppendingString:[NSString stringWithFormat:@"/%@.txt",userHandle.userModel.email]];
        
        self.AlbumDetailModels = [NSMutableArray array];
        self.AlbumDetailModels = userHandle.userModel.SentenceSave;
        
        
        if (self.AlbumDetailModels == nil) {
            
            self.AlbumDetailModels = [NSMutableArray array];
            
            AlbumDetailModel *model = self.ADModel;
            [self.AlbumDetailModels addObject:model];
            userHandle.userModel.SentenceSave = self.AlbumDetailModels;
            [NSKeyedArchiver archiveRootObject:userHandle.userModel toFile:articleSavePath];
            [self saveSuccessAlterView];
            
            [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"star_faved@2x"]];
            
        }else{
            
            if ([self modelIsInSaveModelsArray] == YES) {
                [self saveFailAlterView];
            }else{
                
                [self.AlbumDetailModels addObject:self.ADModel];
                userHandle.userModel.SentenceSave = self.AlbumDetailModels;
                [NSKeyedArchiver archiveRootObject:userHandle.userModel toFile:articleSavePath];
                [self saveSuccessAlterView];
                [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"star_faved@2x"]];
            }
            
        }
        
    }
    
}

-(BOOL)modelIsInSaveModelsArray{
    
    UserHandle *userHandle = [UserHandle shareUserHandle];
    
    NSMutableArray *arrModel = [NSMutableArray array];
    for (AlbumDetailModel *model in userHandle.userModel.SentenceSave) {
        AlbumDetailModel *modelTemp = model;
        NSString *strTitle = modelTemp.title_cn;
        [arrModel addObject:strTitle];
    }
    
    NSString *modelTitle = self.ADModel.title_cn;
    
    if ([arrModel containsObject:modelTitle]) {
        return  YES;
    }else{
        return NO;
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    if ([self modelIsInSaveModelsArray]) {
         [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"star_faved@2x"]];
    }
}

-(void)saveSuccessAlterView{
    UIAlertView *saveSuccess = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [saveSuccess show];
    
}
-(void)saveFailAlterView{
    
    UIAlertView *saveSuccess = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您已经收藏过!!!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [saveSuccess show];
    
}
-(void)NOLoginAlter{
    
    UIAlertView *NOLoginAlterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有登陆,请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [NOLoginAlterView show];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AlbumContentsModel *model = self.contentData[indexPath.row];
    NSString *content = [model.cn stringByAppendingString:model.en];
    CGFloat height = [self cellHeight:content];

    return height + 40 ;
}

-(CGFloat)cellHeight:(NSString *)stringValue{
    
    CGRect stringRect = [stringValue boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 20, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil];
    
    return stringRect.size.height;
}


@end
