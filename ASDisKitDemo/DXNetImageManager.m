//
//  DXNetImageManager.m
//  ASDisKitDemo
//
//  Created by simon on 16/2/27.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "DXNetImageManager.h"
#import <SDWebImageOperation.h>

@implementation DXNetImageManager
+ (instancetype)sharedImageManager{
    static DXNetImageManager *sharedImageManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedImageManager = [[DXNetImageManager alloc]init];
    });

    return sharedImageManager;
}
- (void)fetchCachedImageWithURL:(NSURL *)URL
                  callbackQueue:(dispatch_queue_t)callbackQueue
                     completion:(void (^)(CGImageRef imageFromCache))completion
{

    
   [[SDWebImageManager sharedManager] downloadImageWithURL:URL options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
       if (error) {
//           出现错误，直接返回nil
           dispatch_async(callbackQueue, ^{
               completion(nil);
           });
           
           return ;
       }
       if (cacheType != SDImageCacheTypeNone) {
//           存在缓存,拿到图片并返回
           dispatch_async(callbackQueue, ^{
               completion(image.CGImage);
           });
       }else{
//           不存在缓存，直接返回nil
       dispatch_async(callbackQueue, ^{
           completion(nil);
       });
       
       }
   }];
   

}

- (id)downloadImageWithURL:(NSURL *)URL
             callbackQueue:(dispatch_queue_t)callbackQueue
     downloadProgressBlock:(void (^)(CGFloat progress))downloadProgressBlock
                completion:(void (^)(CGImageRef image, NSError *error))completion
{
  id operation =  [[SDWebImageManager sharedManager] downloadImageWithURL:URL options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//      图片下载过程的回调
         dispatch_async(callbackQueue, ^{
        downloadProgressBlock((CGFloat)(receivedSize / expectedSize));
             });
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        if (cacheType == SDImageCacheTypeNone) {
//            当图片是从网络上获取时，才回调
            dispatch_async(callbackQueue, ^{
                completion(image.CGImage,error);
            });
//        }
    }];
     
    return operation;
}

- (void)cancelImageDownloadForIdentifier:(id)downloadIdentifier{
 
    id <SDWebImageOperation> oper =  (id <SDWebImageOperation> )downloadIdentifier;
    [oper cancel];
    
    
}
@end
