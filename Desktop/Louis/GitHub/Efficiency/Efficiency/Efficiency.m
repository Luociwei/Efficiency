//
//  Efficiency.m
//  MiniLineChart
//
//  Created by ciwei luo on 2019/7/10.
//  Copyright © 2019 ciwei luo. All rights reserved.
//

#import "Efficiency.h"
#import "MyEexception.h"
#import "parseCSV.h"//
@implementation Efficiency

-(void)setVaule_500mA_5V:(NSString *)vaule_500mA_5V{
    _vaule_500mA_5V = vaule_500mA_5V;
    [self checkVaule:_vaule_500mA_5V itemName:@"500mA_5V"];
   
}
-(void)setVaule_1000mA_5V:(NSString *)vaule_1000mA_5V{
    _vaule_1000mA_5V = vaule_1000mA_5V;
    [self checkVaule:_vaule_1000mA_5V itemName:@"1000mA_5V"];
}
-(void)setVaule_2000mA_5V:(NSString *)vaule_2000mA_5V{
    _vaule_2000mA_5V = vaule_2000mA_5V;
    [self checkVaule:_vaule_2000mA_5V itemName:@"2000mA_5V"];
    
}

-(void)setVaule_3000mA_5V:(NSString *)vaule_3000mA_5V{
    _vaule_3000mA_5V = vaule_3000mA_5V;
    [self checkVaule:_vaule_3000mA_5V itemName:@"3000mA_5V"];
}

-(void)setVaule_500mA_9V:(NSString *)vaule_500mA_9V{
    _vaule_500mA_9V = vaule_500mA_9V;
    [self checkVaule:_vaule_500mA_9V itemName:@"500mA_9V"];
    
}
-(void)setVaule_1000mA_9V:(NSString *)vaule_1000mA_9V{
    _vaule_1000mA_9V = vaule_1000mA_9V;
    [self checkVaule:_vaule_1000mA_9V itemName:@"1000mA_9V"];
}
-(void)setVaule_2000mA_9V:(NSString *)vaule_2000mA_9V{
    _vaule_2000mA_9V = vaule_2000mA_9V;
    [self checkVaule:_vaule_2000mA_9V itemName:@"2000mA_9V"];
}

-(void)setVaule_3000mA_9V:(NSString *)vaule_3000mA_9V{
    _vaule_3000mA_9V = vaule_3000mA_9V;
    [self checkVaule:_vaule_3000mA_9V itemName:@"3000mA_9V"];
}


-(void)setVaule_500mA_12V:(NSString *)vaule_500mA_12V{
    _vaule_500mA_12V = vaule_500mA_12V;
    [self checkVaule:_vaule_500mA_12V itemName:@"500mA_12V"];
}
-(void)setVaule_1000mA_12V:(NSString *)vaule_1000mA_12V{
    _vaule_1000mA_12V = vaule_1000mA_12V;
    [self checkVaule:_vaule_1000mA_12V itemName:@"1000mA_12V"];
}
-(void)setVaule_2000mA_12V:(NSString *)vaule_2000mA_12V{
    _vaule_2000mA_12V = vaule_2000mA_12V;
    [self checkVaule:_vaule_2000mA_12V itemName:@"2000mA_12V"];
}

-(void)setVaule_3000mA_12V:(NSString *)vaule_3000mA_12V{
    _vaule_3000mA_12V = vaule_3000mA_12V;
    [self checkVaule:_vaule_3000mA_12V itemName:@"3000mA_12V"];
}
-(void)setVaule_500mA_15V:(NSString *)vaule_500mA_15V{
    _vaule_500mA_15V = vaule_500mA_15V;
    [self checkVaule:_vaule_500mA_15V itemName:@"500mA_15V"];
    
}
-(void)setVaule_1000mA_15V:(NSString *)vaule_1000mA_15V{
    _vaule_1000mA_15V = vaule_1000mA_15V;
    [self checkVaule:_vaule_1000mA_15V itemName:@"1000mA_15V"];
}
-(void)setVaule_2000mA_15V:(NSString *)vaule_2000mA_15V{
    _vaule_2000mA_15V = vaule_2000mA_15V;
    [self checkVaule:_vaule_2000mA_15V itemName:@"2000mA_15V"];
}

-(void)setVaule_3000mA_15V:(NSString *)vaule_3000mA_15V{
    _vaule_3000mA_15V = vaule_3000mA_15V;
    [self checkVaule:_vaule_3000mA_15V itemName:@"3000mA_15V"];
}

-(void)checkVaule:(NSString *)vaule itemName:(NSString *)item{
    NSInteger num =[vaule integerValue];
    if (num<=0 || num>=100) {
        [MyEexception RemindException:@"Check Fail" Information:[NSString stringWithFormat:@"%@:%@",item,vaule]];
       [NSApp terminate:nil];
    }
}

@end

