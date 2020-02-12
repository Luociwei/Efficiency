//
//  TestPlanVC.m
//  TestPlanEditor
//
//  Created by ciwei luo on 2020/1/17.
//  Copyright © 2020 macdev. All rights reserved.
//

#import "TestPlanVC.h"
#import <CWGeneralManager/parseCSV.h>
#import <CWGeneralManager/CWFileManager.h>
#import <CWGeneralManager/NSString+Extension.h>
#import "DebugSettingVC.h"
#import "ColumnVC.h"
#import "ShowingLogVC.h"

static NSString *const key_index = @"INDEX";
static NSString *const key_elapse = @"_ELAPSE";
static NSString *const key_vaule = @"_VALUE";
static NSString *const key_message = @"_MESSAGE";
static NSString *const key_result = @"_RESULT";
static NSString *const key_disable = @"disable";
static NSString *const key_debuging = @"debuging";

@interface TestPlanVC ()<NSTextFieldDelegate>
@property (weak) IBOutlet NSTextField *btn;
@property (weak) IBOutlet NSButton *btnOpen;
@property (weak) IBOutlet NSButton *btnShow;
@property (weak) IBOutlet NSButton *btnDebug;
@property(nonatomic,strong)NSPopover *sharePopover;
@property (weak) IBOutlet NSTableView *tableView;
@property (nonatomic,strong) NSArray *columnTitles;
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) NSMutableArray *failItems;
@property (nonatomic,strong) NSMutableArray *originalDatas;
@property (nonatomic,strong) DebugSettingVC *debugSettingVC;

@property (weak) IBOutlet NSSearchField *searchField;


@end

@implementation TestPlanVC{
    NSInteger _stepIndex;
    BOOL _isStop;
    NSString *_logDirPath;
    NSString *_fileName;
}

-(void)refleshWithPath:(NSString *)path{
    
    CSVParser *csv = [[CSVParser alloc]init];
    NSMutableArray *mutArray = nil;
    if ([csv openFile:path]) {
        mutArray = [csv parseFile];
    }
    
    if (!mutArray.count) {
        return;
    }
    self.sharePopover=nil;
    
    NSArray *arr0 = mutArray[0];
    self.columnTitles = arr0;
    
    [self reloadColumnsWithTitles:arr0];
    
    NSMutableArray *mutDicArr=[NSMutableArray array];
    [mutArray removeObjectAtIndex:0];
    
    for (int j = 0; j<mutArray.count; j++) {
        NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
        NSArray *mutArr_j =mutArray[j];
        if (mutArr_j.count != arr0.count) {
            continue;
        }
        [mutDic setObject:[NSString stringWithFormat:@"%d",j+1] forKey:key_index];
        [mutDic setObject:@"0" forKey:key_disable];
        [mutDic setObject:@"0" forKey:key_debuging];
        
        [mutDic setObject:@"" forKey:key_elapse];
        [mutDic setObject:@"" forKey:key_result];
        [mutDic setObject:@"" forKey:key_vaule];
        [mutDic setObject:@"" forKey:key_message];
        
        for (int k = 0; k<[mutArr_j count]; k++) {
            NSString *vaule =mutArr_j[k];
            if (!vaule.length) {
                vaule = @"";
            }
            [mutDic setObject:vaule forKey:arr0[k]];
        }
        [mutDicArr addObject:mutDic];
    }
    _fileName=[path lastPathComponent];
    self.originalDatas = [NSMutableArray arrayWithArray:mutDicArr];
    self.datas= [NSMutableArray arrayWithArray:mutDicArr];;
    self.tableView.headerView.hidden=NO;
    self.tableView.usesAlternatingRowBackgroundColors=YES;
    self.tableView.gridStyleMask = NSTableViewSolidHorizontalGridLineMask |NSTableViewSolidVerticalGridLineMask ;
    [self.tableView reloadData];
    
    
}

