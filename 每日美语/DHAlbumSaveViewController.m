//
//  DHAlbumSaveViewController.m
//  每日美语
//
//  Created by lanou3g on 15/10/28.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "DHAlbumSaveViewController.h"
#import "UserHandle.h"
#import "UserModel.h"
#import "AlbumDetailModel.h"
#import "DHAlbumContentViewController.h"
#import "HDAllUse.h"

@interface DHAlbumSaveViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation DHAlbumSaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.nightBackgroundColor = UIColorFromRGB(0x343434);
    
  [self loadData];
  [self loadTableView];
  

}

-(void)loadData{
    
    UserHandle *userHandel = [UserHandle shareUserHandle];
    self.dataArray = userHandel.userModel.SentenceSave;
    
}

-(void)loadTableView{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"saveCelll"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"saveCelll" forIndexPath:indexPath];
    AlbumDetailModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.title_cn;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DHAlbumContentViewController *contentVC = [[DHAlbumContentViewController alloc] init];
    AlbumDetailModel *model = self.dataArray[indexPath.row];
    contentVC.ADModel = model;
    
    [self.navigationController pushViewController:contentVC animated:YES];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserHandle *userHandle = [UserHandle shareUserHandle];
    
    [self.dataArray removeObjectAtIndex:indexPath.row];
    userHandle.userModel.SentenceSave = self.dataArray;
    
    NSString *documentStr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] ;
    NSString *filePath =[documentStr stringByAppendingString:[NSString stringWithFormat:@"/%@.txt",userHandle.userModel.email]];
    [NSKeyedArchiver archiveRootObject:userHandle.userModel toFile:filePath];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


@end
