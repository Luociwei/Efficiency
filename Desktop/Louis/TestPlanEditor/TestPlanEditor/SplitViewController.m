//
//  SplitViewController.m
//  TestPlanEditor
//
//  Created by ciwei luo on 2020/1/17.
//  Copyright © 2020 macdev. All rights reserved.
//

#import "SplitViewController.h"

extern NSString *kOpenCloseViewNotification;

@interface SplitViewController ()
@property(nonatomic,assign)BOOL isLeftCollapsed;
@end

@implementation SplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collapsedBottomView) name:kOpenCloseViewNotification object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserverForName:kOpenCloseViewNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//       // [self collapsedBottomView1];
//    }];
    self.view.frame= NSMakeRect(0, 0, 1200, 1000);
    
    [self collapsedBottomView1];
   // [self.view setAutoresizesSubviews:YES];
}


- (void)collapsedBottomView1 {
   
    NSView *top = self.splitView.subviews[0];
    NSView *bottom = self.splitView.subviews[1];
    //隐藏左边视图
    // leftView.hidden = YES;
    NSRect frame = top.frame;
    frame.size = self.splitView.frame.size;
    //右边视图frame 占据整个 splitview 的大小
    top.frame = frame;
    
    NSRect frame2 = bottom.frame;
    frame2.size = CGSizeMake(0, 80);
    //右边视图frame 占据整个 splitview 的大小
    bottom.frame = frame2;
    //重新刷新显示
    [self.splitView display];
}

- (void)collapsedBottomView {
    NSView *top = self.splitView.subviews[0];
    NSView *bottom = self.splitView.subviews[1];
    //隐藏左边视图
   // leftView.hidden = YES;
    NSRect frame = top.frame;
    frame.size = self.splitView.frame.size;
    //右边视图frame 占据整个 splitview 的大小
    top.frame = frame;
    
    NSRect frame2 = bottom.frame;
    frame2.size = CGSizeMake(0, 0);
    //右边视图frame 占据整个 splitview 的大小
    bottom.frame = frame2;
    //重新刷新显示
    [self.splitView display];
}

@end
