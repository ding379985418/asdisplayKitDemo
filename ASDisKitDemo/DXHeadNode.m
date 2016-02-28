//
//  DXHeadNode.m
//  ASDisKitDemo
//
//  Created by simon on 16/2/28.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "DXHeadNode.h"
#import "DXStatusModel.h"
#import "DXUserModel.h"
#define KIconW 50
#define KBrankW 20
@interface DXHeadNode ()
//头像
@property (nonatomic, strong)  DXNetImageNode*iconImageNode;
//名称
@property (nonatomic, strong) ASTextNode *nameTextNode;
//发布时间
@property (nonatomic, strong) ASTextNode *timeTextNode;
//来源
@property (nonatomic, strong) ASTextNode *soureTextNode;
//会员图标
@property (nonatomic, strong) ASImageNode *brankImageNode;
//认证图标
@property (nonatomic, strong) ASImageNode *verifiedImageNode;
@end


@implementation DXHeadNode


- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        [self addSubnode:self.iconImageNode];
        [self addSubnode:self.nameTextNode];
        [self addSubnode:self.timeTextNode];
        [self addSubnode:self.soureTextNode];
        [self addSubnode:self.brankImageNode];
        [self addSubnode:self.verifiedImageNode];
    }
    return self;
}
#pragma mark -模型赋值
- (void)setStatusViewModel:(DXStatusViewModel *)statusViewModel
{
    _statusViewModel = statusViewModel;
    DXStatusModel *statusModel = statusViewModel.statusModel;
    DXUserModel *userModel =statusModel.user;
    self.iconImageNode.URL = [NSURL URLWithString:userModel.profile_image_url];
    self.nameTextNode.attributedString = [NSAttributedString string:userModel.screen_name fontSzie:KDefaultTitleFontSize];
    self.timeTextNode.attributedString = [NSAttributedString string:@"刚刚" fontSzie:KDefaultSubTitleFontSize];
    self.soureTextNode.attributedString = [NSAttributedString string:@"来自iPhone6s" fontSzie:KDefaultSubTitleFontSize];
    self.brankImageNode.image = [UIImage imageNamed:@"common_icon_membership_level1"];
    
}

#pragma mark -子控件布局
- (void)layout{
    [super layout];
    self.iconImageNode.frame = self.statusViewModel.iconImgFrame;
    self.nameTextNode.frame = self.statusViewModel.nameLabelFrame;
    self.brankImageNode.frame = self.statusViewModel.brankImgFrame;
    self.timeTextNode.frame = self.statusViewModel.timeLabelFrame;
    self.soureTextNode.frame = self.statusViewModel.soureLabelFrame;
}
#pragma mark -懒加载
- (DXNetImageNode *)iconImageNode{
    if (!_iconImageNode) {
        _iconImageNode = [DXNetImageNode imageNodeWithPlaceholder:@"avatar_default"];
    }
    return _iconImageNode;
}
- (ASTextNode *)nameTextNode{
    if (!_nameTextNode) {
        _nameTextNode = [[ASTextNode alloc]init];
    }
    return _nameTextNode;
}

- (ASTextNode *)timeTextNode{
    if (!_timeTextNode) {
        _timeTextNode = [[ASTextNode alloc]init];
    }
    return _timeTextNode;
}

- (ASTextNode *)soureTextNode{
    if (!_soureTextNode) {
        _soureTextNode = [[ASTextNode alloc]init];
    }
    return _soureTextNode;
}

- (ASImageNode *)brankImageNode{
    if (!_brankImageNode) {
        _brankImageNode = [[ASImageNode alloc]init];
    }
    return _brankImageNode;
}

- (ASImageNode *)verifiedImageNode{
    if (!_verifiedImageNode) {
        _verifiedImageNode = [[ASImageNode alloc]init];
    }

    return _verifiedImageNode;
}
@end
