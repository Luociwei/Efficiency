//
//  SearchPinVC.m
//  SearchPinVC
//
//  Created by ciwei luo on 2019/6/27.
//  Copyright © 2019 ciwei luo. All rights reserved.
//

#import "SearchPinVC.h"
#import "PinBox.h"
#import "HeardPinBox.h"

@interface SearchPinVC ()<NSSearchFieldDelegate>
@property(copy)NSArray *tpNamesList;
@property(strong)NSMutableArray *tpPinsArr;
@property(strong)PinBox *showingTpPin;
@property(strong)HeardPinBox *showingHeadPin;
@property(nonatomic, weak)NSSearchField *searchFiled;
@property(strong)HeardPinBox *heardPinBoxJ246;
@property(copy)NSDictionary *headPinsList;
@property(strong)NSMutableArray *headPinBoxsArr;
@property(nonatomic, copy)NSArray *headPinGroupNames;
@property(nonatomic, weak)CWTextLabel *textLabel;
//@property(nonatomic, strong)NSScrollView *scrollView;

@end

@implementation SearchPinVC

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do view setup here.
    [self dealDatas];
    [self setHeadPins];
    [self setTpPins];
 
    int x = arc4random() % 5;
    NSString *str=x?@"tp9401":@"j42_29";
    self.searchFiled.stringValue = str;//tp93KE
    
    self.textLabel.stringValue=[NSString stringWithFormat:@"Press Enter to search"];
}



-(void)setHeadPins{
    int headPinBoxW =AppWidth/4;
    int headPinBoxH =60;
    int col = 4;
    int row = 2;
    int gap = (AppWidth-headPinBoxW*col)/3;
    self.headPinBoxsArr = [NSMutableArray array];
    for (int j=0; j<row; j++) {
        int y = (row-j-1)*(headPinBoxH+margin*2)+(AppHeight*0.68);//(row-j-1)
        for (int i=0; i<col; i++) {
            
            int x =i*(headPinBoxW+gap);
            HeardPinBox *headPinBox = [[HeardPinBox alloc]initWithFrame:NSMakeRect(x, y, headPinBoxW, headPinBoxH)];
            NSInteger index = j*col+i;
            headPinBox.netName=[self.headPinGroupNames objectAtIndex:index];
            [self.view addSubview:headPinBox];
            
            [self.headPinBoxsArr addObject:headPinBox];
        }
    }
}

-(void)setTpPins{
    
    self.tpPinsArr=[NSMutableArray array];
    int pinBoxW=AppWidth/31;
    int pinBoxH =pinBoxW;
    int i =0;
    for (NSArray *arr in self.tpNamesList) {
        int j=0;
        NSMutableArray *mutArr = [NSMutableArray array];
        for (NSString *pinName in arr) {
            int x = j*pinBoxW+margin*2;
            int y=i*pinBoxH+3*margin;
            if (i==0) {
                if (j>=9) {
                    x=x+pinBoxW;
                }
                if (j>=15) {
                    x=x+pinBoxW;
                    y=y-margin*0.7;
                }
                if (j>=16) {
                    x=x+pinBoxW;
                }
                
                if (j>=17) {
                    x=x+pinBoxW;
                }
                if (j>=18) {
                    x=x+pinBoxW;
                }
                if (j>=19) {
                    x=x+pinBoxW*0.8;
                }
            }
            if (i==1) {
                if (j>=8) {
                    x=x+pinBoxW;
                }
            }
            if (i==2) {
                x=x+16*pinBoxW;
            }
            if (i==4) {
                if (j>=7) {
                    x=x+pinBoxW;
                }
            }
            if (i==5) {
                if (j>=8) {
                    x=x+pinBoxW;
                }
            }
            if (i==7) {
                if (j>=12) {
                    x=x+pinBoxW;
                }
            }
            PinBox *pin = [[PinBox alloc] initWithFrame:NSMakeRect(x,y,pinBoxW,pinBoxH)];
            
            [pin setTitleStirng:pinName];
            
            [self.view addSubview:pin];
            
            [mutArr addObject:pin];
            j++;
        }
        
        NSArray *array = (NSArray *)mutArr;
        [self.tpPinsArr addObject:array];
        i++;
        
    }
}

//- (NSScrollView*)scrollView
//{
//    if(!_scrollView){
//        _scrollView = [[NSScrollView alloc]initWithFrame:self.view.bounds];
//        _scrollView.backgroundColor = [NSColor greenColor];
//
//        NSClipView *contentView  = _scrollView.contentView;
//        NSPoint newScrollOrigin=NSMakePoint(0.0,0.0);;
//        [contentView scrollPoint:newScrollOrigin];
//        contentView.frame=NSMakeRect(0, 0, 1000, 900);
//        [self.view addSubview:_scrollView];
//
//
//    }
//    return _scrollView;
//}

- (NSSearchField*)searchFiled
{
    if(!_searchFiled){
        NSSearchField *search =[[NSSearchField alloc] initWithFrame:NSMakeRect(10, AppHeight-40, 130, 20)];
        search.delegate=self;
        search.placeholderString=@"Input then Enter";
        [search becomeFirstResponder];
        [self.view addSubview:search];
        _searchFiled=search;
    }
    return _searchFiled;
}


