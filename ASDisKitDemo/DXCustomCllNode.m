//
//  DXCustomCllNode.m
//  ASDisKitDemo
//
//  Created by simon on 16/2/27.
//  Copyright © 2016年 simon. All rights reserved.
//
#define KimgeNodeW 50
#define KMargin 5
#import "DXCustomCllNode.h"
#import "DXNetImageNode.h"
#import "DXStatusModel.h"
#import "DXStatusViewModel.h"
#import "DXHeadNode.h"
#import "DXOriginalNode.h"
#import "DXPicturesNode.h"
#import "DXRetweetNode.h"
#import "DXToolBarNode.h"

@interface DXCustomCllNode ()
@property (nonatomic, strong) DXStatusViewModel *statusViewModel;
// 头像视图
@property (nonatomic, strong) DXHeadNode *headNode;

//原创微博视图
@property (nonatomic, strong) DXOriginalNode *originalNode;

//配图视图
@property (nonatomic, strong) DXPicturesNode *pictureNode;

//转发视图
@property (nonatomic, strong) DXRetweetNode *retweetNode;

//toolBar视图
@property (nonatomic, strong) DXToolBarNode *toolBarNode;

@end

@implementation DXCustomCllNode

- (id)init{
    if (self = [super init]) {
//        添加headNode
        [self addSubnode:self.headNode];
        [self addSubnode:self.originalNode];
        [self addSubnode:self.pictureNode];
        [self addSubnode:self.retweetNode];
        [self addSubnode:self.toolBarNode];
        
    }

    return self;
}

#pragma mark -数据模型赋值
- (void)setStatusModel:(DXStatusModel *)statusModel{
    _statusModel = statusModel;
//    初始化statusViewModel
    self.statusViewModel = [DXStatusViewModel statusViewModelWith:statusModel];

    self.headNode.statusViewModel = self.statusViewModel;
    self.originalNode.statusViewModel = self.statusViewModel;
    self.pictureNode.statusViewModel = self.statusViewModel;
    self.retweetNode.statusViewModel = self.statusViewModel;

}
#pragma mark -返回cell的高度
- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize{

//    return CGSizeMake([UIScreen mainScreen].bounds.size.width, self.statusViewModel.headNodeHeight + self.statusViewModel.originalNodeHeight+ self.statusViewModel.pictureNodeFrame.size.height + self.statusViewModel.retweetNodeFrame.size.height + KDefaultMargin) ;
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width,self.statusViewModel.cellHeight);
 
}
#pragma mark -布局子控件
- (void)layout{
    [super layout];
   
    self.headNode.frame = self.statusViewModel.headNodeFrame;
//    CGFloat originalY = CGRectGetMaxY(self.headNode.frame);
    self.originalNode.frame = self.statusViewModel.originalNodeFrame;//CGRectMake(0,originalY, KScreenW, self.statusViewModel.originalNodeHeight);
    self.pictureNode.frame = self.statusViewModel.pictureNodeFrame;
    self.retweetNode.frame = self.statusViewModel.retweetNodeFrame;
    self.toolBarNode.frame = self.statusViewModel.toolBarFrame;

}

#pragma mark -懒加载
- (DXHeadNode *)headNode{
    if (!_headNode) {
        _headNode = [[DXHeadNode alloc]init];
    }
    return _headNode;
}

- (DXOriginalNode *)originalNode{
    if (!_originalNode) {
        _originalNode = [[DXOriginalNode alloc]init];
    }
    return  _originalNode;
}


- (DXPicturesNode *)pictureNode{
    if (!_pictureNode) {
        _pictureNode = [[DXPicturesNode alloc]init];
        
    }
    return _pictureNode;
}
- (DXRetweetNode *)retweetNode {
    if (!_retweetNode) {
        _retweetNode = [[DXRetweetNode alloc]init];
    }

    return _retweetNode;
}

- (DXToolBarNode *)toolBarNode{
    if (!_toolBarNode) {
        _toolBarNode = [[DXToolBarNode alloc]init];
    }
    
    return _toolBarNode;
}
@end
