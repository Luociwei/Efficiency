//
//  LineView.m
//  MiniLineChart
//
//  Created by ciwei luo on 2019/7/10.
//  Copyright © 2019 ciwei luo. All rights reserved.
//

#import "LineView.h"
#import "Efficiency.h"
#import "CWTextLabel.h"

static float const kOrigin = 70;
static float const myGap = 30;
static float myCurrentSegment=120;
static float zoom=20;
static float const lineWidth=2;


//NSRect myFrame;

@interface LineView ()
@property(strong,nonatomic)Efficiency *eff;
@property(strong,nonatomic)NSBezierPath *path_5v;
@property(strong,nonatomic)NSBezierPath *path_12v;
@property(strong,nonatomic)NSBezierPath *path_9v;
@property(strong,nonatomic)NSBezierPath *path_15v;

@property(nonatomic,strong)NSMutableArray *bScaleArray;
@property(nonatomic,strong)NSMutableArray *sScaleArray;
@property(nonatomic,strong)NSMutableArray *scaleNameArray;
@property(nonatomic,strong)NSMutableArray *xScaleArray;
@property(nonatomic,strong)NSMutableArray *xScaleNameArray;
@property(nonatomic,strong)CWTextLabel *xLine;
@property(nonatomic,strong)CWTextLabel *yLine;

@property(nonatomic,strong)NSMutableArray *btnArray;
@property(nonatomic,strong)NSMutableArray *labelArray;
@end

@implementation LineView{
    BOOL _isDraw;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    //    if (!_isDraw) {
    //        return;
    //    }
    
    [self showLine];
    _isDraw = YES;
    //    NSInteger gap =dirtyRect.size.height/15;
    //    myGap = gap;
    //    CGFloat h = dirtyRect.size.height-gap;
    //    CGFloat w = dirtyRect.size.width-gap;
    //
    //    NSBezierPath *path = [NSBezierPath bezierPath];
    //    [path setLineWidth:2];
    //    [[NSColor grayColor] set];
    //    NSPoint origin = NSMakePoint(gap, gap);
    //    NSPoint pointY = NSMakePoint(gap, h);
    //    NSPoint pointX = NSMakePoint(w, gap);
    //    [path moveToPoint:pointY];
    //    [path lineToPoint:origin];
    //    [path lineToPoint:pointX];
    //
    //
    //    [path moveToPoint:NSMakePoint(pointY.x-5, pointY.y-5)];
    //    [path lineToPoint:pointY];
    //    [path lineToPoint:NSMakePoint(pointY.x+5, pointY.y-5)];
    //
    //
    //    [path moveToPoint:NSMakePoint(pointX.x-5, pointX.y+5)];
    //    [path lineToPoint:pointX];
    //    [path lineToPoint:NSMakePoint(pointX.x-5, pointX.y-5)];
    //
    //    float currentSegment = w/5;
    //    myCurrentSegment = currentSegment;
    //    for (int i = 0; i<5; i++) {
    //        [path moveToPoint:NSMakePoint(currentSegment*(i+1)+gap, 5+gap)];
    //        [path lineToPoint:NSMakePoint(currentSegment*(i+1)+gap, gap-5)];
    //    }
    //
    //    [path stroke];
    
    
    //    [path lineToPoint:origin];
    //    [path lineToPoint:pointX];
    
}

