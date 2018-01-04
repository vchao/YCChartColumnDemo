# YCChartColumnDemo

![Image text](https://github.com/vchao/YCChartColumnDemo/blob/master/YCChartColumnDemo/YCChartColumn/DemoImg/WeChatSight44.gif)

###### 动态图表<br>效果如GIF所示<br>以下是使用示例

```c
@interface ViewController ()

@property (nonatomic, strong) YCChartColumnView *columView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.columView = [[YCChartColumnView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, 200)];
    self.columView.valueArr = @[@120, @110, @200, @180, @150, @180, @200, @100, @170, @190, @100, @110, @120];//内容
    self.columView.valueLineArr = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17"];//X轴
    self.columView.yLineDataArr = @[@{CCYLineNum : @100,
                                      CCYLineColor : [UIColor colorWithRed:211/255.f green:211/255.f blue:211/255.f alpha:1.0],
                                      CCYLineShowNum : @NO},
                                    @{CCYLineNum : @200,
                                      CCYLineColor : [UIColor lightGrayColor],
                                      CCYLineShowNum : @YES}
                                    ];//Y轴辅助线
    self.columView.originSize = CGPointMake(24, 30);//原点
    self.columView.columnSpace = 20.f;//柱体间隔
    self.columView.columnWidth = 25.f;//主体宽度
    self.columView.colorForColumn = [UIColor colorWithRed:54/255.f green:205/255.f blue:107/255.f alpha:1.0];//柱体颜色
    self.columView.colorForColumnLabel =  [UIColor colorWithRed:54/255.f green:205/255.f blue:107/255.f alpha:1.0];//柱体内容文字颜色
    self.columView.fontForColumnLabel = [UIFont systemFontOfSize:14.f];//柱体内容文字字体
    self.columView.colorForXLine = [UIColor grayColor];//X轴线颜色
    self.columView.colorForXLabel = [UIColor blackColor];//X轴文字颜色
    self.columView.fontForXLabel = [UIFont systemFontOfSize:15.f];//X轴文字字体
    self.columView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.columView];
    [self.columView showAnimation];
}
    
```
