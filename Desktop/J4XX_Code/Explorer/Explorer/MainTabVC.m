//
//  MainTabVC.m
//  SearchPinVC
//
//  Created by ciwei luo on 2019/6/27.
//  Copyright © 2019 ciwei luo. All rights reserved.
//

#import "MainTabVC.h"
#import "SearchPinVC.h"

@interface MainTabVC ()

@end

@implementation MainTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame= NSMakeRect(0, 0, AppWidth, AppHeight);
    // Do view setup here.
    SearchPinVC *pinVC=[[SearchPinVC alloc]init];
    pinVC.view.wantsLayer=YES;
    pinVC.view.layer.backgroundColor=[NSColor systemGrayColor].CGColor;
    pinVC.view.frame = self.view.frame;
;
    // pinVC.title = @"pinVC";
    [self addChildViewController:pinVC];
    //self.selectedTabViewItemIndex = 0;
    
}




@end
