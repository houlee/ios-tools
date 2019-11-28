//
//  PurchaseAlertView.m
//  caibo
//
//  Created by zhoujunwang on 16/8/5.
//
//

#import "PurchaseAlertView.h"
#import "CP_PTButton.h"
#import "SepratorLineView.h"
#import "caiboAppDelegate.h"
#import "SMGDetailViewController.h"
#import "LegMatchModel.h"

@interface PurchaseAlertView()

@property(nonatomic,strong)UIButton *selBtn;

@end

@implementation PurchaseAlertView

- (id)initWithTitle:(NSString *)title delegate:(id )delegates cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    self.userInteractionEnabled = YES;
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
        self.customButtons = [NSMutableArray array];
        self.delegate = delegates;
        self.title = title;
        id eachObject;
        va_list argList;
        int i = 0;
        
        if (cancelButtonTitle) {
            CP_PTButton *canclebutton =[[CP_PTButton alloc] initWithFrame:CGRectZero];
            canclebutton.tag =i;
            i++;
            canclebutton.backgroundColor = [UIColor clearColor];
            [canclebutton loadButonImage:nil LabelName:cancelButtonTitle];
            canclebutton.buttonName.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
            [canclebutton addTarget:self action:@selector(dismissWithCancleClickedButton:) forControlEvents:UIControlEventTouchUpInside];
            [canclebutton setTitleColor:BLACK_EIGHTYSEVER forState:UIControlStateNormal];
            [canclebutton setTitleColor:BLACK_EIGHTYSEVER forState:UIControlStateHighlighted];
            [_customButtons addObject:canclebutton];
        }
        if (otherButtonTitles) {
            CP_PTButton *button =[[CP_PTButton alloc] initWithFrame:CGRectZero];
            button.tag =i;
            i++;
            button.backgroundColor = [UIColor clearColor];
            [button loadButonImage:nil LabelName:otherButtonTitles];
            button.buttonName.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
            [button addTarget:self action:@selector(alertViewclickButton:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:BLACK_EIGHTYSEVER forState:UIControlStateNormal];
            [button setTitleColor:BLACK_EIGHTYSEVER forState:UIControlStateHighlighted];
            [_customButtons addObject:button];
            
            va_start(argList,otherButtonTitles);
            eachObject=va_arg(argList,id);
            
            while (eachObject) {
                CP_PTButton *_button =[[CP_PTButton alloc] initWithFrame:CGRectZero];
                _button.tag =i;
                i++;
                _button.backgroundColor = [UIColor clearColor];
                [_button loadButonImage:nil LabelName:eachObject];

                button.buttonName.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];

                [_button addTarget:self action:@selector(alertViewclickButton:) forControlEvents:UIControlEventTouchUpInside];
                [_customButtons addObject:_button];
                eachObject=va_arg(argList,id);
            }
            va_end(argList);
        }
    }
    return self;
}

