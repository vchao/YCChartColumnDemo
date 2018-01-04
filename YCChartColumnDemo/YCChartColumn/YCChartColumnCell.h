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
//柱体颜色
@property (nonatomic, strong) UIColor *colorForColumn;
//柱体字体
@property (nonatomic, strong) UIFont  *fontForValueLabel;
//柱体字体颜色
@property (nonatomic, strong) UIColor *colorForValueLabel;
//X轴字体
@property (nonatomic, strong) UIFont  *fontForXLabel;
//X轴字体颜色
@property (nonatomic, strong) UIColor *colorForXLabel;

- (void)setCellContent:(NSInteger)value xLineText:(NSString *)xText perHeight:(CGFloat)perHeight xLabelHeigth:(CGFloat)xLabelHeight;

@end
