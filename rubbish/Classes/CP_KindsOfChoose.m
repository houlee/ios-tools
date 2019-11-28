//
//  CP_KindsOfChoose.m
//  iphone_control
//
//  Created by yaofuyu on 12-12-6.
//  Copyright (c) 2012年 yaofuyu. All rights reserved.
//

#import "CP_KindsOfChoose.h"
#import "CP_XZButton.h"
#import "CP_PTButton.h"
#import "UIImageExtra.h"
#import "caiboAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "ImageUtils.h"
//#import "GC_IssueList.h"
@implementation CP_KindsOfChoose
@synthesize title;
@synthesize chuanArray;
@synthesize delegate;
@synthesize customButtons;
@synthesize backScrollView;
@synthesize changciView;
@synthesize changCiNum;
@synthesize dataArray;
@synthesize chuantype;
@synthesize duoXuanBool;
@synthesize tishibool;
@synthesize footData;
@synthesize jingcaiBool, zhuanjiaBool, bdsfBool, bdwfBool, bfycBool, is3D, onlyDG;
@synthesize backImageV;
@synthesize isClearBtnCanPress;
@synthesize isKuaiLePuKe;
@synthesize isHaveTitle;
@synthesize everyTitleBtnCount, doubleBool, fiveButtonBool, allButtonBool;
@synthesize kongzhi_Type;
@synthesize isSaiShiShaixuan;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
    }
    return self;
}

- (id)init {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {

    }
    return self;
}
//数字彩
- (id)initWithTitle:(NSString *)_title PKNameArray:(NSArray *)_chuanArray PKArray:(NSMutableArray *)chuan{
    self = [self initWithTitle:_title PKNameArray:_chuanArray];
    if (chuan) {
        chuantype = [[NSMutableArray alloc] initWithCapacity:0];
        [chuantype addObjectsFromArray:chuan];
    }
    if (self) {
        
    }
    return self;
}
- (id)initWithTitle:(NSString *)_title PKNameArray:(NSArray *)_chuanArray {
    self = [super init];
    if (self)
    {
        self.title = _title;
        kindsType= CP_KindsOfChooseTypePKIssue;
        self.chuanArray = _chuanArray;
        self.everyTitleBtnCount = [NSMutableArray arrayWithCapacity:0];
        
    }
    return  self;
}

