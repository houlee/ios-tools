//
//  V1PinBaseViewContrllor.m
//
//  Created by v1 on 15/4/21.
//  Copyright (c) 2015年 v1. All rights reserved.
//

#import "V1PinBaseViewContrllor.h"
#import "SharedMethod.h"

@interface V1PinBaseViewContrllor ()

@property (nonatomic, strong) UILabel *title_nav_lab;

@end

@implementation V1PinBaseViewContrllor

- (void)loadView{
    [super loadView];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = TEXTWITER_COLOR;
    HEIGHTBELOESYSSEVER = 0.0f;
    if (IS_IOS7) {
        HEIGHTBELOESYSSEVER=20.0f;
    }
    

#if defined DONGGEQIU
    _navView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MyWidth, HEIGHTBELOESYSSEVER+44)];
    _navView.image=[UIImage imageNamed:@"navBarBg"];
    _navView.backgroundColor= [UIColor clearColor];
    _navView.userInteractionEnabled=YES;
    [self.view addSubview:_navView];
#else
    _navView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, MyWidth, HEIGHTBELOESYSSEVER+44)];
    _navView.backgroundColor= [UIColor colorWithRed:21.0/255 green:136.0/255 blue:218.0/255 alpha:1.0];
    [self.view addSubview:_navView];
#endif

    
    _title_nav_lab=[[UILabel alloc] initWithFrame:CGRectMake(MyWidth/2-100, HEIGHTBELOESYSSEVER, 200, 44)];
    _title_nav_lab.text=self.title_nav;
    _title_nav_lab.backgroundColor = [UIColor clearColor];
    _title_nav_lab.textColor=TEXTWITER_COLOR;
    _title_nav_lab.textAlignment=NSTextAlignmentCenter;
    _title_nav_lab.font = FONTTHIRTY_TWO;
    [_navView addSubview:_title_nav_lab];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)creatNavView{
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, 60, HEIGHTBELOESYSSEVER+44)];
    backBtn.backgroundColor=[UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"csnavawhiteback.png"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"csnavawhiteback.png"] forState:UIControlStateSelected];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(HEIGHTBELOESYSSEVER+15, 15, 14, 33)];
    [_navView addSubview:backBtn];
    _popBackBtn=backBtn;
    [_popBackBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)rightImgAndAction:(UIImage *)img target:(id)target action:(SEL)action{
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(MyWidth-60, 0, 60, HEIGHTBELOESYSSEVER+44)];
    [rightBtn setImage:img forState:UIControlStateNormal];
    [rightBtn setImage:img forState:UIControlStateHighlighted];
    [rightBtn setImage:img forState:UIControlStateSelected];
    rightBtn.backgroundColor=[UIColor clearColor];
    [_navView addSubview:rightBtn];
    _rightBtn=rightBtn;
    [_rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)rightImgAndAction:(UIImage *)img btnText:(NSString *)btnText target:(id)target action:(SEL)action{
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(MyWidth-62, 0, 62, HEIGHTBELOESYSSEVER+44)];
    [rightBtn rightImgAndAction:img btnText:btnText target:target action:action];
    [_navView addSubview:rightBtn];
    _rightBtn=rightBtn;
}

- (void)setTitle_nav:(NSString *)navTitle{
    _title_nav_lab.text=navTitle;
    
    CGSize btnsize=[PublicMethod setNameFontSize:navTitle andFont:FONTTHITY_EITBLOD andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGRect rect=_title_nav_lab.frame;
    rect.origin.y=HEIGHTBELOESYSSEVER-btnsize.height/2+22;
    rect.size.height=btnsize.height;
    [_title_nav_lab setFrame:rect];
}

- (void)setIsCrazySport:(BOOL)isCrazySport{
    if (isCrazySport) {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+43.5, MyWidth, 0.5)];
        view.backgroundColor=SEPARATORCOLOR;
        [_navView addSubview:view];
    }
}

- (void)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    if ([NSStringFromClass(self.class) hasPrefix:@"CS_"]) {
//        if ([NSStringFromClass(self.class) isEqualToString:@"CS_ConsultViewController"] || [NSStringFromClass(self.class) isEqualToString:@"CS_ConsultChannelViewController"]) {
//            _navView.backgroundColor = [UIColor colorWithRed:223/255.0 green:48/255.0 blue:49/255.0 alpha:1.0];
//            _title_nav_lab.textColor = [UIColor whiteColor];
//        }else{
            _navView.backgroundColor = [UIColor colorWithRed:247/255.0 green:249/255.0 blue:253/255.0 alpha:1.0];
            _title_nav_lab.textColor = [UIColor blackColor];
//        }
    }
}
- (void)changeCSTitileColor {
    
    _navView.backgroundColor = CS_NAVAGATION_COLOR;
    _title_nav_lab.textColor = [UIColor whiteColor];
    
    UIImageView *lineIma = [[UIImageView alloc]init];
    lineIma.frame = CGRectMake(0, _navView.frame.size.height-0.5, 320, 0.5);
    lineIma.backgroundColor = SEPARATORCOLOR;
    lineIma.tag = 123;
    [_navView addSubview:lineIma];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation UIButton(CS_CircleRightBtn)

- (void)rightImgAndAction:(UIImage *)img btnText:(NSString *)btnText target:(id)target action:(SEL)action{
    float height = 0.0f;
    if (IS_IOS7) {
        height=20.0f;
    }
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0.5, height+16, 13.5, 13)];
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:img forState:UIControlStateHighlighted];
    [btn setImage:img forState:UIControlStateSelected];
    btn.backgroundColor=[UIColor clearColor];
    [self addSubview:btn];
    
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(btn)+5, height+14.3, 28, 17)];
    lab.text=btnText;
    lab.font=FONTTWENTY_EIGHT;
    lab.textColor=BLACK_EIGHTYSEVER;
    [self addSubview:lab];

    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end



int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    