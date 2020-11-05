//
//  Efficiency.h
//  MiniLineChart
//
//  Created by ciwei luo on 2019/7/10.
//  Copyright © 2019 ciwei luo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Efficiency : NSObject
@property(copy)NSString *product;
@property(copy)NSString *sn;
@property(nonatomic,copy)NSString *vaule_500mA_5V;
@property(nonatomic,copy)NSString *vaule_1000mA_5V;
@property(nonatomic,copy)NSString *vaule_2000mA_5V;
@property(nonatomic,copy)NSString *vaule_3000mA_5V;

@property(nonatomic,copy)NSString *vaule_500mA_9V;
@property(nonatomic,copy)NSString *vaule_1000mA_9V;
@property(nonatomic,copy)NSString *vaule_2000mA_9V;
@property(nonatomic,copy)NSString *vaule_3000mA_9V;

@property(nonatomic,copy)NSString *vaule_500mA_12V;
@property(nonatomic,copy)NSString *vaule_1000mA_12V;
@property(nonatomic,copy)NSString *vaule_2000mA_12V;
@property(nonatomic,copy)NSString *vaule_3000mA_12V;

@property(nonatomic,copy)NSString *vaule_500mA_15V;
@property(nonatomic,copy)NSString *vaule_1000mA_15V;
@property(nonatomic,copy)NSString *vaule_2000mA_15V;
@property(nonatomic,copy)NSString *vaule_3000mA_15V;

@end

NS_ASSUME_NONNULL_END
