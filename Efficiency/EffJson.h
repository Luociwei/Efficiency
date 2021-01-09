//
//  EffJson.h
//  EfficiencyLineChart
//
//  Created by ciwei luo on 2019/7/16.
//  Copyright © 2019 ciwei luo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EffJson : NSObject
+(id)getJsonDatasWithFileName:(NSString *)file;
+(id)effjsonWithFileName:(NSString *)file;
@property (nonatomic, copy) NSString *efficiencyDirPath;
//@property (copy) NSString *fileKeyWord;
@property  NSInteger checkTimeInterval;
@property  BOOL autoDraw;
@property (nonatomic, copy) NSString *snPath;
//@property (copy) NSString *item_5v_500mA;
//@property (copy) NSString *item_5v_1000mA;
//@property (copy) NSString *item_5v_2000mA;
//@property (copy) NSString *item_5v_3000mA;
//
//@property (copy) NSString *item_9v_500mA;
//@property (copy) NSString *item_9v_1000mA;
//@property (copy) NSString *item_9v_2000mA;
//@property (copy) NSString *item_9v_3000mA;
//
//@property (copy) NSString *item_12v_500mA;
//@property (copy) NSString *item_12v_1000mA;
//@property (copy) NSString *item_12v_2000mA;
//@property (copy) NSString *item_12v_3000mA;
//
//@property (copy) NSString *item_15v_500mA;
//@property (copy) NSString *item_15v_1000mA;
//@property (copy) NSString *item_15v_2000mA;
//@property (copy) NSString *item_15v_3000mA;
//
//@property (copy) NSDictionary *dict_5v;
//@property (copy) NSDictionary *dict_9v;
//@property (copy) NSDictionary *dict_12v;
//@property (copy) NSDictionary *dict_15v;
//
//-(void)checkItemsName:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
