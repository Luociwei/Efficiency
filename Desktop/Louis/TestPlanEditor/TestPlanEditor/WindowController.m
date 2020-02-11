//
//  WindowController.m
//  TestPlanEditor
//
//  Created by ciwei luo on 2020/1/17.
//  Copyright © 2020 macdev. All rights reserved.
//

#import "WindowController.h"
#import "DebugVC.h"
#import "TestPlanVC.h"
#import "ShowingLogVC.h"
#import "SplitViewController.h"
NSString *kOpenCloseViewNotification = @"OpenCloseViewNotification";
@interface WindowController ()

@property(nonatomic,strong)SplitViewController *splitVC;
@property(nonatomic,strong)TestPlanVC *testPlanVC;
@end

@implementation WindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    SplitViewController *splitMainVC = [[SplitViewController alloc]init];
    
    [splitMainVC.splitView setDividerStyle:NSSplitViewDividerStylePaneSplitter];
    [splitMainVC.splitView setVertical:NO];
    
    NSSplitViewController *topVC = [[NSSplitViewController alloc]init];
    
    TestPlanVC *testPlanVC = [TestPlanVC new];
    NSSplitViewItem *item1 = [NSSplitViewItem splitViewItemWithViewController:testPlanVC];
    self.testPlanVC = testPlanVC;
    [topVC addSplitViewItem:item1];
    DebugVC *debugVC1 = [DebugVC new];
    NSSplitViewItem *item2 = [NSSplitViewItem splitViewItemWithViewController:debugVC1];
    item2.collapsed=YES;
    [topVC addSplitViewItem:item2];
    
    NSSplitViewController *botommVC = [[NSSplitViewController alloc]init];
    [botommVC.splitView setDividerStyle:NSSplitViewDividerStylePaneSplitter];
    [botommVC.splitView setVertical:YES];
    ShowingLogVC *showingLogVC = [ShowingLogVC new];
    NSSplitViewItem *item3 = [NSSplitViewItem splitViewItemWithViewController:showingLogVC];
    [botommVC addSplitViewItem:item3];
    DebugVC *debugVC = [DebugVC new];
    NSSplitViewItem *item4 = [NSSplitViewItem splitViewItemWithViewController:debugVC];
    [botommVC addSplitViewItem:item4];
    
    NSSplitViewItem *itemTop = [NSSplitViewItem splitViewItemWithViewController:topVC];
    NSSplitViewItem *itemBotomm = [NSSplitViewItem splitViewItemWithViewController:botommVC];
    
    [splitMainVC addSplitViewItem:itemTop];
    [splitMainVC addSplitViewItem:itemBotomm];
    
    self.splitVC=splitMainVC;

    self.window.contentViewController = splitMainVC;
    
    
}


- (IBAction)openCloseAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:kOpenCloseViewNotification object:nil];
}

@end
