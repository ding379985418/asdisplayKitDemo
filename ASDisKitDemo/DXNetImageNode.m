//
//  DXNetImageNode.m
//  ASDisKitDemo
//
//  Created by simon on 16/2/27.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "DXNetImageNode.h"
#import "DXNetImageManager.h"

@implementation DXNetImageNode

+ (instancetype)imageNodeWithPlaceholder:(NSString *)imgName
{
    DXNetImageNode *imgNode = [[DXNetImageNode alloc]initWithCache:[DXNetImageManager sharedImageManager] downloader:[DXNetImageManager sharedImageManager]];
    if (imgName) {
        
        imgNode.defaultImage = [UIImage imageNamed:imgName];
    }
    return imgNode;
}
@end


