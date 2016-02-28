//
//  NSAttributedString+Category.m
//  ASDisKitDemo
//
//  Created by simon on 16/2/28.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "NSAttributedString+Category.h"

@implementation NSAttributedString (Category)
+ (instancetype)string:(NSString *)string fontSzie:(CGFloat )fontSize{
    NSDictionary *attriDict = @{NSFontAttributeName :[UIFont systemFontOfSize:fontSize ]};
                         
    NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:string attributes:attriDict];

    return attStr;
}
@end
