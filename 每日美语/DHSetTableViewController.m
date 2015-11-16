//
//  DHSetTableViewController.m
//  每日美语
//
//  Created by lanou3g on 15/10/27.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "DHSetTableViewController.h"
#import "HDAllUse.h"

@interface DHSetTableViewController ()
- (IBAction)changeNightModel:(UISwitch *)sender;
@property (strong, nonatomic) IBOutlet UILabel *nightModelLabel;

@end

@implementation DHSetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.nightBarTintColor = UIColorFromRGB(0x444444);
    self.navigationItem.title = @"设置";
    self.navigationController.navigationBar.nightTintColor = UIColorFromRGB(0x343434);    
    self.navigationController.navigationBar.nightBackgroundColor = UIColorFromRGB(0x343434);
    self.view.nightBackgroundColor = UIColorFromRGB(0x343434);
    self.nightModelLabel.nightTextColor = [UIColor whiteColor];
    
}

- (IBAction)changeNightModel:(UISwitch *)sender {
    
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
        [DKNightVersionManager dawnComing];
    } else {
        [DKNightVersionManager nightFalling];
    }

}
@end
