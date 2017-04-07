//
//  ViewController.m
//  SliderBar
//
//  Created by jackli on 2017/4/6.
//  Copyright © 2017年 jackli. All rights reserved.
//

#import "ViewController.h"
#import "WMSliderBar.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    WMSliderBar *slider = [[WMSliderBar alloc] initWithFrame:CGRectMake(0, 50, 320, 30)];
    slider.dataSource = @[@"123",@"qewr",@"456",@"456",@"456",@"456",@"456",@"456"];
    [self.view addSubview:slider];
    slider.backgroundColor=[UIColor redColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
