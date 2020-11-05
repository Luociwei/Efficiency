//
//  ViewController.m
//  MiniLineChart
//
//  Created by ciwei luo on 2019/7/10.
//  Copyright © 2019 ciwei luo. All rights reserved.
//

#import "ViewController.h"
#import "LineView.h"
#import "parseCSV.h"
#import "Efficiency.h"
#import "ShowEffVC.h"
#import "EffJson.h"
#import "MyEexception.h"

@interface ViewController ()

@property (weak) IBOutlet LineView *lineView;
@property (weak) IBOutlet NSTextField *snLabel;
@property (weak) IBOutlet NSButton *roundbtn;
@property (weak) IBOutlet NSTextField *effPathLabel;
@property (weak) IBOutlet NSButton *loadBtn;

@property(strong)NSMutableArray *effArray;
@property(strong,nonatomic)EffJson *effJson;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.effArray = [NSMutableArray array];
    //    self.scrollView.documentView=self.lineView;
    
    self.effJson = [EffJson effjsonWithFileName:@"efficiency.json"];
    if (self.effJson.autoDraw) {
        [self updateEffLine];
    }else{
        NSString *resourcePath = [NSBundle mainBundle].resourcePath;
        NSString *configPath=[resourcePath stringByAppendingPathComponent:@"Default_Efficiency.txt"];
        [self loadCsvFile:configPath];
        [self.loadBtn setHidden:NO];
        
    }
    
    [self.effPathLabel setStringValue:[NSString stringWithFormat:@"EfficiencyFilePath:%@",self.effJson.efficiencyDirPath]];
    //  [self.view addSubview:self.lineView];
    // Do view setup here.
}

-(void)updateEffLine{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        while (YES) {
            
            NSString *configPath =self.effJson.efficiencyDirPath;//efficiencyDict[@"efficiencyDirPath"];
            
            [self loadCsvFile:configPath];
            [self updateSN];
            NSInteger sleep =self.effJson.checkTimeInterval;
            [NSThread sleepForTimeInterval:sleep];
        }
        
    });
    
}

-(void)updateSN{
    //    NSFileManager *fileM = [NSFileManager defaultManager];
    //    if (![fileM fileExistsAtPath:self.effJson.snPath]) {
    //        [MyEexception RemindException:@"Check Fail" Information:[NSString stringWithFormat:@"Not found the sn file"]];
    //
    //    }
    NSString *content = [NSString stringWithContentsOfFile:self.effJson.snPath encoding:NSUTF8StringEncoding error:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.snLabel setStringValue:[NSString stringWithFormat:@"SN:%@",content]];
        
    });
    
    
}


- (IBAction)btnClick:(id)sender {
   // self.lineView.datas = @[@"80",@"90",@"85",];
   // [self.lineView showLine];
    
    NSOpenPanel *openPanel=[NSOpenPanel openPanel];
    
    NSString *openPath = [NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES)lastObject];
    [openPanel setDirectoryURL:[NSURL fileURLWithPath:openPath]];
    
    NSArray *fileType=[NSArray arrayWithObjects:@"csv",nil];
    [openPanel setAllowedFileTypes:fileType];
    ;
    [openPanel setCanChooseFiles:YES];
    [openPanel setAllowsMultipleSelection:NO];
    [openPanel setPrompt:@"Choose"];
    [openPanel beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse result) {
        NSArray *urls=[openPanel URLs];
        if (urls.count) {
            NSString *csvPath = [[urls objectAtIndex:0] path];
            [self loadCsvFile:csvPath];
        }
        
        
//        for (int i=0; i<[urls count]; i++)
//        {
//            NSString *csvPath = [[urls objectAtIndex:i] path];
//        }
    }];

        
   
}
- (IBAction)changeFrame:(id)sender {
    self.lineView.frame = NSMakeRect(0, 0, 660, 1260);
  
    NSRect bounds = NSMakeRect(NSMinX(self.scrollView.contentView.bounds),
                               400,
                               NSWidth(self.scrollView.contentView.bounds),
                               NSHeight(self.scrollView.contentView.bounds));
    [self.scrollView.contentView setValue:@(bounds) forKey:@"bounds"];
    
}
- (IBAction)changeFrame2:(id)sender {
    self.lineView.frame = NSMakeRect(0, 0, 660, 660);

    NSRect bounds = NSMakeRect(NSMinX(self.scrollView.contentView.bounds),
                               0,
                               NSWidth(self.scrollView.contentView.bounds),
                               NSHeight(self.scrollView.contentView.bounds));
    [self.scrollView.contentView setValue:@(bounds) forKey:@"bounds"];
}

- (IBAction)showEff:(id)sender {
    if (!_effArray.count) {
        return;
    }
    ShowEffVC *effVC=[[ShowEffVC alloc]initWithDatas:self.effArray];
    [self presentViewControllerAsModalWindow:effVC];
}


-(void)loadCsvFile:(NSString *)configPath{
    
    NSFileManager *file = [NSFileManager defaultManager];
    if (![file fileExistsAtPath:configPath]) {
    
//        [MyEexception RemindException:@"Check Fail" Information:[NSString stringWithFormat:@"Not found the efficiency file"]];
//        [NSApp terminate:nil];
    
        return;
        
    }
    NSString *content = [NSString stringWithContentsOfFile:configPath encoding:NSUTF8StringEncoding error:nil];
    if (content.length) {
        if ([content hasSuffix:@","]) {
            content = [content substringToIndex:content.length-1];
        }
    }
    NSArray *array = [content componentsSeparatedByString:@","];
    self.lineView.datas = array;
    
}

@end
