//
//  ViewController.m
//  VCalendarView
//
//  Created by Vols on 15/4/20.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "ViewController.h"

#import "VCalendarView.h"

@interface ViewController ()  <CalendarViewDelegate>

@property (nonatomic, strong) VCalendarView * calendarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _calendarView = [[VCalendarView alloc] initWithFrame: CGRectMake(0, 150, kSCREEN_SIZE.width, 0) parent:self];
    _calendarView.delegate = self;
    _calendarView.dataSource = @[@"af3f"];
    
    [self.view addSubview:_calendarView];
}

- (IBAction)click:(id)sender {
    if (_calendarView.frame.size.height > 0) {
        [_calendarView doRemove];
    }else{
        [_calendarView doShow];
    }
}

- (void)calendarDownList:(VCalendarView *)dropDownList selectedIndex:(NSUInteger)row{
    
    NSLog(@"%d", row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
