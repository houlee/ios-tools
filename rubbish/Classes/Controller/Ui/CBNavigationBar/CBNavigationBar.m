//
//  CBNavigationBar.m
//  caibo
//
//  Created by jacob on 11-5-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CBNavigationBar.h"


@implementation UINavigationBar(customBar)


-(void)drawRect:(CGRect)rect
{

    
#ifdef  isCaiPiaoForIPad
    UIImage *image = UIImageGetImageFromName(@"daohangimage.png");
#else
    UIImage *image = UIImageGetImageFromName(@"NavBackImage.png");
#endif
	
	
	[image drawInRect:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height)];
	

}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    