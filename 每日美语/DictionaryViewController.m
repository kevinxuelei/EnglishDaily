//
//  DictionaryViewController.m
//  每日美语
//
//  Created by lanou3g on 15/10/26.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "DictionaryViewController.h"
#import "DictionaryDBHandle.h"
#import "DictionaryModel.h"
#import "HDAllUse.h"


@interface DictionaryViewController ()
@property (strong, nonatomic) IBOutlet UITextField *wordInput;
- (IBAction)selectAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *showLabel;
@property (strong, nonatomic) IBOutlet UILabel *indicateLabel;


@end

@implementation DictionaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.nightBarTintColor = UIColorFromRGB(0x444444);
    self.navigationController.navigationBar.nightTintColor = UIColorFromRGB(0x343434);
    self.navigationController.navigationBar.nightBackgroundColor = UIColorFromRGB(0x343434);
    self.view.nightBackgroundColor = UIColorFromRGB(0x343434);
    self.showLabel.nightTextColor = [UIColor whiteColor];
    UIColorFromRGB(0x444444);
    self.indicateLabel.nightTextColor = [UIColor whiteColor];
    self.indicateLabel.textColor = [UIColor  grayColor];
  
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (IBAction)selectAction:(UIButton *)sender {
    
    DictionaryDBHandle *dictDB = [DictionaryDBHandle shareDictDataBase];
    [dictDB openDB];
    DictionaryModel *model = [dictDB selectFromTableWhereWord:self.wordInput.text];
    self.showLabel.text = model.means;
    [self.showLabel sizeToFit];
   
}
@end
