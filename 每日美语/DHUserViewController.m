//
//  DHUserViewController.m
//  每日美语
//
//  Created by lanou3g on 15/10/26.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "DHUserViewController.h"
#import "HDAllUse.h"
#import "DictionaryDBHandle.h"
#import "DictionaryViewController.h"
#import "DHSetTableViewController.h"
#import "DHLoginViewController.h"
#import "UserModel.h"
#import "DHArticleSkimViewController.h"
#import "DHAlbumSaveViewController.h"
#import "UserHandle.h"

@interface DHUserViewController ()
- (IBAction)LoginBtn:(UIButton *)sender;
- (IBAction)LoginBtnAction:(UIButton *)sender;
- (IBAction)SaveBtn:(UIButton *)sender;

- (IBAction)DictionaryBtn:(UIButton *)sender;
- (IBAction)HistoryBtn:(UIButton *)sender;
- (IBAction)SetBtn:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *saveLabel;

@property (strong, nonatomic) IBOutlet UILabel *dictionaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *historyLabel;
@property (strong, nonatomic) IBOutlet UILabel *setLabel;
@property (strong, nonatomic) IBOutlet UIButton *LoginButton;


@end

@implementation DHUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    

    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = KTabBarColor;
    self.view.nightBackgroundColor = UIColorFromRGB(0x343434);
    self.navigationController.navigationBar.nightBarTintColor = UIColorFromRGB(0x444444);

       self.saveLabel.nightTextColor = [UIColor whiteColor];
       self.dictionaryLabel.nightTextColor = [UIColor whiteColor];
       self.historyLabel.nightTextColor = [UIColor whiteColor];
       self.setLabel.nightTextColor = [UIColor whiteColor];
      self.LoginButton.titleLabel.nightBackgroundColor = [UIColor whiteColor];
}


- (IBAction)LoginBtn:(UIButton *)sender {
    
    UserHandle *userHandle = [UserHandle shareUserHandle];
    if (userHandle.isLogin == YES) {
        [self alreadyLogin];
    }else{
        DHLoginViewController *loginVC = [[DHLoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
}

- (IBAction)LoginBtnAction:(UIButton *)sender {
    
    UserHandle *userHandle = [UserHandle shareUserHandle];
    if (userHandle.isLogin == YES) {
        [self alreadyLogin];
    }else{
        DHLoginViewController *loginVC = [[DHLoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}
- (IBAction)SaveBtn:(UIButton *)sender {
    
    
    UserHandle *userHandle = [UserHandle shareUserHandle];
    
    if (userHandle.isLogin == NO) {
        
        [self NOLoginAlter];
        DHLoginViewController *loginVC = [[DHLoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
        
    }else{

    DHAlbumSaveViewController *albumSaveVC = [[DHAlbumSaveViewController alloc] init];
    [self.navigationController pushViewController:albumSaveVC animated:YES];
    }
}

- (IBAction)DictionaryBtn:(UIButton *)sender {
    
    DictionaryViewController *dictionaryVC = [[DictionaryViewController alloc] init];
    [self.navigationController pushViewController:dictionaryVC animated:YES];
 
}

- (IBAction)HistoryBtn:(UIButton *)sender {
    
    UserHandle *userHandle = [UserHandle shareUserHandle];
    
    if (userHandle.isLogin == NO) {
        
        [self NOLoginAlter];
        DHLoginViewController *loginVC = [[DHLoginViewController alloc] init];
         [self presentViewController:loginVC animated:YES completion:nil];
        
    }else{
    DHArticleSkimViewController *articleVC = [[DHArticleSkimViewController alloc] init];
    [self.navigationController pushViewController:articleVC animated:YES];
   }
}

- (IBAction)SetBtn:(UIButton *)sender {
   
    DHSetTableViewController *setVC = [[DHSetTableViewController alloc] init];
    [self.navigationController pushViewController:setVC animated:YES];

}
-(void)NOLoginAlter{
    
    UIAlertView *NOLoginAlterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有登陆,请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [NOLoginAlterView show];
    
}
-(void)alreadyLogin{
    
    UIAlertView *alreadyLoginAlterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您已经登陆" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alreadyLoginAlterView show];
    
}

@end
