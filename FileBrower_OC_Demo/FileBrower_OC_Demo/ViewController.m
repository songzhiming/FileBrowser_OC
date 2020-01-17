//
//  ViewController.m
//  FileBrower_OC_Demo
//
//  Created by zhiming9 on 2020/1/15.
//  Copyright © 2020 zhiming9. All rights reserved.
//

#import "ViewController.h"
#import "YMFileBrower.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    YMFileBrower *vc = [[YMFileBrower alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
