//
//  VCloseView.m
//  VariousGraphics
//
//  Created by Vols on 15/8/13.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "VCloseView.h"

@implementation VCloseView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    float offset = 1.5;
    float my = rect.size.height/2.0;
    float mx = rect.size.width/2.0;
    
    UIBezierPath* aPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 0, 0)];
    
    [aPath moveToPoint:CGPointMake(0, my)];
    [aPath addLineToPoint:CGPointMake(mx, my-offset)];
    [aPath addLineToPoint:CGPointMake(2*mx, my)];
    [aPath addLineToPoint:CGPointMake(mx, my+offset)];
    [aPath closePath];
    
    // Set the render colors
    [[UIColor blackColor] setStroke];
    [[UIColor whiteColor] setFill];
    [aPath fill];
}




@end
