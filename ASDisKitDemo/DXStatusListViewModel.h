//
//  DXStatusListViewModel.h
//  ASDisKitDemo
//
//  Created by simon on 16/2/28.
//  Copyright © 2016年 simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXNetworkTools.h"
#import "MJExtension.h"
@interface DXStatusListViewModel : NSObject

//首页数据数组
@property (nonatomic, strong) NSArray *statusList;

///下载首页数据，并转换为模型
- (void)loadStatusSince_id:(UInt64)since_id max_id:(UInt64)max_id complete:(void(^)(BOOL isSucess))completeBlock;


@end
