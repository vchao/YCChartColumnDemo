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
@property (nonatomic, strong) UIView      *topLineView;//顶部边框
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
        _columnWidth = 40.f;
        _columnSpace = 15.f;
        _colorForColumn = [UIColor greenColor];
        _colorForColumnSelect = [UIColor greenColor];
        _colorForColumnLabel = [UIColor lightGrayColor];
        _fontForColumnLabel = [UIFont systemFontOfSize:14.f];
        _colorForXLine = [UIColor grayColor];
        _colorForXLabel = [UIColor blackColor];
        _colorForXLabelSelect = [UIColor whiteColor];
        _fontForXLabel = [UIFont systemFontOfSize:15.f];
        _originSize = CGPointMake(0, 40.f);
        _currentIndex = -1;
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
    if (!self.topLineView) {
        self.topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 0.5)];
        self.topLineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.topLineView];
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
            CGFloat dataNum = [[data valueForKey:CCYLineNum] floatValue];
            if (dataNum > _maxHeight) {
                _maxHeight = dataNum;
            }
        }else if ([data floatValue] > _maxHeight) {
            _maxHeight = [data floatValue];
        }
    }
    
    _perHeight = (CGRectGetHeight(self.frame) - _originSize.y - 30)/_maxHeight;
    
    [self refreshView];
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
            CGFloat dataNum = [[data valueForKey:CCYLineNum] floatValue];
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

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if (currentIndex < self.valueArr.count) {
        _currentIndex = currentIndex;
    }
}

- (void)refreshView
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
    
    [self performSelector:@selector(scrollToSelectCell) withObject:nil afterDelay:0.1];
}

- (void)scrollToSelectCell{
    if (_currentIndex < self.valueArr.count) {
        [UIView animateWithDuration:1.5 animations:^{
            NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:_currentIndex inSection:0];
            [self.columnTableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _valueLineArr.count>_valueArr.count?_valueLineArr.count:_valueArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.columnSpace+self.columnWidth;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.columnSpace/2.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return self.columnSpace/2.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.userInteractionEnabled = NO;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.userInteractionEnabled = NO;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YCChartColumnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"columnCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    cell.columnWidth = _columnWidth;
    cell.columnSpace = _columnSpace;
    
    cell.valueLabel.font = _fontForColumnLabel;
    cell.xLineNumLabel.font = _fontForXLabel;
    if (indexPath.row < self.valueArr.count && indexPath.row < self.valueLineArr.count) {
        [cell setCellContent:[[self.valueArr objectAtIndex:indexPath.row] integerValue] xLineText:[self.valueLineArr objectAtIndex:indexPath.row] perHeight:_perHeight xLabelHeigth:_originSize.y];
    }else if (indexPath.row < self.valueLineArr.count) {
        [cell setCellContent:0 xLineText:[self.valueLineArr objectAtIndex:indexPath.row] perHeight:_perHeight  xLabelHeigth:_originSize.y];
    }else if (indexPath.row < self.valueArr.count) {
        [cell setCellContent:[[self.valueArr objectAtIndex:indexPath.row] integerValue] xLineText:@"" perHeight:_perHeight xLabelHeigth:_originSize.y];
    }
    if (_currentIndex == indexPath.row && _canSelectColum) {
        cell.columnView.backgroundColor = _colorForColumnSelect;
        cell.valueLabel.textColor = _colorForColumnSelect;
        cell.xLineNumLabel.textColor = _colorForXLabelSelect;
        cell.xLineNumLabel.backgroundColor = _colorForColumnSelect;
    }else{
        cell.columnView.backgroundColor = _colorForColumn;
        cell.valueLabel.textColor = _colorForColumnLabel;
        cell.xLineNumLabel.textColor = _colorForXLabel;
        cell.xLineNumLabel.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row < self.valueArr.count && indexPath.row != _currentIndex && _canSelectColum) {
        NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:_currentIndex inSection:0];
        YCChartColumnCell *unSelectCell = [tableView cellForRowAtIndexPath:indexPath1];
        YCChartColumnCell *selectCell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (unSelectCell) {
            unSelectCell.columnView.backgroundColor = _colorForColumn;
            unSelectCell.valueLabel.textColor = _colorForColumnLabel;
            unSelectCell.xLineNumLabel.textColor = _colorForXLabel;
            unSelectCell.xLineNumLabel.backgroundColor = [UIColor clearColor];
        }
        
        if (selectCell) {
            selectCell.columnView.backgroundColor = _colorForColumnSelect;
            selectCell.valueLabel.textColor = _colorForColumnSelect;
            selectCell.xLineNumLabel.textColor = _colorForXLabelSelect;
            selectCell.xLineNumLabel.backgroundColor = _colorForColumnSelect;
            
            NSArray *visibleCells = tableView.visibleCells;
            if ([visibleCells lastObject] == selectCell) {
                //如果当前点击的cell没有完全展示出来，则滚动tableview到显示位置
                [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }else if ([visibleCells firstObject] == selectCell) {
                [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        }
        
        _currentIndex = indexPath.row;
        if (self.selectItemBlock) {
            self.selectItemBlock(_currentIndex);
        }
    }
}

@end
