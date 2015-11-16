//
//  MusicPlayHelper.m
//  MusicPlayer
//
//  Created by lanou3g on 15/10/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicPlayHelper.h"
#import <AVFoundation/AVFoundation.h>

@interface MusicPlayHelper ()

@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, strong) NSTimer *timer; // timer which send the playing-time to slider to change value

@end

@implementation MusicPlayHelper

#pragma mark -- 获取音乐的单例对象
+(instancetype)shareMusicPlayHelper{
    
    static MusicPlayHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MusicPlayHelper alloc] init];
    });
    return instance;
}

//使用懒加载创建avplayer对象 getter 方法的调用  self.avplayer

-(AVPlayer *)avPlayer{
    
    if (!_avPlayer) {
        _avPlayer = [[AVPlayer alloc] init];
    }
    return _avPlayer;
}
#pragma mark -- 根据mp3 url 来播放音乐
-(void)preparePlayMusicWithUrlString:(NSString *)urlString{
    
    AVPlayerItem *musicItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:urlString]];
    [self.avPlayer replaceCurrentItemWithPlayerItem:musicItem];
 

    
}

-(void)play{
    
    if (_isPlaying == YES) {
        return;
    }
    
    [self.avPlayer play];
    _isPlaying = YES;
    
    // when playing,the timer works
    if (self.timer != nil) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playAction:) userInfo:nil repeats:YES];
}

-(void)playAction:(NSTimer *)sender{
    
     double second =  CMTimeGetSeconds(self.avPlayer.currentItem.currentTime) / CMTimeGetSeconds(self.avPlayer.currentItem.duration);
    if (self.delegate && [self.delegate respondsToSelector:@selector(playingToTime:)]) {
        
        [self.delegate playingToTime:second];
    }
    
}

-(void)pause{
    
    if (_isPlaying == NO) {
        return ;
    }
    
    [self.avPlayer pause];
    _isPlaying = NO;
    
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark -- play music depended on specific time
-(void)seekToPlayWithTime:(NSTimeInterval)timeInterval{
    
    [self.avPlayer seekToTime:CMTimeMake(self.avPlayer.currentTime.timescale *timeInterval, self.avPlayer.currentTime.timescale) completionHandler:^(BOOL finished) {
        
    }];
}

#pragma mark -- set volume
-(void)setVolume:(float)volume{
  //  _volume = volume;
    self.avPlayer.volume = volume;
}
#pragma mark -- 使用通知观察当前歌曲是否播放完毕
-(instancetype)init{
    if (self = [super init]) {
        
        // notification 添加的观察值 // kvo是观察的某个属性，而专门有通知中心类的观察avplay的方法
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playDidEnd) name:AVPlayerItemDidPlayToEndTimeNotification  object:nil];
    }
    return self;
}

-(void)playDidEnd{
    if (self.delegate && [self.delegate respondsToSelector:@selector(playDidEnd)]) {
        [self.delegate playDidEnd];
    }
    
}

@end
