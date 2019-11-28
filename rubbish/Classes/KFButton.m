//
//  KFButton.m
//  caibo
//
//  Created by houchenguang on 12-11-20.
//
//

#import "KFButton.h"
#import "QuartzCore/QuartzCore.h"
#import "caiboAppDelegate.h"
#import "KFMessageBoxView.h"
#import "GCSearchViewController.h"
#import "Info.h"
#import "LoginViewController.h"
#import "MobClick.h"

@implementation KFButton
@synthesize markImage;
//@synthesize newkfbool;

#pragma mark 显示数目 或 箭头

- (void)setNewkfbool:(BOOL)_newkfbool{
    newkfbool = _newkfbool;
    
    if (_newkfbool) {
        markImage.frame = CGRectMake(152, 19, 8, 8);
        jiantouimage.hidden = YES;
    }else{
        markImage.frame = CGRectMake(142, 19, 8, 8);
         jiantouimage.hidden = NO;
    }
}
- (BOOL)newkfbool{

    return newkfbool;
}


- (void)setShow:(BOOL)_show{
    show = _show;
    
    
    if (show) {
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(calloff) object:self];
        [self performSelector:@selector(calloff) withObject:self afterDelay:10];
//        markImage.image = UIImageGetImageFromName(@"");
//        markImage.frame = CGRectMake(0, 0, 0, 0);
    }else{
         [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(calloff) object:self];
        [self performSelector:@selector(calloff) withObject:self afterDelay:4];
//        markImage.image = UIImageGetImageFromName(@"");
//        markImage.frame = CGRectMake(0, 0, 0, 0);
    
    }

}

- (BOOL)show{
    return show;
}


- (BOOL)markbool{
    return markbool;
}

- (void)setMarkbool:(BOOL)_markbool{
    markbool = _markbool;
    if (markbool) {
        markImage.hidden = NO;
    }else{
        markImage.hidden = YES;
    }
    
}


