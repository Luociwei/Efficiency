//
//  AppDelegate.m
//  SearchPinTool
//
//  Created by ciwei luo on 2019/6/27.
//  Copyright © 2019 ciwei luo. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabVC.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property(nonatomic,strong)MainTabVC *tabViewController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.window.contentViewController = self.tabViewController;
    [self.window center];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(windowWillClose:)
                                                 name:NSWindowWillCloseNotification
                                               object:nil];
    
   
}
- (void)windowWillClose:(NSNotification *)notification {

    [NSApp terminate:nil];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application

}



- (MainTabVC*)tabViewController
{
    if(!_tabViewController){
        _tabViewController =[[MainTabVC alloc]init];
        _tabViewController.tabStyle = NSTabViewControllerTabStyleUnspecified;
    }
    return _tabViewController;
}
@end
