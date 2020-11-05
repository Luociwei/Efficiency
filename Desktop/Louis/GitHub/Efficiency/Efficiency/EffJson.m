//
//  EffJson.m
//  EfficiencyLineChart
//
//  Created by ciwei luo on 2019/7/16.
//  Copyright © 2019 ciwei luo. All rights reserved.
//

#import "EffJson.h"
#import "parseCSV.h"//
#import "MyEexception.h"

static NSDictionary *effDict;

@implementation EffJson

+(id)effjsonWithFileName:(NSString *)file{
    EffJson *eff = [[EffJson alloc] init];
    NSDictionary *dict = [self getJsonDatasWithFileName:file];
    eff.efficiencyDirPath = dict[@"efficiencyDirPath"];
   // eff.fileKeyWord = dict[@"fileKeyWord"];
    eff.autoDraw = [dict[@"autoDraw"] boolValue];
    eff.checkTimeInterval = [dict[@"checkTimeInterval"] integerValue];
    eff.snPath =dict[@"snPath"];
//    eff.dict_5v =dict[@"efficiency_5v_itemsName"];
//    eff.dict_9v =dict[@"efficiency_9v_itemsName"];
//    eff.dict_12v =dict[@"efficiency_12v_itemsName"];
//    eff.dict_15v =dict[@"efficiency_15v_itemsName"];
//
//    eff.item_5v_500mA =eff.dict_5v[@"500mA"];
//    eff.item_5v_1000mA =eff.dict_5v[@"1000mA"];
//    eff.item_5v_2000mA =eff.dict_5v[@"2000mA"];
//    eff.item_5v_3000mA =eff.dict_5v[@"3000mA"];
//
//    eff.item_9v_500mA =eff.dict_9v[@"500mA"];
//    eff.item_9v_1000mA =eff.dict_9v[@"1000mA"];
//    eff.item_9v_2000mA =eff.dict_9v[@"2000mA"];
//    eff.item_9v_3000mA =eff.dict_9v[@"3000mA"];
//
//    eff.item_12v_500mA =eff.dict_12v[@"500mA"];
//    eff.item_12v_1000mA =eff.dict_12v[@"1000mA"];
//    eff.item_12v_2000mA =eff.dict_12v[@"2000mA"];
//    eff.item_12v_3000mA =eff.dict_12v[@"3000mA"];
//
//    eff.item_15v_500mA =eff.dict_15v[@"500mA"];
//    eff.item_15v_1000mA =eff.dict_15v[@"1000mA"];
//    eff.item_15v_2000mA =eff.dict_15v[@"2000mA"];
//    eff.item_15v_3000mA =eff.dict_15v[@"3000mA"];

    return eff;
}

//-(void)checkItemsName:(NSArray *)array{
//    [self checkItemsNameWithDict:self.dict_5v array:array];
//    [self checkItemsNameWithDict:self.dict_9v array:array];
//    [self checkItemsNameWithDict:self.dict_12v array:array];
//    [self checkItemsNameWithDict:self.dict_15v array:array];
//
//}

//-(void)checkItemsNameWithDict:(NSDictionary *)dict array:(NSArray *)array{
//    BOOL check = YES;
//    for (NSString *item in dict.allValues) {
//        if (![array containsObject:item]) {
//            check = NO;
//            [MyEexception RemindException:@"Check Fail" Information:[NSString stringWithFormat:@"not found the item:%@",item]];
//            [NSApp terminate:nil];
//        }
//    }
//}

+(id)getJsonDatasWithFileName:(NSString *)file{
    
    NSString *configfile = [[NSBundle mainBundle] pathForResource:file ofType:nil];
    // NSString *configfile = [[NSBundle mainBundle] pathForResource:@"Property List.plist" ofType:nil];
    
    //    NSString *desktopPath = [NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES)lastObject];
    //    NSString *eCodePath=[desktopPath stringByDeletingLastPathComponent];
    //    NSString *configfile=[eCodePath stringByAppendingPathComponent:@"pinList.json"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:configfile]) {
        [MyEexception RemindException:@"check fail" Information:@"not found file"];
        [NSApp terminate:nil];
       
    }
    NSString* items = [NSString stringWithContentsOfFile:configfile encoding:NSUTF8StringEncoding error:nil];
    if (items.length<10) {
        return nil;
    }
    NSData *data= [items dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    effDict = jsonObject;
    return jsonObject;
}

-(void)setEfficiencyDirPath:(NSString *)efficiencyDirPath{
    _efficiencyDirPath =efficiencyDirPath;
    if (![[NSFileManager defaultManager] fileExistsAtPath:efficiencyDirPath]) {
        [MyEexception RemindException:@"Check Fail" Information:[NSString stringWithFormat:@"Not found efficiency Dir Path:%@",efficiencyDirPath]];
        //[NSApp terminate:nil];
        
    }
}

@end
