//
//  YMFileBrowerModel.m
//  FileBrower_OC_Demo
//
//  Created by zhiming9 on 2020/1/15.
//  Copyright © 2020 zhiming9. All rights reserved.
//

#import "YMFileBrowerModel.h"

@implementation YMFileBrowerModel

//@property (nonatomic,copy) NSString *displayName;
//@property (nonatomic,assign) BOOL isDirectory;
//@property (nonatomic,copy) NSString *fileExtension;
//@property (nonatomic,strong) NSDictionary *fileAttributes;
//@property (nonatomic,copy) NSURL *filePath;
//@property (nonatomic,assign) YMFileBrowerType fileBrowerType;

- (instancetype)filePath:(NSURL *)url
{
    self.filePath = url;
    self.isDirectory = [self checkDirectory:url];
    self.displayName = url.lastPathComponent;
    if (self.isDirectory) {
        self.fileExtension = nil;
        self.fileAttributes = nil;
        self.fileBrowerType = YMFileBrowerTypeDirectory;
    }else{
        self.fileAttributes = [self getFileAttributes:url];
        self.fileExtension = url.pathExtension;
        if (self.fileExtension) {
            if ([self.fileExtension isEqualToString:@"gif"]) {
                self.fileBrowerType = YMFileBrowerTypeGif;
            }else if ([self.fileExtension isEqualToString:@"gif"]) {
                self.fileBrowerType = YMFileBrowerTypeGif;
            }else if ([self.fileExtension isEqualToString:@"jpg"]) {
                self.fileBrowerType = YMFileBrowerTypeJPG;
            }else if ([self.fileExtension isEqualToString:@"json"]) {
                self.fileBrowerType = YMFileBrowerTypeJSON;
            }else if ([self.fileExtension isEqualToString:@"pdf"]) {
                self.fileBrowerType = YMFileBrowerTypePDF;
            }else if ([self.fileExtension isEqualToString:@"png"]) {
                self.fileBrowerType = YMFileBrowerTypePNG;
            }else if ([self.fileExtension isEqualToString:@"zip"]) {
                self.fileBrowerType = YMFileBrowerTypeZIP;
            }else{
                self.fileBrowerType = YMFileBrowerTypeFile;
            }
        }else{
            self.fileBrowerType = YMFileBrowerTypeFile;
        }
    }
    return self;
}

// 是否是目录
- (BOOL)checkDirectory:(NSURL *)url{
    NSNumber *isDirectory;
    [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:nil];
    return isDirectory.boolValue;
}

- (NSDictionary *)getFileAttributes:(NSURL *)url{
   return [[NSFileManager defaultManager]attributesOfItemAtPath:url.path error:nil];
}

+ (UIImage *)typeImage:(YMFileBrowerModel *)model
{
    NSString *name;
    if (model.fileBrowerType == YMFileBrowerTypeDirectory) {
        name = @"YM_folder.png";
    }else if(model.fileBrowerType == YMFileBrowerTypePDF) {
        name = @"YM_pdf.png";
    }else if(model.fileBrowerType == YMFileBrowerTypeZIP) {
        name = @"YM_zip.png";
    }else if(model.fileBrowerType == YMFileBrowerTypeFile) {
        name = @"YM_file.png";
    }else{
        name = @"YM_image.png";
    }
    return [UIImage imageNamed:name];
    
}

@end
