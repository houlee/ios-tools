//
//  YDDebugTool.h
//  caibo
//
//  Created by hu jian on 11-6-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "YDUtil.h"

#define _DEBUG_
#ifdef _DEBUG_
//_IPHONE_
#define YD_LOG(...)		NSLog(__VA_ARGS__)
#define YD_LOGRECT(r)	NSLog(@"(%.1fx%.1f)-(%.1fx%.1f)", r.origin.x, r.origin.y, r.size.width, r.size.height)
#define YD_FUNNAME		NSLog(@"Func Name:%@",NSStringFromSelector(_cmd))
#define YD_LOGFUN		NSLog(@"Class Name:%@##%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd))
#define verbose 1   
#define YD_MEM          {double mem = [YDUtil availableMemory]; \
                        YD_LOG(@"mem2---: %f" , mem);}

#else
#define YD_LOG(...)  
#define YD_LOGRECT(r)
#define YD_LOGFUN
#define YD_FUNNAME
#define verbose 0
#define YD_MEM          
#endif