//
//  CWTextLable.m
//  SearchPinTool
//
//  Created by ciwei luo on 2019/6/30.
//  Copyright © 2019 macdev. All rights reserved.
//

#import "CWTextLabel.h"

@interface CWTextLabel ()

@property (assign)CWTextLabelType myType;

@end

@implementation CWTextLabel


//+(instancetype)textLabelWithType:(NSInteger)type{
//    CWTextLabel *lable = [[CWTextLabel alloc] init];
//    self.myType = type;
//    return lable;
//}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    
    // Drawing code here.
}



-(instancetype)initWithFrame:(NSRect)frameRect{
    
    if (self = [super initWithFrame:frameRect]) {
        self.bordered = YES;
        self.drawsBackground = YES;
        self.stringValue=@"";
        self.alignment=NSTextAlignmentLeft;
        self.backgroundColor = [NSColor gridColor];
        self.font = [NSFont systemFontOfSize:10];
        //self.layer.backgroundColor=[NSColor gridColor];
        self.editable = NO;
    }
    return self;

}
@end