//数字彩
- (id)initWithTitle:(NSString *)_title ShuziNameArray:(NSArray *)_chuanArray shuziArray:(NSMutableArray *)chuan{
    self = [self initWithTitle:_title ChuanNameArray:_chuanArray];
    if (chuan) {
        chuantype = [[NSMutableArray alloc] initWithCapacity:0];
        [chuantype addObjectsFromArray:chuan];
    }
    if (self) {
        
    }
    return self;
}
- (id)initWithTitle:(NSString *)_title ShuziNameWithTitleArray:(NSArray *)_chuanArray shuziArray:(NSMutableArray *)chuan
{
    self = [self initWithTitle:_title ChuanNameTitleArray:_chuanArray];
    if (chuan) {
        chuantype = [[NSMutableArray alloc] initWithCapacity:0];
        [chuantype addObjectsFromArray:chuan];
    }
    if (self) {
        
    }
    return self;
}
//数字彩
- (id)initWithTitle:(NSString *)_title ChuanNameTitleArray:(NSArray *)_chuanArray
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
        self.title = _title;
        kindsType= CP_KindsOfChooseTypeShuZiWithTitle;
        self.chuanArray = _chuanArray;
        self.everyTitleBtnCount = [NSMutableArray arrayWithCapacity:0];
        
    }
    return  self;
}
- (id)initWithTitle:(NSString *)_title ChuanNameArray:(NSArray *)_chuanArray {
    self = [super init];
    if (self)
    {
        self.title = _title;
        kindsType= CP_KindsOfChooseTypeShuZi;
        self.chuanArray = _chuanArray;
        self.everyTitleBtnCount = [NSMutableArray arrayWithCapacity:0];

    }
    return  self;
}
//串法
-(id)initWithTitle:(NSString *)_title withChuanNameArray:(NSArray *)_chuanNameArray andChuanArray:(NSArray *)_chuanArray
{
    self = [self initWithTitle:_title ChuanNameArray:_chuanNameArray cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    if (_chuanArray) {
        chuantype = [[NSMutableArray alloc] initWithCapacity:0];
        [chuantype addObjectsFromArray:_chuanArray];
    }
    if (self) {
        
    }
    return self;
}
//串法
- (id)initWithTitle:(NSString *)_title ChuanNameArray:(NSArray *)_chuanArray cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle {
    self = [super init];
    if (self) {
        //        chuanArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.title = _title;
        kindsType= CP_KindsOfChooseTypeChuan;
        self.chuanArray = _chuanArray;
        if (cancelButtonTitle || otherButtonTitle) {
            self.customButtons = [NSMutableArray array];
            int i = 0;
            if (cancelButtonTitle) {
                
                CP_PTButton *canclebutton =[[CP_PTButton alloc] initWithFrame:CGRectZero];
                canclebutton.tag =i;
                i++;
                canclebutton.backgroundColor = [UIColor clearColor];
                [canclebutton setTitle:cancelButtonTitle forState:UIControlStateNormal];
                canclebutton.titleLabel.font = [UIFont systemFontOfSize:18];
                [canclebutton setBackgroundImage:UIImageGetImageFromName(@"zulan_alertcancel_highlight.png") forState:UIControlStateHighlighted];

                [canclebutton setTitleColor:[UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];
                [canclebutton addTarget:self action:@selector(dismissWithCancleClickedButton:) forControlEvents:UIControlEventTouchUpInside];
                [customButtons addObject:canclebutton];
                [canclebutton release];
            }
            if(otherButtonTitle)
            {
                
                
                CP_PTButton *button =[[CP_PTButton alloc] initWithFrame:CGRectZero];
                button.tag =i;
                i++;
                button.backgroundColor = [UIColor clearColor];
                [button setBackgroundImage:UIImageGetImageFromName(@"zulan_alertsure_highlight.png") forState:UIControlStateHighlighted];

                [button setTitle:otherButtonTitle forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:18];
                [button setTitleColor:[UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(alertViewclickButton:) forControlEvents:UIControlEventTouchUpInside];
                [customButtons addObject:button];
                [button release];
            }
        }
    }
    return  self;
}















- (id)initWithTitle:(NSString *)_title ChangCiTitle:(NSString *)_changtiTitle DataInfo:(NSMutableArray *)_dataArray kongtype:(NSMutableArray *)kongarr{
    if (kongarr) {
        kongzhiType = [[NSMutableArray alloc] initWithCapacity:0];
        [kongzhiType addObjectsFromArray:kongarr];
    }
    duoXuanArr = [[NSMutableArray alloc] initWithCapacity:0];
    [duoXuanArr addObjectsFromArray:kongarr];
    self = [self initWithTitle:_title ChangCiTitle:_changtiTitle DataInfo:_dataArray cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    return self;
}

- (id)initWithTitle:(NSString *)_title ChangCiTitle:(NSString *)_changtiTitle DataInfo:(NSMutableArray *)_dataArray kongtype:(NSMutableArray *)kongarr titleName:(footButtonData *)footdata{
    
    self = [self initWithTitle:_title ChangCiTitle:_changtiTitle DataInfo:_dataArray cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    if (kongarr) {
        kongzhiType = [[NSMutableArray alloc] initWithCapacity:0];
        [kongzhiType addObjectsFromArray:kongarr];
    }
    
    self.footData = footdata;
    duoXuanArr = [[NSMutableArray alloc] initWithCapacity:0];
    [duoXuanArr addObjectsFromArray:kongarr];
    return self;
    
}


- (id)initWithTitle:(NSString *)_title ChangCiTitle:(NSString *)_changtiTitle DataInfo:(NSMutableArray *)_dataArray cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle{
    self = [super init];
    if (self) {
        self.title = _title;
        self.changCiNum = _changtiTitle;
        self.dataArray = _dataArray;
        kindsType= CP_KindsOfChooseTypeKongZhi;
        if (cancelButtonTitle || otherButtonTitle) {
            self.customButtons = [NSMutableArray array];
            int i = 0;
            if (cancelButtonTitle) {
                
                CP_PTButton *canclebutton =[[CP_PTButton alloc] initWithFrame:CGRectZero];
                canclebutton.tag =i;
                i++;
                canclebutton.backgroundColor = [UIColor clearColor];
//                [canclebutton loadButonImage:@"TYD960.png" LabelName:cancelButtonTitle];
                [canclebutton setTitle:cancelButtonTitle forState:UIControlStateNormal];
                canclebutton.titleLabel.font = [UIFont systemFontOfSize:18];
                [canclebutton setTitleColor:[UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];
                [canclebutton setBackgroundImage:UIImageGetImageFromName(@"zulan_alertcancel_highlight.png") forState:UIControlStateHighlighted];

                [canclebutton addTarget:self action:@selector(dismissWithCancleClickedButton:) forControlEvents:UIControlEventTouchUpInside];
                [customButtons addObject:canclebutton];
                [canclebutton release];
            }
            if(otherButtonTitle)
            {
                
                
                CP_PTButton *button =[[CP_PTButton alloc] initWithFrame:CGRectZero];
                button.tag =i;
                i++;
                button.backgroundColor = [UIColor clearColor];
                [button setTitle:otherButtonTitle forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:18];
                [button setBackgroundImage:UIImageGetImageFromName(@"zulan_alertsure_highlight.png") forState:UIControlStateHighlighted];

//                [button loadButonImage:@"TYD960.png" LabelName:otherButtonTitle];
                [button setTitleColor:[UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(alertViewclickButton:) forControlEvents:UIControlEventTouchUpInside];
                [customButtons addObject:button];
                [button release];
            }
        }
    }
    return self;
}

- (id)initWithTitle:(NSString *)_title RandDataInfo:(NSMutableArray *)_dataArray cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle {
    self  = [super init];
    if (self) {
        self.title = _title;
        kindsType= CP_KindsOfChooseTypeRandSetting;
        self.dataArray = _dataArray;
        if (cancelButtonTitle || otherButtonTitle) {
            self.customButtons = [NSMutableArray array];
            int i = 0;
            if (cancelButtonTitle) {
                
                CP_PTButton *canclebutton =[[CP_PTButton alloc] initWithFrame:CGRectZero];
                canclebutton.tag =i;
                i++;
                canclebutton.backgroundColor = [UIColor clearColor];
//                [canclebutton loadButonImage:@"TYD960.png" LabelName:cancelButtonTitle];
                [canclebutton setTitle:cancelButtonTitle forState:UIControlStateNormal];
                canclebutton.titleLabel.font = [UIFont systemFontOfSize:18];
                [canclebutton setTitleColor:[UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];
                [canclebutton setBackgroundImage:UIImageGetImageFromName(@"alert_left_highlight.png") forState:UIControlStateHighlighted];
                [canclebutton addTarget:self action:@selector(dismissWithCancleClickedButton:) forControlEvents:UIControlEventTouchUpInside];
                [customButtons addObject:canclebutton];
                [canclebutton release];
            }
            if(otherButtonTitle)
            {
                
                
                CP_PTButton *button =[[CP_PTButton alloc] initWithFrame:CGRectZero];
                button.tag =i;
                i++;
                button.backgroundColor = [UIColor clearColor];
//                [button loadButonImage:@"TYD960.png" LabelName:otherButtonTitle];
                [button setTitle:otherButtonTitle forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:18];
                [button setBackgroundImage:UIImageGetImageFromName(@"alert_right_highlight.png") forState:UIControlStateHighlighted];

                [button setTitleColor:[UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(alertViewclickButton:) forControlEvents:UIControlEventTouchUpInside];
                [customButtons addObject:button];
                [button release];
            }
        }
    }
    return  self;
}



//控制按钮点击
- (void)kongzhiClike:(UIButton *)sender {
    
    
    self.kongzhi_Type = sender.tag + 2222;
    
    BOOL isAllChoose = NO;
    
    UIView *v = sender.superview;
    
    
    for(CP_PTButton *btn in v.subviews)
    {
        if([btn isKindOfClass:[CP_PTButton class]])
        {
            if(btn.tag == sender.tag){
                
                btn.selected = !btn.selected;
            
                isAllChoose =btn.selected;
                
                if ([btn.buttonName.text isEqualToString:@"全选"]) {
                    
                    allButtonBool = btn.selected;
                    fiveButtonBool = NO;
                }
                
                if ([btn.buttonName.text isEqualToString:@"仅五大联赛"]) {
                    
                    fiveButtonBool = btn.selected;
                    allButtonBool = NO;
                }
                
                
                
            }
            
            else
                btn.selected = NO;
        }
        
    }
    
    if (v.tag - 1000 < [self.dataArray count]) {
        NSDictionary *data = [self.dataArray objectAtIndex:v.tag - 1000];
        NSArray *aray = [data objectForKey:@"kongzhi"];
        NSLog(@"仅五大联赛 000000000000000 %@",[data objectForKey:[aray objectAtIndex:sender.tag]]);
        if ([data objectForKey:[aray objectAtIndex:sender.tag]]) {
            NSArray *kongzhiBtnArray = [data objectForKey:[aray objectAtIndex:sender.tag]];//控制按钮控制的按钮
            for (CP_XZButton *btn in v.subviews) {
                
                if ([btn isKindOfClass:[CP_XZButton class]] ) {
                    if ([kongzhiBtnArray containsObject:btn.buttonName.text]) {
                        btn.selected = YES;
                    }
                    else {
                        btn.selected = NO;
                    }
                    if ([btn.buttonName.text isEqualToString:@"专家推荐"] || [btn.buttonName.text isEqualToString:@"仅单关"]) {
                        btn.selected = NO;
                        
                    }
                    
                }
            }
        }
        else {
            for (CP_XZButton *btn in v.subviews) {
                if ([btn isKindOfClass:[CP_XZButton class]] ) {
                    if ([btn.buttonName.text isEqualToString:@"专家推荐"]|| [btn.buttonName.text isEqualToString:@"仅单关"]) {
                        btn.selected = NO;
//                        allButtonBool = NO;
//                        fiveButtonBool = NO;
                        btn.buttonName.textColor = [UIColor colorWithRed:72/255.0 green:70/255.0 blue:64/255.0 alpha:1];
                    }
                    else{
                        btn.selected = isAllChoose;
                    }
                    
                }
            }
        }
    }

    [self selectCicke:nil];
    
}

- (NSMutableArray *)retunChooseArray {
    macthBool = NO;
    //    NSInteger countSelect = 0;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 1000;i - 1000< [dataArray count];i++) {
        UIView *backV = [backScrollView viewWithTag:i];
        NSMutableArray *array2 = [NSMutableArray array];
        for (CP_XZButton *btn in backV.subviews) {
            
            if ([btn isKindOfClass:[CP_XZButton class]]&&btn.selected == YES) {
                [array2 addObject:btn.buttonName.text];
                if (bdsfBool && i == 1000) {
                    if ([btn.buttonName.text  rangeOfString:@"足球("].location !=NSNotFound) {
                        macthBool = YES;
                    }
                    //                    countSelect +=1;
                }
            }
        }
        [array addObject:array2];
    }
    
    if (bdsfBool) {
        if (macthBool) {
            [self showBDSFFunc];
        }else{
            
            [self hiddenBDSFFunc];
            
        }
        
    }
    
    
    return array;
}

- (NSMutableArray *)returnRandArray {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 1000;i - 1000< [dataArray count];i++) {
        UIView *backV = [backScrollView viewWithTag:i];
        for (CP_PTButton *btn in backV.subviews) {
            
            if ([btn isKindOfClass:[CP_PTButton class]]&&btn.selected == YES) {
                [array addObject:btn.buttonName.text];
            }
        }
    }
    return array;
    
}

- (void)selectCickeChuan:(CP_XZButton *)sender{
    if (duoXuanBool) {
        
        if (sender.selected == YES) {
            sender.buttonName.textColor = [UIColor whiteColor];
        }
        else
        {
            sender.selected = NO;
            sender.buttonName.textColor = [UIColor colorWithRed:72/255.0 green:70/255.0 blue:64/255.0 alpha:1];
        }
//        if (doubleBool) {
//            if ([sender.buttonName.text isEqualToString:@"单关"]) {
//                for (int i = 0; i < [[backScrollView subviews] count]; i++) {
//                    if ([[[backScrollView subviews] objectAtIndex:i] isKindOfClass:[CP_XZButton class]]) {
//                        CP_XZButton * xbutton = [[backScrollView subviews] objectAtIndex:i];
//                        
//                        if ([xbutton.buttonName.text isEqualToString:@"单关"]) {
//                            xbutton.selected = YES;
//                            xbutton.buttonName.textColor = [UIColor whiteColor];
//                        }else{
//                            xbutton.selected = NO;
//                             xbutton.buttonName.textColor = [UIColor colorWithRed:72/255.0 green:70/255.0 blue:64/255.0 alpha:1];
//                        }
//                    }
//                }
//            }else{
//                for (int i = 0; i < [[backScrollView subviews] count]; i++) {
//                    if ([[[backScrollView subviews] objectAtIndex:i] isKindOfClass:[CP_XZButton class]]) {
//                         CP_XZButton * xbutton = [[backScrollView subviews] objectAtIndex:i];
//                        if ([xbutton.buttonName.text isEqualToString:@"单关"]) {
//                            xbutton.selected = NO;
//                            xbutton.buttonName.textColor = [UIColor colorWithRed:72/255.0 green:70/255.0 blue:64/255.0 alpha:1];
//                        }else{
//                            if (xbutton.selected == YES) {
//                                xbutton.buttonName.textColor = [UIColor whiteColor];
//                            }
//                            else
//                            {
//                                xbutton.selected = NO;
//                                xbutton.buttonName.textColor = [UIColor colorWithRed:72/255.0 green:70/255.0 blue:64/255.0 alpha:1];
//                            }
//                        }
//                    }
//                }
//            
//            }
//        }
        
        
        

    }
    
    else {
        for (CP_XZButton *btn in backScrollView.subviews) {
            if ([btn isKindOfClass:[CP_XZButton class]] ) {
                btn.selected = NO;
                if(isKuaiLePuKe)
                {
                    btn.buttonName.textColor = [UIColor colorWithRed:147/255.0 green:191/255.0 blue:220/255.0 alpha:1];

                }
                else
                    btn.buttonName.textColor = [UIColor colorWithRed:72/255.0 green:70/255.0 blue:64/255.0 alpha:1];
            }
            
        }
        
        sender.selected = YES;
        if(isKuaiLePuKe)
        {
            sender.buttonName.textColor = [UIColor colorWithRed:134/255.0 green:213/255.0 blue:235/255.0 alpha:1];

        }
        else
            sender.buttonName.textColor = [UIColor whiteColor];
        
    }
    
    
    if (delegate &&[delegate respondsToSelector:@selector(CP_KindsOfChooseView:chuanButtonIndex:button:)]) {
        [delegate CP_KindsOfChooseView:self chuanButtonIndex:sender.tag button:sender];
    }
    
    if(kindsType == CP_KindsOfChooseTypeShuZi || kindsType == CP_KindsOfChooseTypeShuZiWithTitle || kindsType == CP_KindsOfChooseTypePKIssue)
    {
        [self alertViewclickButton:sender];

    }
}

- (void)expertRecommend:(UIButton *)sender{//专家推荐
    
    
    self.kongzhi_Type = 1111;
    
    if (sender.selected) {
        for (int i = 0; i < [self.dataArray count]; i++) {
            UIView *v = [backScrollView viewWithTag:i+1000];
            for (CP_XZButton *btn in v.subviews) {
                if ([btn isKindOfClass:[CP_XZButton class]]) {
                    btn.selected = NO;
                }
                if ([btn isKindOfClass:[CP_PTButton class]]) {
                    btn.selected = NO;
                }
            }

            
        }
        sender.selected = YES;
    }else{
        

    }
    
    [self selectCicke:nil];
}

- (void)frameShowFunc:(float)viewHight isMatchBool:(BOOL)_match{
    //    UIView * showOneView = (UIView *)[backScrollView viewWithTag:1000];
    
    float infoImageHeight = 0;
    if (viewHight > 275) {
        infoImageHeight = 275;
    }
    else {
        infoImageHeight = viewHight;
    }
    if(_match)
    {
        backScrollView.contentSize = CGSizeMake(256, viewHight + 30);
        infoImage.frame = CGRectMake(0, 59.5, 291, infoImageHeight - 10);
    }
    else
    {
        backScrollView.contentSize = CGSizeMake(256, viewHight);
        infoImage.frame = CGRectMake(0, 59.5, 291, infoImageHeight);
    }

    backScrollView.frame = infoImage.bounds;
    float backHeight = 50 + infoImageHeight;
    
    float btnWith = 290.0/[customButtons count];
    for (int i = 0; i < [self.customButtons count]; i++) {
        CP_PTButton *btn = [customButtons objectAtIndex:i];
//        btn.frame = CGRectMake(10+btnWith*i, backHeight, btnWith-10, 35);
        btn.frame = CGRectMake(btnWith*i, backHeight+10, btnWith, 35);
        btn.buttonName.frame = btn.bounds;
        btn.buttonImage.image = [btn.buttonImage.image stretchableImageWithLeftCapWidth:11 topCapHeight:17];
        [backImageV addSubview:btn];
    }
    backHeight = backHeight + 48;
    backImageV.frame = CGRectMake(10, 100, 291, backHeight);
    backImageV.image = [backImageV.image imageFromImage:backImageV.image inRect:backImageV.bounds];
    backImageV.center = self.center;
    
    backImageV.image = [UIImageGetImageFromName(@"huntoukuangnew.png") stretchableImageWithLeftCapWidth:150 topCapHeight:30];

}

- (void)hiddenBDSFFunc{
    
    UIView * showView = (UIView *)[backScrollView viewWithTag:1001];
    
    showView.hidden = YES;
    
    
    backScrollView.contentSize = CGSizeMake(256, backScrollView.contentSize.height - showView.frame.size.height);
    UIView * showOneView = (UIView *)[backScrollView viewWithTag:1000];
    [self frameShowFunc:showOneView.frame.size.height isMatchBool:NO];
    
    
}
- (void)showBDSFFunc{
    UIView * showView = (UIView *)[backScrollView viewWithTag:1001];
    
    showView.hidden = NO;
    
    
    backScrollView.contentSize = CGSizeMake(256, backScrollView.contentSize.height + showView.frame.size.height);
    UIView * showOneView = (UIView *)[backScrollView viewWithTag:1000];
    float countHight = showOneView.frame.size.height + showView.frame.size.height;
    
    [self frameShowFunc:countHight isMatchBool:YES];
    
}

- (void)kongzhiTypeFunc{
    
    [kongzhiType removeAllObjects];
    
    
    
    for (int i = 0; i < 2; i++) {
        NSMutableArray * kongarr = [[NSMutableArray alloc] initWithCapacity:0];
        UIView * allviewbt = [backScrollView viewWithTag:1000+i];
        for (CP_XZButton *btn in allviewbt.subviews) {
            
            if ([btn isKindOfClass:[CP_XZButton class]]) {
                if (btn.selected) {
                    [kongarr addObject:@"1"];
                }else{
                    [kongarr addObject:@"0"];
                }
            }
        }
        if (i == 0) {
            NSMutableDictionary * type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",kongarr,@"choose", nil];
            [kongzhiType addObject:type2];
        }else{
            NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"过关",@"title",kongarr,@"choose", nil];
            [kongzhiType addObject:type2];
        }
        
        [kongarr removeAllObjects];
        [kongarr release];
    }
}


- (void)selectCicke:(UIButton *)sender {
    if (is3D) {
        for (int i = 0; i < [kongzhiType count]; i++) {
            UIView * allview = (UIView *)[backScrollView viewWithTag:i+1000];
            NSMutableDictionary * dictkong = [kongzhiType objectAtIndex:i];
            NSMutableArray * kongtypearr = [dictkong objectForKey:@"choose" ];
            
            for (int k = 0; k < [kongtypearr count]; k++) {
                CP_XZButton * xzbut = (CP_XZButton *)[allview viewWithTag:(i + 1) * 100 + k];
                if (xzbut.tag == sender.tag) {
                    xzbut.selected = YES;
                    xzbut.buttonName.textColor = [UIColor whiteColor];
                }else{
                    xzbut.selected = NO;
                    xzbut.buttonName.textColor = [UIColor colorWithRed:72.0/255.0 green:70.0/255.0 blue:64.0/255.0 alpha:1];
                }
            }
        }
        return;
    }
    
    if (tishibool) {
        NSDictionary *data = [dataArray objectAtIndex:0];
        NSMutableArray *chooseArray = [data objectForKey:@"choose"];
        if (sender.tag == [chooseArray count]) {
            sender.selected = YES;
        }else{
            sender.selected = NO;
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"稍后上线,敬请关注"];
            
        }
        return;
    }
    if (kindsType == CP_KindsOfChooseTypeKongZhi)
    {
        for (int i = 0; i < [dataArray count]; i++)
        {
            UIView * allview = sender.superview;

            for (CP_PTButton *pubtn in [allview subviews])
            {
                if ([pubtn  isKindOfClass:[CP_PTButton class]])
                {
                    pubtn.selected = NO;
                    if ([pubtn.buttonName.text isEqualToString:@"全选"]) {
                        
                        allButtonBool = pubtn.selected;
                        fiveButtonBool = NO;
                    }
                    
                    if ([pubtn.buttonName.text isEqualToString:@"仅五大联赛"]) {
                        
                        fiveButtonBool = pubtn.selected;
                        allButtonBool = NO;
                    }
                }
            }
        }
    }

    if (kindsType == CP_KindsOfChooseTypeRandSetting)
    {
        for (int i = 0; i < [dataArray count]; i++)
        {
            UIView * allview = sender.superview;
            for (CP_PTButton *pubtn in [allview subviews])
            {
                if ([pubtn  isKindOfClass:[CP_PTButton class]])
                {
                    if(pubtn.tag == sender.tag)
                    {
                        pubtn.selected = YES;
                        pubtn.buttonName.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];

                    }
                    else
                    {
                        pubtn.selected = NO;
                        pubtn.buttonName.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:1];
                    }

                }

            }
            
        }
//        sender.selected = YES;
        return;
    }


    if (!duoXuanBool) {
        NSInteger countj = 0;
        
        for (int i = 0; i < [kongzhiType count]; i++) {
            UIView * allview = (UIView *)[backScrollView viewWithTag:i+1000];
            
            NSMutableDictionary * dictkong = [kongzhiType objectAtIndex:i];
            NSMutableArray * kongtypearr = [dictkong objectForKey:@"choose" ];
            BOOL boolBreak = NO;
            for (int k = 0; k < [kongtypearr count]; k++) {
                if (jingcaiBool == beidan) {
                    CP_XZButton * xzbut = (CP_XZButton *)[allview viewWithTag:k+[kongtypearr count]+i*100];
                    NSLog(@"k = %@", [kongtypearr objectAtIndex:k]);
                    
                    if (xzbut.tag == sender.tag) {
                        countj = i;
                        boolBreak = YES;
                        break;
                    }
                }else{
                    CP_XZButton * xzbut = (CP_XZButton *)[allview viewWithTag:k+[kongtypearr count]];
                    NSLog(@"k = %@", [kongtypearr objectAtIndex:k]);
                    
                    if (xzbut.tag == sender.tag) {
                        countj = i;
                        break;
                    }
                }
                
                
                
            }
            if (jingcaiBool == beidan) {
                if (boolBreak) {
                    break;
                }
            }
            
        }
        
        UIView * allview = (UIView *)[backScrollView viewWithTag:countj+1000];
        
        NSMutableDictionary * dictkong = [kongzhiType objectAtIndex:countj];
        NSMutableArray * kongtypearr = [dictkong objectForKey:@"choose" ];
        
        
        
        for (int k = 0; k < [kongtypearr count]; k++) {
            
            CP_XZButton * xzbut = nil;
            if (jingcaiBool == beidan) {
                xzbut = (CP_XZButton *)[allview viewWithTag:k+[kongtypearr count]+countj*100];
            }else{
                xzbut = (CP_XZButton *)[allview viewWithTag:k+[kongtypearr count]];
            }
            
            NSLog(@"k = %@", [kongtypearr objectAtIndex:k]);
            
            if (xzbut.tag == sender.tag) {
                
                xzbut.selected = YES;
                xzbut.buttonName.textColor = [UIColor whiteColor];
                
            }else{
                xzbut.selected = NO;
                xzbut.buttonName.textColor = [UIColor colorWithRed:72.0/255.0 green:70.0/255.0 blue:64.0/255.0 alpha:1];
            }
            
            
        }
        
        
    }else{
        
        
        
    }
    
    
    if (jingcaiBool == jingcaizuqiuwf && bdsfBool == NO) {
        
        UIView * allviewup = (UIView *)[backScrollView viewWithTag:1000];
        CP_XZButton * xzbutup = (CP_XZButton *)[allviewup viewWithTag:7];
//        CP_XZButton * xzbutup1 = (CP_XZButton *)[allviewup viewWithTag:11];
        
        
        UIView * allview = (UIView *)[backScrollView viewWithTag:1+1000];
        CP_XZButton * xzbut = (CP_XZButton *)[allview viewWithTag:2];
        CP_XZButton * xzbutgg = (CP_XZButton *)[allview viewWithTag:3];
        

        
        if (jingcaiBool != normalType &&( huntouselect == YES || (sender.tag == 3 && xzbutup.selected == YES && jingcaiBool != jingcaipinglun)||(sender.tag == 7 && jingcaiBool != jingcaipinglun)||sender.tag == 12 || sender.tag == 13)) {
            xzbut.enabled = NO;
            xzbut.selected = NO;
            xzbut.buttonName.textColor = [UIColor lightGrayColor];

            xzbutgg.selected = YES;
            xzbutgg.buttonName.textColor = [UIColor whiteColor];
        }

        else if(jingcaiBool != normalType && xzbutgg.selected == YES)
        {
            xzbut.enabled = YES;
//            xzbut.buttonName.textColor = [UIColor colorWithRed:72.0/255.0 green:70.0/255.0 blue:64.0/255.0 alpha:1];
        }
        else{
            xzbut.enabled = YES;
            if ([xzbut.buttonName.text isEqualToString:@"全选"]) {
                
                allButtonBool = xzbut.selected;
                fiveButtonBool = NO;
            }
            
            if ([xzbut.buttonName.text isEqualToString:@"仅五大联赛"]) {
                
                fiveButtonBool = xzbut.selected;
                allButtonBool = NO;
            }
//            xzbut.buttonName.textColor = [UIColor whiteColor];
            
        }
        if (sender.selected) {//如果有其他按钮点击的时候 专家推荐 取消
            for (int i = 0; i < [self.dataArray count]; i++) {
                UIView *v = [backScrollView viewWithTag:i+1000];
                for (CP_XZButton *btn in v.subviews) {
                    if ([btn isKindOfClass:[CP_XZButton class]]) {
                        if (btn.tag == 9999 || btn.tag == 9998) {
                            btn.selected = NO;
                        }
                    }
                }
                
            }
        }
        
    }else if (jingcaiBool == jingcailanqiuwf){
        UIView * allview = (UIView *)[backScrollView viewWithTag:1+1000];
        CP_XZButton * xzbut = (CP_XZButton *)[allview viewWithTag:2];
        CP_XZButton * xzbutgg = (CP_XZButton *)[allview viewWithTag:3];
        
        UIView * allviewup = (UIView *)[backScrollView viewWithTag:1000];
        CP_XZButton * xzbutup = (CP_XZButton *)[allviewup viewWithTag:9];
        
        
        if (jingcaiBool != normalType &&(huntouselect == YES||sender.tag == 9 || (sender.tag == 3 && xzbutup.selected == YES) )) {
            xzbut.enabled = NO;
            xzbut.selected = NO;
            xzbut.buttonName.textColor = [UIColor lightGrayColor];
            xzbutgg.selected = YES;
            xzbutgg.buttonName.textColor = [UIColor whiteColor];

        }
        else if (jingcaiBool != normalType && xzbutgg.selected == YES)
        {
            xzbut.enabled = YES;
            xzbut.buttonName.textColor = [UIColor colorWithRed:72.0/255.0 green:70.0/255.0 blue:64.0/255.0 alpha:1];
        }
        else{
            xzbut.enabled = YES;
            xzbut.buttonName.textColor = [UIColor whiteColor];
        }
    }
    
    
    
    if (delegate &&[delegate respondsToSelector:@selector(CP_KindsOfChooseView:chooseButtonIndex:returnArray:)]) {
        [delegate CP_KindsOfChooseView:self chooseButtonIndex:sender.tag returnArray:[self retunChooseArray]];
    }
    if (bdsfBool) {
        [self retunChooseArray];
    }
    
    
    
    BOOL sfqtbool = NO;
    UIView *backV = [backScrollView viewWithTag:1000];
    
    if (bdwfBool) {
        //         [self kongzhiTypeFunc];
        NSString * strName = @"";
        for (CP_XZButton *btn in backV.subviews) {
            //                NSLog(@"selected = %d", btn.selected);
            if ([btn isKindOfClass:[CP_XZButton class]]&&btn.selected == YES) {
                strName = btn.buttonName.text;
                if ([btn.buttonName.text isEqualToString:@"胜负过关"]) {
                    sfqtbool = YES;
                }
            }
        }
        if (sender.tag < 100) {
            
            //            [self kongzhiTypeFunc];
            if (delegate &&[delegate respondsToSelector:@selector(shengfuFuncReturn:chooseView:kongzhiType: name:)]) {
                [delegate shengfuFuncReturn:sfqtbool chooseView:self kongzhiType:kongzhiType name:strName];
            }
        }
        
        
    }
    
    
    
    //    if (self.bjdcType == 1 || self.bjdcType == 2) {
    //        BOOL sfqtbool = NO;
    //            UIView *backV = [backScrollView viewWithTag:1000];
    //
    //            for (CP_XZButton *btn in backV.subviews) {
    ////                NSLog(@"selected = %d", btn.selected);
    //                if ([btn isKindOfClass:[CP_XZButton class]]&&btn.selected == YES) {
    //                    if ([btn.buttonName.text isEqualToString:@"胜负过关"]) {
    //                        sfqtbool = YES;
    //                    }
    //                }
    //            }
    //
    //
    //        if (sfqtbool) {
    //            self.bjdcType = 2;
    //        }else{
    //            self.bjdcType = 1;
    //        }
    //        [self showbdsfPlayTileFunc];
    //    }
    
    
}

//- (void)showbdsfPlayTileFunc{
//
//
//    UIView * allview = (UIView *)[backScrollView viewWithTag:1+1000];
//
////    UIView *backV = [backScrollView viewWithTag:1000];
//
//    for (CP_XZButton *btn in allview.subviews) {
//
//        if ([btn isKindOfClass:[CP_XZButton class]]) {
//            [btn removeFromSuperview];
//        }
//    }
//    NSMutableArray * chooseArray = [NSMutableArray array];
//    NSString * issueString = @"";
//    if (self.bjdcType == 1) {//其他玩法
//
//        chooseArray = self.issueTypeArray;
//        issueString = self.qtissueString;
//
//    }else if (self.bjdcType == 2){//胜负玩法
//
//        chooseArray = self.sfIssueArray;
//        issueString = self.sfissueString;
//    }
//
//
//
//    if (chooseArray) {
//        for (int k = 0; k<[chooseArray count]; k++) {
//            int a = k %2;
//            int b = k /2;
//            CP_XZButton *testBtn = [CP_XZButton buttonWithType:UIButtonTypeCustom];
//            testBtn.frame = CGRectMake(15+120*a, 35 + b*35, 106, 29);
//            if (self.footData) {
//                testBtn.frame = CGRectMake(15+120*a, 60+b*35, 106, 29);
//            }
//            if (jingcaiBool == beidan) {
//                testBtn.tag = k + [chooseArray count] + 1*100;
//            }else{
//                testBtn.tag = k + [chooseArray count];
//            }
//
////            testBtn.tag = k + [chooseArray count];
//
//
//            [testBtn addTarget:self action:@selector(selectCicke:) forControlEvents:UIControlEventValueChanged];
//
//             IssueDetail * detail = [chooseArray objectAtIndex:k];
//            [testBtn loadButtonName:detail.issue];
//            NSLog(@"textname = %@", detail.issue);
//            if (tishibool) {
//                if (testBtn.tag == [chooseArray count]) {
//                    testBtn.selected = YES;
//                }
//
//            }else{
//                IssueDetail * detail = [chooseArray objectAtIndex:k];
//                if (k<[chooseArray count]&&[detail.issue isEqualToString:issueString]) {
//                    testBtn.selected = YES;
//                    NSLog(@"tag = %d", testBtn.tag);
//
//                }else{
//
//                    testBtn.selected = NO;
//                }
//
//
//
//
//            }
//
//
//
//            [allview addSubview:testBtn];
//        }
//    }
//
//
//
//
//
//
//
//}



- (void)show {
    macthBool = NO;
    


    //    NSInteger countSelect = 0;
    backImageV = [[UIImageView alloc] init];
//    backImageV.layer.masksToBounds=YES;
//    backImageV.layer.cornerRadius = 8;

//    backImageV.backgroundColor = [UIColor blackColor];
    backImageV.frame = CGRectMake(10, 100, 291, 195);
    backImageV.userInteractionEnabled = YES;
    [self addSubview:backImageV];
    
    
    float backHeight = 10;
    if (self.title) {

        titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, backImageV.frame.size.width, 17)];
        titleLable.text = self.title;
        [backImageV addSubview:titleLable];
        titleLable.textAlignment = NSTextAlignmentCenter;
        
        titleLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        titleLable.font = [UIFont boldSystemFontOfSize:17];
        titleLable.backgroundColor = [UIColor clearColor];
        [titleLable release];
        backHeight = backHeight + 30;
    }
    if(kindsType == CP_KindsOfChooseTypeChuan)
    {
        NSLog(@"%@", chuanArray);
        
        if(bfycBool){
            UILabel *messLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(titleLable)+15, backImageV.frame.size.width, 14)];
            messLabel.text = @"进入八方预测,首先呈现您选中的";
            messLabel.textAlignment = NSTextAlignmentCenter;
            messLabel.font = [UIFont systemFontOfSize:14];
            messLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            messLabel.backgroundColor = [UIColor clearColor];
            [backImageV addSubview:messLabel];
            [messLabel release];
            backHeight = backHeight+14;
            
        }
        
        self.backScrollView = nil;
        infoImage = [[UIImageView alloc] init];
        infoImage.backgroundColor = [UIColor clearColor];
        if ([chuanArray count] <= 14) {
            infoImage.frame = CGRectMake(0, 59.5, 291, (([chuanArray count] + 1)/2) *41 + 7);
            backHeight = backHeight + (([chuanArray count] + 1)/2) *41 + 30;
        }
        else {
            infoImage.frame = CGRectMake(0, 59.5, 291, 260);
            backHeight = backHeight + 283;
        }
        
        if(bfycBool){
            infoImage.frame = CGRectMake(0, infoImage.frame.origin.y+14, 291, infoImage.frame.size.height);

        }
        
        infoImage.userInteractionEnabled = YES;
        [backImageV addSubview:infoImage];
        [infoImage release];
        backScrollView = [[UIScrollView alloc] initWithFrame:infoImage.bounds];
        backScrollView.contentSize = CGSizeMake(291, (([chuanArray count] + 1)/2) *41 +7);
        [infoImage addSubview:backScrollView];
        [backScrollView release];
        for (int i = 0; i<[chuanArray count]; i++) {
            NSString * chuanstring = @"";
            if ([chuantype count] == [chuanArray count]) {
                chuanstring = [chuantype objectAtIndex:i];
            }
            
            int a = i%2;
            int b = i/2;
            CP_XZButton *testBtn = [CP_XZButton buttonWithType:UIButtonTypeCustom];

            testBtn.frame = CGRectMake(9.5+140*a, 7 + b*41, 131, 32.5);
            testBtn.tag = i;
            NSLog(@"chuan arrya = %@", [chuanArray objectAtIndex:i]);
            [testBtn loadButtonName:[chuanArray objectAtIndex:i]];
            if ([testBtn.buttonName.text length] >8) {
                testBtn.buttonName.textAlignment = NSTextAlignmentRight;
                testBtn.buttonName.frame = CGRectMake(0, 0, 103, 29);
            }
            [testBtn addTarget:self action:@selector(selectCickeChuan:) forControlEvents:UIControlEventTouchUpInside];
            if ([chuanstring isEqualToString:@"1"]) {
                testBtn.selected = YES;
                testBtn.buttonName.textColor = [UIColor whiteColor];
            }else{
                
                testBtn.selected = NO;
                testBtn.buttonName.textColor = [UIColor colorWithRed:72/255.0 green:70/255.0 blue:64/255.0 alpha:1];
            }

            [backScrollView addSubview:testBtn];
        }
        

    }
    if(kindsType == CP_KindsOfChooseTypeShuZiWithTitle)
    {
        NSLog(@"%@", chuanArray);
        self.backScrollView = nil;
        [titleLable removeFromSuperview];
        infoImage = [[UIImageView alloc] init];
        infoImage.backgroundColor = [UIColor clearColor];
        NSMutableArray *mutableChooseArray = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *mutableTitleArray = [NSMutableArray arrayWithCapacity:0];
        titleArray = [[NSMutableArray alloc] init];
        //每个title下按钮个数
        
        //带Title的  例：福彩3D 、排 3

        for(int i =0;i<[chuanArray count];i++)
        {
            NSDictionary *dic = [chuanArray objectAtIndex:i];
            NSArray *tmpArray = [dic objectForKey:@"choose"];
            if (tmpArray) {
                [mutableChooseArray addObjectsFromArray:tmpArray];
                [titleArray addObject:tmpArray];
                [self.everyTitleBtnCount addObject:[NSString stringWithFormat:@"%lu",(unsigned long)[tmpArray count]]];
                [mutableTitleArray addObject:[dic objectForKey:@"title"]];
            }
        }
        self.chuanArray = [NSArray arrayWithArray:mutableChooseArray];
        
        infoImage.frame = CGRectMake(0, 0, 320, (([chuanArray count] + 1)/3) *41 + 40+([everyTitleBtnCount count]-1) * 41);
        backHeight =  (([chuanArray count] + 1)/3) *41 + +40+(37+3)/2  + ([everyTitleBtnCount count]-1) * 41;
        
        
        if ([chuanArray count] <= 14) {
            for(int j = 0;j<[everyTitleBtnCount count];j++)
            {

                if([[titleArray objectAtIndex:j] count] == 2 || [[titleArray objectAtIndex:j] count] == 4)
                {
                    infoImage.frame = CGRectMake(0, 0, 320, infoImage.frame.size.height+(41-8.5)*(([[titleArray objectAtIndex:j] count]+1)/2-1));
                    backHeight =  backHeight +(41-8.5)*(([[titleArray objectAtIndex:j] count]+1)/2-1);
                }
                else
                {
                    infoImage.frame = CGRectMake(0, 0, 320, infoImage.frame.size.height+(41-8.5)*(([[titleArray objectAtIndex:j] count]+2)/3-1));
                    backHeight =  backHeight +(41-8.5)*(([[titleArray objectAtIndex:j] count]+2)/3-1);
                }
            }

            

        }
        else
        {
            infoImage.frame = CGRectMake(0, 0, 291, 260);
            backHeight = backHeight + 275;
        }
        infoImage.userInteractionEnabled = YES;
        [backImageV addSubview:infoImage];
        [infoImage release];
        backScrollView = [[UIScrollView alloc] initWithFrame:infoImage.bounds];
        backScrollView.contentSize = CGSizeMake(256, (([chuanArray count] + 1)/2) *35 +10);
        [infoImage addSubview:backScrollView];
        [backScrollView release];
        
        backImageV.frame = CGRectMake(0, -backHeight, 320 , backHeight);

        int btnHeigth = 0;
        
        for(int i = 0;i<[mutableTitleArray count];i++)
        {
            
            UIImageView *leftxian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 19.5+(20.5*i)+(19.5 * i) + btnHeigth * i, 105, 1)];
            leftxian.backgroundColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1];
            [backScrollView addSubview:leftxian];
            [leftxian release];
            
            
            UIImageView *rightxian = [[UIImageView alloc] initWithFrame:CGRectMake(215, 19.5+(20.5*i)+(19.5 * i) + btnHeigth * i, 125, 1)];
            rightxian.backgroundColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1];
            [backScrollView addSubview:rightxian];
            [rightxian release];
            
            UILabel *titleLabel  =[[UILabel alloc] initWithFrame:CGRectMake(100, 19.5+(20.5*i)+(19.5 * i) + (btnHeigth* i)-10, 110, 21)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont boldSystemFontOfSize:16];
            titleLabel.text = [mutableTitleArray objectAtIndex:i];
            titleLabel.textColor = [UIColor colorWithRed:114/255.0 green:114/255.0 blue:114/255.0 alpha:1];
            [backScrollView addSubview:titleLabel];
            [titleLabel release];

            btnHeigth = ([[everyTitleBtnCount objectAtIndex:i] integerValue]+2)/3 * 32.5 + (([[everyTitleBtnCount objectAtIndex:i] integerValue] + 2)/3 -1) * 8.5;
        }
        
        
        
        int yyyy = 0;
        
        for(int j = 0;j<[everyTitleBtnCount count];j++)
        {
            
            for (int i = 0; i<[[everyTitleBtnCount objectAtIndex:j] integerValue]; i++) {
                
                
                int a = i%3;
                int b = yyyy/3;
                if(j>0 && ([[titleArray objectAtIndex:j-1] count] ==2 || [[titleArray objectAtIndex:j-1] count] == 4))
                {
                    b = (yyyy+(int)[[titleArray objectAtIndex:j-1] count]/2)/3;
                }
                
                if([[titleArray objectAtIndex:j] count] ==2 || [[titleArray objectAtIndex:j] count] == 4)
                {
                    a=i%2;
                    b=yyyy/2;
                }
                
                CP_XZButton *testBtn = [CP_XZButton buttonWithType:UIButtonTypeCustom];
                if(isKuaiLePuKe)
                {
                    testBtn.iskuailepuke = YES;
                }
                
                float yfloat = 40 + b*41 + j*(41-8.5);
                
                if([[titleArray objectAtIndex:j] count] == 2 || [[titleArray objectAtIndex:j] count] == 4)
                {
                    yfloat = 41+b*42.5 + j*(41-8.5);
                }

                testBtn.tag = (j+1)*100+i;

                
                if(([[titleArray objectAtIndex:j] count] ==2 || [[titleArray objectAtIndex:j] count] == 4))
                    testBtn.frame = CGRectMake(15+150*a, yfloat, 140, 32.5);
                else
                    testBtn.frame = CGRectMake(15+100*a, yfloat, 90, 32.5);
                
                [testBtn loadButtonName:[[titleArray objectAtIndex:j] objectAtIndex:i]];
                
                if ([testBtn.buttonName.text length] >= 6) {
                    
                    testBtn.buttonName.font = [UIFont boldSystemFontOfSize:13];
                }
                [testBtn addTarget:self action:@selector(selectCickeChuan:) forControlEvents:UIControlEventTouchUpInside];

                [backScrollView addSubview:testBtn];
                
                
                yyyy = yyyy + 1;

            }

        }
        
        
        UIView *blueview = [[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(infoImage)+18.5, 320, 1.5)];

        blueview.backgroundColor = [UIColor colorWithRed:15.0/255.0 green:136.0/255.0 blue:218.0/255.0 alpha:1];
            
        [backImageV addSubview:blueview];
        [blueview release];
        UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [clearBtn setBackgroundColor:[UIColor clearColor]];
        [clearBtn setFrame:CGRectMake(0, ORIGIN_Y(blueview)+64, 320, self.frame.size.height-ORIGIN_Y(blueview))];
        [clearBtn addTarget:self action:@selector(disMissWithPressOtherFrame) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clearBtn];

    }
    if (kindsType == CP_KindsOfChooseTypeShuZi || kindsType == CP_KindsOfChooseTypePKIssue) {
        NSLog(@"%@", chuanArray);
        self.backScrollView = nil;
        [titleLable removeFromSuperview];
        infoImage = [[UIImageView alloc] init];
        infoImage.backgroundColor = [UIColor clearColor];
        if ([chuanArray count] <= 14) {
            if (bfycBool)
            {
                infoImage.frame = CGRectMake(0, 59.5, 291, (([chuanArray count] + 1)/2) *35 + 10 + 30);
                backHeight = backHeight + (([chuanArray count] + 1)/2) *35 + 10+30;
            }else
            {
                if([chuanArray count] ==2 || [chuanArray count] == 4 || kindsType == CP_KindsOfChooseTypePKIssue)
                {
                    infoImage.frame = CGRectMake(0, 0, 320, (([chuanArray count] + 1)/2) *42.5 + 41);
                    backHeight =  (([chuanArray count] + 1)/2) *42.5 + 41+ (37+3)/2;
                }
                else if(chuanArray.count == 1)
                {
                    infoImage.frame = CGRectMake(0, 0, 320, ((3 + 1)/3) *42.5 + 41);
                    backHeight =  ((3 + 1)/3) *42.5 + 41+ (37+3)/2;
                }
                else
                {
                    infoImage.frame = CGRectMake(0, 0, 320, (([chuanArray count] + 2)/3) *41 + 40);
                    backHeight =  (([chuanArray count] + 2)/3) *41 + +40+(37+3)/2;
                }

            }
            
        }
        else
        {
            infoImage.frame = CGRectMake(0, 0, 320, (([chuanArray count] + 1)/2) * 34);
            backHeight = backHeight + (([chuanArray count] + 1)/2) *34 - 20;
        }
        infoImage.userInteractionEnabled = YES;
        [backImageV addSubview:infoImage];
        [infoImage release];
        backScrollView = [[UIScrollView alloc] initWithFrame:infoImage.bounds];
        backScrollView.contentSize = CGSizeMake(256, (([chuanArray count] + 1)/2) *35 +10);
        [infoImage addSubview:backScrollView];
        [backScrollView release];
        
        backImageV.frame = CGRectMake(0, -backHeight, 320 , backHeight);
        
        if (bfycBool) {
            UILabel * infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 5, 250, 20)];
            infoLabel.backgroundColor = [UIColor clearColor];
            infoLabel.textAlignment = NSTextAlignmentLeft;
            infoLabel.font = [UIFont systemFontOfSize:12];
            infoLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            infoLabel.text = @"进入八方预测，首先呈现你选中的";
            [backScrollView addSubview:infoLabel];
            [infoLabel release];
        }
        

        
        for (int i = 0; i<[chuanArray count]; i++) {
            NSString * chuanstring = @"";
            if ([chuantype count] == [chuanArray count]) {
                chuanstring = [chuantype objectAtIndex:i];
            }
            int a = i%3;
            int b = i/3;

            if([chuanArray count] ==2 || [chuanArray count] == 4 || kindsType == CP_KindsOfChooseTypePKIssue)
            {
                a=i%2;
                b=i/2;
            }

            
            CP_XZButton *testBtn = [CP_XZButton buttonWithType:UIButtonTypeCustom];
            if(isKuaiLePuKe)
            {
                testBtn.iskuailepuke = YES;
            }
            float yfloat = 40 + b*41;
            if([chuanArray count] == 2 || [chuanArray count] == 4 || kindsType == CP_KindsOfChooseTypePKIssue)
            {
                yfloat = 41+b*42.5;
            }
            
            if (bfycBool) {
                yfloat = 30 + b*35;
            }
            testBtn.tag = i;

            
            if(([chuanArray count] ==2 || [chuanArray count] == 4 || kindsType == CP_KindsOfChooseTypePKIssue) && !isHaveTitle)
                testBtn.frame = CGRectMake(15+150*a, yfloat, 140, 32.5);
            else
                testBtn.frame = CGRectMake(15+100*a, yfloat, 90, 32.5);


            NSLog(@"chuan arrya = %@", [chuanArray objectAtIndex:i]);
            [testBtn loadButtonName:[chuanArray objectAtIndex:i]];
            if ([testBtn.buttonName.text length] >= 6) {

                testBtn.buttonName.font = [UIFont boldSystemFontOfSize:13];
            }
            [testBtn addTarget:self action:@selector(selectCickeChuan:) forControlEvents:UIControlEventTouchUpInside];

            
            if ([chuanstring isEqualToString:@"1"]) {
                testBtn.selected = YES;
                testBtn.backgroundColor = [UIColor whiteColor];

            }else{
                testBtn.selected = NO;
            }
            [backScrollView addSubview:testBtn];
        }
        
        UIView *blueview = [[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(infoImage)+18.5, 320, 1.5)];
        if(isKuaiLePuKe)
        {
            blueview.backgroundColor = [UIColor colorWithRed:26/255.0 green:33/255.0 blue:49/255.0 alpha:1];

        }
        else
        {
            blueview.backgroundColor = [UIColor colorWithRed:15.0/255.0 green:136.0/255.0 blue:218.0/255.0 alpha:1];
        }
        
        [backImageV addSubview:blueview];
        [blueview release];
        
        UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [clearBtn setBackgroundColor:[UIColor clearColor]];
        [clearBtn setFrame:CGRectMake(0, ORIGIN_Y(blueview)+64, 320, self.frame.size.height-ORIGIN_Y(blueview))];
        [clearBtn addTarget:self action:@selector(disMissWithPressOtherFrame) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clearBtn];
        
        
    }
    else if (kindsType == CP_KindsOfChooseTypeKongZhi) {
        self.backScrollView = nil;
        infoImage = [[UIImageView alloc] init];
        infoImage.userInteractionEnabled = YES;
        [backImageV addSubview:infoImage];
        [infoImage release];
        float infoImageHeight = 0;
        float scrolContHeight = 0;
        backScrollView = [[UIScrollView alloc] initWithFrame:infoImage.bounds];
        backScrollView.contentSize = CGSizeMake(256, (([chuanArray count] + 1)/2) *35 +10);
        [infoImage addSubview:backScrollView];
        [backScrollView release];
        changciView = [[ColorView alloc] init];
        //        changciView.font = [UIFont systemFontOfSize:12];
        //        changciView.colorfont = [UIFont systemFontOfSize:12];
        changciView.backgroundColor = [UIColor clearColor];
        changciView.frame = CGRectMake(90, 5, 140, 20);
        changciView.tag  = 300;
        [backScrollView addSubview:changciView];
        changciView.changeColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        changciView.text = self.changCiNum;
        [changciView release];
        NSInteger changhight = 0;
        if ([self.changCiNum length]) {
            changhight += 25;
        }
        scrolContHeight = scrolContHeight +changhight;
        
        
        
        BOOL huntou = NO;
        
        for (int i = 0;i< [dataArray count];i++) {
            UIView *tiView = [[UIView alloc] init];

            [backScrollView addSubview:tiView];
            tiView.tag = i + 1000;
            NSInteger titleHeight = 0;
            NSDictionary *data = [dataArray objectAtIndex:i];
            if ([[data objectForKey:@"title"] length]) {
                UIImageView *titleChoseImage = [[UIImageView alloc] init];
                titleChoseImage.frame = CGRectMake(0, 0, 281.5, 20.5);
                [tiView addSubview:titleChoseImage];
                if (self.footData) {
                    titleChoseImage.hidden = YES;
                }
                titleChoseImage.image = UIImageGetImageFromName(@"wanfa_alert_topxian.png");
                [titleChoseImage release];
                UILabel *choseTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 68, 20.5)];
                [titleChoseImage addSubview:choseTitle];

                choseTitle.font = [UIFont systemFontOfSize:13];
                choseTitle.textColor = [UIColor colorWithRed:114.0/255.0 green:114.0/255.0 blue:114.0/255.0 alpha:1];
                choseTitle.textAlignment = NSTextAlignmentCenter;
                choseTitle.backgroundColor = [UIColor clearColor];
                choseTitle.text = [data objectForKey:@"title"];
                [choseTitle release];
                titleHeight = 42;
                if (self.footData) {
                    titleHeight = 51;
                }

                
            }
            
            
            NSMutableArray *kongzhiArray = [data objectForKey:@"kongzhi"];
            NSMutableArray *chooseArray = [data objectForKey:@"choose"];
            NSMutableArray * kongtypearr;
            if(!tishibool){
                if (duoXuanArr) {
                    NSDictionary * dictkong = [duoXuanArr objectAtIndex:i];
                    kongtypearr = [dictkong objectForKey:@"choose" ];
                }else{
                    NSDictionary * dictkong = [kongzhiType objectAtIndex:i];
                    kongtypearr = [dictkong objectForKey:@"choose" ];
                    
                }
            }
            
            
            
            if (kongzhiArray) {
                for (int k = 0; k<[kongzhiArray count]; k++) {
                    int a = k%2;
                    int b = k/2;
                    if ([[kongzhiArray objectAtIndex:k] isEqualToString:@"专家推荐"]) {
                        CP_XZButton *testBtn = [CP_XZButton buttonWithType:UIButtonTypeCustom];
                        testBtn.frame = CGRectMake(9.5+141*a, 35 + b*41, 131, 32.5);
                        
                        testBtn.tag = 9999 ;
                        [testBtn addTarget:self action:@selector(expertRecommend:) forControlEvents:UIControlEventValueChanged];
                        [testBtn loadButtonName:[kongzhiArray objectAtIndex:k]];
                        [tiView addSubview:testBtn];
                        
                        if (self.zhuanjiaBool) {
                            testBtn.selected = YES;
                        }else{
                            testBtn.selected = NO;
                        }
                        
                    }else if ([[kongzhiArray objectAtIndex:k] isEqualToString:@"仅单关"]) {
                        CP_XZButton *testBtn = [CP_XZButton buttonWithType:UIButtonTypeCustom];
                        testBtn.frame = CGRectMake(9.5+141*a, 35 + b*41, 131, 32.5);
                        
                        testBtn.tag = 9998 ;
                        [testBtn addTarget:self action:@selector(expertRecommend:) forControlEvents:UIControlEventValueChanged];
                        [testBtn loadButtonName:[kongzhiArray objectAtIndex:k]];
                        [tiView addSubview:testBtn];
                        
                        if (self.onlyDG) {
                            testBtn.selected = YES;
                            allButtonBool = NO;
                            fiveButtonBool = NO;
                        }else{
                            testBtn.selected = NO;
                        }
                        
                    }else{
                        CP_PTButton *testBtn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
                        testBtn.frame = CGRectMake(9.5+141*a, 35 + b*41, 131, 32.5);
                        testBtn.tag = k;
                        [testBtn addTarget:self action:@selector(kongzhiClike:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [testBtn loadButonImage:@"btn_gray_selected.png" LabelName:[kongzhiArray objectAtIndex:k]];

                        testBtn.buttonName.textColor =[UIColor colorWithRed:72/255.0 green:70/255.0 blue:64/255.0 alpha:1];
                        testBtn.selectTextColor =[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
                        testBtn.nomorTextColor =[UIColor colorWithRed:72/255.0 green:70/255.0 blue:64/255.0 alpha:1];
                        testBtn.selectImage = [UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7];
                        if (self.onlyDG == NO && self.zhuanjiaBool == NO) {
                            if([[kongzhiArray objectAtIndex:k] isEqualToString:@"全选"]){
                                
                                if (allButtonBool) {
                                    testBtn.selected = YES;
                                }else{
                                    testBtn.selected = NO;
                                }
                                
                            }
                            if([[kongzhiArray objectAtIndex:k] isEqualToString:@"仅五大联赛"]){
                                
                                if (fiveButtonBool) {
                                    testBtn.selected = YES;
                                }else{
                                    testBtn.selected = NO;
                                }
                                
                            }
                        }else{
                            fiveButtonBool = NO;
                            allButtonBool = NO;
                            if([[kongzhiArray objectAtIndex:k] isEqualToString:@"全选"]){
                                
                                
                                    testBtn.selected = NO;
                             
                                
                            }
                            if([[kongzhiArray objectAtIndex:k] isEqualToString:@"仅五大联赛"]){
                                
                              
                                    testBtn.selected = NO;
                            
                                
                            }
                        }
                       
                        [tiView addSubview:testBtn];
                    }
                    
                }
            }
            
            if (chooseArray) {
                for (int k = 0; k<[chooseArray count]; k++) {
                    int a = (k + [kongzhiArray count])%2;
                    int b = (k + (int)[kongzhiArray count])/2;
                    CP_XZButton *testBtn = [CP_XZButton buttonWithType:UIButtonTypeCustom];
                    testBtn.frame = CGRectMake(9.5+141*a, 35 + b*41, 131, 32.5);
                    if (self.footData) {
                        testBtn.frame = CGRectMake(9.5+141*a, 60+b*41, 131, 32.5);
                    }
                    if (jingcaiBool == beidan) {
                        testBtn.tag = k + [chooseArray count] + i*100;
                    }else{
                        if (is3D) {
                            testBtn.tag = (i + 1) * 100 + k;
                        }else{
                            testBtn.tag = k + [chooseArray count];
                        }
                    }
                    
                    [testBtn addTarget:self action:@selector(selectCicke:) forControlEvents:UIControlEventValueChanged];
                    [testBtn loadButtonName:[chooseArray objectAtIndex:k]];
                    NSLog(@"textname = %@", [chooseArray objectAtIndex:k]);
                    if (tishibool) {
                        if (testBtn.tag == [chooseArray count]) {
                            testBtn.selected = YES;
                        }
                        
                    }else{
                        if (k<[kongtypearr count]&&[[kongtypearr objectAtIndex:k] isEqualToString:@"1"]) {
                            testBtn.selected = YES;
                            testBtn.buttonName.textColor = [UIColor whiteColor];
                            if (bdsfBool == NO) {
                                if ((testBtn.tag == 7 && jingcaiBool != jingcaipinglun) || testBtn.tag == 12|| testBtn.tag == 13) {
                                    huntou = YES;
                                }
                            }else{
                                
                                if ([testBtn.buttonName.text  rangeOfString:@"足球("].location !=NSNotFound) {
                                    macthBool = YES;
                                }
                            }
                            //                            countSelect += 1;
                        }else{
                            
                            testBtn.selected = NO;
                        }
                        
                        if (jingcaiBool == jingcaizuqiuwf) {
                            if (huntou && !isSaiShiShaixuan) {
                                if (testBtn.tag == 2)
                                {
                                    testBtn.enabled = NO;
                                    testBtn.selected = NO;
                                    testBtn.buttonName.textColor = [UIColor lightGrayColor];
                                    
                                }else if(testBtn.tag == 3)
                                {
                                    testBtn.enabled = YES;
                                    testBtn.selected = YES;
                                    testBtn.buttonName.textColor = [UIColor colorWithRed:72.0/255.0 green:70.0/255.0 blue:64.0/255.0 alpha:1];
                                }
                            }
                            else
                            {
                                
                                testBtn.enabled = YES;
                            }
                        }
                        
                        
                    }
                    
                    
                    
                    [tiView addSubview:testBtn];
                }
            }
            tiView.frame = CGRectMake(0, scrolContHeight, 281.5, (([chooseArray count] + [kongzhiArray count] + 1)/2) *41 + 35);
            [tiView release];
            
            if (self.footData) {
                
                tiView.frame = CGRectMake(0, scrolContHeight, 281.5, (([chooseArray count] + [kongzhiArray count] + 1)/2) *41 + 65);
            }
            scrolContHeight = scrolContHeight + (([chooseArray count] + [kongzhiArray count] + 1)/2) *41 + 10 +titleHeight;
            
        }
        

        
        
        
        if (self.footData) {
            
            UIImageView * teamNameImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 230, 31)];
            teamNameImage.backgroundColor = [UIColor clearColor];
            teamNameImage.image = [UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:20];
            [backScrollView addSubview:teamNameImage];
            [teamNameImage release];
            
            UILabel * homeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 80, 31)];
            homeLabel.font = [UIFont boldSystemFontOfSize:13];
            homeLabel.backgroundColor = [UIColor clearColor];
            homeLabel.textAlignment = NSTextAlignmentCenter;
            homeLabel.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            homeLabel.text = self.footData.matchHome;
            [teamNameImage addSubview:homeLabel];
            [homeLabel release];
            
            UILabel * guestLabel = [[UILabel alloc] initWithFrame:CGRectMake(230-80-20, 0, 80, 31)];
            guestLabel.font = [UIFont boldSystemFontOfSize:13];
            guestLabel.backgroundColor = [UIColor clearColor];
            guestLabel.textAlignment = NSTextAlignmentCenter;
            guestLabel.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            guestLabel.text = self.footData.matchGuest;
            [teamNameImage addSubview:guestLabel];
            [guestLabel release];
            
            
            UILabel * vsLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 30, 31)];
            vsLabel.font = [UIFont boldSystemFontOfSize:13];
            vsLabel.backgroundColor = [UIColor clearColor];
            vsLabel.textAlignment = NSTextAlignmentCenter;
            vsLabel.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            vsLabel.text = @"vs";
            [teamNameImage addSubview:vsLabel];
            [vsLabel release];
            
        }
        
        if (scrolContHeight > 275) {
            infoImageHeight = 275;
        }
        else {
            infoImageHeight = scrolContHeight;
        }
        
        
        
        backScrollView.contentSize = CGSizeMake(256, scrolContHeight);
        infoImage.frame = CGRectMake(0, 59.5, 291, infoImageHeight);
        infoImage.backgroundColor = [UIColor clearColor];
        backScrollView.frame = infoImage.bounds;
        backHeight = backHeight + infoImageHeight +10 + 14;
        
        
    }
    else if (kindsType == CP_KindsOfChooseTypeRandSetting){
        self.backScrollView = nil;
        infoImage = [[UIImageView alloc] init];
        infoImage.userInteractionEnabled = YES;
        [backImageV addSubview:infoImage];
        [infoImage release];
        
        titleLable.frame = CGRectMake(0, 20, 270, 17);
        
        float infoImageHeight = 0;
        float scrolContHeight = 0;
        backScrollView = [[UIScrollView alloc] initWithFrame:infoImage.bounds];
        backScrollView.contentSize = CGSizeMake(256, (([chuanArray count] + 1)/2) *35 +10);
        [backImageV addSubview:backScrollView];
        [backScrollView release];
        changciView = [[ColorView alloc] init];
        //        changciView.font = [UIFont systemFontOfSize:12];
        //        changciView.colorfont = [UIFont systemFontOfSize:12];
        changciView.backgroundColor = [UIColor clearColor];
        changciView.frame = CGRectMake(90, 5, 140, 20);
        changciView.tag  = 300;
        [backScrollView addSubview:changciView];
        changciView.changeColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        changciView.text = self.changCiNum;
        [changciView release];
        NSInteger changhight = 0;
        if ([self.changCiNum length]) {
            changhight += 25;
        }
        
        
        scrolContHeight = scrolContHeight +changhight;
        
        for (int i = 0;i< [dataArray count];i++) {
            UIView *tiView = [[UIView alloc] init];
//            if(i == 0)
//                tiView.backgroundColor = [UIColor orangeColor];
//            else
//                tiView.backgroundColor = [UIColor blueColor];
            [backScrollView addSubview:tiView];
            tiView.tag = i + 1000;
            NSInteger titleHeight = 59.5;
            NSDictionary *data = [dataArray objectAtIndex:i];
            if ([[data objectForKey:@"title"] length]) {
                UIImageView *titleChoseImage = [[UIImageView alloc] init];
                titleChoseImage.frame = CGRectMake(0, 6, 14, 1);
                [tiView addSubview:titleChoseImage];
                titleChoseImage.backgroundColor = [UIColor colorWithRed:193.0/255.0 green:193.0/255.0 blue:193.0/255.0 alpha:1];
                [titleChoseImage release];
                UIImageView *titleChoseImage1 = [[UIImageView alloc] init];
                titleChoseImage1.frame = CGRectMake(84.5, 6, 185.5, 1);
                [tiView addSubview:titleChoseImage1];
                titleChoseImage1.backgroundColor = [UIColor colorWithRed:193.0/255.0 green:193.0/255.0 blue:193.0/255.0 alpha:1];
                [titleChoseImage1 release];
                
                
                UILabel *choseTitle = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 70.5, 14)];
                [tiView addSubview:choseTitle];
                choseTitle.font = [UIFont systemFontOfSize:14];
                choseTitle.textColor = [UIColor colorWithRed:114.0/255.0 green:114.0/255.0 blue:114.0/255.0 alpha:1];
                choseTitle.textAlignment = NSTextAlignmentCenter;
                choseTitle.backgroundColor = [UIColor clearColor];
                choseTitle.text = [data objectForKey:@"title"];
                [choseTitle release];
                titleHeight = 25;
                
            }
            
            NSMutableArray *chooseArray = [data objectForKey:@"choose"];
            if (chooseArray) {
                for (int k = 0; k<[chooseArray count]; k++) {
                    int a = k%6;
                    int b = k/6;
                    CP_PTButton *testBtn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
                    testBtn.frame = CGRectMake(21.5+39*a, 28 + b*39, 30, 30);
                    testBtn.tag = k;
                    testBtn.showShadow = YES;
                    [testBtn addTarget:self action:@selector(selectCicke:) forControlEvents:UIControlEventTouchUpInside];
                    [testBtn loadButonImage:@"btn_gray_selected.png" LabelName:[chooseArray objectAtIndex:k]];
                    testBtn.buttonName.textColor =[UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:1];
                    testBtn.selectTextColor =[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
                    testBtn.nomorTextColor =[UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:1];
    
                    if (i == 0) {
                        
                        testBtn.selectImage = [UIImageGetImageFromName(@"btn_red_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7];
                        
                    }
                    else {
                        
                        testBtn.selectImage = [UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7];
                    }



                    [tiView addSubview:testBtn];
                }
            }
            tiView.frame = CGRectMake(0, scrolContHeight, 270, (([chooseArray count] - 1)/6 + 1) *39 + 28);
            [tiView release];
            scrolContHeight = scrolContHeight + (([chooseArray count] - 1)/6 +1) *39 + 17.5 +titleHeight;
        }
        if (scrolContHeight +10 > 275) {
            infoImageHeight = 275;
        }
        else {
            infoImageHeight = scrolContHeight + 10;
        }
        backScrollView.contentSize = CGSizeMake(270, scrolContHeight);
        infoImage.frame = CGRectMake(0, 59.5, 270, infoImageHeight);

//        infoImage.backgroundColor = [UIColor orangeColor];
        
        backScrollView.frame = infoImage.frame;
        backHeight = backHeight + infoImageHeight +10 + 17.5;
        
        
    }
    
    
    
    
    
    if(kindsType != CP_KindsOfChooseTypeShuZi && kindsType != CP_KindsOfChooseTypeShuZiWithTitle && kindsType != CP_KindsOfChooseTypePKIssue)
    {

        if ([customButtons count]) {
            float btnWith = 0;
            if(kindsType != CP_KindsOfChooseTypeRandSetting)
                btnWith = 291.0/[customButtons count];
            else
                btnWith = 270.0/[customButtons count];

            for (int i = 0; i < [self.customButtons count]; i++) {
                CP_PTButton *btn = [customButtons objectAtIndex:i];
                if(i==0){
                    btn.frame = CGRectMake(btnWith*i, backHeight+4, btnWith-2, 44);
                }
                else{
                    btn.frame = CGRectMake(btnWith*i, backHeight+4, btnWith, 44);

                }
                btn.buttonName.frame = btn.bounds;
                btn.buttonImage.image = [btn.buttonImage.image stretchableImageWithLeftCapWidth:11 topCapHeight:17];
                [backImageV addSubview:btn];
            }
            backHeight = backHeight +48;
        }
        if(kindsType != CP_KindsOfChooseTypeRandSetting)
        {
            backImageV.frame = CGRectMake(10, 100, 291, backHeight);
            
        }
        else
        {
            backImageV.frame = CGRectMake(10, 100, 270, backHeight);
        }
        
        backImageV.image = [backImageV.image imageFromImage:backImageV.image inRect:backImageV.bounds];
        backImageV.center = self.center;
    }
    
    

    
    if (kindsType == CP_KindsOfChooseTypeShuZi || kindsType == CP_KindsOfChooseTypeShuZiWithTitle || kindsType == CP_KindsOfChooseTypePKIssue)
    {
        if(isKuaiLePuKe)
        {
            backImageV.image = UIImageGetImageFromName(@"kuailepukeback.jpg");
        }
        else
        {
            backImageV.backgroundColor = [UIColor whiteColor];
            CGRect rect = CGRectMake(0, 64, 320 , backHeight);
            UIImage *image1 = [[[caiboAppDelegate getAppDelegate] JiePing] gaussianBlur];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6) {
                backImageV.image = [image1 imageFromImage:image1  inRect:CGRectMake(0, rect.origin.y, rect.size.width/2, backImageV.bounds.size.height/2)];
            }
            else {
                backImageV.image = [image1 imageFromImage:image1 inRect:CGRectMake(0, rect.origin.y *2, rect.size.width, rect.size.height)];
            }
            backImageV.alpha = 1.0;
            infoImage.alpha = 0.9;
            infoImage.backgroundColor = [UIColor whiteColor];
            infoImage.frame = CGRectMake(0, infoImage.frame.origin.x, 320 , backHeight);
        }

        [UIView animateWithDuration:0.3 animations:^{
            backImageV.frame = CGRectMake(0, 64, 320 , backHeight);

        } completion:^(BOOL finish){

            
            isClearBtnCanPress = YES;
            if(delegate && [delegate respondsToSelector:@selector(CP_KindsOfChooseViewAlreadyShowed:)])
            {
                [delegate CP_KindsOfChooseViewAlreadyShowed:self];
            }
        }];

    }
    
    if (bdsfBool) {
        if (macthBool ) {
            [self showBDSFFunc];
        }else{
            
            [self hiddenBDSFFunc];
        }
        
    }
    
    