#pragma mark 动画显示和消失 箭头按钮
- (void)callShow{
    self.frame = CGRectMake(-127, 303, 173, 48);
    [UIView beginAnimations:@"ndd" context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.alpha = 1;
    [UIView commitAnimations];
}

- (void)calloff{
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.alpha = 0;
   
    
    [UIView commitAnimations];
     self.frame = CGRectMake(-173, 303, 173, 48);
}
- (void)beginShow{

    [self performSelector:@selector(calloff) withObject:self afterDelay:10];
}

#pragma mark 初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        markbool = NO;
        newkfbool = NO;
        self.userInteractionEnabled = YES;
      //  self.frame = CGRectMake(0, 310, 157, 48);
        self.image = UIImageGetImageFromName(@"XZXTK960chang.png");//(@"XZXTK960.png");
        self.backgroundColor = [UIColor clearColor];
        
        
        
        markImage = [[UIImageView alloc] initWithFrame:CGRectMake(142, 19, 8, 8)];//(15, 19, 8, 8)  31 173-31=142
        markImage.backgroundColor = [UIColor clearColor];
        markImage.image = UIImageGetImageFromName(@"hq960.png");
        [self addSubview:markImage];
        
        
        jiantouimage = [[UIImageView alloc] initWithFrame:CGRectMake(152, 15, 16, 15)];//(25, 15, 16, 15) 21 173-21 = 152
        jiantouimage.image = UIImageGetImageFromName(@"jiantouyou.png");
        jiantouimage.backgroundColor = [UIColor clearColor];
        [self addSubview:jiantouimage];
        [jiantouimage release];
        
             
        
    }
    return self;
}
#pragma mark 取消阴影
- (void)chulaitiao{
    self.alpha = 1;
     self.frame = CGRectMake(-173, 303, 173, 48);
    [UIView beginAnimations:@"800" context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.frame = CGRectMake(-127, 303, 173, 48);
    
    
    [UIView commitAnimations];
}

- (void)guanxingoff{
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(calloff) object:self];
    [self chulaitiao];
    if (newkfbool) {
        [self setShow:YES];
        
    }else{
        [self setShow:NO];
    }
    if (newkfbool) {
       markImage.frame = CGRectMake(152, 19, 8, 8);
        jiantouimage.hidden = YES;
    }else{
       markImage.frame = CGRectMake(142, 19, 8, 8);
        jiantouimage.hidden = NO;
    }
    [bgview removeFromSuperview];
    
}
#pragma mark 按钮出现 和 消失 动画
- (void)tiaoxiaoshi{
    self.alpha = 1;
    [UIView beginAnimations:@"100" context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.frame = CGRectMake(-173, 303, 173, 48);
    
    
    [UIView commitAnimations];
    
}

- (void)tingliushouqi{
    [self performSelector:@selector(tiaoxiaoshi) withObject:self afterDelay:0.1];
}

- (void)donghuahoufunc{
    kefulabel.hidden = NO;
    searchlabel.hidden = NO;
    if (newkfbool) {
        newkfimage.hidden = NO;
    }else{
        newkfimage.hidden = YES;
    }
    if (newkfbool) {
        markImage.frame = CGRectMake(152, 19, 8, 8);
        jiantouimage.hidden = YES;
    }else{
       markImage.frame = CGRectMake(142, 19, 8, 8);
        jiantouimage.hidden = NO;
    }

}

- (void)guanxing{
//    [UIView beginAnimations:@"020" context:NULL];
//    [UIView setAnimationDuration:0.03];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    //    [UIView setAnimationDelegate:self];
//    //    [UIView setAnimationDidStopSelector:@selector(guanxing)];
//    searchbutton.frame = CGRectMake(120, 310, 35, 36);
//    kfbutton.frame = CGRectMake(75, 310, 35, 36);
//    [UIView commitAnimations];

    
    CAKeyframeAnimation *keyAn2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	[keyAn2 setDuration:0.4f];
	NSArray *array2 = [[NSArray alloc] initWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(searchbutton.center.x, searchbutton.center.y)],
                       [NSValue valueWithCGPoint:CGPointMake(searchbutton.center.x+20, searchbutton.center.y)],
                       [NSValue valueWithCGPoint:CGPointMake(searchbutton.center.x, searchbutton.center.y)],
                       [NSValue valueWithCGPoint:CGPointMake(searchbutton.center.x+1, searchbutton.center.y)],
                       [NSValue valueWithCGPoint:CGPointMake(searchbutton.center.x, searchbutton.center.y)],
                      // [NSValue valueWithCGPoint:CGPointMake(searchbutton.center.x, searchbutton.center.y)],
                       nil];
	[keyAn2 setValues:array2];
	[array2 release];
	NSArray *times2 = [[NSArray alloc] initWithObjects:
                       [NSNumber numberWithFloat:0.00f],
                       [NSNumber numberWithFloat:0.2f],
                       [NSNumber numberWithFloat:0.3f],
                       [NSNumber numberWithFloat:0.35f],
                       [NSNumber numberWithFloat:0.4f],
                       //[NSNumber numberWithFloat:0.3f],
                       


                       
                       nil];
	[keyAn2 setKeyTimes:times2];
	[times2 release];
	[searchbutton.layer addAnimation:keyAn2 forKey:@"searchbutton"];
    
    
    CAKeyframeAnimation *keyAn = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	[keyAn setDuration:0.4f];
	NSArray *array = [[NSArray alloc] initWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(kfbutton.center.x, kfbutton.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(kfbutton.center.x+20, kfbutton.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(kfbutton.center.x, kfbutton.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(kfbutton.center.x+1, kfbutton.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(kfbutton.center.x, kfbutton.center.y)],
                     //  [NSValue valueWithCGPoint:CGPointMake(kfbutton.center.x, kfbutton.center.y)],
                       nil];
	[keyAn setValues:array];
	[array release];
	NSArray *times = [[NSArray alloc] initWithObjects:
                      [NSNumber numberWithFloat:0.01f],
                      [NSNumber numberWithFloat:0.2f],
                      [NSNumber numberWithFloat:0.3f],
                      [NSNumber numberWithFloat:0.35f],
                      [NSNumber numberWithFloat:0.4f],




                      
                       nil];
	[keyAn setKeyTimes:times];
	[times release];
	[kfbutton.layer addAnimation:keyAn forKey:@"searchbutton"];
    
    [self performSelector:@selector(donghuahoufunc) withObject:self afterDelay:0.4];
       
}



- (void)buttonShow{
    
    [UIView beginAnimations:@"200" context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(tingliushouqi)];
    self.frame = CGRectMake(-86, 303, 173, 48);
    
   
    [UIView commitAnimations];

    
    
    
    
    [UIView beginAnimations:@"000" context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(guanxing)];
        searchbutton.frame = CGRectMake(135, 310, 35, 35);
        kfbutton.frame = CGRectMake(75, 310, 35, 35);
    [UIView commitAnimations];
    
    
    
    CABasicAnimation* rotationAnimation =
    
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    
    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 15];
    
    rotationAnimation.duration = 0.5f;
    
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [searchbutton.layer addAnimation:rotationAnimation forKey:@"run"];
    
    
    CABasicAnimation* rotationAnimation2 =
    
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    
    rotationAnimation2.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 15];
    
    rotationAnimation2.duration = 0.5f;
    
    rotationAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [kfbutton.layer addAnimation:rotationAnimation2 forKey:@"run"];
    
 
    
    

   
}



#pragma mark 按下触发事件


- (void)pressBgButton:(UIButton *)sender{
    kefulabel.hidden = YES;
    searchlabel.hidden = YES;
    newkfimage.hidden = YES;
    
    
    
    
    kefulabel.alpha = 0;
    searchlabel.alpha = 0;
    newkfimage.alpha = 0;
    
    
    [UIView beginAnimations:@"001" context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(guanxingoff)];
    searchbutton.frame = CGRectMake(-35, 310, 35, 35);
    kfbutton.frame = CGRectMake(-35, 310, 35, 35);
    [UIView commitAnimations];
    
    
    
    CABasicAnimation* rotationAnimation =
    
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    
    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 10];
    
    rotationAnimation.duration = 0.4f;
    
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [searchbutton.layer addAnimation:rotationAnimation forKey:@"run"];
    
    
    CABasicAnimation* rotationAnimation2 =
    
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    
    rotationAnimation2.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 10];
    
    rotationAnimation2.duration = 0.4f;
    
    rotationAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [kfbutton.layer addAnimation:rotationAnimation2 forKey:@"run"];

    
    
    
}