-(void)sizeToFitWithColumn{
    if (!self.datas.count) {
        return;
    }
    NSMutableDictionary *columnDic = [NSMutableDictionary dictionary];
    for (NSTableColumn *col in self.tableView.tableColumns) {
        [columnDic setObject:col.identifier forKey:col.identifier];
    }
    int i =0;
    for (NSMutableDictionary *mutDic in self.datas) {
        for (NSString *key in mutDic.allKeys) {
            if ([key isEqualToString:key_disable]||[key isEqualToString:key_debuging]) {
                continue;
            }
            NSString *maxValue = [columnDic objectForKey:key];
            if (maxValue.length<[mutDic[key] length]) {
                [columnDic setObject:mutDic[key] forKey:key];
                
            }
        }
        
        i++;
    }
    for (NSString *key in columnDic.allKeys) {
        
        NSTableColumn *column = [self.tableView tableColumnWithIdentifier:key];
        NSString *vaule =columnDic[key];
        float w = [vaule sizeWithAttributes:nil].width;
        
        //NSInteger w =9*vaule.length;
        column.width = w+10;
    }
}

-(void)reloadColumnsWithTitles:(NSArray *)titles{
    
    while([[self.tableView tableColumns] count] > 0) {
        [self.tableView removeTableColumn:[[self.tableView tableColumns] lastObject]];
    }
    
    [self addColumnWithTitle:key_index];
    
    for (int i=0; i<titles.count; i++) {
        
        NSString *title =titles[i];
        if (!title.length) {
            title = @"";
        }
        NSTableColumn *column=[[NSTableColumn alloc]initWithIdentifier:title];
        
        column.editable = YES;
        column.title = title;
        [self.tableView addTableColumn:column];
    }
    [self addColumnWithTitle:key_elapse];
    [self addColumnWithTitle:key_result];
    [self addColumnWithTitle:key_vaule];
    [self addColumnWithTitle:key_message];
    
}

-(void)addColumnWithTitle:(NSString *)title{
    if ([self.columnTitles containsObject:title]) {
        return;
    }
    NSTableColumn *column=[[NSTableColumn alloc]initWithIdentifier:title];
    column.title = column.identifier;
    [self.tableView addTableColumn:column];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _logDirPath = [[NSString cw_getUserPath]stringByAppendingString:@"/Suncode/TestPlanEditor/results"];
    [CWFileManager cw_createFile:_logDirPath isDirectory:YES];
    // Do view setup here.
}



#pragma mark-  NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    //返回表格共有多少行数据
    return [self.datas count];
}

#pragma mark-  NSTableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    NSDictionary *data = self.datas[row];
    NSString *identifier = tableColumn.identifier;
    
    NSString *value = data[identifier];
    NSView *view = [tableView makeViewWithIdentifier:identifier owner:self];
    NSTextField *textField;
    if(!view){
        
        textField =  [[NSTextField alloc]init];
        textField.delegate=self;
        textField.wantsLayer=YES;
        //textField.font = [NSFont systemFontOfSize:10];
        [textField setBezeled:NO];
        [textField setDrawsBackground:NO];
        textField.identifier = identifier;
        view = textField ;
        
    }
    else{
        
        textField = (NSTextField*)view;
        
    }
    
    if(value){
        //更新单元格的文本
        textField.stringValue = value;
    }
    
    if ([[data objectForKey:key_disable] isEqualToString:@"1"]) {
        
        textField.layer.backgroundColor = [NSColor gridColor].CGColor;
    }else{
//        if ([[data objectForKey:key_debuging] isEqualToString:@"1"]) {
//
//            textField.layer.backgroundColor = [NSColor systemOrangeColor].CGColor;
//        }else{
//
//            textField.layer.backgroundColor = [NSColor clearColor].CGColor;
//        }
        if (![[data objectForKey:key_result] length]) {
            textField.layer.backgroundColor = [NSColor clearColor].CGColor;
        }else{
            if ([[[data objectForKey:key_result] lowercaseString] isEqualToString:@"pass"]) {
                
                textField.layer.backgroundColor = [NSColor systemGreenColor].CGColor;
            }else{
                
                textField.layer.backgroundColor = [NSColor systemRedColor].CGColor;
            }
        }

        
    }
    
    return view;
}


- (void)controlTextDidEndEditing:(NSNotification *)ob{
    
    NSTextField *textF =ob.object;
    NSInteger row =self.tableView.selectedRow;
    
    NSInteger col = [self.tableView columnForView:textF];
    
    NSMutableDictionary *editDic = self.datas[row];;
    
    [editDic setObject:textF.stringValue forKey:self.tableView.tableColumns[col].identifier];

    
}



