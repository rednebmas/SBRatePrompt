//
//  ViewController.m
//  SBRatePromptExample
//
//  Created by Sam Bender on 7/27/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import "ViewController.h"
#import <SBRatePrompt/SBRatePrompt.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(id)sender {
    [SBRatePrompt debugShow];
}

@end
