//
//  YCChartColumnCell.m
//  YCChartColumnDemo
//
//  Created by 任维超 on 2017/11/15.
//  Copyright © 2017年 vchao. All rights reserved.
//

#import "YCChartColumnCell.h"

@interface YCChartColumnCell()

@end

@implementation YCChartColumnCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    [self setupUI];
    return self;
}

- (void)setupUI
{
    if (!self.columnView) {
        self.columnView = [[UIView alloc] initWithFrame:CGRectMake(30, 10, 100, 30)];
        self.columnView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.columnView];
    }
    if (!self.valueLabel) {
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.valueLabel.textColor = [UIColor grayColor];
        self.valueLabel.font = [UIFont systemFontOfSize:14.f];
        self.valueLabel.textAlignment = NSTextAlignmentCenter;
        self.valueLabel.text = @"";
        [self.contentView addSubview:self.valueLabel];
        self.valueLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    if (!self.xLineNumLabel) {
        self.xLineNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        self.xLineNumLabel.center = CGPointMake(self.center.x, 16);
        self.xLineNumLabel.backgroundColor = [UIColor clearColor];
        self.xLineNumLabel.layer.masksToBounds = YES;
        self.xLineNumLabel.layer.cornerRadius = 16.f;
        self.xLineNumLabel.font = [UIFont systemFontOfSize:15.f];
        self.xLineNumLabel.textAlignment = NSTextAlignmentCenter;
        self.xLineNumLabel.textColor = [UIColor blackColor];
        self.xLineNumLabel.text = @"0";
        [self.contentView addSubview:self.xLineNumLabel];
        self.xLineNumLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
}

- (void)setCellContent:(NSInteger)value xLineText:(NSString *)xText perHeight:(CGFloat)perHeight xLabelHeigth:(CGFloat)xLabelHeight
{
    self.columnView.frame = CGRectMake(xLabelHeight, _columnSpace/2.f, 0, _columnWidth);
    
    self.valueLabel.frame = CGRectMake(CGRectGetMaxX(self.columnView.frame), 0, 18, _columnSpace + _columnWidth);
    self.valueLabel.text = [NSString stringWithFormat:@"%ld", value];
    
    self.xLineNumLabel.text = xText;
//    self.xLineNumBtn.frame = CGRectMake(0, 0, xLabelHeight, _columnSpace + _columnWidth);
    self.xLineNumLabel.center = CGPointMake(16, (_columnSpace + _columnWidth)/2.f);
    
    if (value) {
        CGFloat cHeight = perHeight*value;
        [UIView animateWithDuration:1.5 animations:^{
            self.columnView.frame = CGRectMake(xLabelHeight, _columnSpace/2.f, cHeight, _columnWidth);
            self.valueLabel.frame = CGRectMake(CGRectGetMaxX(self.columnView.frame), 0, 18, _columnSpace + _columnWidth);
        }];
    }else{
        self.valueLabel.text = @"";
    }
    
}

@end
