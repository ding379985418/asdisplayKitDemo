//
//  DXRetweetNode.m
//  ASDisKitDemo
//
//  Created by simon on 16/2/28.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "DXRetweetNode.h"
#import "DXStatusViewModel.h"
#import "DXStatusModel.h"
@interface DXRetweetNode ()

@property (nonatomic, strong) ASTextNode *textNode;
@end

@implementation DXRetweetNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self addSubnode:self.textNode];
    }
    return self;
}
- (void)setStatusViewModel:(DXStatusViewModel *)statusViewModel{
    
    _statusViewModel = statusViewModel;
    if (statusViewModel.statusModel.retweeted_status.text) {
        self.textNode.attributedString = [NSAttributedString string:statusViewModel.statusModel.retweeted_status.text fontSzie:KDefaultFontSize];
    }
   
    
}
#pragma mark -子控件布局
- (void)layout{
    [super layout];
    self.textNode.frame = self.bounds;
}
#pragma mark -懒加载
- (ASTextNode *)textNode{
    
    if (!_textNode) {
        _textNode = [[ASTextNode alloc]init];
    }
    return _textNode;
}

@end
