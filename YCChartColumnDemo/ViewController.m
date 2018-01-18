//
//  ViewController.m
//  YCChartColumnDemo
//
//  Created by 任维超 on 2017/11/15.
//  Copyright © 2017年 vchao. All rights reserved.
//

#import "ViewController.h"
#import "YCChartColumnView.h"

@interface ViewController ()

@property (nonatomic, strong) YCChartColumnView *columView;

@end

static NSString *MyCellID = @"thisIsMyCellId";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.columView = [[YCChartColumnView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, 200)];
    self.columView.valueLineArr = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17"];//X轴
    self.columView.yLineDataArr = @[@{CCYLineNum : @200,
                                      CCYLineColor : [UIColor colorWithRed:255/255.f green:105/255.f blue:105/255.f alpha:1.0],
                                      CCYLineShowNum : @NO}
                                    ];//Y轴辅助线
    self.columView.originSize = CGPointMake(0, 40);//原点
    self.columView.columnSpace = 15.f;//柱体间隔
    self.columView.columnWidth = 40.f;//主体宽度
    self.columView.colorForColumn = [UIColor colorWithRed:255/255.f green:198/255.f blue:198/255.f alpha:1.0];//柱体颜色
    self.columView.colorForColumnLabel =  [UIColor colorWithRed:150/255.f green:150/255.f blue:150/255.f alpha:1.0];//柱体内容文字颜色
    self.columView.fontForColumnLabel = [UIFont systemFontOfSize:13.f];//柱体内容文字字体
    self.columView.colorForXLine = [UIColor grayColor];//X轴线颜色
    self.columView.colorForXLabel = [UIColor colorWithRed:100/255.f green:100/255.f blue:100/255.f alpha:1.0];//X轴文字颜色
    self.columView.fontForXLabel = [UIFont systemFontOfSize:15.f];//X轴文字字体
    self.columView.colorForColumnSelect = [UIColor redColor];//选中柱体、文字及X轴文字背景颜色
    self.columView.colorForXLabelSelect = [UIColor whiteColor];//选中X轴字体颜色
    self.columView.backgroundColor = [UIColor clearColor];
    self.columView.canSelectColum = YES;//可以选中
    [self.view addSubview:self.columView];
    self.columView.selectItemBlock = ^(NSInteger index) {
        NSLog(@"select item index:%ld", (long)index);
    };
    [self.columView refreshView];
    
    [self performSelector:@selector(setContentValue) withObject:nil afterDelay:3.0];
    
}

- (void)setContentValue{
    self.columView.valueArr = @[@120, @110, @200, @180, @150, @180, @200, @100, @170, @190, @100, @110, @120];//内容
    self.columView.currentIndex = 4;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
