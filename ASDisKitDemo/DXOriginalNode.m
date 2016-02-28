//
//  DXOriginalNode.m
//  ASDisKitDemo
//
//  Created by simon on 16/2/28.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "DXOriginalNode.h"
#import "DXStatusViewModel.h"
#import "DXStatusModel.h"
@interface DXOriginalNode ()
@property (nonatomic, strong) ASTextNode *textNode;

@end

@implementation DXOriginalNode

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.backgroundColor = [UIColor blueColor];
        [self addSubnode:self.textNode];
    }
    return self;
}
#pragma mark -模型数据设置
- (void)setStatusViewModel:(DXStatusViewModel *)statusViewModel{

    _statusViewModel = statusViewModel;
    self.textNode.attributedString = [NSAttributedString string:statusViewModel.statusModel.text fontSzie:KDefaultFontSize];
}
#pragma mark -子控件布局
- (void)layout{
    [super layout];
    self.textNode.frame = self.statusViewModel.originalTextFrame;
}
#pragma mark -懒加载
- (ASTextNode *)textNode{

    if (!_textNode) {
        _textNode = [[ASTextNode alloc]init];
    }
    return _textNode;
}

@end
