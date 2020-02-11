//
//  PinBox.m
//  SearchPinVC
//
//  Created by ciwei luo on 2019/6/27.
//  Copyright © 2019 ciwei luo. All rights reserved.
//

#import "PinBox.h"

@interface PinBox ()




@end


@implementation PinBox

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
  
  
}



-(instancetype)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if (self) {
        self.boxType = NSBoxCustom;
        self.borderType=NSNoBorder;
       // self.fillColor=[NSColor greenColor];
        int pinBoxW = frameRect.size.width;
        NSButton *btn = [[NSButton alloc] initWithFrame:NSMakeRect(pinBoxW/4, pinBoxW/3, pinBoxW/4, pinBoxW/4)];
        btn.title=@"";
        [btn setBezelStyle:NSBezelStyleCircular];//NSBezelStyleCircular
        [btn setButtonType:NSButtonTypeOnOff];
        btn.state =0;
        [self addSubview:btn];
        self.btn=btn;
        
        CWTextLabel *label =[[CWTextLabel alloc] initWithFrame:NSMakeRect(-2, 0, pinBoxW*1.2, pinBoxW/4)];
        label.font = [NSFont systemFontOfSize:pinBoxW/5.8];
//        label.wantsLayer=YES;
//        label.layer.backgroundColor=[NSColor redColor].CGColor;
       
       //label.stringValue = @"TP_GND";
        self.label=label;

        [self addSubview:label];
    }
    return self;
}

-(void)highLight{
    self.btn.state=1;
    self.fillColor=[NSColor redColor];
    
}

-(void)setTitleStirng:(NSString *)str{
    [self.label setStringValue:str];
}

@end
