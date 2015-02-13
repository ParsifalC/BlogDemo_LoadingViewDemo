//
//  CPLoadingView.m
//  LoadingViewDemo
//
//  Created by Parsifal on 15/2/13.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "CPLoadingView.h"
#define kViewCount 10
#define kLength 30
#define kDuration 0.6f

@interface CPLoadingView ()

@property (strong, nonatomic) NSMutableArray *viewArray;
@property (strong, nonatomic) NSMutableArray *positionArray;

@end

@implementation CPLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *colorArray = @[[UIColor colorWithRed:0.303 green:0.500 blue:0.484 alpha:1.000],[UIColor blueColor],[UIColor redColor],[UIColor purpleColor],[UIColor yellowColor],[UIColor blueColor],[UIColor blackColor],[UIColor grayColor],[UIColor orangeColor], [UIColor lightTextColor]];
        
        for (int i = 0; i < kViewCount; i++) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
            view.center = self.center;
            view.backgroundColor = colorArray[i];
            view.layer.cornerRadius = 5.0;
            view.layer.transform = CATransform3DMakeScale(0, 0, 0);
            
            [self.positionArray addObject:NSStringFromCGPoint([self calculatePositionView:view WithIndex:i])];
            [self.viewArray addObject:view];
            [self addSubview:view];
        }
    }
    return self;
}


- (void)startAnimation
{
    for (int i = 0; i < self.viewArray.count; i++) {
        UIView *view = self.viewArray[i];
        [view.layer removeAllAnimations];
        [view.layer addAnimation:[self createAnimationGroupForView:view withIndex:i] forKey:@(i).stringValue];
    }
}

#pragma mark - private method
- (NSMutableArray *)viewArray
{
    if (!_viewArray) {
        _viewArray = [NSMutableArray new];
    }
    
    return _viewArray;
}

- (NSMutableArray *)positionArray
{
    if (!_positionArray) {
        _positionArray = [NSMutableArray new];
    }
    
    return _positionArray;
}

- (CGPoint)calculatePositionView:(UIView *)view WithIndex:(NSInteger)index
{
    //计算点在圆圈中的位置
    CGFloat x = view.center.x + kLength * sin(2 * M_PI / kViewCount * index);
    CGFloat y = view.center.y + kLength * cos(2 * M_PI / kViewCount * index);
    
    return CGPointMake(x, y);
}

- (CAAnimationGroup *)createAnimationGroupForView:(UIView *)view withIndex:(NSInteger)index
{
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    //move animation
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:view.center];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointFromString(self.positionArray[index])];
    
    //scale animaiton
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    animationGroup.duration = kDuration;
    animationGroup.beginTime = CACurrentMediaTime() + index * kDuration / kViewCount;
    animationGroup.repeatCount = 10;
    animationGroup.autoreverses = YES;
    animationGroup.animations = @[moveAnimation, scaleAnimation];
    
    return animationGroup;
}

- (void)dealloc
{
    for (UIView *view in _viewArray) {
        [view removeFromSuperview];
    }
    
    [_positionArray removeAllObjects];
    [_viewArray removeAllObjects];

#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
}
@end
