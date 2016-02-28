//
//  DXHeadNode.h
//  ASDisKitDemo
//
//  Created by simon on 16/2/28.
//  Copyright © 2016年 simon. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "DXStatusViewModel.h"

@interface DXHeadNode : ASDisplayNode
@property (nonatomic, strong) DXStatusViewModel *statusViewModel;
@end