- (void)show:(NSArray *)arr{
    UIImageView *backImageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 100, 290, 363)];
    backImageV.center = self.center;
    backImageV.image = [UIImageGetImageFromName(@"shuZiAlertBG1.png") stretchableImageWithLeftCapWidth:0 topCapHeight:22];
    backImageV.userInteractionEnabled = YES;
    [self addSubview:backImageV];
    
    CGSize titleLabelSize = [self.title sizeWithFont:FONTTHIRTYBOLD constrainedToSize:CGSizeMake(INT_MAX, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 15, backImageV.frame.size.width, titleLabelSize.height)];
    titleLabel.textColor = BLACK_EIGHTYSEVER;
    titleLabel.font = FONTTHIRTY;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = self.title;
    [backImageV addSubview:titleLabel];
    
    CGSize gmSize=[PublicMethod setNameFontSize:@"购买" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    for (int i=0; i<4; i++) {
        PurchaseMdl *purchaseMdl=[arr objectAtIndex:i];
        UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 48+55*i, 290, 55)];
        bgView.backgroundColor=[UIColor whiteColor];
        bgView.userInteractionEnabled=YES;
        [backImageV addSubview:bgView];
        
        ShenDanAlertCell *sdAlertView=[[ShenDanAlertCell alloc] initWithFrame:CGRectMake(0, 0, 257-gmSize.width, 55) indexPath:i];
        sdAlertView.btnTag=purchaseMdl.code;
        sdAlertView.backgroundColor=[UIColor clearColor];
        [bgView addSubview:sdAlertView];
        [_btnArr addObject:sdAlertView.optBtn];
        
        if (i<3) {
            UIView *sepratorLineView=[[UIView alloc] initWithFrame:CGRectMake(15, 54.5, 260, 0.5)];
            sepratorLineView.backgroundColor=SEPARATORCOLOR;
            [sdAlertView addSubview:sepratorLineView];
        }
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSelPlan:)];
        sdAlertView.userInteractionEnabled=YES;
        [sdAlertView addGestureRecognizer:tap];
        
        NSString *isbuy=@"0";
        isbuy=purchaseMdl.is_buy;
        NSArray *textArr=[purchaseMdl.explain componentsSeparatedByString:@"#"];
        NSString *uptext=[textArr objectAtIndex:0];
        NSString *downtext=@"";
        if ([textArr count]==2) {
            downtext=[textArr objectAtIndex:1];
        }
        [sdAlertView isBuy:isbuy upText:uptext downText:downtext nameText:purchaseMdl.name];
        
        if ([isbuy isEqualToString:@"0"]) {
            CGSize sdSize=[PublicMethod setNameFontSize:@"购买" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            UIButton *purchaseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            purchaseBtn.frame=CGRectMake(ORIGIN_X(sdAlertView), 0, sdSize.width+33, 55);
            [purchaseBtn setTitle:@"购买" forState:UIControlStateNormal];
            [purchaseBtn setTitleColor:[UIColor colorWithHexString:@"#1588DA"] forState:UIControlStateNormal];
            purchaseBtn.titleLabel.font=FONTTWENTY_FOUR;
            purchaseBtn.tag=[purchaseMdl.code integerValue];
            [bgView addSubview:purchaseBtn];
            [purchaseBtn setTitleEdgeInsets:UIEdgeInsetsMake(27.5-sdSize.height/2,13,27.5-sdSize.height/2,20)];
            [purchaseBtn addTarget:self action:@selector(clicksk:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    CGSize dealSize=[PublicMethod setNameFontSize:@"彩民购买彩票专家方案协议" andFont:FONTTWENTY_EIGHT andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];

    UIImageView *imgV=[[UIImageView alloc] initWithFrame:CGRectMake(15, 268+20, 18, 18)];
    imgV.image=[UIImage imageNamed:@"勾选中"];
    if (imgV.frame.origin.x < 2) {
        imgV.frame = CGRectMake(2, 268+15, 18, 18);
    }
    imgV.tag=101;
    [backImageV addSubview:imgV];
    
    UITapGestureRecognizer *clickTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
    imgV.userInteractionEnabled=YES;
    [imgV addGestureRecognizer:clickTap];
    
    UILabel *dealLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgV.frame)+10, CGRectGetMinY(imgV.frame), dealSize.width + 20, 18)];
    dealLabel.text=@"彩民购买彩票专家方案协议";
    dealLabel.backgroundColor = [UIColor clearColor];
    dealLabel.font=FONTTWENTY_FOUR;
    dealLabel.textColor=BLACK_EIGHTYSEVER;
    [backImageV addSubview:dealLabel];
    
    UITapGestureRecognizer *clickDealTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPuchsPlanDealTap:)];
    dealLabel.userInteractionEnabled=YES;
    [dealLabel addGestureRecognizer:clickDealTap];
    
    float btnWith = backImageV.frame.size.width/[_customButtons count];
    for (int i = 0; i < [self.customButtons count]; i++) {
        CP_PTButton *btn = [_customButtons objectAtIndex:i];
        btn.frame = CGRectMake(btnWith*i, backImageV.frame.size.height - 44, btnWith, 44);
        btn.buttonName.frame = btn.bounds;
        btn.buttonName.font = [UIFont systemFontOfSize:18];
        btn.buttonName.textColor = [UIColor blackColor];
        btn.backgroundColor = [UIColor clearColor];
        [backImageV addSubview:btn];
    }
    
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
}

