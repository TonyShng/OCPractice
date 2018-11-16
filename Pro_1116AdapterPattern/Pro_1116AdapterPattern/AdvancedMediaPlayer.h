//
//  AdvancedMediaPlayer.h
//  Pro_1116AdapterPattern
//
//  Created by Tony on 2018/11/16.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AdvancedMediaPlayer <NSObject>
- (void)playVlcWithFileName:(NSString *)fileName;
- (void)playMp4WithFileName:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
