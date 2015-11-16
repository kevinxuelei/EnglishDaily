//
//  MusicPlayHelper.h
//  MusicPlayer
//
//  Created by lanou3g on 15/10/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

//declare the delegate protocal
@protocol MusicPlayHelperDelegate <NSObject>

// playing the music 
-(void)playingToTime:(NSTimeInterval)time;

// end of playing
-(void)playDidEnd;

@end


@interface MusicPlayHelper : NSObject

@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, assign) id<MusicPlayHelperDelegate> delegate;

#pragma mark -- 获取音乐的单例对象
+(instancetype)shareMusicPlayHelper;

#pragma mark -- 根据mp3 url 来播放音乐
-(void)preparePlayMusicWithUrlString:(NSString *)urlString;

#pragma mark -- 播放功能
-(void)play;
#pragma mark -- 暂停
-(void)pause;
#pragma mark -- 快进
-(void)accelerate;
#pragma mark -- play music depended on specific time
-(void)seekToPlayWithTime:(NSTimeInterval)timeInterval;
#pragma mark -- set volume of player
@property (nonatomic, assign) float volume;



@end
