//
//  CWTextLable.h
//  SearchPinTool
//
//  Created by ciwei luo on 2019/6/30.
//  Copyright © 2019 macdev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_OPTIONS(NSUInteger, CWTextLabelType) {
    
    CWTextLabelTypeLine  = 1,
    
    
    CWTextLabelTypeCummon  =   2
    
};

NS_ASSUME_NONNULL_BEGIN

@interface CWTextLabel : NSTextField

@end

NS_ASSUME_NONNULL_END
