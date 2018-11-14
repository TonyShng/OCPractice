//
//  ViewController.m
//  Pro_1112DuckModel
//
//  Created by Tony on 2018/11/12.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "ViewController.h"
#import "XXDuckEntity.h"
#import "XXUserEntity.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *json = @"{\"name\": \"sunnyxx\", \"sex\": \"boy\", \"age\": 24}";
    id<XXDuckEntity, XXUserEntity> entity = XXDuckEntityCreateWithJson(json);
//    id<XXUserEntity> copied = [entity copy];
//    NSLog(@"%@ %@ %@", copied.jsonString, copied.name, copied.age);
    
    
}


@end