-(void)layout{
    [super layout];
    
    NSRect myFrame = self.bounds;
    CGFloat yH = myFrame.size.height-2*myGap;
    CGFloat xW = myFrame.size.width-2*myGap;
    zoom = yH/30;
    myCurrentSegment =4*myGap;
    // Drawing code here.
    if (self.yLine != nil) {
        self.yLine.frame=NSMakeRect(myGap,myGap,3, yH);
        
    }else{
        CWTextLabel *yLine =[[CWTextLabel alloc]initWithFrame:NSMakeRect(myGap,myGap,3, yH)];
        [self addSubview:yLine];
        self.yLine = yLine;
    }
    
    if (self.xLine != nil) {
        self.xLine.frame =NSMakeRect(myGap,myGap,xW, 3);
        
    }else{
        CWTextLabel *xLine =[[CWTextLabel alloc]initWithFrame:NSMakeRect(myGap,myGap,xW, 3)];
        [self addSubview:xLine];
        self.xLine = xLine;
    }
    
    NSMutableArray *mutArr4 = [NSMutableArray array];
    NSMutableArray *mutArr5 = [NSMutableArray array];
    for (int k = 0; k<4; k++) {
        if (!self.xScaleArray.count) {
            CWTextLabel *xScale =[[CWTextLabel alloc]initWithFrame:NSMakeRect(myGap+(k+1)*myCurrentSegment,myGap,3, 10)];
            [self addSubview:xScale];
            [mutArr4 addObject:xScale];
        }else{
            CWTextLabel *xScale =self.xScaleArray[k];
            xScale.frame =NSMakeRect(myGap+(k+1)*myCurrentSegment,myGap,3, 10);
        }
        
        //        if (!self.xScaleNameArray.count) {
        //            CWTextLabel *xScaleName =[[CWTextLabel alloc]initWithFrame:NSMakeRect(myGap+(k+1)*myCurrentSegment,myGap,100, 20)];
        //            xScaleName.bordered=NO;
        //            xScaleName.drawsBackground=NO;
        //            NSInteger num = k? 1000*k : 500;
        //            xScaleName.stringValue = [NSString stringWithFormat:@"%ldmA",(long)num];
        //            xScaleName.backgroundColor =[NSColor clearColor];
        //            [self addSubview:xScaleName];
        //            [mutArr5 addObject:xScaleName];
        //        }else{
        //            CWTextLabel *xScale =self.xScaleNameArray[k];
        //            xScale.frame =NSMakeRect(myGap+(k+1)*myCurrentSegment,myGap,35, 20);
        //        }
        
    }
    
    self.xScaleArray = mutArr4;
    self.xScaleNameArray = mutArr5;
    
    int count =6;
    int bScaleGap = yH/count;
    int sScaleCount=4;
    int sScaleGap =bScaleGap/(sScaleCount+1);
    NSMutableArray *mutArray1 = [NSMutableArray array];
    NSMutableArray *mutArray2 = [NSMutableArray array];
    NSMutableArray *mutArray3 = [NSMutableArray array];
    
    for (int i =0; i<count; i++) {
        if (!self.bScaleArray.count) {
            CWTextLabel *bScale =[[CWTextLabel alloc]initWithFrame:NSMakeRect(myGap, bScaleGap*(i+1)+myGap, 15, 3)];
            [self addSubview:bScale];
            [mutArray1 addObject:bScale];
        }else{
            CWTextLabel *bScale = self.bScaleArray[i];
            bScale.frame =NSMakeRect(myGap, bScaleGap*(i+1)+myGap, 15, 3);
        }
        
        //        if (!self.scaleNameArray.count) {
        //            CWTextLabel *scaleName =[[CWTextLabel alloc]initWithFrame:NSMakeRect(1, bScaleGap*(i+1)+myGap*0.8,40,16)];
        //            scaleName.bordered=NO;
        //            scaleName.drawsBackground = NO;
        //            NSInteger num = 70+(i+1)*5;
        //            scaleName.stringValue = [NSString stringWithFormat:@"%ld%%",(long)num];
        //            scaleName.backgroundColor =[NSColor clearColor];
        //
        //            //        scaleName.font = [NSFont systemFontOfSize:10];
        //            [self addSubview:scaleName];
        //            [mutArray2 addObject:scaleName];
        //        }else{
        //            CWTextLabel *scaleName = self.scaleNameArray[i];
        //            scaleName.frame= NSMakeRect(myGap*0.3, bScaleGap*(i+1)+myGap*0.8,25,16);
        //        }
        
        
        
        //        if (i==0||i==1||i==5) {
        //            continue;
        //        }
        NSLog(@"111");
        for (int j =0; j<sScaleCount; j++) {
            if (!self.sScaleArray.count) {
                CWTextLabel *sScale =[[CWTextLabel alloc]initWithFrame:NSMakeRect(myGap, bScaleGap*i+sScaleGap*(j+1)+myGap, 10, 3)];
                [self addSubview:sScale];
                [mutArray3 addObject:sScale];
            }else{
                CWTextLabel *sScale = self.sScaleArray[i*sScaleCount+j];
                sScale.frame= NSMakeRect(myGap, bScaleGap*i+sScaleGap*(j+1)+myGap, 10, 3);
            }
        }
        
    }
    
    self.bScaleArray = mutArray1;
    self.scaleNameArray = mutArray2;
    self.sScaleArray = mutArray3;
    
    //  [self setNeedsDisplay:YES];
}


