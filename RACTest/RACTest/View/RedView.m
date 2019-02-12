//
//  RedView.m
//  RACTest
//
//  Created by TonyShng on 2019/2/12.
//  Copyright © 2019 TonyShng. All rights reserved.
//

#import "RedView.h"

@interface RedView ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation RedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView
{
    _button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    [_button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
}


- (void)btnClick:(UIButton *)button
{
    
}


@end
