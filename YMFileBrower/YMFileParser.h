//
//  YMFileParser.h
//  FileBrower_OC_Demo
//
//  Created by zhiming9 on 2020/1/15.
//  Copyright © 2020 zhiming9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMFileBrowerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YMFileParser : NSObject

+ (instancetype)shareInstance;

- (NSArray<YMFileBrowerModel *> *)filesForDirectory:(NSURL *)directoryPath;

@end

NS_ASSUME_NONNULL_END