- (IBAction)clicksss:(NSButton *)sender {
    //表格当前选择的行
    NSIndexSet  *rowIndexes = self.tableView.selectedRowIndexes;
    
    //如果row小于0表示没有选择行
    if(!rowIndexes){
        return;
    }
    
    
    [self.tableView beginUpdates];
    [self.tableView hideRowsAtIndexes:rowIndexes withAnimation:NSTableViewAnimationSlideUp];
    [self.tableView endUpdates];
    
    
    //从数据区删除选择的行的数据
   // [self.datas removeObjectsAtIndexes:rowIndexes];
    
    //[self.tableView reloadData];
    
}

#pragma mark btn click
- (IBAction)open:(NSButton *)sender {
    NSOpenPanel *openPanel=[NSOpenPanel openPanel];
    //NSString *openPath =[[NSBundle mainBundle] resourcePath];
    NSString *openPath = [NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES)lastObject];
    [openPanel setDirectoryURL:[NSURL fileURLWithPath:openPath]];
    
    NSArray *fileType=[NSArray arrayWithObjects:@"csv",nil];
    [openPanel setAllowedFileTypes:fileType];
    ;
    [openPanel setCanChooseFiles:YES];
    [openPanel setAllowsMultipleSelection:NO];
    [openPanel setPrompt:@"Choose"];
    
    [openPanel beginSheetModalForWindow:[[NSApplication sharedApplication] mainWindow] completionHandler:^(NSInteger result){
        if (result==NSFileHandlingPanelOKButton)
        {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
                NSArray *urls=[openPanel URLs];
                
                for (int i=0; i<[urls count]; i++)
                {
                    NSString *csvPath = [[urls objectAtIndex:i] path];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self refleshWithPath:csvPath];
                    });

                    [ShowingLogVC postNotificationWithLog:[NSString stringWithFormat:@"Open test plan:%@",csvPath] type:@"INFO"];
                    
                }
            });
        }
    }];
}




- (IBAction)save:(NSButton *)sender {
    
    NSSavePanel *saveDlg = [[NSSavePanel alloc]init];
    
    saveDlg.title = @"Save File";
    
    saveDlg.message = @"Save File";
    
    saveDlg.allowedFileTypes = @[@"csv"];
    
    saveDlg.nameFieldStringValue = @"J417_FCT__SystemTest_P2_V02";
    
    [saveDlg beginWithCompletionHandler: ^(NSInteger result){
        
        if(result==NSFileHandlingPanelOKButton){
            
            NSURL  *url =[saveDlg URL];
            
            NSLog(@"filePath url%@",url);
            NSMutableString *text = [NSMutableString string];
            
            NSArray *columns = self.tableView.tableColumns;
            for (int i =0; i<columns.count; i++) {
                [text appendString:[columns[i] title]];
                if (i!=columns.count-1) {
                    [text appendString:@","];
                }else{
                    [text appendString:@"\n"];
                }
            }
            
            
            for (NSDictionary *dic in self.datas) {
                
                for (int i =0; i<columns.count; i++) {
                    NSString *key = [columns[i] title];
                    [text appendString:dic[key]];
                    if (i!=columns.count-1) {
                        [text appendString:@","];
                    }else{
                        [text appendString:@"\n"];
                    }
                }
                
            }
            
            
            NSError *error;
            
            [text writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:&error];
            
            if(error){
                NSLog(@"save file error %@",error);
            }
        }
        
    }];
    
}

