//
//  AudioPlayer.m
//  Pro_1116AdapterPattern
//
//  Created by Tony on 2018/11/16.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "AudioPlayer.h"
#import "MediaAdapter.h"

@interface AudioPlayer ()
@property (nonatomic, strong) MediaAdapter *mediaAdapter;
@end

@implementation AudioPlayer

- (void)playWithAudioType:(nonnull NSString *)audioType FileName:(nonnull NSString *)fileName
{
    // 播放mp3音乐文件的内置支持
    if ([audioType isEqualToString:@"mp3"]) {
        NSLog(@"Playing mp3 file. Name: %@", fileName);
    }
    // mediaAdapter 提供了播放其他文件格式的支持
    else if ([audioType isEqualToString:@"vlc"] || [audioType isEqualToString:@"mp4"]){
        self.mediaAdapter = [[MediaAdapter alloc]initWithAudioType:audioType];
        [self.mediaAdapter playWithAudioType:audioType FileName:fileName];
    }
    else{
        NSLog(@"Invalid media. %@ format not supported", audioType);
    }
}

@end
