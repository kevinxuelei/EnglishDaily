//
//  DHArticleContentsViewController.m
//  每日美语
//
//  Created by lanou3g on 15/10/28.
//  Copyright (c) 2015年 DH. All rights reserved.
//

#import "DHArticleContentsViewController.h"
#import "NetWorkHandle.h"
#import "ArticleContentModel.h"
#import "HDAllUse.h"
#import "MusicPlayHelper.h"
#define KMusicPlayHelper [MusicPlayHelper shareMusicPlayHelper]
#import "UserHandle.h"



@interface DHArticleContentsViewController ()<MusicPlayHelperDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) ArticleContentModel *contentModel;
- (IBAction)playAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UISlider *progressSlider;
@property (strong, nonatomic) IBOutlet UIButton *playOrPauseBtn;
@property (nonatomic, strong) NSMutableArray *articleModels;

@end

@implementation DHArticleContentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
   
    
    self.navigationItem.title = self.ALModel.title;
    KMusicPlayHelper.delegate = self;
    self.progressSlider.value = 0;
    self.view.nightBackgroundColor = UIColorFromRGB(0x444444);
    
    _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.webView loadHTMLString:self.contentModel.newstext baseURL:nil];
    
}


-(void)historyRecorder{
    
      UserHandle *userHandle = [UserHandle shareUserHandle];
    
            NSString *documentStr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] ;
            NSString *articleSavePath = [documentStr stringByAppendingString:[NSString stringWithFormat:@"/%@.txt",userHandle.userModel.email]];
    
            self.articleModels = [NSMutableArray array];
            self.articleModels = userHandle.userModel.ArticleSave;
    
            if (self.articleModels == nil) {
    
                self.articleModels               = [NSMutableArray array];
                ArticleListModel *model          = self.ALModel;
                [self.articleModels addObject:model];
                userHandle.userModel.ArticleSave = self.articleModels;
                [NSKeyedArchiver archiveRootObject:userHandle.userModel toFile:articleSavePath];
             
            }else{
                
        
                if ([self modelIsInSaveModelsArray] == YES) {
                  
                }else{
    
                    [self.articleModels addObject:self.ALModel];
                    userHandle.userModel.ArticleSave = self.articleModels;
                    [NSKeyedArchiver archiveRootObject:userHandle.userModel toFile:articleSavePath];

                }
                
            }

}

-(BOOL)modelIsInSaveModelsArray{
    
    UserHandle *userHandle = [UserHandle shareUserHandle];

    NSMutableArray *arrModel    = [NSMutableArray array];
    for (ArticleListModel *model in userHandle.userModel.ArticleSave) {
    ArticleListModel *modelTemp = model;
    NSString *strTitle          = modelTemp.title;
        [arrModel addObject:strTitle];

    }
    
    NSString *modelTitle = self.ALModel.title;
    if ([arrModel containsObject:modelTitle]) {
        return  YES;
    }else{
        return NO;
    }
    
}


-(void)playingToTime:(NSTimeInterval)time{
    
    
    self.progressSlider.value = time;
    
}

-(void)loadData{
    
    [NetWorkHandle SynchronouspostDataWithUrlString:KArticleContentUrl andBodyString:[NSString stringWithFormat:@"contentid=%@&tbname=yingyu",self.ALModel.id] compare:^(id object) {
        
        self.contentModel = [ArticleContentModel ArticleContentModelWithDict:object];
        
    }];
}


-(void)prepareForPlaying{
    
    [KMusicPlayHelper preparePlayMusicWithUrlString:self.ALModel.mp3url];
    
}

- (IBAction)playAction:(UIButton *)sender {
    
    if ([KMusicPlayHelper isPlaying] == YES) {
        
        self.playOrPauseBtn.selected = NO;
        [KMusicPlayHelper pause];
    }else{

         self.playOrPauseBtn.selected = YES;
        [KMusicPlayHelper play];
    }

}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [self prepareForPlaying];
     [KMusicPlayHelper pause];
    if ([self.ALModel.mp3url isEqualToString:@""]) {
        self.playOrPauseBtn.hidden = YES;
        self.progressSlider.hidden = YES;
    }
}
-(void)viewDidAppear:(BOOL)animated{
    
    UserHandle *userHandle = [UserHandle shareUserHandle];
    if (userHandle.isLogin == YES) {
        [self historyRecorder];
    }
}
-(void)dealloc{

   KMusicPlayHelper.delegate = nil ;
}

@end
