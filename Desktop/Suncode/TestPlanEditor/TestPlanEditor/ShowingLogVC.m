//
//  ShowingLogVC.m
//  TestPlanEditor
//
//  Created by ciwei luo on 2020/1/17.
//  Copyright © 2020 macdev. All rights reserved.
//

#import "ShowingLogVC.h"
#import <CWGeneralManager/NSString+Extension.h>

@interface ShowingLogVC ()
@property (copy,nonatomic)NSMutableString *mutLogString;
@property (unsafe_unretained) IBOutlet NSTextView *logTextView;

@end

@implementation ShowingLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mutLogString = [NSMutableString string];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showLog:)
                                                 name:@"ShowingLogVCWillPrintLog"
                                               object:nil];
    // Do view setup here.
}


+(void)postNotificationWithLog:(NSString *)log type:(NSString *)type{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:log forKey:@"log"];
    [dic setObject:type forKey:@"type"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowingLogVCWillPrintLog" object:nil userInfo:dic];
}


-(void)showLog:(NSNotification *)notification
{
    NSDictionary *dic = [notification userInfo];
    NSString *log = [dic objectForKey:@"log"];
    NSString *type = [dic objectForKey:@"type"];
    NSString *timeString = [NSString cw_stringFromCurrentDateTimeWithMicrosecond];
    [self.mutLogString appendString:[NSString stringWithFormat:@"%@ %@ %@\n",timeString,type,log]];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.logTextView.string = self.mutLogString;
    });
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