#pragma mark 按下触发事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"press image button!!!!!");
    caiboAppDelegate * caiboapp = [caiboAppDelegate getAppDelegate];
    
    if (!bgview) {
        bgview = [[UIView alloc] initWithFrame:caiboapp.window.bounds];
    }
        bgview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        UIButton * bgbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgbutton.frame = caiboapp.window.bounds;
        [bgbutton addTarget:self action:@selector(pressBgButton:) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:bgbutton];
    
    
    if (!kfbutton) {
        kfbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
        kfbutton.frame = CGRectMake(-35, 310, 35, 35);
    [kfbutton setImage:UIImageGetImageFromName(@"XKF960.png") forState:UIControlStateNormal];
        [kfbutton addTarget:self action:@selector(pressKfbutton:) forControlEvents:UIControlEventTouchUpInside];
    kfbutton.alpha = 1;
//        UIImageView * butimage = [[UIImageView alloc] initWithFrame:kfbutton.bounds];
//        butimage.image = UIImageGetImageFromName(@"XKF960.png");
//       // butimage.userInteractionEnabled = YES;
//        butimage.backgroundColor = [UIColor clearColor];
//        [kfbutton addSubview:butimage];
//        [butimage release];
        
    
   
    if (!searchbutton) {
        searchbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
        searchbutton.frame = CGRectMake(-35, 310, 35, 35);
    searchbutton.alpha = 1;
    [searchbutton setImage:UIImageGetImageFromName(@"XSS960.png") forState:UIControlStateNormal];
        [searchbutton addTarget:self action:@selector(presssearchbutton:) forControlEvents:UIControlEventTouchUpInside];
//        UIImageView * searchimage = [[UIImageView alloc] initWithFrame:searchbutton.bounds];
//        searchimage.image = UIImageGetImageFromName(@"XSS960.png");
//       // searchimage.userInteractionEnabled = YES;
//        searchimage.backgroundColor = [UIColor clearColor];
//        [searchbutton addSubview:searchimage];
//        [searchimage release];
    
    
    if (!kefulabel) {
        kefulabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 345, 35, 20)];
    }
    kefulabel.backgroundColor = [UIColor clearColor];
    kefulabel.text = @"客服";
    kefulabel.textColor = [UIColor whiteColor];
    kefulabel.font = [UIFont systemFontOfSize:12];
    kefulabel.textAlignment = NSTextAlignmentCenter;
    kefulabel.hidden = YES;
    kefulabel.alpha = 1;
    
    if (!searchlabel) {
        searchlabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 345, 35, 20)];
    }
    searchlabel.backgroundColor = [UIColor clearColor];
    searchlabel.text = @"搜索";
    searchlabel.textColor = [UIColor whiteColor];
    searchlabel.font = [UIFont systemFontOfSize:12];
    searchlabel.textAlignment = NSTextAlignmentCenter;
    searchlabel.hidden = YES;
    searchlabel.alpha = 1;
    
    
    if (!newkfimage) {
        newkfimage = [[UIImageView alloc] initWithFrame:CGRectMake(105, 306, 8, 8)];
    }
    newkfimage.image = UIImageGetImageFromName(@"hq960.png");
    newkfimage.backgroundColor = [UIColor clearColor];
    newkfimage.alpha = 1;
    newkfimage.hidden = YES;
    
    
    
    [bgview addSubview:kfbutton];
    [bgview addSubview:searchbutton];
    [bgview addSubview:kefulabel];
    [bgview addSubview:searchlabel];
    [bgview addSubview:newkfimage];
    [caiboapp.window addSubview:bgview];
    
    
    
    [self buttonShow];
    
    
    
}


