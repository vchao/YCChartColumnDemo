//
//  YCChartColumnView.m
//  YCChartColumnDemo
//
//  Created by 任维超 on 2017/11/15.
//  Copyright © 2017年 vchao. All rights reserved.
//

#import "YCChartColumnView.h"
#import "YCChartColumnCell.h"

@interface YCChartColumnView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView      *yLineView;//Y轴辅助线背景view
@property (nonatomic, strong) UIView      *xLineView;//X轴
@property (nonatomic, strong) UITableView *columnTableView;
//峰值(valueArr及yLineDataArr最大值)
@property (nonatomic, assign) CGFloat maxHeight;
//单位高度
@property (nonatomic,assign) CGFloat perHeight;

@end

@implementation YCChartColumnView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _columnWidth = 30.f;
        _columnSpace = 20.f;
        _colorForColumn = [UIColor greenColor];
        _colorForColumnLabel = [UIColor lightGrayColor];
        _fontForColumnLabel = [UIFont systemFontOfSize:14.f];
        _colorForXLine = [UIColor grayColor];
        _colorForXLabel = [UIColor blackColor];
        _fontForXLabel = [UIFont systemFontOfSize:15.f];
        _originSize = CGPointMake(0, 30.f);
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    if (!self.yLineView) {
        self.yLineView = [[UIView alloc] initWithFrame:self.bounds];
        self.yLineView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.yLineView];
    }
    if (!self.xLineView) {
        self.xLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - _originSize.y, self.bounds.size.width, 0.5)];
        self.xLineView.backgroundColor = _colorForXLine;
        [self addSubview:self.xLineView];
    }
    if (!self.columnTableView) {
        self.columnTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _originSize.x, self.bounds.size.height, self.bounds.size.width - _originSize.x*2)];
        self.columnTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.columnTableView.scrollsToTop = NO;
        self.columnTableView.estimatedSectionHeaderHeight = 0;
        self.columnTableView.estimatedSectionFooterHeight = 0;
        self.columnTableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        self.columnTableView.showsVerticalScrollIndicator = NO;
        self.columnTableView.bounces = NO;
        self.columnTableView.delegate = self;
        self.columnTableView.dataSource = self;
        self.columnTableView.backgroundColor = [UIColor clearColor];
        [self.columnTableView registerClass:[YCChartColumnCell class] forCellReuseIdentifier:@"columnCell"];
        self.columnTableView.frame = CGRectMake(_originSize.x, 0, self.bounds.size.width - _originSize.x*2, self.bounds.size.height);
        [self addSubview:self.columnTableView];
    }
}

- (void)setOriginSize:(CGPoint)originSize
{
    _originSize = originSize;
    self.columnTableView.frame = CGRectMake(_originSize.x, 0, self.bounds.size.width-_originSize.x*2, self.bounds.size.height);
}

- (void)setValueArr:(NSArray *)valueArr
{
    _valueArr = valueArr;
    
    for (id number in _valueArr) {
        if ([number floatValue] > _maxHeight) {
            _maxHeight = [number floatValue];
        }
    }
    for (id data in _yLineDataArr) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            CGFloat dataNum = [[data valueForKey:@"num"] floatValue];
            if (dataNum > _maxHeight) {
                _maxHeight = dataNum;
            }
        }else if ([data floatValue] > _maxHeight) {
            _maxHeight = [data floatValue];
        }
    }
    
    _perHeight = (CGRectGetHeight(self.frame) - _originSize.y - 30)/_maxHeight;
}

- (void)setYLineDataArr:(NSArray *)yLineDataArr
{
    _yLineDataArr = yLineDataArr;
    for (id number in _valueArr) {
        if ([number floatValue] > _maxHeight) {
            _maxHeight = [number floatValue];
        }
    }
    for (id data in _yLineDataArr) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            CGFloat dataNum = [[data valueForKey:@"num"] floatValue];
            if (dataNum > _maxHeight) {
                _maxHeight = dataNum;
            }
        }else if ([data floatValue] > _maxHeight) {
            _maxHeight = [data floatValue];
        }
    }
    
    _perHeight = (CGRectGetHeight(self.frame) - _originSize.y - 30)/_maxHeight;
}

- (void)setColorForXLine:(UIColor *)colorForXLine
{
    _colorForXLine = colorForXLine;
    _xLineView.backgroundColor = colorForXLine;
}

- (void)showAnimation
{
    for (UIView *view in self.yLineView.subviews) {
        [view removeFromSuperview];
    }
    for (id data in _yLineDataArr) {
        CGFloat dataNum = 0.f;
        UIColor *lineColor = [UIColor lightGrayColor];
        BOOL showNum = NO;
        if ([data isKindOfClass:[NSDictionary class]]) {
            dataNum = [[data valueForKey:CCYLineNum] floatValue];
            lineColor = [data valueForKey:CCYLineColor];
            showNum = [[data valueForKey:CCYLineShowNum] boolValue];
        }else{
            dataNum = [data floatValue];
        }
        CGFloat y = self.bounds.size.height - (dataNum*_perHeight + _originSize.y);
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, y, self.bounds.size.width, 0.5)];
        line.backgroundColor = lineColor;
        [self.yLineView addSubview:line];
        
        if (showNum) {
            UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, y - 14, 50, 14)];
            numLabel.font = [UIFont systemFontOfSize:10.f];
            numLabel.textColor = lineColor;
            numLabel.text = [NSString stringWithFormat:@"%.0f", dataNum];
            [self.yLineView addSubview:numLabel];
        }
    }
    [self.columnTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _valueLineArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.columnSpace+self.columnWidth;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YCChartColumnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"columnCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    cell.columnWidth = _columnWidth;
    cell.columnSpace = _columnSpace;
    cell.colorForColumn = _colorForColumn;
    cell.colorForValueLabel = _colorForColumnLabel;
    cell.fontForValueLabel = _fontForColumnLabel;
    cell.fontForXLabel = _fontForXLabel;
    cell.colorForXLabel = _colorForXLabel;
    if (indexPath.row < self.valueArr.count && indexPath.row < self.valueLineArr.count) {
        [cell setCellContent:[[self.valueArr objectAtIndex:indexPath.row] integerValue] xLineText:[self.valueLineArr objectAtIndex:indexPath.row] perHeight:_perHeight xLabelHeigth:_originSize.y];
    }else if (indexPath.row < self.valueLineArr.count) {
        [cell setCellContent:0 xLineText:[self.valueLineArr objectAtIndex:indexPath.row] perHeight:_perHeight  xLabelHeigth:_originSize.y];
    }
    
    return cell;
}

@end
