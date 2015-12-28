//
//  ViewController.m
//  MiniNav
//
//  Created by m2sar on 27/10/2014.
//  Copyright (c) 2014 m2sar. All rights reserved.
//

#import "ViewController.h"
#import "MiniNavView.h"

@interface ViewController ()

@end

@implementation ViewController

MiniNavView *v;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIScreen *ecran = [UIScreen mainScreen];
    CGRect rect=[ecran bounds];
    v = [[MiniNavView alloc] initWithFrame:rect];
    [v setBackgroundColor:[ UIColor whiteColor]];
    
    [self setView:v];[v release];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
