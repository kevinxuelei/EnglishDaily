//
//  DHLoginViewController.m
//  每日美语
//
//  Created by lanou3g on 15/10/28.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "DHLoginViewController.h"
#import "HDAllUse.h"
#import "DHRegisteViewController.h"
#import "UserModel.h"
#import "UserHandle.h"

@interface DHLoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *EmailLabel;
@property (strong, nonatomic) IBOutlet UITextField *passwordLabel;

@property (strong, nonatomic) IBOutlet UIButton *LoginBtn;

@property (strong, nonatomic) IBOutlet UIButton *registBtn;
- (IBAction)registAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
- (IBAction)cancleAction:(UIButton *)sender;

@end

@implementation DHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"用户登陆";
   
    self.EmailLabel.layer.cornerRadius=4.0f;
    self.EmailLabel.layer.masksToBounds=YES;
    self.EmailLabel.layer.borderColor=[KtextColor CGColor];
    self.EmailLabel.layer.borderWidth= 1.0f;
    self.passwordLabel.layer.cornerRadius=4.0f;
    self.passwordLabel.layer.masksToBounds=YES;
    self.passwordLabel.layer.borderColor=[KtextColor CGColor];
    self.passwordLabel.layer.borderWidth= 1.0f;
    [self.cancelBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [self.LoginBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [self.registBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [self.LoginBtn setBackgroundColor:KtextColor];
    [self.registBtn setBackgroundColor:KtextColor];
    [self.cancelBtn setBackgroundColor:KtextColor];
    self.LoginBtn.titleLabel.textColor = [UIColor whiteColor];
    self.view.nightBackgroundColor =  UIColorFromRGB(0x444444);
    self.LoginBtn.nightBackgroundColor = [UIColor grayColor];
    self.registBtn.nightBackgroundColor = [UIColor grayColor];
    self.cancelBtn.nightBackgroundColor = [UIColor grayColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registeAction:)];


}

- (IBAction)LoginAction:(UIButton *)sender {
    
    NSString *fileName = self.EmailLabel.text;
    NSString *documentStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentStr stringByAppendingString:[NSString stringWithFormat:@"/%@.txt",fileName]];
    
    UserModel *user = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    if (user == nil) {
        [self NoUserInfo];
    }else{
        if ([user.password isEqualToString:self.passwordLabel.text]) {
            
            UserHandle *userHandle = [UserHandle shareUserHandle];
            userHandle.isLogin = YES;
            userHandle.userModel = user;
            
            [UIView animateWithDuration:1 animations:^{
                [self dismissViewControllerAnimated:YES completion:nil];
                [self loginSuccess];
            }];
            
            
        }else{
            
            [self WrongPassWord];
        }
    }

}
-(void)registeAction:(UIBarButtonItem *)sender{
    
    DHRegisteViewController *registeVC = [[DHRegisteViewController alloc] init];
    [self.navigationController pushViewController:registeVC animated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)loginSuccess{
    
    UIAlertView *loginSuccessInfo = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [loginSuccessInfo show];
    
}
-(void)NoUserInfo{
    
    UIAlertView *NoUser = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名不存在,请重新登录或注册后登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [NoUser show];
}
-(void)WrongPassWord{
    
    UIAlertView *WrongPassWordInfo = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码错误,请重新登陆" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [WrongPassWordInfo show];
}

- (IBAction)registAction:(UIButton *)sender {
    DHRegisteViewController *registeVC = [[DHRegisteViewController alloc] init];
    [self presentViewController:registeVC animated:YES completion:nil];
}
- (IBAction)cancleAction:(UIButton *)sender {
    
   [self dismissViewControllerAnimated:YES completion:nil];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self WrongPassWord];
    }];
    

}
@end