-(instancetype)initWithCoder:(NSCoder *)decoder{
    if (self = [super initWithCoder:decoder]) {
        self.wantsLayer = YES;
        self.layer.backgroundColor = [[NSColor whiteColor] CGColor];
    }
    return self;
}


-(void)showLine{
    
    if (self.datas.count) {
        
        [self cleanTextLabel];
        [self draw_5V];
        [self draw_9V];
        [self draw_12V];
        [self draw_15V];
        
    }
    
}

-(void)draw_15V{
    // if (self.datas.count>=15) {
    if (self.datas.count>=12) {
        self.eff.vaule_1000mA_15V = self.datas[11];
        [self.path_15v moveToPoint:NSMakePoint(myGap+2*myCurrentSegment,([_eff.vaule_1000mA_15V floatValue]-70)*zoom+20)];
        CWTextLabel *label14 = self.labelArray[12];
        [label14 setFrame:NSMakeRect(myGap*0.5+2*myCurrentSegment,([_eff.vaule_1000mA_15V floatValue]-70)*zoom+5, myGap*1.5, 10)];
        label14.stringValue=_eff.vaule_1000mA_15V;
    }
    if (self.datas.count>=13) {
        self.eff.vaule_500mA_15V = self.datas[12];
        [self.path_15v lineToPoint:NSMakePoint(myGap+myCurrentSegment,([_eff.vaule_500mA_15V floatValue]-70)*zoom+20)];//([eff.vaule_2000mA_5V floatValue]-70)*20)
        CWTextLabel *label13 = self.labelArray[13];
        [label13 setFrame:NSMakeRect(myCurrentSegment-15,([_eff.vaule_500mA_15V floatValue]-70)*zoom+15, myGap*1.5, 10)];
        label13.stringValue=_eff.vaule_500mA_15V;
        
        
    }
    
    if (self.datas.count>=14) {
        self.eff.vaule_2000mA_15V = self.datas[13];
        [self.path_15v moveToPoint:NSMakePoint(myGap+2*myCurrentSegment,([_eff.vaule_1000mA_15V floatValue]-70)*zoom+20)];
        [self.path_15v lineToPoint:NSMakePoint(myGap+3*myCurrentSegment,([_eff.vaule_2000mA_15V floatValue]-70)*zoom+20)];
        CWTextLabel *label15 = self.labelArray[14];
        [label15 setFrame:NSMakeRect(myGap*0.5+3*myCurrentSegment+5,([_eff.vaule_2000mA_15V floatValue]-70)*zoom+5, myGap*1.5, 10)];
        label15.stringValue=_eff.vaule_2000mA_15V;
    }
    
    
    
    
    if (self.datas.count>=15) {
        self.eff.vaule_3000mA_15V = self.datas[14];
        [self.path_15v lineToPoint:NSMakePoint(myGap+4*myCurrentSegment,([_eff.vaule_3000mA_15V floatValue]-kOrigin)*zoom+20)];
        CWTextLabel *label16 = self.labelArray[15];
        [label16 setFrame:NSMakeRect(myGap+4*myCurrentSegment,([_eff.vaule_3000mA_15V floatValue]-kOrigin)*zoom+5, myGap*1.5, 10)];
        label16.stringValue=_eff.vaule_3000mA_15V;
    }
    
    
    
    
    
    [self.path_15v stroke];
    self.path_15v = nil;
    //}
}

