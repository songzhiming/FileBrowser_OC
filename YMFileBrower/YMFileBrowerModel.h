//
//  YMFileBrowerModel.h
//  FileBrower_OC_Demo
//
//  Created by zhiming9 on 2020/1/15.
//  Copyright © 2020 zhiming9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    YMFileBrowerTypeDirectory,//目录
    YMFileBrowerTypeGif,
    YMFileBrowerTypeJPG,
    YMFileBrowerTypeJSON,
    YMFileBrowerTypePDF,
    YMFileBrowerTypePLIST,
    YMFileBrowerTypePNG,
    YMFileBrowerTypeZIP,
    YMFileBrowerTypeFile,//file
} YMFileBrowerType;

@interface YMFileBrowerModel : NSObject

@property (nonatomic,copy) NSString *displayName;
@property (nonatomic,assign) BOOL isDirectory;
@property (nonatomic,copy) NSString *fileExtension;
@property (nonatomic,strong) NSDictionary *fileAttributes;
@property (nonatomic,copy) NSURL *filePath;
@property (nonatomic,assign) YMFileBrowerType fileBrowerType;


- (instancetype)filePath:(NSURL *)url;

+ (UIImage *)typeImage:(YMFileBrowerModel *)model;

@end

NS_ASSUME_NONNULL_END
