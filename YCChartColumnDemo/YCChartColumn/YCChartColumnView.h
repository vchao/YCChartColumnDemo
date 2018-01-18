//
//  YCChartColumnView.h
//  YCChartColumnDemo
//
//  Created by 任维超 on 2017/11/15.
//  Copyright © 2017年 vchao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CCYLineNum     @"CCYLineNum"     //Y轴辅助线数值
#define CCYLineColor   @"CCYLineColor"   //Y轴辅助线及文字颜色
#define CCYLineShowNum @"CCYLineShowNum" //Y轴辅助线文字是否显示（默认不显示）

typedef void (^selectItemBlock)(NSInteger index);

@interface YCChartColumnView : UIView

//柱状数据源
@property (nonatomic, strong) NSArray *valueArr;
//X轴数据
@property (nonatomic, strong) NSArray *valueLineArr;
//Y轴辅助线数据源
@property (nonatomic, strong) NSArray *yLineDataArr;

//柱体宽度
@property (nonatomic, assign) CGFloat columnWidth;
//柱体间距
@property (nonatomic, assign) CGFloat columnSpace;
//柱体颜色
@property (nonatomic, strong) UIColor *colorForColumn;
//柱体字体
@property (nonatomic, strong) UIFont  *fontForColumnLabel;
//柱体字体颜色
@property (nonatomic, strong) UIColor *colorForColumnLabel;
//X轴线颜色
@property (nonatomic, strong) UIColor *colorForXLine;
//X轴字体
@property (nonatomic, strong) UIFont  *fontForXLabel;
//X轴字体颜色
@property (nonatomic, strong) UIColor *colorForXLabel;
//选中柱体颜色
@property (nonatomic, strong) UIColor *colorForColumnSelect;
//选中柱体X轴字体颜色
@property (nonatomic, strong) UIColor *colorForXLabelSelect;
//当前选中index
@property (nonatomic, assign) NSInteger currentIndex;

//起始点，即0坐标的左侧和底部间距
@property (nonatomic, assign) CGPoint originSize;

@property (nonatomic, assign) BOOL canSelectColum;//是否可选中，默认NO不可选中

//选中block
@property (nonatomic, copy) selectItemBlock selectItemBlock;

//显示
- (void)refreshView;

@end
