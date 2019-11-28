//
//  DataUtils.h
//  caibo
//
//  Created by jacob on 11-6-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataUtils : NSObject {
	

}


// 计算 cell 的高度，用来 去定  tableViewCell 的 高度
+(CGFloat)CellHeigth:(NSString*)messageText messageFontSize:(CGFloat)mFontSize originText:(NSString*)originText originTextFontSize:(CGFloat)oFontSize;

+(CGFloat)textWidth:(NSString*)text Fontsize:(CGFloat)mFontSize;


@end
