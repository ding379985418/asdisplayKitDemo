//
//  DXStatusViewModel.h
//  ASDisKitDemo
//
//  Created by simon on 16/2/28.
//  Copyright © 2016年 simon. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DXStatusModel;
@interface DXStatusViewModel : NSObject
@property (nonatomic, strong) DXStatusModel *statusModel;
//headNode 控件的布局
@property (nonatomic, assign) CGRect iconImgFrame;
@property (nonatomic, assign) CGRect nameLabelFrame;
@property (nonatomic, assign) CGRect brankImgFrame;
@property (nonatomic, assign) CGRect timeLabelFrame;
@property (nonatomic, assign) CGRect soureLabelFrame;
@property (nonatomic, assign) CGFloat headNodeHeight;
@property (nonatomic, assign) CGRect headNodeFrame;

//原创微博 控件的布局
@property (nonatomic, assign) CGRect originalTextFrame;
@property (nonatomic, assign) CGFloat originalNodeHeight;
@property (nonatomic, assign) CGRect originalNodeFrame;

//配图视图的布局
@property (nonatomic, assign) CGRect pictureNodeFrame;
//@property (nonatomic, assign) CGFloat pictureNodeHeight;

//转发内容
@property (nonatomic, assign) CGRect retweetNodeFrame;
//@property (nonatomic, assign) CGFloat retweetNodeHeight;


//toolbar 布局
@property (nonatomic, assign) CGRect toolBarFrame;

//cell 的高度
@property (nonatomic, assign) CGFloat cellHeight;
///初始化viewModel
+ (instancetype)statusViewModelWith:(DXStatusModel *)statusModel;

@end
