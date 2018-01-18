//
//  YCChartColumnCell.h
//  YCChartColumnDemo
//
//  Created by 任维超 on 2017/11/15.
//  Copyright © 2017年 vchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCChartColumnCell : UITableViewCell

//柱体宽度
@property (nonatomic, assign) CGFloat columnWidth;
//柱体间距
@property (nonatomic, assign) CGFloat columnSpace;

//柱体
@property (nonatomic, strong) UIView  *columnView;
//柱体文字
@property (nonatomic, strong) UILabel *valueLabel;
//X轴数字
@property (nonatomic, strong) UILabel *xLineNumLabel;

- (void)setCellContent:(NSInteger)value xLineText:(NSString *)xText perHeight:(CGFloat)perHeight xLabelHeigth:(CGFloat)xLabelHeight;

@end
