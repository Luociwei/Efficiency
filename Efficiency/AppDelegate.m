//
//  AppDelegate.m
//  MiniLineChart
//
//  Created by ciwei luo on 2019/7/10.
//  Copyright © 2019 ciwei luo. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    ViewController *vc = [ViewController new];
    self.window.contentViewController = vc;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(windowWillClose:)
                                                 name:NSWindowWillCloseNotification
                                               object:nil];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}
- (void)windowWillClose:(NSNotification *)notification {
    
    [NSApp terminate:nil];
}

@end
