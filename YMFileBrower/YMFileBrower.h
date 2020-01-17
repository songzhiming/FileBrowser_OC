//
//  YMFileBrower.h
//  FileBrower_OC_Demo
//
//  Created by zhiming9 on 2020/1/15.
//  Copyright © 2020 zhiming9. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMFileBrower : UINavigationController

- (instancetype)initWithPath:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
