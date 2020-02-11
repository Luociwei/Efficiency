//
//  PinBox.h
//  SearchPinVC
//
//  Created by ciwei luo on 2019/6/27.
//  Copyright © 2019 ciwei luo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface PinBox : NSBox
@property(nonatomic,strong)NSButton *btn;
-(void)highLight;
-(void)setTitleStirng:(NSString *)str;
@property(nonatomic,strong)CWTextLabel *label;
@end

NS_ASSUME_NONNULL_END
