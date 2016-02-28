//
//  DXNetworkTools.h
//  ASDisKitDemo
//
//  Created by simon on 16/2/28.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface DXNetworkTools : AFHTTPSessionManager
typedef enum : NSUInteger {
    GET,
    POST,
} DXRequestMethod;

/// 网络请求回调类型
///
/// @param result 返回结果
/// @param error  错误信息
typedef void (^DXRequestCallBack)(id result, NSError *error);

+ (instancetype)sharedTools;

/// 加载微博数据
///
/// @param accessToken accessToken
/// @param since_id    since_id 若指定此参数，则返回ID比since_id大的微博
/// @param max_id      max_id 若指定此参数，则返回ID小于或等于max_id的微博
/// @param finished    完成回调
- (void)loadStatusWithAccessToken:(NSString *)accessToken since_id:(UInt64)since_id max_id:(UInt64)max_id finished:(DXRequestCallBack)finished;
@end