- (void)clickSelPlan:(UITapGestureRecognizer *)tap{
    if(_selBtn){
        _selBtn.selected=NO;
    }
    ShenDanAlertCell *alertView=(ShenDanAlertCell *)tap.view;
    _selBtn=(UIButton *)[alertView viewWithTag:505];
    _selBtn.selected=YES;
    __weak __typeof(SMGDetailViewController *)weakself=_smgVc;
    _smgVc.selPlanBlock=^(){
        weakself.selTag=alertView.btnTag;
    };
    [_smgVc selPlanBlock:_smgVc.selPlanBlock];
}

- (void)clicksk:(UIButton *)btn{
    __weak __typeof(SMGDetailViewController *)weakself=_smgVc;
    _smgVc.selPlanPurchaseBlock=^(){
        weakself.selPurchaseTag= [NSString stringWithFormat:@"%ld",(long)btn.tag];
        [self removeFromSuperview];
    };
    [_smgVc selPlanPurchaseBlock:_smgVc.selPlanPurchaseBlock];
}

- (void)dismissWithCancleClickedButton:(UIButton *)sender {
    if(sender != nil)
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissWithCancleClickedButton:) object:nil];
    [self alertViewclickButton:sender];
}

- (void)alertViewclickButton:(UIButton *)sender {
    if (_delegate &&[_delegate respondsToSelector:@selector(purchaseAlertView:didDismissWithButtonIndex:)]) {
        [_delegate purchaseAlertView:self didDismissWithButtonIndex:sender.tag];
    }
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.alpha = 0;
    [UIView commitAnimations];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5];
}

- (void)clickTap:(UITapGestureRecognizer *)sender{
    UIImageView *imgView=(UIImageView *)sender.view;
    CP_PTButton *btn = [_customButtons objectAtIndex:[_customButtons count]-1];
    if (imgView.tag==101) {
        imgView.image=[UIImage imageNamed:@"未勾选"];
        imgView.tag=102;
        btn.enabled=NO;
        btn.buttonName.textColor = [UIColor colorWithRed:165.0/255.0 green:165.0/255.0 blue:165.0/255.0 alpha:1.0];
    }else if(imgView.tag==102){
        imgView.image=[UIImage imageNamed:@"勾选中"];
        imgView.tag=101;
        btn.enabled=YES;
        btn.buttonName.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
    }
}

