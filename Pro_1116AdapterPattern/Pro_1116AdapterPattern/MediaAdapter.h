//
//  MediaAdapter.h
//  Pro_1116AdapterPattern
//
//  Created by Tony on 2018/11/16.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MediaPlayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface MediaAdapter : NSObject <MediaPlayer>

- (instancetype)initWithAudioType:(NSString *)audioType;
- (void)playWithAudioType:(NSString *)audioType FileName:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