- (IBAction)btnEnableClick:(NSButton *)sender {
    
    NSIndexSet  *rowIndexes = self.tableView.selectedRowIndexes;
    
    //如果row小于0表示没有选择行
    if(!rowIndexes.count){
        return;
    }
    for (NSInteger i = rowIndexes.firstIndex; i<rowIndexes.lastIndex+1; i++) {
        NSMutableDictionary *dic = [self.datas objectAtIndex:i];
        [dic setObject:@"0" forKey:@"Disable"];
    }
    [self.tableView reloadData];
    
    
}
- (IBAction)btnShowClick:(NSButton *)sender {
    NSInteger state = self.btnShow.state;
    if (state) {
        [self.btnShow setImage:[NSImage imageNamed:@"Show_No"]];
        NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
        NSInteger i =0;
        for (NSMutableDictionary *dic in self.datas) {
            if ([[dic objectForKey:key_disable] isEqualToString:@"1"]) {
                [indexSet addIndex:i];
            }
            i++;
        }
        [self.datas removeObjectsAtIndexes:indexSet];
    }else{
        [self.btnShow setImage:[NSImage imageNamed:@"Show"]];
        self.datas = [NSMutableArray arrayWithArray:self.originalDatas];
    }
    
    [self.tableView reloadData];
}

- (IBAction)btnDisableClick:(NSButton *)sender {
    //表格当前选择的行
    NSIndexSet  *rowIndexes = self.tableView.selectedRowIndexes;
    
    //如果row小于0表示没有选择行
    if(!rowIndexes.count){
        return;
    }
    for (NSInteger i = rowIndexes.firstIndex; i<rowIndexes.lastIndex+1; i++) {
        NSMutableDictionary *dic = [self.datas objectAtIndex:i];
        [dic setObject:@"1" forKey:key_disable];
    }
    [self.tableView reloadData];
}


- (IBAction)validateClick:(NSButton *)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"OpenCloseViewNotification" object:nil];
}


- (IBAction)resizeClick:(NSButton *)sender {
    //[self.tableView sizeToFit];
    [self sizeToFitWithColumn];
}

- (IBAction)debugClick:(NSButton *)sender {
    NSInteger state = self.btnDebug.state;
    if (state) {
        [self.btnDebug setImage:[NSImage imageNamed:@"Debug_Green"]];
        
        [self presentViewControllerAsModalWindow:self.debugSettingVC];
        
    }else{
        [self.btnDebug setImage:[NSImage imageNamed:@"Debug"]];
    }
}

- (IBAction)columnClick:(NSButton *)btn {

    [self.sharePopover showRelativeToRect:[btn bounds] ofView:btn preferredEdge:NSRectEdgeMaxY];
}
- (IBAction)logClick:(NSButton *)btn {
    
    system([[NSString stringWithFormat:@"open %@",_logDirPath] UTF8String]);
}

- (IBAction)startClick:(NSButton *)sender {
    if (self.datas.count==0) {
        return;
    }
    
    [self.tableView reloadData];
    _isStop = NO;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        
        // NSInteger lastIndex = 0;
        for (int i =0 ; i<self.datas.count; i++) {
            if (_isStop) {
                return ;
            }
            //        NSString *name = [NSString stringWithFormat:@"suncode_%d",i];
            //        dispatch_queue_t queue = dispatch_queue_create([name cStringUsingEncoding:NSUTF8StringEncoding] , DISPATCH_QUEUE_SERIAL);
            
            NSMutableDictionary *dic = self.datas[i];
            NSString *disable=@"";
            NSString *function = @"";
            NSString *timeout = @"";
            NSString *param1 = @"";
            NSString *param2 = @"";
            NSString *low = @"";
            NSString *high = @"";
            NSString *elapse = @"";
            NSString *result = @"";
            NSString *vaule = @"";
            NSString *message = @"";
            
            //  if ([dic.allKeys containsObject:key_disable]) {
            disable = dic[key_disable];
            if ([disable isEqualToString:@"1"]) {
                result = @"skip";
                vaule = @"none";
                message=@"skip";
                // continue ;
                // }
            }else{
                if (![dic.allKeys containsObject:@"FUNCTION"]) {
                    result = @"fail";
                    vaule = @"none";
                    message=@"no FUNCTION";
                    
                }else{
                    function = dic[@"FUNCTION"];

                    if ([dic.allKeys containsObject:@"TIMEOUT"]) {
                        timeout = dic[@"TIEMOUT"];
                    }
                    if ([dic.allKeys containsObject:@"PARAM1"]) {
                        param1 = dic[@"PARAM1"];
                    }
                    if ([dic.allKeys containsObject:@"PARAM2"]) {
                        param2 = dic[@"PARAM2"];
                    }
                    if ([dic.allKeys containsObject:@"LOW"]) {
                        low = dic[@"LOW"];
                    }
                    if ([dic.allKeys containsObject:@"HIGH"]) {
                        high = dic[@"HIGH"];
                    }
                }
            }

            [dic setObject:@"1" forKey:key_debuging];
            if ([dic.allKeys containsObject:key_vaule]) {
                if (!vaule.length) {
                    
                    NSArray *arr = [self getResponeWithFunctionName:function timeout:timeout param1:param1 param2:param2 low:low high:high index:i];
                    vaule = arr[0];
                    result = arr[1];
                    message=arr[2];
                    elapse=arr[3];
                    
                    if (vaule.length) {
                        if (vaule.integerValue>high.integerValue || vaule.integerValue < low.integerValue) {
                            if ([dic.allKeys containsObject:@"GROUP"]) {
                                [self.failItems addObject:dic[@"GROUP"]];
                            }
                        }
                    }
                    
                }
                [dic setObject:elapse forKey:key_elapse];
                [dic setObject:vaule forKey:key_vaule];
                [dic setObject:message forKey:key_message];
                [dic setObject:result forKey:key_result];
                
            }
            

            dispatch_sync(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadDataForRowIndexes:[NSIndexSet indexSetWithIndex:i] columnIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.tableView.tableColumns.count)]];
                
            });
        }
        
        [self saveCsv];
        if (self.failItems.count) {
            [self.failItems removeAllObjects];
        }
    });
    
}

