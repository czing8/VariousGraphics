//
//  VCalendarView.m
//  VCalendarView
//
//  Created by Vols on 15/4/20.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "VCalendarView.h"



@interface VCalendarView() <UITableViewDelegate, UITableViewDataSource>{
    CGRect originalRect;
    float selfFrameY;
}

@property (nonatomic, strong) UIView * bgView;

@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) UIViewController * parentVC;


@end


@implementation VCalendarView


- (id)initWithFrame:(CGRect)frame parent:(UIViewController *)parentVC{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.parentVC = parentVC;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgView];

        [self addSubview:self.contentView];
        
        [self.contentView addSubview:self.tableView];

    }
    return self;
}


- (void)doShow{
    
    CGRect frame = self.frame;
    frame.size.height = kSCREEN_SIZE.height;
    self.frame = frame;

    
    [UIView animateWithDuration:0.3 animations:^{
        
        _bgView.hidden = NO;
        
        self.contentView.frame = CGRectMake(0, 0, kSCREEN_SIZE.width, _dataSource.count < 4? _dataSource.count*45:225);
        
        self.tableView.frame = self.contentView.bounds;

    } completion:^(BOOL finished) {
        
    }];
}

- (void)doRemove{
    
    _bgView.hidden = YES;

    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame = CGRectMake(0, 0, kSCREEN_SIZE.width, 0);
        self.tableView.frame = CGRectMake(0, 0, kSCREEN_SIZE.width, 0);
        
    } completion:^(BOOL finished) {
        self.frame = CGRectMake(0, self.frame.origin.y, kSCREEN_SIZE.width, 0);
    }];
}


#pragma mark - properties

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_SIZE.width, kSCREEN_SIZE.height)];
        _bgView.alpha = 0.5;
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.hidden = YES;
        _bgView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapm=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doRemove)];
        [_bgView addGestureRecognizer:tapm];
    }
    return _bgView;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_SIZE.width, 0)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}


- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor orangeColor];
        _tableView.userInteractionEnabled = YES;
    }
    return _tableView;
}


-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    
    originalRect = CGRectMake(0, self.frame.origin.y, kSCREEN_SIZE.width, _dataSource.count < 4? _dataSource.count*45+45:225);
    
    if (_dataSource) {
        [_tableView  reloadData];
    }
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    else{
        for (id obj in  [cell.contentView subviews]) {
            if ([obj isKindOfClass:[UILabel class]]||[obj isKindOfClass:[UIImageView class]]) {
                [obj removeFromSuperview];
            }
        }
    }

        if (_dataSource.count > 0) {
            
            UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(20, 7, 280, 30)];
            label.backgroundColor=[UIColor clearColor];
            label.text=[NSString stringWithFormat:@" %@", _dataSource[indexPath.row]];
            //            label.textColor=kRGB(110, 110, 110);
            label.font=[UIFont systemFontOfSize:16.0];
            [cell.contentView addSubview:label];
        }

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor =[UIColor clearColor];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate calendarDownList:self selectedIndex:indexPath.row];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
