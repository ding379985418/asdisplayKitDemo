//
//  DXPicturesNode.m
//  ASDisKitDemo
//
//  Created by simon on 16/2/28.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "DXPicturesNode.h"
#import "DXStatusViewModel.h"
@interface DXPicturesNode ()


@end
@implementation DXPicturesNode
#pragma mark -模型数据设置

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}
- (void)setStatusViewModel:(DXStatusViewModel *)statusViewModel{
    
    _statusViewModel = statusViewModel;
    
}
@end