#ifdef isCaiPiaoForIPad
    if (delegate && [delegate isKindOfClass:[UIViewController class]]) {
        self.frame = [(UIViewController *)delegate view].bounds;
        backImageV.center = self.center;
        [[(UIViewController *)delegate view] addSubview:self];
    }
    //    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    //    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    //    rotationAnimation.duration = 0.0f;
    //
    //    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    [backImageV.layer addAnimation:rotationAnimation forKey:@"run"];
    //    backImageV.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    
#else
    if(kindsType != CP_KindsOfChooseTypeShuZi && kindsType != CP_KindsOfChooseTypeShuZiWithTitle && kindsType != CP_KindsOfChooseTypePKIssue)
    {
        [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];

    }

    
#endif
    [backImageV release];
    
    if (jingcaiBool == jingcaizuqiuwf && !isSaiShiShaixuan) {
        if(kindsType != CP_KindsOfChooseTypeRandSetting)
        {
            UIView * allviewup = (UIView *)[backScrollView viewWithTag:1000];
            CP_XZButton * xzbutup = (CP_XZButton *)[allviewup viewWithTag:7];
//            CP_XZButton * xzbutup1 = (CP_XZButton *)[allviewup viewWithTag:8];
//            CP_XZButton * xzbutup3 = (CP_XZButton *)[allviewup viewWithTag:9];
//            CP_XZButton * xzbutup4 = (CP_XZButton *)[allviewup viewWithTag:10];
            CP_XZButton * xzbutup5 = (CP_XZButton *)[allviewup viewWithTag:12];
            CP_XZButton * xzbutup2 = (CP_XZButton *)[allviewup viewWithTag:13];
            
            UIView * allview = (UIView *)[backScrollView viewWithTag:1+1000];
            CP_XZButton * xzbut = (CP_XZButton *)[allview viewWithTag:2];
            CP_XZButton * xzbutgg = (CP_XZButton *)[allview viewWithTag:3];
            
            
            
            if ( (xzbutup.selected == YES && jingcaiBool != jingcaipinglun) || xzbutup2.selected == YES || xzbutup5.selected == YES) {
                xzbut.enabled = NO;
                xzbut.selected = NO;
                xzbutgg.selected = YES;
                xzbut.buttonName.textColor = [UIColor lightGrayColor];
                xzbutgg.buttonName.textColor = [UIColor whiteColor];

            }
            else if(xzbut.selected == YES)
            {
                xzbut.enabled = YES;
                xzbut.buttonName.textColor = [UIColor whiteColor];
            }
            else{
                xzbut.enabled = YES;
                xzbut.buttonName.textColor = [UIColor colorWithRed:72.0/255.0 green:70.0/255.0 blue:64.0/255.0 alpha:1];
            }
        }


    }else if(jingcaiBool == jingcailanqiuwf){
        UIView * allview = (UIView *)[backScrollView viewWithTag:1+1000];
        CP_XZButton * xzbut = (CP_XZButton *)[allview viewWithTag:2];
        CP_XZButton * xzbutgg = (CP_XZButton *)[allview viewWithTag:3];
        
        
        UIView * allviewup = (UIView *)[backScrollView viewWithTag:1000];
        CP_XZButton * xzbutup = (CP_XZButton *)[allviewup viewWithTag:9];
        
        if ( xzbutup.selected == YES)
        {
            xzbut.enabled = NO;
            xzbut.selected = NO;
            xzbutgg.selected = YES;
            xzbut.buttonName.textColor = [UIColor lightGrayColor];

            xzbutgg.buttonName.textColor = [UIColor whiteColor];
        }
        else if(xzbutup.selected == NO && xzbut.selected == YES)
        {
            xzbut.buttonName.textColor = [UIColor whiteColor];
            xzbutgg.buttonName.textColor = [UIColor colorWithRed:72.0/255.0 green:70.0/255.0 blue:64.0/255.0 alpha:1];
        }
        else{
            xzbut.enabled = YES;
            xzbut.buttonName.textColor = [UIColor colorWithRed:72.0/255.0 green:70.0/255.0 blue:64.0/255.0 alpha:1];
            xzbutgg.buttonName.textColor = [UIColor whiteColor];
        }
    }
    
    //    if (self.bjdcType == 1 || self.bjdcType == 2) {
    //        [self showbdsfPlayTileFunc];
    //    }
    
    
    
    if(kindsType != CP_KindsOfChooseTypeShuZi && kindsType != CP_KindsOfChooseTypeShuZiWithTitle && kindsType != CP_KindsOfChooseTypePKIssue)
    {
        if(kindsType == CP_KindsOfChooseTypeRandSetting){
        
            backImageV.image = [UIImageGetImageFromName(@"huntoukuangnew_1.png") stretchableImageWithLeftCapWidth:150 topCapHeight:15];

        }else{
            
            backImageV.image = [UIImageGetImageFromName(@"huntoukuangnew.png") stretchableImageWithLeftCapWidth:150 topCapHeight:30];
        }
    }
    
