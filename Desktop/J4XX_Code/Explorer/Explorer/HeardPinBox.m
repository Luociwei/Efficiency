//
//  HeardPinBox.m
//  SearchPinTool
//
//  Created by ciwei luo on 2019/6/29.
//  Copyright © 2019 macdev. All rights reserved.
//

#import "HeardPinBox.h"

@interface HeardPinBox()
@property(nonatomic,strong)NSMutableArray *headPinsArr;
@property(nonatomic,strong)NSButton *showingBtn;
@end


@implementation HeardPinBox

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}
-(instancetype)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if (self) {
        self.boxType = NSBoxPrimary;
        self.borderType=NSLineBorder;
        int gap = margin/6.5;
        int count =32;
        int boxW = frameRect.size.width-margin/3;
        int boxH = frameRect.size.height-14;
        int headPinW =((boxW-gap*(count-1))/count);
        int headPinH =headPinW;
        
        
        for (int i =0; i<count; i++) {//for (int i =0; i<count; i++) {
            int x = i*(headPinW+gap);
            for (int j=1; j>=0; j--) {
                //int y = j*boxH/2;
                int y = j*boxH/2;
                if (j==0) {
                    y=margin/1.5;
                }
                NSButton *headPin = [[NSButton alloc] initWithFrame:NSMakeRect(x, y, headPinW, headPinH)];
                headPin.title=@"";
                [headPin setBezelStyle:NSBezelStyleCircular];
                [headPin setButtonType:NSButtonTypeOnOff];
                headPin.state =0;
//                if (i==0&&j==1) {
//                    headPin.state =0;
//                    headPin.wantsLayer=YES;
//                    headPin.layer.backgroundColor=[NSColor redColor].CGColor;
//                }
                [self addSubview:headPin];
                [self.headPinsArr addObject:headPin];
            }
        }
        
        for (int k =0; k<5; k++) {
            int x = k*boxW/4.35;
            
            CWTextLabel *label = [[CWTextLabel alloc] initWithFrame:NSMakeRect(x, 0, boxW/14.7, boxH/5)];
            label.font = [NSFont systemFontOfSize:6];
            int num=k?k*8:1;
            label.stringValue=[NSString stringWithFormat:@"%d",num];
            [self addSubview:label];
        }
        
    }
    return self;
}

-(void)resetShowingPin{
    self.showingBtn.wantsLayer=YES;
    self.showingBtn.state=0;
    self.showingBtn.layer.backgroundColor=[NSColor clearColor].CGColor;
}

-(void)highLightWithPinPosition:(int)pinPosition{
    
    self.showingBtn=[self.headPinsArr objectAtIndex:pinPosition-1];
    self.showingBtn.state=1;
    self.showingBtn.layer.backgroundColor=[NSColor redColor].CGColor;
    
}


- (NSMutableArray*)headPinsArr
{
    if(!_headPinsArr){
        _headPinsArr=[NSMutableArray array];
    }
    return _headPinsArr;
}

-(void)setNetName:(NSString *)netName{
    _netName=netName;
    self.title=netName;
}
@end