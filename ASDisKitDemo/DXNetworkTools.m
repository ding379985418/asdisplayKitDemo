//
//  DXNetworkTools.m
//  ASDisKitDemo
//
//  Created by simon on 16/2/28.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "DXNetworkTools.h"
/// 微博服务器 BASE URL
NSString *const WB_SERVER_URL = @"https://api.weibo.com/";
@protocol DXNetworkToolsProxy <NSObject>

@optional
/// AFN 内部的数据访问方法
///
/// @param method           HTTP 方法
/// @param URLString        URLString
/// @param parameters       请求参数字典
/// @param uploadProgress   上传进度
/// @param downloadProgress 下载进度
/// @param success          成功回调
/// @param failure          失败回调
///
/// @return NSURLSessionDataTask，需要 resume
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end



@interface DXNetworkTools ()<DXNetworkToolsProxy>


@end


@implementation DXNetworkTools
#pragma mark - 单例 & 构造函数
+ (instancetype)sharedTools {
    
    static DXNetworkTools *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:WB_SERVER_URL]];
    });
    
    return instance;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    
    if (self) {
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        }];
        [self.reachabilityManager startMonitoring];
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
        [(AFJSONResponseSerializer *)self.responseSerializer setRemovesKeysWithNullValues:YES];
    }
    return self;
}
#pragma mark - 封装 AFN 网络访问方法
/// 发起网络请求
///
/// @param method     GET / POST
/// @param URLString  URLString
/// @param parameters 请求参数字典
/// @param finished   完成回调
- (void)requestWithMethod:(DXRequestMethod)method URLString:(NSString *)URLString parameters:(id)parameters finished:(DXRequestCallBack)finished {
    
    if (method == POST) {
        [self POST:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            finished(responseObject, nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"网络请求错误 %@", error.localizedDescription);

            
        }];
    }else if (method == GET){
        [self GET:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            finished(responseObject, nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"网络请求错误 %@", error.localizedDescription);

        }];
        
    }

}

/// POST 上传二进制数据
///
/// @param data       二进制数据
/// @param URLString  URLString
/// @param name       服务器字段名
/// @param parameters 请求参数字典
/// @param finished   完成回调
- (void)uploadData:(NSData *)data URLString:(NSString *)URLString name:(NSString *)name parameters:(id)parameters finished:(DXRequestCallBack)finished {
    
    [self POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:@"oooxxx" mimeType:@"application/octet-stream"];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        finished(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求错误 %@", error.localizedDescription);
        
        finished(nil, error);
    }];
}
#pragma mark - 加载微博数据
/// 加载微博数据
- (void)loadStatusWithAccessToken:(NSString *)accessToken since_id:(UInt64)since_id max_id:(UInt64)max_id finished:(DXRequestCallBack)finished {
    
    NSString *urlString = @"/2/statuses/home_timeline.json";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = accessToken;
    
    // 下拉 / 上拉刷新数据
    if (since_id > 0) {
        params[@"since_id"] = @(since_id);
    } else if (max_id > 0) {
        params[@"max_id"] = @(max_id - 1);
    }
    
    [self requestWithMethod:GET URLString:urlString parameters:params finished:finished];
}
@end
