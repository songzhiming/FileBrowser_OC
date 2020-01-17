//
//  YMFileParser.m
//  FileBrower_OC_Demo
//
//  Created by zhiming9 on 2020/1/15.
//  Copyright © 2020 zhiming9. All rights reserved.
//

#import "YMFileParser.h"

@interface YMFileParser()
@property (nonatomic,strong) NSFileManager *fileManager;
@end

@implementation YMFileParser

+ (instancetype)shareInstance
{
    static YMFileParser *fileParser;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fileParser = [[YMFileParser alloc]init];
        fileParser.fileManager = [NSFileManager defaultManager];
    });
    return fileParser;
}

- (NSArray<YMFileBrowerModel *> *)filesForDirectory:(NSURL *)directoryPath
{
    NSArray *tmp =  [self.fileManager contentsOfDirectoryAtURL:directoryPath includingPropertiesForKeys:@[] options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
    NSMutableArray *arr = @[].mutableCopy;
    for (NSURL *url in tmp) {
        YMFileBrowerModel *model = [[YMFileBrowerModel alloc]filePath:url];
        [arr addObject:model];
    }
    return arr;
}

@end
