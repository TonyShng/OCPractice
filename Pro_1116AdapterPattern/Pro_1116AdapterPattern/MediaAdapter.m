//
//  MediaAdapter.m
//  Pro_1116AdapterPattern
//
//  Created by Tony on 2018/11/16.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "MediaAdapter.h"
#import "AdvancedMediaPlayer.h"
#import "VlcPlayer.h"
#import "Mp4Player.h"

@interface MediaAdapter ()
@property (nonatomic, strong) id<AdvancedMediaPlayer> advancedMusicPlayer;
@end

@implementation MediaAdapter

- (instancetype)initWithAudioType:(NSString *)audioType
{
    self = [super init];
    if (self) {
        if ([audioType isEqualToString:@"vlc"]) {
            self.advancedMusicPlayer = [VlcPlayer new];
        } else if ([audioType isEqualToString:@"mp4"]) {
            self.advancedMusicPlayer = [Mp4Player new];
        }
    }
    return self;
}

- (void)playWithAudioType:(NSString *)audioType FileName:(NSString *)fileName
{
    if ([audioType isEqualToString:@"vlc"]) {
        [self.advancedMusicPlayer playVlcWithFileName:fileName];
    } else if ([audioType isEqualToString:@"mp4"]) {
        [self.advancedMusicPlayer playMp4WithFileName:fileName];
    }
}




@end
