//
//  DXStatusListViewModel.m
//  ASDisKitDemo
//
//  Created by simon on 16/2/28.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "DXStatusListViewModel.h"
#import "DXStatusModel.h"
#import "DXUserModel.h"
@implementation DXStatusListViewModel

- (void)loadStatusSince_id:(UInt64)since_id max_id:(UInt64)max_id complete:(void(^)(BOOL isSucess))completeBlock{
    
    [[DXNetworkTools sharedTools] loadStatusWithAccessToken:KSTATUSTOKEN since_id:0 max_id:0 finished:^(id result, NSError *error) {
        if (completeBlock) {
        if (error) {
            completeBlock(NO);
        }else{
        self.statusList =[[DXStatusModel mj_objectArrayWithKeyValuesArray:result[@"statuses"]] copy];
             completeBlock(YES);
        }
    }
 }];
    
}



@end