//    if (onlyDG) {dddd
//        for (int i = 0; i < [self.dataArray count]; i++) {
//            UIView *v = [backScrollView viewWithTag:i+1000];
//            for (CP_XZButton *btn in v.subviews) {
//                if ([btn isKindOfClass:[CP_XZButton class]]) {
//                    if (btn.tag == 9998) {
//                        if (btn.selected ) {
//                            self.onlyDG = YES;
//                        }else{
//                            self.onlyDG = NO;
//                        }
//                    }
//                }
//            }
//            
//        }
//    }
    
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
-(void)disMissWithPressOtherFrame
{
    if(self.isClearBtnCanPress)
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            backImageV.frame = CGRectMake(0, backImageV.frame.origin.y-backImageV.frame.size.height, 320 , backImageV.frame.size.height);
            self.alpha = 0;
            
        } completion:^(BOOL finish){
            
            
            if(self.superview){
                
                [self removeFromSuperview];
                
                if(delegate && [delegate respondsToSelector:@selector(disMissWithPressOtherFrame:)])
                {
                    [delegate disMissWithPressOtherFrame:self];
                    
                }
                
            }
            

        }];
    }
    
}
- (void)dismissWithCancleClickedButton:(UIButton *)sender {
    [self alertViewclickButton:sender];
}

