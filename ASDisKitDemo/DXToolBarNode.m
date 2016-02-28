//
//  DXToolBarNode.m
//  ASDisKitDemo
//
//  Created by simon on 16/2/28.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "DXToolBarNode.h"
#import "DXStatusViewModel.h"
@interface DXToolBarNode ()
@property (nonatomic, strong) ASButtonNode *retweetBtnNode;

@property (nonatomic, strong) ASButtonNode *commentBtnNode;

@property (nonatomic, strong) ASButtonNode *likeBtnNode;

@end
@implementation DXToolBarNode
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithR:254 G:254 B:254];
        self.retweetBtnNode = [self buttonWithTitle:@"转发" imgName:@"timeline_icon_retweet" addTarget:self action:@selector(likeBtnClick:) forControlEvents:ASControlNodeEventTouchUpInside];
        [self addSubnode:self.retweetBtnNode];
        
        self.commentBtnNode = [self buttonWithTitle:@"评论" imgName:@"timeline_icon_comment" addTarget:self action:@selector(likeBtnClick:) forControlEvents:ASControlNodeEventTouchUpInside];
        [self addSubnode:self.commentBtnNode];
        
        self.likeBtnNode = [self buttonWithTitle:@"赞" imgName:@"ASControlNodeEventTouchUpInside" addTarget:self action:@selector(likeBtnClick:) forControlEvents:ASControlNodeEventTouchUpInside];
        [self addSubnode:self.likeBtnNode];
    }
    return self;
}

- (void)likeBtnClick:(ASButtonNode *)btn {


}
- (void)setStatusViewModel:(DXStatusViewModel *)statusViewModel{
    
    _statusViewModel = statusViewModel;
    
}
- (void)layout{
    [super layout];
    CGFloat BtnW = KScreenW /3;
    CGFloat BtnH = self.frame.size.height;
    self.retweetBtnNode.frame = CGRectMake(0, 0, BtnW, BtnH);
    self.commentBtnNode.frame = CGRectMake(BtnW, 0, BtnW, BtnH);
    self.likeBtnNode.frame = CGRectMake(BtnW * 2, 0, BtnW, BtnH);


}

- (ASButtonNode *)buttonWithTitle:(NSString *)title imgName:(NSString *)imgName addTarget:(id)target action:(SEL)action forControlEvents:(ASControlNodeEvent)controlEvents{
    NSDictionary *placeholderAttrs = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:14.0f] , NSForegroundColorAttributeName: [UIColor greenColor] };
    
    ASButtonNode *btn = [[ASButtonNode alloc]init];
    
    [btn setAttributedTitle:[[NSAttributedString alloc] initWithString:title attributes:placeholderAttrs]  forState:ASButtonStateNormal];
    [btn setImage:[UIImage imageNamed:imgName] forState:ASButtonStateNormal];
    [btn addTarget:target action:action forControlEvents:controlEvents];
//    [btn setFrame:CGRectMake(20, 20, 100, 44)];
    btn.backgroundColor = [UIColor randomColor];
    btn.displaysAsynchronously = NO;
    return btn;
}

@end
