//
//  DHRegisteViewController.m
//  每日美语
//
//  Created by lanou3g on 15/10/28.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "DHRegisteViewController.h"
#import "HDAllUse.h"
#import "UserModel.h"
#import "UserHandle.h"
#import "DHLoginViewController.h"

@interface DHRegisteViewController ()
@property (strong, nonatomic) IBOutlet UITextField *EmaliLabel;
@property (strong, nonatomic) IBOutlet UITextField *passwordLabel;

- (IBAction)RegistAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *alterLabel;
@property (strong, nonatomic) IBOutlet UIButton *RegisterBtn;

@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;

- (IBAction)cancelAction:(UIButton *)sender;

@end

@implementation DHRegisteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.passwordLabel.layer.cornerRadius=4.0f;
    self.passwordLabel.layer.masksToBounds=YES;
    self.passwordLabel.layer.borderColor=[KtextColor CGColor];
    self.passwordLabel.layer.borderWidth= 1.0f;
    self.EmaliLabel.layer.cornerRadius=4.0f;
    self.EmaliLabel.layer.masksToBounds=YES;
    self.EmaliLabel.layer.borderColor=[KtextColor CGColor];
    self.EmaliLabel.layer.borderWidth= 1.0f;
    [self.RegisterBtn setBackgroundColor:KtextColor];
    [self.cancelBtn setBackgroundColor:KtextColor];
    self.RegisterBtn.titleLabel.textColor = [UIColor whiteColor];
    self.alterLabel.textColor = [UIColor grayColor];
    self.alterLabel.nightTextColor = [UIColor grayColor];
      self.view.nightBackgroundColor =  UIColorFromRGB(0x444444);
    self.RegisterBtn.nightBackgroundColor = [UIColor grayColor];
    self.cancelBtn.nightBackgroundColor = [UIColor grayColor];
     [self.RegisterBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
     [self.cancelBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    self.navigationController.title = @"注册";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UIBarButtonItemStylePlain target:self action:@selector(LoginAction:)];
}

-(void)LoginAction:(UIBarButtonItem *)sender{
    DHLoginViewController *loginVC = [[DHLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}
- (IBAction)RegistAction:(UIButton *)sender {
    
    if ( [self.passwordLabel.text isEqualToString:@""] ||  [self.EmaliLabel.text isEqualToString:@""]   ) {
        [self lackRegistInfo];
        
    }else{
        
        if (self.passwordLabel.text.length < 6) {
            [self lackLengthInfo];
        }else{
        NSString *fileName = self.EmaliLabel.text;
        NSString *documentStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *userInfoPath = [documentStr stringByAppendingString:[NSString stringWithFormat:@"/%@.txt",fileName]];
        UserModel *user = [[UserModel alloc] initWithEmail:self.EmaliLabel.text password:self.passwordLabel.text ArticleSave:nil SentenceSave:nil];
        
        [NSKeyedArchiver archiveRootObject:user toFile:userInfoPath];
        
        UserHandle *userHandle = [UserHandle shareUserHandle];
        userHandle.isLogin = NO;
        userHandle.userModel = user;

        [UIView animateWithDuration:1 animations:^{
            [self dismissViewControllerAnimated:YES completion:nil];
            [self registSuccess];
        }];
        }
    }
    
}

-(void)lackLengthInfo{
    UIAlertView *alertViewRegistFail = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码至少六位，请重新注册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertViewRegistFail show];
}
-(void)lackRegistInfo{
    UIAlertView *alertViewRegistFail = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入完整信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertViewRegistFail show];
}

-(void)registSuccess{
    UIAlertView *alertViewRegistSuccess = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功，请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertViewRegistSuccess show];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}


- (IBAction)cancelAction:(UIButton *)sender {
    
    [UIView animateWithDuration:4 animations:^{
       [self dismissViewControllerAnimated:YES completion:nil];
    }];
}
@end