-(void)saveCsv{
    
    NSString *localCSVPath = [NSString stringWithFormat:@"%@/Log_%@",_logDirPath,_fileName];
    NSFileManager *csvfileManager = [NSFileManager defaultManager];
    if (![csvfileManager fileExistsAtPath:localCSVPath]) {

        [csvfileManager createFileAtPath:localCSVPath contents:nil attributes:nil];
        NSMutableString *stationInfo = [NSMutableString stringWithFormat:@"app_version:%@,,,,,,,,,",@"v1.1.1"];
        NSMutableString *testInfo = [NSMutableString stringWithFormat:@"Product,SerialNumber,Special Build Name,Special Build Description,Unit Number,Station ID,Test Pass/Fail Status,Start Time,End Time,List Of Failing Tests"];

        NSMutableString *displayName   = [NSMutableString stringWithFormat:@"Display Name---------->,,,,,,,,,"];
        NSMutableString *pdcaPriority = [NSMutableString stringWithFormat:@"PDCA Priority--------->,,,,,,,,,"];
        NSMutableString *upperLimit     = [NSMutableString stringWithFormat:@"Upper Limit------------>,,,,,,,,,"];
        NSMutableString *lowLimit    = [NSMutableString stringWithFormat:@"Lower Limit----------->,,,,,,,,,"];
        NSMutableString *unit          = [NSMutableString stringWithFormat:@"Measure Unit---------->,,,,,,,,,"];
        for (int i = 0; i < self.originalDatas.count; i++) {
            NSMutableDictionary * item = self.originalDatas[i];
            if ([item.allKeys containsObject:key_index]) {
                [testInfo appendString:[NSString stringWithFormat:@",%@", item[key_index]]];
            }
            if ([item.allKeys containsObject:@"GROUP"]) {
               [displayName appendString:[NSString stringWithFormat:@",%@", item[@"GROUP"]]];
            }
            if ([item.allKeys containsObject:@"HIGH"]) {
                [upperLimit appendString:[NSString stringWithFormat:@",%@", item[@"HIGH"]]];
            }
            if ([item.allKeys containsObject:@"LOW"]) {
                [lowLimit appendString:[NSString stringWithFormat:@",%@", item[@"LOW"]]];
            }
            if ([item.allKeys containsObject:@"UNIT"]) {
                [unit appendString:[NSString stringWithFormat:@",%@",item[@"UNIT"]]];
            }
            
            [pdcaPriority appendString:[NSString stringWithFormat:@",%@", @"0"]];
        }

        NSString *localCSVTitle = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@\n",stationInfo,testInfo,displayName,pdcaPriority,upperLimit,lowLimit,unit];

        [CWFileManager cw_writeToFile:localCSVPath content:localCSVTitle];

    }
    
    NSMutableString *failItemsString = [NSMutableString string];
    if (self.failItems.count) {
        for (NSString * str in self.failItems) {
            [failItemsString appendString:str];
            [failItemsString appendString:@";"];
        }
    }
    
    NSMutableString *csvData = [NSMutableString stringWithFormat:@",,,,,,,,,%@,",failItemsString];
    for (int i =0; i<self.datas.count; i++) {
        NSMutableDictionary *dic =self.datas[i];
        if ([dic.allKeys containsObject:key_vaule]) {
            NSString *vaule = dic[key_vaule];
            //[csvData appendString:vaule];
            [csvData appendString:@"1"];
            if (i!=self.datas.count-1) {
                [csvData appendString:@","];
            }
        }
    }
    [CWFileManager cw_writeToFile:localCSVPath content:csvData];
    
}



