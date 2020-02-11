//
//  CWTextLable.m
//  SearchPinTool
//
//  Created by ciwei luo on 2019/6/30.
//  Copyright © 2019 macdev. All rights reserved.
//

#import "CWTextLabel.h"

@implementation CWTextLabel

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    
    // Drawing code here.
}
-(instancetype)initWithFrame:(NSRect)frameRect{
    
    if (self = [super initWithFrame:frameRect]) {
        self.bordered = NO;
        self.drawsBackground = NO;
        self.alignment=NSTextAlignmentLeft;
        
        self.textColor=[NSColor greenColor];
        self.editable = NO;
    }
    return self;
    
}
@end
