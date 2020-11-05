//
//  LineView.h
//  MiniLineChart
//
//  Created by ciwei luo on 2019/7/10.
//  Copyright © 2019 ciwei luo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN



@interface LineView : NSView
-(void)layoutViews;
-(void)showLine;
@property (strong,nonatomic)NSArray *datas;


@end

NS_ASSUME_NONNULL_END