-(NSArray *)getResponeWithFunctionName:(NSString *)function timeout:(NSString *)timeout param1:(NSString *)param1 param2:(NSString *)param2 low:(NSString *)low high:(NSString *)high index:(NSInteger)i{
    if (function.length==0) {
        return [NSArray arrayWithObjects:@"",@"",@"",@"", nil];
    }
    [ShowingLogVC postNotificationWithLog:[NSString stringWithFormat:@"Run test %ld,function:%@,parameter:[%@,%@]",(long)i,function,param1,param2] type:@"DEBUG ####"];
    NSDate *date = [NSDate date];
    [NSThread sleepForTimeInterval:0.2];
    NSString *vaule=[self getVauleWithLowLimit:low upper:high];
    NSString *result = @"pass";
    if (vaule.length) {
        if (vaule.integerValue>high.integerValue || vaule.integerValue < low.integerValue) {
            NSMutableDictionary *dic = self.datas[i];
            result = @"fail";
            if ([dic.allKeys containsObject:@"GROUP"]) {
                [self.failItems addObject:dic[@"GROUP"]];
            }
        }
    }
    
    NSString *message = @"";
    NSString *elapse =[NSString stringWithFormat:@"%f",-[date timeIntervalSinceNow]];
    
    NSString *log_vaule = [NSString stringWithFormat:@"function:%@,timeout:%@,param1:%@,param2:%@,low:%@,high:%@",function,timeout,param1,param2,low,high];
    [ShowingLogVC postNotificationWithLog:[NSString stringWithFormat:@"Return value %@",log_vaule] type:@"DEBUG $$$$$$"];
    return [NSArray arrayWithObjects:vaule,result,message,elapse, nil];
}

-(NSString *)getVauleWithLowLimit:(NSString *)low upper:(NSString *)upper{
    NSString *vaule = @"";
    if (low.length && upper.length) {
        NSInteger int_low = low.integerValue;
        NSInteger int_upper = upper.integerValue;
        
        if (int_upper-int_low>=0) {
          NSInteger int_vaule =(int_low-50) + arc4random()%(int_upper-int_low+100);
            vaule = [NSString stringWithFormat:@"%ld",(long)int_vaule];
        }

        
    }
    return vaule;
}

