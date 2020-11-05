//
//  ShowEffVC.m
//  MiniLineChart
//
//  Created by ciwei luo on 2019/7/11.
//  Copyright © 2019 ciwei luo. All rights reserved.
//

#import "ShowEffVC.h"
#import "Efficiency.h"
@interface ShowEffVC ()

@property(strong,nonatomic)NSMutableArray *datas;
@property (unsafe_unretained) IBOutlet NSTextView *effTextView;
@property(strong,nonatomic)NSMutableString *effString;

@end

@implementation ShowEffVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.title=@"Efficiency";
    [self.effTextView setString:self.effString];
}


-(instancetype)initWithDatas:(NSMutableArray *)datas{
    if (self=[super init]) {
        self.datas = datas;
        if (datas.count) {
            for (Efficiency *eff in datas) {
                [self.effString appendString:[NSString stringWithFormat:@"%@,",eff.product]];
                [self.effString appendString:[NSString stringWithFormat:@"%@,",eff.sn]];
                [self.effString appendString:[NSString stringWithFormat:@"%@,",eff.vaule_500mA_5V]];
                [self.effString appendString:[NSString stringWithFormat:@"%@,",eff.vaule_1000mA_5V]];
                [self.effString appendString:[NSString stringWithFormat:@"%@,",eff.vaule_2000mA_5V]];
                [self.effString appendString:[NSString stringWithFormat:@"%@,",eff.vaule_3000mA_5V]];
                [self.effString appendString:[NSString stringWithFormat:@"%@,",eff.vaule_500mA_9V]];
                [self.effString appendString:[NSString stringWithFormat:@"%@,",eff.vaule_1000mA_9V]];
                [self.effString appendString:[NSString stringWithFormat:@"%@,",eff.vaule_2000mA_9V]];
                [self.effString appendString:[NSString stringWithFormat:@"%@,",eff.vaule_3000mA_9V]];
                [self.effString appendString:[NSString stringWithFormat:@"%@,",eff.vaule_500mA_12V]];
                [self.effString appendString:[NSString stringWithFormat:@"%@,",eff.vaule_1000mA_12V]];
                [self.effString appendString:[NSString stringWithFormat:@"%@,",eff.vaule_2000mA_12V]];
                [self.effString appendString:[NSString stringWithFormat:@"%@,",eff.vaule_3000mA_12V]];
                [self.effString appendString:[NSString stringWithFormat:@"%@,",eff.vaule_500mA_15V]];
                [self.effString appendString:[NSString stringWithFormat:@"%@,",eff.vaule_1000mA_15V]];
                [self.effString appendString:[NSString stringWithFormat:@"%@,",eff.vaule_2000mA_15V]];
                [self.effString appendString:[NSString stringWithFormat:@"%@\n",eff.vaule_3000mA_15V]];

            }
        }
    }
    return self;
}


-(NSMutableString *)effString{
    if (!_effString) {

        _effString = [NSMutableString stringWithFormat:@"Product,SN,Charger LV_CurrentTrim Charger_efficiency_500mA@5V,Charger LV_CurrentTrim Charger_efficiency_1000mA@5V,Charger LV_CurrentTrim Charger_efficiency_2100mA@5V,Charger LV_CurrentTrim Charger_efficiency_3000mA@5V,Charger 9V_CurrentTrim Charger_efficiency_500mA@9V,Charger 9V_CurrentTrim Charger_efficiency_1000mA@9V,Charger 9V_CurrentTrim Charger_efficiency_2000mA@9V,Charger 9V_CurrentTrim Charger_efficiency_3000mA@9V,harger 12V_CurrentTrim Charger_efficiency_500mA@12V,Charger 12V_CurrentTrim Charger_efficiency_1000mA@12V,Charger 12V_CurrentTrim Charger_efficiency_2000mA@12V,Charger HCCM_TopOff Charger_efficiency_3000mA@12V,Charger 15V_CurrentTrim Charger_efficiency_500mA@15V,Charger 15V_CurrentTrim Charger_efficiency_1000mA@15V,Charger 15V_CurrentTrim Charger_efficiency_2000mA@15V,harger HCCM_ACCL Charger_efficiency_3000mA@15V\n"];
//        _effString = [NSMutableString stringWithFormat:@"Product,SN,Eff_500mA_5V,Eff_1000mA_5V,Eff_2000mA_5V,Eff_3000mA_5V,Eff_500mA_9V,Eff_1000mA_9V,Eff_2000mA_9V,Eff_3000mA_9V,Eff_500mA_12V,Eff_1000mA_12V,Eff_2000mA_12V,Eff_3000mA_12V,Eff_500mA_15V,Eff_1000mA_15V,Eff_2000mA_15V,Eff_3000mA_15V\n"];
    }
    return _effString;
}



@end
