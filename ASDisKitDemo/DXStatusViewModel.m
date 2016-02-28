//
//  DXStatusViewModel.m
//  ASDisKitDemo
//
//  Created by simon on 16/2/28.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "DXStatusViewModel.h"
#import "DXStatusModel.h"
#import "DXUserModel.h"
#define KIconW 35
#define KBrankW 10
#define KToolBarH 30
/// 每列图片数量
#define kPicViewColCount 3
/// 图片间距
#define kPicViewItemMargin 5
@interface DXStatusViewModel ()


@end
@implementation DXStatusViewModel

+ (instancetype)statusViewModelWith:(DXStatusModel *)statusModel{
    
    DXStatusViewModel *viewModel = [[DXStatusViewModel alloc]init];
    viewModel.statusModel = statusModel;
    return viewModel;
}

- (void)setStatusModel:(DXStatusModel *)statusModel{
    _statusModel = statusModel;
    DXUserModel *userModel = statusModel.user;
    //    iconFrame
    CGFloat iconX = KDefaultMargin;
    CGFloat iconW = KIconW;
    CGFloat iconH = KIconW;
    CGFloat iconY = KDefaultMargin;
    self.iconImgFrame = CGRectMake(iconX, iconY, iconW, iconH);
    //    nameFrame
    CGFloat nameX = CGRectGetMaxX(self.iconImgFrame) + KDefaultMargin;
    CGFloat nameY = iconY;
    CGSize nameMaxSize = CGSizeMake(KScreenW - iconW - KBrankW - 4 *KDefaultMargin, CGFLOAT_MAX);
    CGSize nameSize = [userModel.screen_name stringSizeWithFontSzie:KDefaultTitleFontSize maxSize:nameMaxSize];
    
    self.nameLabelFrame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    //    brankFrame
    CGFloat brankX = CGRectGetMaxX(self.nameLabelFrame) + KDefaultMargin;
    CGFloat brankW = KBrankW;
    CGFloat brankH = KBrankW;
      CGFloat brankY = CGRectGetMidY(self.nameLabelFrame) - brankH ;
    self.brankImgFrame = CGRectMake(brankX, brankY, brankW, brankH);
    
    //    timeFrame
    CGFloat timeX = nameX;
    CGSize timeSize = [@"刚刚" stringSizeWithFontSzie:KDefaultSubTitleFontSize maxSize:nameMaxSize];
    CGFloat timeY = CGRectGetMaxY(self.iconImgFrame) - timeSize.height;
    self.timeLabelFrame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    //    soureFrame
    CGFloat soureX = CGRectGetMaxX(self.timeLabelFrame) + KDefaultMargin;
    CGFloat soureY = timeY;
    CGSize soureMaxSize = CGSizeMake(KScreenW - iconW - timeSize.width - 4 * KDefaultMargin, CGFLOAT_MAX);
    CGSize soureSize = [@"来自iPhone6s" stringSizeWithFontSzie:KDefaultSubTitleFontSize maxSize:soureMaxSize];
    self.soureLabelFrame = CGRectMake(soureX, soureY, soureSize.width, soureSize.height);
    self.headNodeHeight = CGRectGetMaxY(self.iconImgFrame) + KDefaultMargin;
    self.headNodeFrame = CGRectMake(0, 0, KScreenW, self.headNodeHeight);
    
    
//    原创内容frame
    CGFloat originalX = KDefaultMargin;
    CGFloat originalY = 0;
    CGSize textMaxSize = CGSizeMake(KScreenW - 2 * KDefaultMargin, CGFLOAT_MAX);
    CGSize originalSize = [statusModel.text stringSizeWithFontSzie:KDefaultFontSize maxSize:textMaxSize];
    self.originalTextFrame = CGRectMake(originalX, originalY, originalSize.width, originalSize.height);
    self.originalNodeHeight = CGRectGetMaxY(self.originalTextFrame);
    self.originalNodeFrame = CGRectMake(0, CGRectGetMaxY(self.headNodeFrame), KScreenW,  self.originalNodeHeight);
//    配图视图
    CGFloat pictureX = KDefaultMargin;
      CGSize pictureSize = CGSizeZero;
//    CGFloat pictureX = KDefaultMargin;
    CGFloat pictureY = CGRectGetMaxY(self.originalNodeFrame);
    
//    转发内容视图
    CGFloat retweetX = KDefaultMargin;
    CGFloat retweetY =  CGRectGetMaxY(self.originalNodeFrame);
    CGSize retweetSize = [statusModel.retweeted_status.text stringSizeWithFontSzie:KDefaultFontSize maxSize:textMaxSize];
    
//    toolBar视图
    CGFloat toolBarX = 0;
    CGFloat toolBarY = CGRectGetMaxY(self.originalNodeFrame);
    CGFloat toolBarW = KScreenW;
    
    if (self.statusModel.pic_urls.count >0 ) {
        pictureSize = [self calcViewSize:self.statusModel.pic_urls.count];
        pictureY = CGRectGetMaxY(self.originalNodeFrame) + KDefaultMargin;
        retweetY = pictureY + pictureSize.height + KDefaultMargin;
        toolBarY = retweetY + retweetSize.height;

    }else if (self.statusModel.retweeted_status.pic_urls.count > 0){
        pictureSize = [self calcViewSize:self.statusModel.retweeted_status.pic_urls.count];
        retweetY = CGRectGetMaxY(self.originalNodeFrame) + KDefaultMargin;
        pictureY = retweetY + retweetSize.height + KDefaultMargin;
        toolBarY = pictureY + pictureSize.height;
    
    }else if (self.statusModel.pic_urls.count==0 &&self.statusModel.retweeted_status.pic_urls.count == 0){
        retweetY = CGRectGetMaxY(self.originalNodeFrame) + KDefaultMargin;
        toolBarY = retweetY + retweetSize.height;
    }
    
    self.pictureNodeFrame = CGRectMake(pictureX, pictureY, pictureSize.width, pictureSize.height);
    self.retweetNodeFrame = CGRectMake(retweetX, retweetY, retweetSize.width, retweetSize.height);
    self.toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, KToolBarH);
    
    self.cellHeight = CGRectGetMaxY(self.toolBarFrame) + KDefaultMargin;
    
    
}

- (CGSize)calcViewSize:(NSInteger)count {
    
    // 1. 配图数量
//    NSInteger count = _urls.count;
    
    // 如果没有图片，直接返回
    if (count == 0) {
        return CGSizeZero;
    }
    
    // 2. 基本数据计算
    // 单个 cell 的宽高
    CGFloat itemWH = (KScreenW - (kPicViewColCount - 1) * (kPicViewItemMargin + KDefaultMargin)) / kPicViewColCount;
    
    // 设置布局 item 大小
//    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
//    layout.itemSize = CGSizeMake(itemWH, itemWH);
    
    // 列数
    NSInteger col = count == 4 ? 2 : (count >= kPicViewColCount ? kPicViewColCount : count);
    // 行数
    NSInteger row = (count - 1) / kPicViewColCount + 1;
    
    // 3. 计算宽高
    CGFloat width = ceil(col * itemWH + (col - 1) * kPicViewItemMargin);
    CGFloat height = ceil(row * itemWH + (row - 1) * kPicViewItemMargin);
    
    return CGSizeMake(width, height);
}
@end