- (void)clickPuchsPlanDealTap:(UITapGestureRecognizer *)sender{
    if (_delegate&&[_delegate respondsToSelector:@selector(purchaseAlertView:clickPuchsPlanDealTap:)]) {
        [_delegate purchaseAlertView:self clickPuchsPlanDealTap:sender];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

@implementation  ShenDanAlertCell

-(id)initWithFrame:(CGRect)frame indexPath:(NSInteger)indexPath
{
    if (self=[super initWithFrame:frame]) {
        UIButton *optBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [optBtn setFrame:CGRectMake(15, 21.5, 12, 12)];
        [optBtn setImage:[UIImage imageNamed:@"sd_opt_normal"] forState:UIControlStateNormal];
        [optBtn setImage:[UIImage imageNamed:@"sd_opt_selected"] forState:UIControlStateSelected];
        optBtn.tag=505;
        [self addSubview:optBtn];
        self.optBtn=optBtn;
        
        UIButton *planBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [planBtn setFrame:CGRectMake(ORIGIN_X(optBtn)+10,12.5,70,30)];
        NSString *imgBtn=@"";
        if(indexPath==0){
            imgBtn=@"sd_by_V2";
        }else if(indexPath==1){
            imgBtn=@"sd_by_V1";
        }else if(indexPath==2){
            imgBtn=@"sd_bc";
        }else if(indexPath==3){
            imgBtn=@"sd_dx";
        }
        [planBtn setBackgroundImage:[UIImage imageNamed:imgBtn] forState:UIControlStateNormal];
        [planBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        planBtn.titleLabel.font=FONTTWENTY_FOUR;
        [self addSubview:planBtn];
        self.planBtn=planBtn;
        
        UILabel *upLab=[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(planBtn)+10, 0, 0, 0)];
        upLab.font=[UIFont systemFontOfSize:11];
        upLab.textColor=BLACK_FIFITYFOUR;
        upLab.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        upLab.textAlignment=NSTextAlignmentRight;
        [self addSubview:upLab];
        self.upLab=upLab;
        
        UILabel *downLab=[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(planBtn)+20, 0, 0, 0)];
        downLab.font=[UIFont systemFontOfSize:11];
        downLab.textColor=BLACK_EIGHTYSEVER;
        [self addSubview:downLab];
        self.downLab=downLab;
    }
    return self;
}

-(void)isBuy:(NSString *)isBuy upText:(NSString *)upText downText:(NSString *)downText nameText:(NSString *)nameText
{
    if ([isBuy isEqualToString:@"0"]) {
        self.userInteractionEnabled=NO;
    }else{
        self.userInteractionEnabled=YES;
    }
    
    [self.planBtn setTitle:nameText forState:UIControlStateNormal];
    
    if (![downText isEqualToString:@""]) {
        [SharedMethod getSizeByText:upText font:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:self.upLab.lineBreakMode];
        CGSize textSize=[PublicMethod setNameFontSize:upText andFont:[UIFont systemFontOfSize:11] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        self.upLab.attributedText=[self attrString:upText];
        self.upLab.frame=CGRectMake(self.frame.size.width-textSize.width, 25-textSize.height, textSize.width,textSize.height);
        
        NSString *attStr=[self attrString:downText].string;
        textSize=[PublicMethod setNameFontSize:attStr andFont:[UIFont systemFontOfSize:11] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        
        self.downLab.attributedText= [self attrString:downText];
        self.downLab.hidden=NO;
        self.downLab.frame=CGRectMake(self.frame.size.width-textSize.width, 30, textSize.width,textSize.height);
    }else{
        CGSize textSize=[PublicMethod setNameFontSize:upText andFont:[UIFont systemFontOfSize:11] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        self.upLab.frame=CGRectMake(self.frame.size.width-textSize.width, (55-textSize.height)/2, textSize.width,textSize.height);
        self.upLab.attributedText=[self attrString:upText];
        self.downLab.hidden=YES;
    }
}

- (NSAttributedString *)attrString:(NSString *)str{
    if([str rangeOfString:@"<"].location!=NSNotFound){
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        NSRange rangeForward=[str rangeOfString:@"<"];
        NSRange rangeLater=[str rangeOfString:@">"];
        NSRange rangMake=NSMakeRange(rangeForward.location, rangeLater.location-rangeForward.location-1);
        [attributes setObject:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#1588da"]} forKey:NSStringFromRange(rangMake)];
        str=[str stringByReplacingOccurrencesOfString:@"<" withString:@""];
        str=[str stringByReplacingOccurrencesOfString:@">" withString:@""];
        NSArray *keys = [attributes allKeys];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        for (NSString *key in keys) {
            NSRange range = NSRangeFromString(key);
            NSDictionary *attr = [attributes objectForKey:key];
            [attrStr setAttributes:attr range:range];
        }
        return attrStr;
    }
    else
    return [[NSMutableAttributedString alloc] initWithString:str];
}

@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    