-(void)draw_12V{
    //  if (self.datas.count>=11) {
    if (self.datas.count>=9) {
        
        
        self.eff.vaule_1000mA_12V = self.datas[8];
        [self.path_12v moveToPoint:NSMakePoint(myGap+2*myCurrentSegment,([_eff.vaule_1000mA_12V floatValue]-kOrigin)*zoom+20)];
        CWTextLabel *label10 = self.labelArray[8];
        [label10 setFrame:NSMakeRect(myGap*0.5+2*myCurrentSegment,([_eff.vaule_1000mA_12V floatValue]-kOrigin)*zoom+5+20, myGap*1.5, 10)];
        label10.stringValue=_eff.vaule_1000mA_12V;
    }
    
    
    
    // self.eff.vaule_3000mA_12V = self.datas[11];
    
    if (self.datas.count>=10) {
        
        self.eff.vaule_500mA_12V = self.datas[9];
        [self.path_12v lineToPoint:NSMakePoint(myGap+myCurrentSegment,([_eff.vaule_500mA_12V floatValue]-kOrigin)*zoom+20)];//([eff.vaule_2000mA_5V floatValue]-70)*20)
        CWTextLabel *label9 = self.labelArray[9];
        [label9 setFrame:NSMakeRect(myCurrentSegment-15,([_eff.vaule_500mA_12V floatValue]-kOrigin)*zoom+15, myGap*1.5, 10)];
        label9.stringValue=_eff.vaule_500mA_12V;
    }
    
    if (self.datas.count>=11) {
        self.eff.vaule_2000mA_12V = self.datas[10];
        [self.path_12v moveToPoint:NSMakePoint(myGap+2*myCurrentSegment,([_eff.vaule_1000mA_12V floatValue]-kOrigin)*zoom+20)];
        [self.path_12v lineToPoint:NSMakePoint(myGap+3*myCurrentSegment,([_eff.vaule_2000mA_12V floatValue]-kOrigin)*zoom+20)];
        CWTextLabel *label11 = self.labelArray[10];
        [label11 setFrame:NSMakeRect(myGap*0.5+3*myCurrentSegment+5,([_eff.vaule_2000mA_12V floatValue]-kOrigin)*zoom+20, myGap*1.5, 10)];
        label11.stringValue=_eff.vaule_2000mA_12V;
    }
    
    if (self.datas.count==16) {
        self.eff.vaule_3000mA_12V = self.datas[15];
        [self.path_12v lineToPoint:NSMakePoint(myGap+4*myCurrentSegment,([_eff.vaule_3000mA_12V floatValue]-kOrigin)*zoom+20)];
        CWTextLabel *label12 = self.labelArray[11];
        [label12 setFrame:NSMakeRect(myGap+4*myCurrentSegment,([_eff.vaule_3000mA_12V floatValue]-kOrigin)*zoom+25, myGap*1.5, 10)];
        label12.stringValue=_eff.vaule_3000mA_12V;
    }
    
    
    [self.path_12v stroke];
    self.path_12v = nil;
    //}
}
-(void)draw_9V{
    // if (self.datas.count>=8) {
    if (self.datas.count>=5) {
        
        self.eff.vaule_500mA_9V = self.datas[4];
        [self.path_9v moveToPoint:NSMakePoint(myGap+myCurrentSegment,([_eff.vaule_500mA_9V floatValue]-kOrigin)*zoom+20)];//([eff.vaule_2000mA_5V floatValue]-70)*20)
        CWTextLabel *label5 = self.labelArray[4];
        [label5 setFrame:NSMakeRect(myCurrentSegment-10,([_eff.vaule_500mA_9V floatValue]-kOrigin)*zoom+15, myGap*1.5, 10)];
        label5.stringValue=_eff.vaule_500mA_9V;
    }
    
    
    
    
    
    if (self.datas.count>=6) {
        self.eff.vaule_1000mA_9V = self.datas[5];
        
        [self.path_9v lineToPoint:NSMakePoint(myGap+2*myCurrentSegment,([_eff.vaule_1000mA_9V floatValue]-kOrigin)*zoom+20)];
        CWTextLabel *label6 = self.labelArray[5];
        [label6 setFrame:NSMakeRect(myGap*0.5+2*myCurrentSegment,([_eff.vaule_1000mA_9V floatValue]-kOrigin)*zoom+5+20, myGap*1.5, 10)];
        label6.stringValue=_eff.vaule_1000mA_9V;
    }
    
    if (self.datas.count>=7) {
        self.eff.vaule_2000mA_9V = self.datas[6];
        
        [self.path_9v lineToPoint:NSMakePoint(myGap+3*myCurrentSegment,([_eff.vaule_2000mA_9V floatValue]-kOrigin)*zoom+20)];
        CWTextLabel *label7 = self.labelArray[6];
        [label7 setFrame:NSMakeRect(myGap*0.5+3*myCurrentSegment,([_eff.vaule_2000mA_9V floatValue]-kOrigin)*zoom+5+20, myGap*1.5, 10)];
        label7.stringValue=_eff.vaule_2000mA_9V;
    }
    
    
    if (self.datas.count>=8) {
        self.eff.vaule_3000mA_9V = self.datas[7];
        [self.path_9v lineToPoint:NSMakePoint(myGap+4*myCurrentSegment,([_eff.vaule_3000mA_9V floatValue]-kOrigin)*zoom+20)];
        CWTextLabel *label8 = self.labelArray[7];
        [label8 setFrame:NSMakeRect(myGap+4*myCurrentSegment,([_eff.vaule_3000mA_9V floatValue]-70)*zoom+5+20, myGap*1.5, 10)];
        label8.stringValue=_eff.vaule_3000mA_9V;
    }
    
    
    
    [self.path_9v stroke];
    self.path_9v = nil;
    //}
}
-(void)draw_5V{
    //if (self.datas.count>=4) {
    if (self.datas.count>=1) {
        if ([self.datas[0] length]) {
            self.eff.vaule_500mA_5V = self.datas[0];
            [self.path_5v moveToPoint:NSMakePoint(myGap+myCurrentSegment,([_eff.vaule_500mA_5V floatValue]-kOrigin)*zoom+20)];//([eff.vaule_2000mA_5V floatValue]-70)*20)
            
            CWTextLabel *label1 = self.labelArray[0];
            [label1 setFrame:NSMakeRect(myCurrentSegment-15,([_eff.vaule_500mA_5V floatValue]-kOrigin)*zoom+15, myGap*1.5, 10)];
            label1.stringValue=_eff.vaule_500mA_5V;
            
            
        }
        
    }
    
    if (self.datas.count>=2&&[self.datas[1] length]) {
        self.eff.vaule_1000mA_5V = self.datas[1];
        [self.path_5v lineToPoint:NSMakePoint(myGap+2*myCurrentSegment,([_eff.vaule_1000mA_5V floatValue]-kOrigin)*zoom+20)];
        CWTextLabel *label2 = self.labelArray[1];
        [label2 setFrame:NSMakeRect(myGap*0.5+2*myCurrentSegment,([_eff.vaule_1000mA_5V floatValue]-kOrigin)*zoom+5+20, myGap*1.5, 10)];
        label2.stringValue=_eff.vaule_1000mA_5V;
    }
    
    if (self.datas.count>=3&&[self.datas[2] length]) {
        self.eff.vaule_2000mA_5V = self.datas[2];
        [self.path_5v lineToPoint:NSMakePoint(myGap+3*myCurrentSegment,([_eff.vaule_2000mA_5V floatValue]-kOrigin)*zoom+20)];
        
        CWTextLabel *label3 = self.labelArray[2];
        [label3 setFrame:NSMakeRect(myGap*0.5+3*myCurrentSegment,([_eff.vaule_2000mA_5V floatValue]-kOrigin)*zoom+5+20, myGap*1.5, 10)];
        label3.stringValue=_eff.vaule_2000mA_5V;
    }
    
    if (self.datas.count>=4&&[self.datas[3] length]) {
        self.eff.vaule_3000mA_5V = self.datas[3];
        [self.path_5v lineToPoint:NSMakePoint(myGap+4*myCurrentSegment,([_eff.vaule_3000mA_5V floatValue]-kOrigin)*zoom+20)];
        CWTextLabel *label4 = self.labelArray[3];
        [label4 setFrame:NSMakeRect(myGap+4*myCurrentSegment,([_eff.vaule_3000mA_5V floatValue]-70)*zoom+5+20, myGap*1.5, 10)];
        label4.stringValue=_eff.vaule_3000mA_5V;
    }
    
    
    [self.path_5v stroke];
    self.path_5v = nil;
    //}
}