- (IBAction)stepClick:(NSButton *)sender {
    if (_stepIndex>=self.datas.count) {
        return;
    }
    NSMutableDictionary *dic = self.datas[_stepIndex];
    NSString *disable=@"";
    NSString *function = @"";
    NSString *timeout = @"";
    NSString *param1 = @"";
    NSString *param2 = @"";
    NSString *low = @"";
    NSString *high = @"";
    NSString *elapse = @"";
    NSString *result = @"";
    NSString *vaule = @"";
    NSString *message = @"";
    if ([dic.allKeys containsObject:key_disable]) {
        disable = dic[key_disable];
        if ([disable isEqualToString:@"1"]) {
            result = @"skip";
            vaule = @"none";
            message=@"skip";
            // continue ;
        }
    }else{
        if (![dic.allKeys containsObject:@"FUNCTION"]) {
            result = @"fail";
            vaule = @"none";
            message=@"no FUNCTION";
            
        }else{
            function = dic[@"FUNCTION"];
            if (function.length==0) {
                //                result = @"fail";
                //                vaule = @"none";
                //                message=@"no FUNCTION";
                // continue;
            }
            if ([dic.allKeys containsObject:@"TIEMOUT"]) {
                timeout = dic[@"TIEMOUT"];
            }
            if ([dic.allKeys containsObject:@"PARAM1"]) {
                param1 = dic[@"PARAM1"];
            }
            if ([dic.allKeys containsObject:@"PARAM2"]) {
                param2 = dic[@"PARAM2"];
            }
            if ([dic.allKeys containsObject:@"LOW"]) {
                low = dic[@"LOW"];
            }
            if ([dic.allKeys containsObject:@"HIGH"]) {
                high = dic[@"HIGH"];
            }
        }
    }
    
    [dic setObject:@"1" forKey:key_debuging];
    
    if ([dic.allKeys containsObject:key_vaule]) {
        if (!vaule.length) {
            
            NSArray *arr = [self getResponeWithFunctionName:function timeout:timeout param1:param1 param2:param2 low:low high:high index:_stepIndex];
            vaule = arr[0];
            result = arr[1];
            message=arr[2];
            elapse=arr[3];
            if (vaule.length) {
                if (vaule.integerValue>high.integerValue || vaule.integerValue < low.integerValue) {
                    if ([dic.allKeys containsObject:@"GROUP"]) {
                        [self.failItems addObject:dic[@"GROUP"]];
                    }
                }
            }
        }
        [dic setObject:elapse forKey:key_elapse];
        [dic setObject:vaule forKey:key_vaule];
        [dic setObject:message forKey:key_message];
        [dic setObject:result forKey:key_result];
    }
    
    [self.tableView reloadDataForRowIndexes:[NSIndexSet indexSetWithIndex:_stepIndex] columnIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.tableView.tableColumns.count)]];
    
    _stepIndex++;
}

- (IBAction)stopClick:(NSButton *)sender {
    _isStop = YES;
    
}

- (IBAction)resetClick:(NSButton *)sender {
    for (int i =0 ; i<self.originalDatas.count; i++) {
        NSMutableDictionary *dic = self.originalDatas[i];
        [dic setObject:@"0" forKey:key_debuging];
        [dic setObject:@"" forKey:key_elapse];
        [dic setObject:@"" forKey:key_result];
        [dic setObject:@"" forKey:key_vaule];
        [dic setObject:@"" forKey:key_message];
    }
    [self.failItems removeAllObjects];
    [self.tableView reloadData];
    _stepIndex=0;
}

- (IBAction)searchAction:(NSSearchField *)sender {
    
    NSString *content = sender.stringValue;
    NSLog(@"content %@",content);
    NSMutableArray *mutDatas = [NSMutableArray arrayWithArray:self.originalDatas];
    if (content.length) {
        NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
        NSInteger i =0;
        
        for (NSMutableDictionary *dic in mutDatas) {
            BOOL isContainSearch = NO;
            for (NSString *vaule in dic.allValues) {
                if ([vaule.uppercaseString containsString:content.uppercaseString]) {
                    
                    isContainSearch = YES;
                    break;
                }
            }
            if (!isContainSearch) {
                [indexSet addIndex:i];
            }
            
            i++;
        }
        [mutDatas removeObjectsAtIndexes:indexSet];
    }
    self.datas = mutDatas;
    [self.tableView reloadData];
    
}


- (NSPopover*)sharePopover
{
    if(!_sharePopover){
        _sharePopover = [[NSPopover alloc]init];
        ColumnVC *colVC =[[ColumnVC alloc]initWithTitles:self.columnTitles];
        colVC.reloadColumnBlock = ^(NSArray * _Nonnull titles) {
            [self reloadColumnsWithTitles:titles];
        };
        _sharePopover.contentViewController = colVC;
        _sharePopover.behavior = NSPopoverBehaviorTransient;

        //_sharePopover.appearance = NSPopoverAppearanceHUD;
        
    }
    return _sharePopover;
}
-(DebugSettingVC *)debugSettingVC{
    if (!_debugSettingVC) {
        _debugSettingVC=[DebugSettingVC new];
        _debugSettingVC.debugBtn = self.btnDebug;
        
    }
    return _debugSettingVC;
}

-(NSMutableArray *)failItems{
    if (!_failItems) {
        _failItems = [NSMutableArray array];
    }
    return _failItems;
}

@end
