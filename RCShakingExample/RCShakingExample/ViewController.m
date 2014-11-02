//
//  ViewController.m
//  RCShakingExample
//
//  Created by Looping on 14/10/31.
//  Copyright (c) 2014 RidgeCorn. All rights reserved.
//

#import "ViewController.h"
#import <UIView+RCShaking.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)verShakingTouched:(UIButton *)sender {
    [_avatarView verShaking];
    [sender verShaking];
}

- (IBAction)horShakingTouched:(UIButton *)sender {
    [_avatarView horShaking];
    [sender horShaking];
}

- (IBAction)ranShaking:(UIButton *)sender {
    [_avatarView ranShaking];
    [sender ranShaking];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