-(void)setDatas:(NSArray *)datas{
    _datas=datas;
    if (datas.count) {
        //        if (![datas[0] length]) {
        //            return;
        //        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setNeedsDisplay:YES];
        });
        //        if (datas.count==8 || datas.count==11 || datas.count==16 || datas.count==15 || datas.count==1) {
        //            dispatch_async(dispatch_get_main_queue(), ^{
        //                [self setNeedsDisplay:YES];
        //            });
        //
        //        }
    }
    
    
}

-(void)layoutViews{
    
    //[self setNeedsDisplay:YES];
}

- (NSBezierPath*)path_5v
{
    if(!_path_5v){
        _path_5v =[NSBezierPath bezierPath];
        [_path_5v setLineWidth:lineWidth];
        [[NSColor systemRedColor] setStroke];
        
        //        [_path_5v setLineJoinStyle:NSLineJoinStyleRound];
        //        [_path_5v setLineCapStyle:NSLineCapStyleRound];
    }
    return _path_5v;
}


- (NSBezierPath*)path_9v
{
    if(!_path_9v){
        _path_9v =[NSBezierPath bezierPath];
        [_path_9v setLineWidth:lineWidth];
        [[NSColor systemBrownColor] setStroke];
        
        //        [_path_9v setLineJoinStyle:NSLineJoinStyleRound];
        //        [_path_9v setLineCapStyle:NSLineCapStyleRound];
    }
    return _path_9v;
}


