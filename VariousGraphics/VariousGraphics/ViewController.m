//
//  ViewController.m
//  VariousGraphics
//
//  Created by Vols on 2015/4/11.
//  Copyright © 2015年 vols. All rights reserved.
//

#import "ViewController.h"
#import "VCloseView.h"
#import "Masonry.h"
#import "VariousChart.h"

@interface ViewController ()

@property (nonatomic, strong) UIView        * showView;
@property (nonatomic, strong) VariousChart  * theChart;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.showView];
    [_showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(300, 200));
    }];
    [self.view layoutIfNeeded];
    
    [self createButtons];
}

- (void)createButtons {
    
    for (int i = 0; i < 10; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(40 + 90*(i%3), 260 + 50*(i/3), 80, 30);
        button.backgroundColor = [UIColor purpleColor];
        [button setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        button.titleLabel.textColor = [UIColor greenColor];
        button.layer.cornerRadius = 5.0;
        [button setTitleColor:[UIColor brownColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        [self.view addSubview:button];
    }
}


- (void)clickAction:(UIButton *)button {
    [self.showView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    NSArray *keys = @[@"a", @"b", @"c"];
    NSArray *values = @[@"10", @"50", @"39"];

    if (button.tag -100 == 0) {
        [self.showView addSubview:self.theChart];
        [_theChart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_showView);
        }];
        [self.theChart drawBarChart:keys values:values];

    }
    else if (button.tag - 100 == 1) {
        [self.showView addSubview:self.theChart];
        [_theChart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_showView);
        }];
        [self.theChart drawLineChart:keys values:values];
    }
    else if (button.tag - 100 == 2) {
        [self.showView addSubview:self.theChart];
        _theChart.backgroundColor = [UIColor orangeColor];
        [_theChart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_showView);
        }];
        [self.theChart drawPieChart:keys values:values];
        
    }
    else if (button.tag - 100 == 3) {
        [self closeTVEffect];
    }
}

- (void)closeTVEffect {
    UIView * blackView = [[UIView alloc]initWithFrame:self.showView.bounds];
    blackView.backgroundColor = [UIColor blackColor];
    
    UIView *whiteView = [[UIView alloc]initWithFrame:self.showView.bounds];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.showView addSubview:blackView];
    
    VCloseView *closeView = [[VCloseView alloc]initWithFrame:self.showView.bounds];
    [blackView addSubview:whiteView];
    
    [UIView animateWithDuration:0.5 animations:^{
        whiteView.transform = CGAffineTransformMakeScale(1, 0.005);
    } completion:^(BOOL finished){
        //黑屏2s
        [blackView addSubview:closeView];
        
        [UIView animateWithDuration:0.31 animations:^{
            whiteView.transform = CGAffineTransformMakeScale(0, 0);
            closeView.transform = CGAffineTransformMakeScale(1, 0.0000001);
            [UIView animateWithDuration:10 animations:^{
            }];
            //退出
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [whiteView removeFromSuperview];
            });
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Properties
- (UIView *)showView {
    if (_showView == nil) {
        _showView = [UIView new];
        _showView.backgroundColor = [UIColor purpleColor];
    }
    return _showView;
}

- (VariousChart *)theChart {
    if (_theChart == nil) {
        _theChart = [[VariousChart alloc] init];
    }
    return _theChart;
}

@end
