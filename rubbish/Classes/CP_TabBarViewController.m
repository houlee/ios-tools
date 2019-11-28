//
//  CP_TabBarViewController.m
//  kongjiantabbat
//
//  Created by houchenguang on 12-11-28.
//
//

#import "CP_TabBarViewController.h"
#import "caiboAppDelegate.h"
#import "HomeViewController.h"
#import "Info.h"
#import "LoginViewController.h"

@interface CP_TabBarViewController ()

@end

@implementation CP_TabBarViewController
@synthesize loginyn;
@synthesize backgroundImage;
@synthesize delegateCP, goucaibool;
@synthesize showXuanZheZhao;

- (void)cpTabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if ([delegateCP respondsToSelector:@selector(cpTabBarController:didSelectViewController:)]) {
        [delegateCP cpTabBarController:tabBarController didSelectViewController:viewController];
    }
}//回调
-(void)cpTabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if ([delegateCP respondsToSelector:@selector(cpTabBar:didSelectItem:)]) {
        [delegateCP cpTabBar:tabBar didSelectItem:item];
    }
}//回调

//即将消失
- (void)cpViewWillDisappear:(BOOL)animated{
    if ([delegateCP respondsToSelector:@selector(cpViewWillDisappear:)]) {
        [delegateCP cpViewWillDisappear:animated];
    }
}

//即将出现
- (void)cpViewWillAppear:(BOOL)animated{
    if ([delegateCP respondsToSelector:@selector(cpViewWillAppear:)]) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [delegateCP cpViewWillAppear:animated];
    }

}
- (void)dealloc{
//    [myTabBar release];
    [backgroundImage release];
    [imageStringArr release];
    [LabelStringArr release];
    [selectdImageArr release];
    [super dealloc];
   
}

- (void)setStateArray:(NSMutableArray *)_stateArray{

    if(stateArray != _stateArray){
        [stateArray release];
        stateArray = [_stateArray retain];
    }
    
    for (int i = 0; i < [_stateArray count]; i++) {
        if ([_stateArray count] > i) {
            UIImageView * stateimage = (UIImageView*)[myTabBar viewWithTag:300+i];
            UILabel * textlabel = (UILabel *)[myTabBar viewWithTag:400+i];
            
            
            if ([[_stateArray objectAtIndex:i] intValue] > 99) {
                textlabel.text = @"N+";
            }else{
                textlabel.text = [_stateArray objectAtIndex:i];
            }
            if ([[_stateArray objectAtIndex:i] intValue] > 0) {
                stateimage.hidden = NO;
            }else{
                stateimage.hidden = YES;
            }
            
            if (i == self.selectedIndex) {
                stateimage.hidden = YES;
                textlabel.text = @"0";
            }
            
        }
    }
    

}

- (NSMutableArray *)stateArray{
    return stateArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
                
    }
    return self;
}

- (id)initWithFrame:(CGRect)frames tabBarFrame:(CGRect)tabFrame Controllers:(NSMutableArray *)controller allButtonImageName:(NSMutableArray *)namearr allLabelString:(NSMutableArray *)labelname allSelectImageName:(NSMutableArray *)selectarr{
    showXuanZheZhao = YES;
    
    diyicideng = YES;
    imageStringArr = [[NSMutableArray alloc] initWithCapacity:0];
    LabelStringArr = [[NSMutableArray alloc] initWithCapacity:0];
    selectdImageArr = [[NSMutableArray alloc] initWithCapacity:0];
    [imageStringArr removeAllObjects];
    [LabelStringArr removeAllObjects];
    [selectdImageArr removeAllObjects];
    [imageStringArr addObjectsFromArray:namearr];
    [LabelStringArr addObjectsFromArray:labelname];
    [selectdImageArr addObjectsFromArray:selectarr];

    controllerCount = [controller count];
      NSLog(@"image = %@", LabelStringArr);
    self.hidesBottomBarWhenPushed = YES;
    self = [super init];
    self.delegate = self;
    if (self) {
       
        self.viewControllers = controller;
        UIView * selfview = [[self.view subviews] objectAtIndex:0];
        
        
#ifdef isCaiPiaoForIPad
        selfview.frame = CGRectMake(0, 0, 768, 1024);
        self.tabBar.frame = CGRectMake(0, 1024-49, 768, 49);
#else
        selfview.frame = frames;
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//            self.tabBar.frame = CGRectMake(tabFrame.origin.x, tabFrame.origin.y + 20, tabFrame.size.width, tabFrame.size.height);
//        }
//        else {
            self.tabBar.frame = tabFrame;
//        }
        
#endif
       
        self.tabBar.backgroundColor=[UIColor clearColor];
        [self.tabBar addSubview:myTabBar];
        [myTabBar release];
        [myTabBar beginCustomizingItems:self.tabBar.items];
        [myTabBar endCustomizingAnimated:NO];
        
//        UIButton * butoon = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        butoon.frame = CGRectMake(0, 0, 100, 49);
//        [butoon addTarget:self action:@selector(prewefsafas) forControlEvents:UIControlEventTouchUpInside];
//        [self.tabBar addSubview:butoon];
        
    }
    
    return self;
    


}






- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

   
    myTabBar = [[UITabBar alloc] initWithFrame:self.tabBar.bounds];
    NSLog(@"xxxx = %d",[self.tabBar isCustomizing]);
    [self.tabBar isCustomizing];
    
    
    
//    self.tabBar.selectedImageTintColor = [UIColor  redColor];
//    self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"PSD.png"];
    
    backgroundImage = [[UIImageView alloc] initWithFrame:self.tabBar.bounds];
    backgroundImage.backgroundColor = [UIColor clearColor];
    backgroundImage.backgroundColor = [UIColor blackColor];
    backgroundImage.userInteractionEnabled = YES;
    [myTabBar addSubview:backgroundImage];
    
#ifdef  isCaiPiaoForIPad
    
    self.tabBar.frame = CGRectMake(0, 1024-49, 768, 49);
    NSLog(@"x= %f, y = %f", self.tabBar.frame.origin.x, self.tabBar.frame.origin.y);
    backgroundImage.frame = CGRectMake(0, 0, 390, 49);
    myTabBar.frame = CGRectMake(0, 0, 390, 49);
#else
#endif
    
    
    float width = 0;
    for (int i = 0; i < controllerCount; i++) {
        
        //增大点击范围的按钮
        UIButton * tabbg = [UIButton buttonWithType:UIButtonTypeCustom];
        tabbg.userInteractionEnabled = YES;
        tabbg.frame = CGRectMake(width, 0, backgroundImage.frame.size.width / controllerCount, backgroundImage.frame.size.height);//tabBarBut.bounds;
        [tabbg addTarget:self action:@selector(pressTabBarButton:) forControlEvents:UIControlEventTouchUpInside];
        tabbg.tag = i+100;
        
       //tabbar上的图片
        UIImageView * tabBarBut = [[UIImageView alloc] initWithFrame:CGRectMake(width, 0, backgroundImage.frame.size.width / controllerCount, backgroundImage.frame.size.height)];
        tabBarBut.userInteractionEnabled = NO;
        tabBarBut.backgroundColor = [UIColor clearColor];
        
        //遮罩
        UIImageView * zhezhaoimage = [[UIImageView alloc] init];
        zhezhaoimage.backgroundColor = [UIColor clearColor];
        zhezhaoimage.tag = 200+i;
//        zhezhaoimage.image = [UIImageGetImageFromName(@"XDHAX960x.png") stretchableImageWithLeftCapWidth:12 topCapHeight:28];
        zhezhaoimage.hidden = YES;
        
//        if (controllerCount <= 3) {
//            zhezhaoimage.frame = CGRectMake(tabBarBut.frame.origin.x - ((68-tabBarBut.frame.size.width)/2), 0, 68, myTabBar.frame.size.height);
//        }else{
            zhezhaoimage.frame = CGRectMake(width, 0, backgroundImage.frame.size.width / controllerCount,backgroundImage.frame.size.height);
//        }

        tabBarBut.tag = i+1;
        if (0 == i && showXuanZheZhao) {
            zhezhaoimage.hidden = NO;
            tabBarBut.image =[UIImage imageNamed: [selectdImageArr objectAtIndex:i]];
        }else{
            zhezhaoimage.hidden = YES;
            tabBarBut.image = [UIImage imageNamed:[imageStringArr objectAtIndex:i]];
        }
        CGRect rectimage = CGRectMake((tabBarBut.frame.size.width - (tabBarBut.image.size.width/2))/2+width, 8, tabBarBut.image.size.width/2, tabBarBut.image.size.height/2);
        NSLog(@"%f , %f, %f, %f", rectimage.origin.x, rectimage.origin.y, rectimage.size.width, rectimage.size.height);
        tabBarBut.frame = rectimage;
        
        if ([[selectdImageArr objectAtIndex:i] isEqualToString:@"xw49.png"]) {
            tabBarBut.frame = CGRectMake(68, 0, 53, 35);
        }

        //new标注
        UIImageView * stateimage = [[UIImageView alloc] initWithFrame:CGRectMake(tabBarBut.frame.origin.x + tabBarBut.frame.size.width+1, -8, 19, 19)];
        stateimage.backgroundColor = [UIColor clearColor];
        stateimage.image = [UIImage imageNamed:@"N960.png"];
        stateimage.tag = 300+i;
        stateimage.hidden = YES;
        
        UILabel * textlabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 17, 17)];
        textlabel.textAlignment = NSTextAlignmentCenter;
        textlabel.font = [UIFont systemFontOfSize:9];
        textlabel.backgroundColor = [UIColor clearColor];
        textlabel.textColor = [UIColor whiteColor];
        [stateimage addSubview:textlabel];
        textlabel.tag = 400+i;
        [textlabel release];
        
        
        //tabbar上的标题
        UILabel * tabLabel = [[UILabel alloc] initWithFrame:CGRectMake(width,  backgroundImage.frame.size.height-22, backgroundImage.frame.size.width / controllerCount, 20)];
        tabLabel.backgroundColor = [UIColor clearColor];
        tabLabel.text = [LabelStringArr objectAtIndex:i];
        tabLabel.textColor = [UIColor colorWithRed:139/255.0 green:210/255.0 blue:1 alpha:1];//[UIColor blackColor];
        tabLabel.font = [UIFont systemFontOfSize:12];
        tabLabel.textAlignment = NSTextAlignmentCenter;
        tabLabel.tag = controllerCount+i+1;
        
       
        
        
        //宽度自加
         width += (backgroundImage.frame.size.width / controllerCount);
        
        
        
        [myTabBar addSubview:zhezhaoimage];
        [zhezhaoimage release];
        [myTabBar addSubview:tabbg];
        [myTabBar addSubview:tabBarBut];
        [myTabBar addSubview:tabLabel];
        [myTabBar addSubview:stateimage];
        [stateimage release];
        [tabLabel release];
        [tabBarBut release];
    }
    
 
    
    
    
}



