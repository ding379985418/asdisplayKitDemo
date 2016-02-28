//
//  DXToolBarNode.h
//  ASDisKitDemo
//
//  Created by simon on 16/2/28.
//  Copyright © 2016年 simon. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
@class DXStatusViewModel;
@interface DXToolBarNode : ASDisplayNode
@property (nonatomic, strong) DXStatusViewModel *statusViewModel;
@end