- (CWTextLabel*)textLabel
{
    if(!_textLabel){
        CWTextLabel *textLabel =[[CWTextLabel alloc] initWithFrame:NSMakeRect(160, AppHeight-40, 200, 20)];
        [self.view addSubview:textLabel];
        _textLabel=textLabel;
    }
    return _textLabel;
}

- (NSArray*)headPinGroupNames
{
    if(!_headPinGroupNames){
        _headPinGroupNames=[NSArray arrayWithObjects:@"J246", @"J43",@"J108",@"J180",@"J42",@"J109",@"J245",@"J179",nil];
    }
    return _headPinGroupNames;
}

-(void)viewDidAppear{
    [super viewDidAppear];

    [MyEexception checkInstancesNum];
}

-(void)dealDatas{
    
    self.tpNamesList= [self getJsonDatasWithFileName:@"tpNamesList.json"];
    
    self.headPinsList=[self getJsonDatasWithFileName:@"HeadPinList.json"];
    
}


-(id)getJsonDatasWithFileName:(NSString *)file{
    
    NSString *configfile = [[NSBundle mainBundle] pathForResource:file ofType:nil];
    // NSString *configfile = [[NSBundle mainBundle] pathForResource:@"Property List.plist" ofType:nil];
    
    //    NSString *desktopPath = [NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES)lastObject];
    //    NSString *eCodePath=[desktopPath stringByDeletingLastPathComponent];
    //    NSString *configfile=[eCodePath stringByAppendingPathComponent:@"pinList.json"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:configfile]) {
        
        return nil;
    }
    NSString* items = [NSString stringWithContentsOfFile:configfile encoding:NSUTF8StringEncoding error:nil];
    if (items.length<10) {
        return nil;
    }
    NSData *data= [items dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    return jsonObject;
}

- (void)controlTextDidEndEditing:(NSNotification *)obj{
    NSLog(@"2-SearchPinVC frame %@",NSStringFromRect(self.view.frame));
    NSTextField *textF=obj.object;
    NSLog(@"%s--%@",__func__,textF.stringValue);
    if (textF==self.searchFiled) {
        NSString *searchStr=[self checkPinName:textF.stringValue];
        NSArray *searchArr = [self searchIndexsWithPinName:searchStr];
        self.textLabel.stringValue=@"";
        self.showingTpPin.fillColor=[NSColor clearColor];
        self.showingTpPin.btn.state=0;
        
        [self.showingHeadPin resetShowingPin];
        if (searchArr.count) {
            NSInteger row = [searchArr[0] integerValue];
            NSInteger index = [searchArr[1] integerValue];
            NSMutableString *mutStr = [NSMutableString stringWithFormat:@"TP:row=%ld,col=%ld",(long)row,(long)index];
            PinBox *pinB = self.tpPinsArr[row][index];
            [pinB highLight];
            self.showingTpPin=pinB;
            
            for (NSString *key in self.headPinsList.allKeys) {
                NSDictionary *dict = self.headPinsList[key];
                for (NSString *name in dict.allKeys) {
                    if ([name isEqualToString:searchStr]) {
                        NSString *pinPos=dict[name];
                        for (HeardPinBox *headPinBox in _headPinBoxsArr) {
                            if ([headPinBox.netName isEqualToString:key]) {
                                self.showingHeadPin=headPinBox;
                                [headPinBox highLightWithPinPosition:pinPos.intValue];
                                [mutStr appendFormat:@"%@", [NSString stringWithFormat:@" HeadPin:%@_%@",key,pinPos]];
                            }
                        }
         
                    }
                }
            }
                                 
            self.textLabel.stringValue=mutStr;
        }
        
        
    }
}

-(NSString *)checkPinName:(NSString *)pinName{
    if ([pinName containsString:@"_"]) {
        NSArray *arr = [pinName componentsSeparatedByString:@"_"];
        if (arr.count==2) {
            NSString *name =[arr[0] uppercaseString];
            NSString *pos=arr[1];
            NSDictionary *dict = _headPinsList[name];
            
            for (NSString *key in dict) {
                if ([dict[key] isEqualToString:pos]) {
                    pinName=key;
                }
            }
        }
        
    }
    return [pinName uppercaseString];
}


-(NSArray *)searchIndexsWithPinName:(NSString *)pinName{

    NSInteger row=0;
    NSInteger index=0;
    if (!(pinName.length==5 || pinName.length==6)) {
        if ([pinName isEqualToString:@"TP78"]) {
            return @[@5,@7];
        }else{
            return nil;
        }
    }
    
    for (NSArray *rowArr in self.tpNamesList) {
        
        for (NSString *name in rowArr) {
            if ([name isEqualToString:pinName]) {
                row = [self.tpNamesList indexOfObject:rowArr];
                index=[rowArr indexOfObject:pinName];
                NSArray *arr = [NSArray arrayWithObjects:[NSNumber numberWithInteger:row],[NSNumber numberWithInteger:index], nil];
                return arr;
            }
        }
    }
    
    return nil;
}




@end
