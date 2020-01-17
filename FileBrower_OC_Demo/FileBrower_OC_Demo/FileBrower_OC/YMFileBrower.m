//
//  YMFileBrower.m
//  FileBrower_OC_Demo
//
//  Created by zhiming9 on 2020/1/15.
//  Copyright © 2020 zhiming9. All rights reserved.
//

#import "YMFileBrower.h"
#import "YMFileListViewController.h"

@interface YMFileBrower ()

@end

@implementation YMFileBrower

- (instancetype)init{
    return [self initWithPath:[NSURL URLWithString:NSHomeDirectory()]];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self init];
}

- (instancetype)initWithPath:(NSURL *)url {
    YMFileListViewController *vc = [[YMFileListViewController alloc]init];
    vc.path = url;
    self = [super initWithRootViewController:vc];
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}
@end