- (void)alertViewclickButton:(UIButton *)sender  {
    if (is3D) {
        if (sender.tag == 1) {
            NSMutableArray * returnArray = [NSMutableArray array];
            
            for (int i = 0; i < [kongzhiType count]; i++) {
                UIView * allview = (UIView *)[backScrollView viewWithTag:i+1000];
                
                NSMutableDictionary * dictkong = [kongzhiType objectAtIndex:i];
                NSMutableArray * kongtypearr = [dictkong objectForKey:@"choose" ];
                
                NSMutableArray * partArray = [NSMutableArray array];
                
                for (int k = 0; k < [kongtypearr count]; k++) {
                    CP_XZButton * xzbut = (CP_XZButton *)[allview viewWithTag:(i + 1) * 100 + k];
                    if (xzbut.selected) {
                        [partArray addObject:@"1"];
                        [[[kongzhiType objectAtIndex:i] objectForKey:@"choose"] replaceObjectAtIndex:k withObject:@"1"];
                    }else{
                        [partArray addObject:@"0"];
                        [[[kongzhiType objectAtIndex:i] objectForKey:@"choose"] replaceObjectAtIndex:k withObject:@"0"];
                    }
                }
                [returnArray addObject:partArray];
            }
            [delegate CP_KindsOfChooseView:self didDismissWithButtonIndex:sender.tag returnArray:returnArray kongtype:kongzhiType];
            
        }
        
        [UIView beginAnimations:@"nddd" context:NULL];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.alpha = 0;
        [UIView commitAnimations];
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5];

        
        return;
    }
    if (delegate && [delegate respondsToSelector:@selector(CP_KindsOfChooseView:chuanButtonIndex:typeArrya:)]) {
        
        
        for (CP_XZButton *v in backScrollView.subviews) {
            if ([v isKindOfClass:[CP_XZButton class]]) {
                NSLog(@"bu = %@", v.buttonName.text);
                if (v.selected == YES) {
                    [chuantype replaceObjectAtIndex:v.tag withObject:@"1"];
                }else{
                    [chuantype replaceObjectAtIndex:v.tag withObject:@"0"];
                }
            }
        }
        
        [delegate CP_KindsOfChooseView:self chuanButtonIndex:sender.tag typeArrya:chuantype];
        
    }
    
    if(delegate && [delegate respondsToSelector:@selector(CP_KindsOfChooseView:didDismissWithButtonIndex:returnKongZhiType:)]){
    
    
        if(kindsType == CP_KindsOfChooseTypeKongZhi){
        
            [delegate CP_KindsOfChooseView:self didDismissWithButtonIndex:sender.tag returnKongZhiType:self.kongzhi_Type];
        }
    }
    
    if (delegate &&[delegate respondsToSelector:@selector(CP_KindsOfChooseView:didDismissWithButtonIndex:returnArray:kongtype:)]) {
        NSMutableArray *returArray = [NSMutableArray array];
        if (kindsType == CP_KindsOfChooseTypeShuZi ||kindsType == CP_KindsOfChooseTypeShuZiWithTitle|| kindsType == CP_KindsOfChooseTypeChuan ||kindsType == CP_KindsOfChooseTypePKIssue) {
            for (CP_XZButton *btn in backScrollView.subviews) {
                if ([btn isKindOfClass:[CP_XZButton class]] && btn.selected)
                {
                    if(isHaveTitle)
                    {
                        int tag = 0;
                        if(btn.tag >= 100 && btn.tag < 200)
                        {
                            tag = btn.tag%100;
                        }
                        if(btn.tag >= 200 && btn.tag < 300)
                        {
                            tag = btn.tag%200+ [[everyTitleBtnCount objectAtIndex:0] intValue];
                        }
                        if(btn.tag >= 300 && btn.tag < 400)
                        {
                            tag = btn.tag%300+[[everyTitleBtnCount objectAtIndex:0] intValue]+[[everyTitleBtnCount objectAtIndex:1] intValue];
                        }
                        
                        
                        [returArray addObject:[chuanArray objectAtIndex:tag]];

                    }
                    else
                    {
                        [returArray addObject:[chuanArray objectAtIndex:btn.tag]];

                    }
                }
            }
        }
        else if (kindsType == CP_KindsOfChooseTypeKongZhi) {
            returArray = [self retunChooseArray];
            
        }
        else if (kindsType == CP_KindsOfChooseTypeRandSetting) {
            returArray = [self returnRandArray];
        }

        if (duoXuanArr) {
            if (sender.tag == 1) {
                for (int i = 0; i < [duoXuanArr count]; i++) {
                    UIView * allview = (UIView *)[backScrollView viewWithTag:i+1000];
                    
                    NSMutableDictionary * dictkong = [duoXuanArr objectAtIndex:i];
                    NSMutableArray * kongtypearr = [dictkong objectForKey:@"choose" ];
                    
                    for (int k = 0; k < [kongtypearr count]; k++) {
                        CP_XZButton * xzbut = nil;
                        if (jingcaiBool == beidan) {
                            xzbut = (CP_XZButton *)[allview viewWithTag:k+[kongtypearr count]+i*100];
                        }else{
                            xzbut = (CP_XZButton *)[allview viewWithTag:k+[kongtypearr count]];
                        }
                        
                        NSLog(@"k = %@", [kongtypearr objectAtIndex:k]);
                        
                        if (xzbut.selected == YES) {
                            [kongtypearr replaceObjectAtIndex:k withObject:@"1"];
                        }else{
                            [kongtypearr replaceObjectAtIndex:k withObject:@"0"];
                        }
                        
                        
                    }
                    [duoXuanArr replaceObjectAtIndex:i withObject:dictkong];
                    
                }
                for (int i = 0; i < [self.dataArray count]; i++) {
                    UIView *v = [backScrollView viewWithTag:i+1000];
                    for (CP_XZButton *btn in v.subviews) {
                        if ([btn isKindOfClass:[CP_XZButton class]]) {
                            if (btn.tag == 9999) {
                                if (btn.selected ) {
                                    self.zhuanjiaBool = YES;
                                }else{
                                    self.zhuanjiaBool = NO;
                                }
                            }
                            if (btn.tag == 9998) {
                                if (btn.selected ) {
                                    self.onlyDG = YES;
                                }else{
                                    self.onlyDG = NO;
                                }
                            }
                        }
                    }
                    
                }
                
                if(CP_KindsOfChooseTypeKongZhi){
                
                    
                }
                
                [delegate CP_KindsOfChooseView:self didDismissWithButtonIndex:sender.tag returnArray:returArray kongtype:duoXuanArr];
            }
            
            
            
            
            
        }else{
            if (sender.tag == 1 || kindsType == CP_KindsOfChooseTypeShuZi || kindsType == CP_KindsOfChooseTypeShuZiWithTitle || kindsType == CP_KindsOfChooseTypePKIssue) {
                NSInteger countj = 0;
                
                for (int i = 0; i < [kongzhiType count]; i++) {
                    UIView * allview = (UIView *)[backScrollView viewWithTag:i+1000];
                    
                    NSMutableDictionary * dictkong = [kongzhiType objectAtIndex:i];
                    NSMutableArray * kongtypearr = [dictkong objectForKey:@"choose" ];
                    
                    for (int k = 0; k < [kongtypearr count]; k++) {
                        CP_XZButton * xzbut = (CP_XZButton *)[allview viewWithTag:k+[kongtypearr count]];
                        NSLog(@"k = %@", [kongtypearr objectAtIndex:k]);
                        
                        if (xzbut.tag == sender.tag) {
                            countj = i;
                            break;
                        }
                        
                        
                    }
                    
                    
                }
                
                
                UIView * allview = (UIView *)[backScrollView viewWithTag:countj+1000];
                
                NSMutableDictionary * dictkong = [kongzhiType objectAtIndex:countj];
                NSMutableArray * kongtypearr = [dictkong objectForKey:@"choose" ];
                
                for (int k = 0; k < [kongtypearr count]; k++) {
                    CP_XZButton * xzbut = (CP_XZButton *)[allview viewWithTag:k+[kongtypearr count]];
                    NSLog(@"k = %@", [kongtypearr objectAtIndex:k]);
                    
                    if (xzbut.tag == sender.tag) {
                        
                        NSString * str = [NSString stringWithFormat:@"1" ];
                        [kongtypearr replaceObjectAtIndex:k withObject:str];
                        xzbut.selected = YES;
                        
                    }else{
                        NSString * str = [NSString stringWithFormat:@"0" ];
                        [kongtypearr replaceObjectAtIndex:k withObject:str];
                        xzbut.selected = NO;
                    }
                    
                    
                }
                
                [kongzhiType replaceObjectAtIndex:countj withObject:dictkong];
                [delegate CP_KindsOfChooseView:self didDismissWithButtonIndex:sender.tag returnArray:returArray kongtype:kongzhiType];
                
            }
            
        }
        
        
    }
    
    if(kindsType == CP_KindsOfChooseTypeShuZi || kindsType== CP_KindsOfChooseTypeShuZiWithTitle || kindsType == CP_KindsOfChooseTypePKIssue)
    {
        [self disMissWithPressOtherFrame];
        NSLog(@"点选项----普通投注or胆拖");
    }
    else
    {
        [UIView beginAnimations:@"nddd" context:NULL];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.alpha = 0;
        [UIView commitAnimations];
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5];
    }
    

}
-(void)removeFromSuperview
{
    [super removeFromSuperview];
    
    if(delegate && [delegate respondsToSelector:@selector(chooseViewDidRemovedFromSuperView:)])
    {
        [delegate chooseViewDidRemovedFromSuperView:self];
    }
}
- (void)dealloc {
    //    [issueTypeArray release];
    //    [qtissueString release];
    //    [sfissueString release];
    //    [sfIssueArray release];
    [everyTitleBtnCount release];
    [footData release];
    [kongzhiType release];
    [chuantype release];
    self.title = nil;
    self.delegate = nil;
    self.chuanArray = nil;
    self.customButtons = nil;
    self.changCiNum = nil;
    self.dataArray = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    