- (NSBezierPath*)path_12v
{
    if(!_path_12v){
        _path_12v =[NSBezierPath bezierPath];
        [_path_12v setLineWidth:lineWidth];
        [[NSColor systemBlueColor] setStroke];
        
        //        [_path_12v setLineJoinStyle:NSLineJoinStyleRound];
        //        [_path_12v setLineCapStyle:NSLineCapStyleRound];
    }
    return _path_12v;
}
- (Efficiency*)eff
{
    if(!_eff){
        _eff =[[Efficiency alloc]init];
        
    }
    return _eff;
}

- (NSBezierPath*)path_15v
{
    if(!_path_15v){
        _path_15v =[NSBezierPath bezierPath];
        [_path_15v setLineWidth:lineWidth];
        [[NSColor systemGreenColor] setStroke];
        
        //        [_path_15v setLineJoinStyle:NSLineJoinStyleRound];
        //        [_path_15v setLineCapStyle:NSLineCapStyleRound];
    }
    return _path_15v;
}

- (NSMutableArray*)bScaleArray
{
    if(!_bScaleArray){
        _bScaleArray = [NSMutableArray array];
    }
    return _bScaleArray;
}
- (NSMutableArray*)sScaleArray
{//scaleNameArray
    if(!_sScaleArray){
        _sScaleArray = [NSMutableArray array];
    }
    return _sScaleArray;
}
- (NSMutableArray*)scaleNameArray
{//
    if(!_scaleNameArray){
        _scaleNameArray = [NSMutableArray array];
    }
    return _scaleNameArray;
}

- (NSMutableArray*)btnArray
{//
    if(!_btnArray){
        _btnArray = [NSMutableArray array];
        for (int i = 0; i<16; i++) {
            NSButton *btn = [[NSButton alloc] init];
            btn.title=@"";
            [btn setBezelStyle:NSBezelStyleCircular];//NSBezelStyleCircular
            [btn setButtonType:NSButtonTypeOnOff];
            btn.state =0;
            [self addSubview:btn];
            [_btnArray addObject:btn];
        }
    }
    return _btnArray;
}
- (NSMutableArray*)labelArray
{//
    if(!_labelArray){
        _labelArray = [NSMutableArray array];
        for (int i = 0; i<16; i++) {
            CWTextLabel *vaule = [[CWTextLabel alloc] initWithFrame:NSMakeRect(0, 0, 30, 20)];
            vaule.font=[NSFont systemFontOfSize:10.0];
            vaule.stringValue = @"";
            
            if (i==0||i==1||i==2||i==3) {
                vaule.backgroundColor =[NSColor clearColor];
                vaule.textColor =[NSColor systemRedColor];
            }
            if (i==4||i==5||i==6||i==7) {
                vaule.backgroundColor =[NSColor clearColor];
                vaule.textColor =[NSColor systemBrownColor];//systemOrangeColor
            }
            if (i==8||i==9||i==10||i==11) {
                vaule.backgroundColor =[NSColor clearColor];
                vaule.textColor =[NSColor systemBlueColor];
            }
            if (i==12||i==13||i==14||i==15) {
                vaule.backgroundColor =[NSColor clearColor];
                vaule.textColor =[NSColor systemGreenColor];
            }
            
            vaule.bordered=NO;
            [self addSubview:vaule];
            [_labelArray addObject:vaule];
        }
    }
    return _labelArray;
}

-(void)cleanTextLabel{
    for (CWTextLabel *label in self.labelArray) {
        [label setStringValue:@""];
    }
}


@end
