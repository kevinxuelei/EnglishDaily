//
//  DHArticleSkimViewController.m
//  每日美语
//
//  Created by lanou3g on 15/10/28.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "DHArticleSkimViewController.h"
#import "ArticleListModel.h"
#import "UserHandle.h"
#import "UserModel.h"
#import "ArticleTableViewCell.h"
#import "DHArticleContentsViewController.h"
#import "HDAllUse.h"

@interface DHArticleSkimViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation DHArticleSkimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    [self loadData];
    [self loadTableView];
      self.tableView.nightBackgroundColor = UIColorFromRGB(0x343434);
  
}

-(void)loadData{
    
    UserHandle *userHandel = [UserHandle shareUserHandle];
    self.dataArray = userHandel.userModel.ArticleSave;
    
}

-(void)loadTableView{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 85;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ArticleTableViewCell *cell = [ArticleTableViewCell ArticleTableViewCellWith:tableView];
    ArticleListModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DHArticleContentsViewController *contentVC = [[DHArticleContentsViewController alloc] init];
    ArticleListModel *model = self.dataArray[indexPath.row];
    contentVC.ALModel = model;
    
    [self.navigationController pushViewController:contentVC animated:YES];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserHandle *userHandle = [UserHandle shareUserHandle];
    
    [self.dataArray removeObjectAtIndex:indexPath.row];
    userHandle.userModel.ArticleSave = self.dataArray;
    
    NSString *documentStr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] ;
    NSString *filePath =[documentStr stringByAppendingString:[NSString stringWithFormat:@"/%@.txt",userHandle.userModel.email]];
    [NSKeyedArchiver archiveRootObject:userHandle.userModel toFile:filePath];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}



@end