#pragma mark 按钮点击事件
- (void)presssearchbutton:(UIButton *)sender{
    searchbutton.frame = CGRectMake(135, 310, 35, 35);
    kfbutton.frame = CGRectMake(75, 310, 35, 35);
    [UIView beginAnimations:@"002" context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(searchbuttonbig)];
    
    
    searchbutton.frame = CGRectMake(125, 300, 55, 55);
    kfbutton.frame = CGRectMake(92, 328, 0, 0);
    searchbutton.alpha = 0;
    kfbutton.alpha = 0;
    kefulabel.alpha = 0;
    searchlabel.alpha = 0;
    newkfimage.alpha = 0;
       
     [searchbutton.layer setMasksToBounds:YES];
    [kfbutton.layer setMasksToBounds:YES];
    
    
    [UIView commitAnimations];

}

- (void)pressKfbutton:(UIButton *)sender{
    [MobClick event:@"event_kefu"];
    searchbutton.frame = CGRectMake(135, 310, 35, 35);
    kfbutton.frame = CGRectMake(75, 310, 35, 35);
    [UIView beginAnimations:@"003" context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(kfbuttonbig)];
    
    
    searchbutton.frame = CGRectMake(135, 328, 0, 0);
    kfbutton.frame = CGRectMake(65, 300, 55, 55);
    searchbutton.alpha = 0;
    kfbutton.alpha = 0;
    kefulabel.alpha = 0;
    searchlabel.alpha = 0;
    newkfimage.alpha = 0;
    [searchbutton.layer setMasksToBounds:YES];
    [kfbutton.layer setMasksToBounds:YES];

    
    [UIView commitAnimations];


}


