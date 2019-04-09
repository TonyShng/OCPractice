//
//  TwoViewController.m
//  RACTestSecond
//
//  Created by TonyShng on 2019/4/8.
//  Copyright © 2019 TonyShng. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testButton;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)buttonSelected:(UIButton *)sender
{
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