- (void)pressTabBarButton:(UIButton *)sender{
    
    self.selectedIndex = sender.tag-100;
    
    UITabBarItem * item = [[UITabBarItem alloc] init];
    item.tag = sender.tag - 100;
     [self cpTabBar:myTabBar didSelectItem:item];
    [item release];
    
    [self cpTabBarController:self didSelectViewController:nil];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    
    
    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    NSString * diyistr = [devicestr substringToIndex:1];
    if ([diyistr intValue] >= 5) {
        if (diyicideng) {
            diyicideng = NO;
            return;
        }
    }
    
    
    
    Info *info1 = [Info getInstance];
    if (![info1.userId intValue]) {
        if (loginyn) {
            if (selectedIndex > 1) {
                return;
            }
        }
        
        if (goucaibool) {
            if (selectedIndex > 3) {
//                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
//                cai.gaodian = YES;
//                [cai showMessage:@"登录后可用"];
//                cai.gaodian = NO;
                
                LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                [loginVC setHidesBottomBarWhenPushed:YES];
                [loginVC setIsShowDefultAccount:YES];
                [self.navigationController pushViewController:loginVC animated:YES];
                [loginVC release];
                return;
            }
        }
    }
    
    
    UILabel * label = (UILabel *)[self.tabBar viewWithTag:controllerCount+selectedIndex+1];
     self.navigationItem.title = label.text;
    
    [super setSelectedIndex:selectedIndex];
    
    UIImageView * stateimage = (UIImageView*)[myTabBar viewWithTag:300+selectedIndex];
    UILabel * textla = (UILabel *)[myTabBar viewWithTag:400+selectedIndex];
    stateimage.hidden = YES;
    textla.text = @"0";
    
    for (int i = 0; i < controllerCount; i++) {
        UIImageView * imagesen = (UIImageView *)[myTabBar viewWithTag:i+1];
        UIImageView * zhezhao = (UIImageView *)[myTabBar viewWithTag:200+i];
        UILabel * textlabel = (UILabel *)[myTabBar viewWithTag:controllerCount+i+1];
        textlabel.font=[UIFont systemFontOfSize:9];
        if (i == selectedIndex) {
//            textlabel.textColor = [UIColor whiteColor];
            textlabel.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
            imagesen.image = [UIImage imageNamed:[selectdImageArr objectAtIndex:i]];
            if (showXuanZheZhao == YES) {
                zhezhao.hidden = NO;
            }
            else {
                zhezhao.hidden = YES;
            }
            
        }else{
//            textlabel.textColor = [UIColor colorWithRed:139/255.0 green:210/255.0 blue:1 alpha:1];
//            textlabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
            textlabel.textColor=[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
            imagesen.image = [UIImage imageNamed:[imageStringArr objectAtIndex:i]];
             zhezhao.hidden = YES;
        }
    }

}

#pragma mark UITabBarDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

    [self cpTabBarController:tabBarController didSelectViewController:viewController];
}


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    
   // UIImageView * sender = (UIImageView *)[self.tabBar viewWithTag:item.tag+1];
    /////////////title 的改变
    
    UILabel * label = (UILabel *)[self.tabBar viewWithTag:controllerCount+item.tag+1];
    self.navigationItem.title = label.text;//[LabelStringArr objectAtIndex:item.tag];

    /////////////////////////////改变按钮的状态
    [self cpTabBar:tabBar didSelectItem:item];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self cpViewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self cpViewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSUInteger)supportedInterfaceOrientations{
#ifdef  isCaiPiaoForIPad
    return UIInterfaceOrientationMaskLandscapeRight;
#else
    return (1 << UIInterfaceOrientationPortrait);
#endif
}

- (BOOL)shouldAutorotate {
#ifdef  isCaiPiaoForIPad
    return YES;
#else
    return NO;
#endif
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
#ifdef  isCaiPiaoForIPad
    return interfaceOrientation == UIInterfaceOrientationLandscapeRight;
#else
    return NO;
#endif
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    