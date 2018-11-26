//
//  ViewController.m
//  Pro_1119Load
//
//  Created by Tony on 2018/11/19.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "ViewController.h"
#import "XXXSunObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    XXXSunObject *sun = [XXXSunObject new];
    [sun didSomething];
    
}


@end
