//
//  DXStatusModel.h
//  ASDisKitDemo
//
//  Created by simon on 16/2/28.
//  Copyright © 2016年 simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXUserModel.h"

@interface DXStatusModel : NSObject
/// 微博ID - 注意不能使用 NSUInteger，否则在 32 位架构设备上，id 会被截断
@property (nonatomic, assign) UInt64 id;
/// 微博信息内容
@property (nonatomic, copy) NSString *text;
/// 创建日期字符串
@property (nonatomic, copy) NSString *created_at;
/// 创建日期
@property (nonatomic, strong) NSDate *createdDate;
/// 微博来源
@property (nonatomic, copy) NSString *source;
/// 转发数
@property (nonatomic, assign) NSInteger reposts_count;
/// 评论数
@property (nonatomic, assign) NSInteger comments_count;
/// 表态数
@property (nonatomic, assign) NSInteger attitudes_count;

/// 微博作者的用户信息字段
@property (nonatomic, strong) DXUserModel *user;
/// 被转发的原微博信息字段，当该微博为转发微博时返回
@property (nonatomic, strong) DXStatusModel *retweeted_status;
/// 微博配图数组
@property (nonatomic, strong) NSArray *pic_urls;
@end
