//
//  DXNetImageManager.h
//  ASDisKitDemo
//
//  Created by simon on 16/2/27.
//  Copyright © 2016年 simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AsyncDisplayKit.h>
#import <SDWebImageManager.h>
@interface DXNetImageManager : NSObject<ASImageCacheProtocol,ASImageDownloaderProtocol>

+ (instancetype)sharedImageManager;

@end
