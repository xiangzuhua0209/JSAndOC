//
//  ViewController.m
//  OCAndJS
//
//  Created by DayHR on 2016/11/4.
//  Copyright © 2016年 lisiye. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)buttonAction:(UIButton *)sender {
    SecondViewController * secondVC = [[SecondViewController alloc] init];
    [self presentViewController:secondVC animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
