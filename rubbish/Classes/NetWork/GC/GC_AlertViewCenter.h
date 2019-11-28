//
//  AlertViewCenter.h
//  Lottery
//
//  Created by Teng Kiefer on 12-2-19.
//  Copyright (c) 2012年 windo-soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GC_AlertViewCenter : NSObject <UIAlertViewDelegate>

+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle;

@end
