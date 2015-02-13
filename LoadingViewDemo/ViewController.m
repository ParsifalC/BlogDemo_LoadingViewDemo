//
//  ViewController.m
//  LoadingViewDemo
//
//  Created by Parsifal on 15/2/13.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "ViewController.h"
#import "CPLoadingView.h"
#define RANDOMCOLOR arc4random()% 256 / 256.0
#define kViewCount 8


@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *viewArray;
@property (strong, nonatomic) NSMutableArray *positionArray;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) CPLoadingView *loadingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapStartButton:(UIButton *)sender
{
    NSString *title = [self.startButton.titleLabel.text isEqualToString:@"start"] ? @"end" : @"start";
    [self.startButton setTitle:title forState:UIControlStateNormal];
    
    if (self.loadingView) {
        [self.loadingView removeFromSuperview];
        self.loadingView = nil;
    }
    
    self.loadingView = [[CPLoadingView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:self.loadingView];
    [self.loadingView startAnimation];
    
}


#pragma mark - private method

@end



