- (void)kfbuttonbig{
   
//   caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
//
//    [bgview removeFromSuperview];
//    kefulabel.hidden = YES;
//    searchlabel.hidden = YES;
//    newkfimage.hidden = YES;
//    markbool = NO;
//    newkfbool = NO;
//    
//    
//    if (newkfbool) {
//        
//        markImage.frame = CGRectMake(152, 19, 8, 8);
//        markImage.hidden = YES;
//        jiantouimage.hidden = YES;
//    }else{
//        markImage.frame = CGRectMake(142, 19, 8, 8);
//        jiantouimage.hidden = NO;
//        markImage.hidden = YES;
//    }
//
//    Info *info = [Info getInstance];
//    if ([info.userId intValue]) {
//        
//        
//        if (!msgbox) {
//            msgbox = [[KFMessageBoxView alloc] initWithFrame:app.window.bounds];
//        }
//        msgbox.showBool = YES;
//        
//        [msgbox tsInfo];//调用提示信息
//        
//        //if (newkfbool) {
//        msgbox.newBool = newkfbool;
//        [msgbox returnSiXinCount];
//       // }
//        newkfbool = NO;
//        if (newkfbool) {
//           markImage.frame = CGRectMake(152, 19, 8, 8);
//            jiantouimage.hidden = YES;
//            markImage.hidden = YES;
//        }else{
//           markImage.frame = CGRectMake(142, 19, 8, 8);
//            jiantouimage.hidden = NO;
//            markImage.hidden = YES;
//        }
//
//        [app.window addSubview:msgbox];
//        
//        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"]) {
//            NSDictionary * chekdict = [[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"];
//            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:chekdict];
//            [dic setValue:@"0" forKey:@"kfsx"];
//            
//            
//            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"cheknewpush"];
//            caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
//            caiboappdelegate.keFuButton.markbool = NO;
//            caiboappdelegate.keFuButton.newkfbool = NO;
//          
//        }
//    }
//    else {
//#ifdef isCaiPiaoForIPad
//        [[caiboAppDelegate getAppDelegate] LoginForIpad];
//#else
//        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//        [loginVC setHidesBottomBarWhenPushed:YES];
//        [loginVC setIsShowDefultAccount:YES];
//        [(UINavigationController *)app.window.rootViewController pushViewController:loginVC animated:YES];
//        [loginVC release];
//#endif
//        
//    }
    
    

    
//    KFMessageViewController *kfc=[KFMessageViewController alloc];
//    [kfc setHidesBottomBarWhenPushed:YES];
//    [(UINavigationController *)app.window.rootViewController pushViewController:kfc animated:YES];
//    [kfc release];
    
    
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    
    [bgview removeFromSuperview];
    kefulabel.hidden = YES;
    searchlabel.hidden = YES;
    newkfimage.hidden = YES;
    markbool = NO;
    newkfbool = NO;
    
    
    if (newkfbool) {
        
        markImage.frame = CGRectMake(152, 19, 8, 8);
        markImage.hidden = YES;
        jiantouimage.hidden = YES;
    }else{
        markImage.frame = CGRectMake(142, 19, 8, 8);
        jiantouimage.hidden = NO;
        markImage.hidden = YES;
    }
    
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        
        if(!kfmBox)
        {
            kfmBox=[KFMessageViewController alloc];
        }
        
        kfmBox.showBool = YES;
        
        [kfmBox tsInfo];//调用提示信息
        [kfmBox tsInfoHidden];
        
        //if (newkfbool) {
        kfmBox.newBool = newkfbool;
        [kfmBox returnSiXinCount];
        // }
        newkfbool = NO;
        if (newkfbool) {
            markImage.frame = CGRectMake(152, 19, 8, 8);
            jiantouimage.hidden = YES;
            markImage.hidden = YES;
        }else{
            markImage.frame = CGRectMake(142, 19, 8, 8);
            jiantouimage.hidden = NO;
            markImage.hidden = YES;
        }
        
        [(UINavigationController *)app.window.rootViewController pushViewController:kfmBox animated:YES];
        
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"]) {
            NSDictionary * chekdict = [[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:chekdict];
            [dic setValue:@"0" forKey:@"kfsx"];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"cheknewpush"];
            caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
            caiboappdelegate.keFuButton.markbool = NO;
            caiboappdelegate.keFuButton.newkfbool = NO;
            
        }
    }
    else {
#ifdef isCaiPiaoForIPad
        [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [loginVC setHidesBottomBarWhenPushed:YES];
        [loginVC setIsShowDefultAccount:YES];
        [(UINavigationController *)app.window.rootViewController pushViewController:loginVC animated:YES];
        [loginVC release];
#endif
        
    }

    
    
    
}

- (void)searchbuttonbig{
    [bgview removeFromSuperview];
    kefulabel.hidden = YES;
    searchlabel.hidden = YES;
    newkfimage.hidden = YES;
    caiboAppDelegate * caiboapp = [caiboAppDelegate getAppDelegate];
    
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        //添加搜索
        GCSearchViewController * gcsear = [[GCSearchViewController alloc] init];
        [(UINavigationController *)caiboapp.window.rootViewController pushViewController:gcsear animated:YES];
        [gcsear searchbegin];
        [gcsear release];
    }
    else {
#ifdef isCaiPiaoForIPad
        [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [loginVC setHidesBottomBarWhenPushed:YES];
        [loginVC setIsShowDefultAccount:YES];
        [(UINavigationController *)caiboapp.window.rootViewController pushViewController:loginVC animated:YES];
        [loginVC release];
#endif
        
    }



}


- (void)dealloc{
    [newkfimage release];
    [kefulabel release];
    [searchlabel release];
//     [msgbox release];
    [kfmBox release];
    
    [bgview release];
    [markImage release];
    [super dealloc];

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    