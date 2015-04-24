//
//  VCalendarView.h
//  VCalendarView
//
//  Created by Vols on 15/4/20.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSCREEN_SIZE        [UIScreen mainScreen].bounds.size

@class VCalendarView;
@protocol CalendarViewDelegate <NSObject>

@optional

- (void)calendarDownList:(VCalendarView *) calendarView selectedIndex:(NSUInteger)row;

@end

@interface VCalendarView : UIView

@property (nonatomic, assign) id <CalendarViewDelegate>delegate;
@property (nonatomic, strong) NSArray *dataSource;

- (id)initWithFrame:(CGRect)frame parent:(UIViewController *)parentVC;

- (void)doShow;

- (void)doRemove;


@end
