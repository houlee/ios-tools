//
//  CP_UIAlertView.m
//  iphone_control
//
//  Created by yaofuyu on 12-12-5.
//  Copyright (c) 2012年 yaofuyu. All rights reserved.
//

#import "CP_UIAlertView.h"
#import "CP_PTButton.h"
#import "UIImageExtra.h"
#import "caiboAppDelegate.h"
#import "CP_SWButton.h"
#import "HeaderLabel.h"
#import "MoreLoadCell.h"
#import "GC_HttpService.h"
#import "GC_WinningInfoList.h"
#import "JSON.h"
#import "NetURL.h"
#import "CP_UISegement.h"
#import "ImageUtils.h"
#import "ColorView.h"
#import "SharedMethod.h"
#import "GC_UIkeyView.h"

@implementation CP_UIAlertView

@synthesize delegate;
@synthesize title,message;
@synthesize customButtons;
@synthesize shouldRemoveWhenOtherAppear;
@synthesize alertTpye;
@synthesize myTextField;

@synthesize myTableView;
@synthesize exChangeSureFirstCell;
@synthesize exChangeSureSecondCell;
@synthesize exChangeSureThirdCell;
@synthesize allFlagWinningList;
@synthesize pageArray;
@synthesize alertBgButton;

@synthesize imageName;
@synthesize alertSegement;
@synthesize gckeyView;
@synthesize isShowingKeyboard;
@synthesize checkMarkButton;
@synthesize dontDismiss;
@synthesize attributedMessage;
@synthesize messageLabel;
@synthesize agreeTitle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitle:(NSString *)titles message:(NSString *)messages delegate:(id )delegates cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    self.userInteractionEnabled = YES;
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
        self.customButtons = [NSMutableArray array];
        self.pageArray = [NSMutableArray arrayWithCapacity:0];
        self.allFlagWinningList = [NSMutableArray arrayWithCapacity:0];
        self.delegate = delegates;
        
        self.title = titles;
        shouldRemoveWhenOtherAppear = NO;
        self.message = messages;
        id eachObject;
        va_list argList;
        int i = 0;
        
        curPage = 1;

        
        if (cancelButtonTitle) {
            
            CP_PTButton *canclebutton =[[CP_PTButton alloc] initWithFrame:CGRectZero];
            canclebutton.tag =i;
            i++;
            canclebutton.backgroundColor = [UIColor clearColor];
//---------------------------------------------bianpinghua by sichuanlin
//            [canclebutton loadButonImage:@"TYD960.png" LabelName:cancelButtonTitle];
            [canclebutton loadButonImage:nil LabelName:cancelButtonTitle];
            canclebutton.buttonName.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
            [canclebutton addTarget:self action:@selector(dismissWithCancleClickedButton:) forControlEvents:UIControlEventTouchUpInside];
            [canclebutton setTitleColor:[UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];
            [customButtons addObject:canclebutton];
            [canclebutton release];
        }
        if(otherButtonTitles)
        {
            
            
                CP_PTButton *button =[[CP_PTButton alloc] initWithFrame:CGRectZero];
                button.tag =i;
                i++;
                button.backgroundColor = [UIColor clearColor];
//---------------------------------------------bianpinghua by sichuanlin
//                [button loadButonImage:@"TYD960.png" LabelName:otherButtonTitles];
            [button loadButonImage:nil LabelName:otherButtonTitles];
            button.buttonName.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];

                [button addTarget:self action:@selector(alertViewclickButton:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];

                [customButtons addObject:button];
                [button release];

            
            va_start(argList,otherButtonTitles);
            eachObject=va_arg(argList,id);
            while (eachObject) {
                CP_PTButton *_button =[[CP_PTButton alloc] initWithFrame:CGRectZero];
                _button.tag =i;
                i++;
                _button.backgroundColor = [UIColor clearColor];
//---------------------------------------------bianpinghua by sichuanlin
//                [_button loadButonImage:@"TYD960.png" LabelName:eachObject];
                [_button loadButonImage:nil LabelName:eachObject];
                button.buttonName.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
                [button setTitleColor:[UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];
                [_button addTarget:self action:@selector(alertViewclickButton:) forControlEvents:UIControlEventTouchUpInside];
                [customButtons addObject:_button];
                eachObject=va_arg(argList,id);
                [_button release];
            }
            va_end(argList);
        }
        
        //[self layout];
    }
    return self;
}

- (void)dealloc {
    self.agreeTitle = nil;
    self.title = nil;
    self.message = nil;
    self.delegate = nil;
    self.customButtons = nil;
    [myTableView release];
    [allFlagWinningList release];
    [alertSegement release];
 
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [gckeyView release];
    
    [alertBgButton release];
    [checkMarkImageView release];
    [checkMarkButton release];
    
    [attributedMessage release];
    [messageLabel release];
    [msgTextView release];
    
    [super dealloc];
}

- (void)show {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CPAlertApear" object:nil];
    if (shouldRemoveWhenOtherAppear) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeFromSuperview) name:@"CPAlertApear" object:nil];
    }
    UIImageView *backImageV = [[UIImageView alloc] init];
    backImageV.frame = CGRectMake(25, 100, 270, 189.5);
    if(alertTpye==purchasePaln){
        backImageV.frame=CGRectMake(25, 100, 270, 169);
    }
//    NSInteger heightrect = 0;
    
    if ([customButtons count] > 3) {
        backImageV.frame = CGRectMake(25, 100, 270, 155 + [customButtons count] * 40);
    }
    backImageV.center = self.center;
    backImageV.userInteractionEnabled = YES;
    [self addSubview:backImageV];
//    UIImageView *titleImage = nil;
  
    UILabel * titleLabel = nil;
    if (self.title) {
        
        titleLabel = [[[UILabel alloc] init] autorelease];
        titleLabel.text = self.title;
        [backImageV addSubview:titleLabel];
        titleLabel.textColor = [UIColor  blackColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        CGSize titleLabelSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        titleLabel.frame = CGRectMake(0, 15, backImageV.frame.size.width, titleLabelSize.height);
        
    }

    
    if(alertTpye == autoRemoveType)
    {
        [self performSelector:@selector(dismissWithCancleClickedButton:) withObject:nil afterDelay:3];
    }
    if (alertTpye == passWordType || alertTpye == textViewType) {
        
//     UIImageView   *textImageBg = [[UIImageView alloc] initWithFrame:CGRectMake(19, 34, 262, 106)];
//        textImageBg.backgroundColor = [UIColor clearColor];
//        textImageBg.userInteractionEnabled = YES;
//        textImageBg.image = UIImageGetImageFromName(@"msgAlerImge.png");
//        [backImageV addSubview:textImageBg];
//        [textImageBg release];
        
        UIImageView * kuangimage = [[UIImageView alloc] initWithFrame:CGRectMake((backImageV.frame.size.width - 246)/2, ORIGIN_Y(titleLabel) + 38, 246, 33.5)];
        kuangimage.backgroundColor = [UIColor clearColor];
        kuangimage.userInteractionEnabled = YES;
        kuangimage.image = [UIImageGetImageFromName(@"whiteButton.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10];
        [backImageV addSubview:kuangimage];
        [kuangimage release];
        
        myTextField = [[UITextField alloc] initWithFrame:CGRectMake(1, 4.7, 240, 22)];
//        myTextField.placeholder = self.message;
        myTextField.backgroundColor = [UIColor clearColor];
        myTextField.autocorrectionType = UITextAutocorrectionTypeYes;
        if(alertTpye == passWordType){
        
            myTextField.secureTextEntry = YES;

        }
        myTextField.delegate = self;
        myTextField.font = [UIFont systemFontOfSize:15];
        [myTextField becomeFirstResponder];
        [kuangimage addSubview:myTextField];
        [myTextField release];
        
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 220, 22)];
        textLabel.text = self.message;
        [myTextField addSubview:textLabel];
        textLabel.textColor = [UIColor  colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
        textLabel.font = [UIFont boldSystemFontOfSize:15];
//        textLabel.shadowColor = [UIColor whiteColor];//阴影
//        textLabel.shadowOffset = CGSizeMake(0, 1.0);
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.backgroundColor = [UIColor clearColor];
        [textLabel release];
        
        
        
        
    }else if (alertTpye == tableType){
        
        backImageV.frame = CGRectMake(10, 50, 300, 420);
        titleLabel.frame = CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y - 2, backImageV.frame.size.width, titleLabel.frame.size.height);

        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(4, 40, 292, 330) style:UITableViewStylePlain];
        myTableView.delegate =self;
        myTableView.dataSource = self;
        myTableView.showsVerticalScrollIndicator = NO;
        myTableView.backgroundColor = [UIColor clearColor];
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backImageV addSubview:myTableView];
        
    }
    else if (alertTpye == ChongzhiSuccType || alertTpye == ChongzhiFailType || alertTpye == ExchangePointFailType){
    
        UIImageView *okImage = nil;
        NSString *string1 = nil;
        NSString *string2=  nil;
        ColorView *okLabel = [[ColorView alloc] init];
        
        if(alertTpye == ChongzhiSuccType){
            
            okImage = [[UIImageView alloc] initWithFrame:CGRectMake(75, 60, 35, 35)];
            okImage.image = UIImageGetImageFromName(@"chongzhi_ok.png");
            okImage.backgroundColor = [UIColor clearColor];
            [backImageV addSubview:okImage];
            [okImage release];
            
            okLabel.frame = CGRectMake(ORIGIN_X(okImage)+10,68, backImageV.frame.size.width-ORIGIN_X(okImage)+10, 20);

        }
        else if (alertTpye == ExchangePointFailType){
            okImage = [[UIImageView alloc] initWithFrame:CGRectMake(75, 60, 35, 35)];
            okImage.image = UIImageGetImageFromName(@"chongzhi_fail.png");
            okImage.backgroundColor = [UIColor clearColor];
            [backImageV addSubview:okImage];
            [okImage release];
            
            okLabel.frame = CGRectMake(ORIGIN_X(okImage)+5,68, backImageV.frame.size.width-ORIGIN_X(okImage)+10, 40);

            okLabel.isN = YES;
            
            if([[self.message componentsSeparatedByString:@"|"] count] == 2){
                
                string1 = [NSString stringWithFormat:@"%@",[[self.message componentsSeparatedByString:@"|"] objectAtIndex:0]];
                string2 = [NSString stringWithFormat:@"%@",[[self.message componentsSeparatedByString:@"|"] objectAtIndex:1]];
                okLabel.frame = CGRectMake(ORIGIN_X(okImage)+5,68, backImageV.frame.size.width-ORIGIN_X(okImage)+10, 20);
                CGSize size = CGSizeMake(300, 17);
                CGSize size1 = [string2 sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
                UILabel *okLabel1 = [[UILabel alloc] initWithFrame:CGRectMake((backImageV.frame.size.width-size1.width)/2.0, ORIGIN_Y(okImage)+1, size1.width, 20)];
                okLabel1.text = string2;
                okLabel1.backgroundColor = [UIColor clearColor];
                okLabel1.font = [UIFont systemFontOfSize:17];
                okLabel1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                [backImageV addSubview:okLabel1];
                [okLabel1 release];

                
            }
        }
        else{
        
            okLabel.frame = CGRectMake(30,40, 210, 70);
            okLabel.textAlignment = NSTextAlignmentCenter;
            okLabel.jianjuHeight = 10;
            okLabel.isN = YES;




        }
        if(alertTpye == ExchangePointFailType){
        
            okLabel.text = string1;
            
        }
        else{
        
            okLabel.text = self.message;

        }
        okLabel.backgroundColor = [UIColor clearColor];
        okLabel.font = [UIFont systemFontOfSize:17];
        okLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        okLabel.changeColor = [UIColor redColor];
        [backImageV addSubview:okLabel];
        [okLabel release];

    }
    else if (alertTpye == textAndImage)
    {
        backImageV.frame = CGRectMake(25, 100, 270, 355);
        
        UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, 270, 249)];
        grayView.backgroundColor = [UIColor clearColor];
        grayView.layer.masksToBounds = YES;
        grayView.layer.cornerRadius = 5.0;
        grayView.layer.borderColor = [[UIColor grayColor] CGColor];
        [backImageV addSubview:grayView];
        [grayView release];
        
        
        UILabel *mesLabel = [[UILabel alloc] init];
        
        UIFont *font = [UIFont systemFontOfSize:15];
        CGSize size = CGSizeMake(266, 200);
        CGSize fontSize = [self.message sizeWithFont:font constrainedToSize:size];
        
        mesLabel.frame = CGRectMake(0, 35, 266, fontSize.height);
        
        mesLabel.backgroundColor = [UIColor clearColor];
        mesLabel.text = self.message;
        mesLabel.font = [UIFont systemFontOfSize:15];
        mesLabel.lineBreakMode = NSLineBreakByWordWrapping;
        mesLabel.textAlignment = NSTextAlignmentCenter;
        mesLabel.numberOfLines = 0;
        [grayView addSubview:mesLabel];
        [mesLabel release];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageName]];
        if([self.imageName isEqualToString:@"anti-addiction_1.png"])
        {
            imageView.frame = CGRectMake(90, mesLabel.frame.origin.y+mesLabel.frame.size.height+20, 120, 126);
        }
        if([self.imageName isEqualToString:@"anti-addiction_2.png"])
        {
            imageView.frame = CGRectMake(100, mesLabel.frame.origin.y+mesLabel.frame.size.height+40, 99,97);
        }
        if([self.imageName isEqualToString:@"anti-addiction_3.png"])
        {
            imageView.frame = CGRectMake(94, mesLabel.frame.origin.y+mesLabel.frame.size.height+42, 88, 78);
        }
        imageView.backgroundColor = [UIColor clearColor];
        [grayView addSubview:imageView];
        [imageView release];
        

    }
    else if (alertTpye == howGetFlag){
    
        
        backImageV.frame = CGRectMake(25, 100, 270, 330);
        
        UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(7, 36, 286, 240)];
        grayView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
        grayView.layer.masksToBounds = YES;
        grayView.layer.cornerRadius = 5.0;
        grayView.layer.borderColor = [[UIColor grayColor] CGColor];
        [backImageV addSubview:grayView];
        [grayView release];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(16, 19, 254, 17)];
        label1.text = @"购买世界杯比赛,即可赢取到该国家的国旗。";
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:13];
        label1.textAlignment = NSTextAlignmentCenter;
        [grayView addSubview:label1];
        [label1 release];
        
        
        UIImageView *xianImage = [[UIImageView alloc] initWithFrame:CGRectMake(16, label1.frame.origin.y+label1.frame.size.height+10, 254, 1)];
        [xianImage setImage:[UIImage imageNamed:@"jifen_xian.png"]];
        xianImage.backgroundColor = [UIColor clearColor];
        [grayView addSubview:xianImage];
        [xianImage release];
        
        
        
        UIImageView *tongBei = [[UIImageView alloc] initWithFrame:CGRectMake(18, xianImage.frame.origin.y+xianImage.frame.size.height+22, 54, 54)];
        [tongBei setImage:[UIImage imageNamed:@"CopperCup.png"]];
        [grayView addSubview:tongBei];
        [tongBei release];
        
        UILabel *jiantou = [[UILabel alloc] initWithFrame:CGRectMake(tongBei.frame.origin.x+tongBei.frame.size.width+18, xianImage.frame.origin.y+xianImage.frame.size.height+40, 10, 10)];
        jiantou.text = @">";
        jiantou.backgroundColor = [UIColor clearColor];
        jiantou.textColor = [UIColor colorWithRed:188.0/255.0 green:188.0/255.0 blue:188.0/255.0 alpha:1];
        jiantou.font = [UIFont boldSystemFontOfSize:14];
        [grayView addSubview:jiantou];
        [jiantou release];
        
        UIImageView *yinBei = [[UIImageView alloc] initWithFrame:CGRectMake(jiantou.frame.origin.x+jiantou.frame.size.width+18, xianImage.frame.origin.y+xianImage.frame.size.height+22, 54, 54)];
        [yinBei setImage:[UIImage imageNamed:@"SilverCup.png"]];
        [grayView addSubview:yinBei];
        [yinBei release];
        
        UILabel *jiantou1 = [[UILabel alloc] initWithFrame:CGRectMake(yinBei.frame.origin.x+yinBei.frame.size.width+18, xianImage.frame.origin.y+xianImage.frame.size.height+40, 10, 10)];
        jiantou1.text = @">";
        jiantou1.backgroundColor = [UIColor clearColor];
        jiantou1.textColor = [UIColor colorWithRed:188.0/255.0 green:188.0/255.0 blue:188.0/255.0 alpha:1];
        jiantou1.font = [UIFont boldSystemFontOfSize:14];
        [grayView addSubview:jiantou1];
        [jiantou1 release];
        
        
        UIImageView *jinBei = [[UIImageView alloc] initWithFrame:CGRectMake(jiantou1.frame.origin.x+jiantou1.frame.size.width+18, xianImage.frame.origin.y+xianImage.frame.size.height+22, 54, 54)];
        [jinBei setImage:[UIImage imageNamed:@"GoldCup.png"]];
        [grayView addSubview:jinBei];
        [jinBei release];
        
        UILabel *jiangbeiName = [[UILabel alloc] initWithFrame:CGRectMake(16, tongBei.frame.origin.y+tongBei.frame.size.height+13, 254, 17)];
        jiangbeiName.font = [UIFont boldSystemFontOfSize:14];
        jiangbeiName.textColor = [UIColor colorWithRed:59.0/255.0 green:59.0/255.0 blue:59.0/255.0 alpha:1];
        jiangbeiName.text = @"大力铜杯           大力银杯          大力金杯";
        jiangbeiName.backgroundColor = [UIColor clearColor];
        [grayView addSubview:jiangbeiName];
        [jiangbeiName release];
        
        ColorView *flagLabel = [[ColorView alloc] initWithFrame:CGRectMake(16, jiangbeiName.frame.origin.y+jiangbeiName.frame.size.height+6, 254, 17)];
        flagLabel.text = @"<10>枚国旗          <17>枚国旗         <32>枚国旗";
        flagLabel.font = [UIFont systemFontOfSize:14];
        flagLabel.backgroundColor = [UIColor clearColor];
        flagLabel.changeColor = [UIColor colorWithRed:41.0/255.0 green:154.0/255.0 blue:194.0/255.0 alpha:1];
        flagLabel.textColor = [UIColor colorWithRed:59.0/255.0 green:59.0/255.0 blue:59.0/255.0 alpha:1];
        [grayView addSubview:flagLabel];
        [flagLabel release];
        
        UIButton *huodongRule = [UIButton buttonWithType:UIButtonTypeCustom];
        [huodongRule setFrame:CGRectMake(83, flagLabel.frame.origin.y+flagLabel.frame.size.height+24, 120, 15)];
        [huodongRule setTitle:@"活动规则>>" forState:UIControlStateNormal];
        [huodongRule setTitleColor:[UIColor colorWithRed:41.0/255.0 green:154.0/255.0 blue:194.0/255.0 alpha:1] forState:UIControlStateNormal];
        huodongRule.tag = 1111; //固定tag ， 防止重复
        huodongRule.titleLabel.font = [UIFont systemFontOfSize:14];
        [huodongRule addTarget:self action:@selector(PressRule:) forControlEvents:UIControlEventTouchUpInside];
        [grayView addSubview:huodongRule];
        
        UIView *xiahuaxian = [[UIView alloc] initWithFrame:CGRectMake(105, huodongRule.frame.origin.y+huodongRule.frame.size.height, 72, 1)];
        [xiahuaxian setBackgroundColor:[UIColor colorWithRed:41.0/255.0 green:154.0/255.0 blue:194.0/255.0 alpha:1]];
        [grayView addSubview:xiahuaxian];
        [xiahuaxian release];
        
        
    }
    else if (alertTpye == exChangeSure)
    {
        backImageV.frame = CGRectMake(25, 100, 270, 215);
        
//        UIImageView   *textImageBg = [[UIImageView alloc] initWithFrame:CGRectMake(19, 34, 262, 115)];
//        textImageBg.backgroundColor = [UIColor clearColor];
//        textImageBg.userInteractionEnabled = YES;
//        textImageBg.image = UIImageGetImageFromName(@"msgAlerImge.png");
//        [backImageV addSubview:textImageBg];
//        [textImageBg release];
        
        ColorView *firstCell = [[ColorView alloc] initWithFrame:CGRectMake((backImageV.frame.size.width - 200)/2, ORIGIN_Y(titleLabel) + 16, 270, 17)];
        firstCell.text = self.exChangeSureFirstCell;
        firstCell.backgroundColor = [UIColor clearColor];
        firstCell.font = [UIFont systemFontOfSize:15];
        firstCell.colorfont = [UIFont systemFontOfSize:15];
        firstCell.textColor = [SharedMethod getColorByHexString:@"929292"];
        firstCell.changeColor = [SharedMethod getColorByHexString:@"454545"];
        [backImageV addSubview:firstCell];
        [firstCell release];
        
        ColorView *secondCell = [[ColorView alloc] initWithFrame:CGRectMake(firstCell.frame.origin.x, ORIGIN_Y(firstCell) + 15, 270-firstCell.frame.origin.x, 17)];
        secondCell.text = self.exChangeSureSecondCell;
        secondCell.backgroundColor = [UIColor clearColor];
        secondCell.font = [UIFont systemFontOfSize:15];
        secondCell.colorfont = [UIFont systemFontOfSize:15];
        secondCell.textColor = [SharedMethod getColorByHexString:@"929292"];
        secondCell.changeColor = [SharedMethod getColorByHexString:@"454545"];
        [backImageV addSubview:secondCell];
        [secondCell release];
        
        
        ColorView *thirdCell = [[ColorView alloc] initWithFrame:CGRectMake(secondCell.frame.origin.x, ORIGIN_Y(secondCell) + 15, 270, 17)];
        thirdCell.text = self.exChangeSureThirdCell;
        thirdCell.backgroundColor = [UIColor clearColor];
        thirdCell.font = [UIFont systemFontOfSize:15];
        thirdCell.colorfont = [UIFont systemFontOfSize:15];
        thirdCell.textColor = [SharedMethod getColorByHexString:@"929292"];
        thirdCell.changeColor = [SharedMethod getColorByHexString:@"454545"];
        [backImageV addSubview:thirdCell];
        [thirdCell release];
        
        

    }
    else if (alertTpye == twoTextType){
    
//        UIImageView * textImageBg = [[UIImageView alloc] initWithFrame:CGRectMake(19, 34, 262, 106)];
//        textImageBg.backgroundColor = [UIColor clearColor];
//        textImageBg.userInteractionEnabled = YES;
//        textImageBg.image = UIImageGetImageFromName(@"msgAlerImge.png");
//        [backImageV addSubview:textImageBg];
//        [textImageBg release];
        
        
        UILabel * oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(titleLabel) + 20, 262, 20)];
        oneLabel.backgroundColor = [UIColor clearColor];
        oneLabel.textAlignment = NSTextAlignmentCenter;
        oneLabel.font = [UIFont boldSystemFontOfSize:14];
        oneLabel.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        oneLabel.text = @"刚才的输入很麻烦?";
        [backImageV addSubview:oneLabel];
        [oneLabel release];
        
        UILabel * oneLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(oneLabel) + 8, 262, 20)];
        oneLabel1.backgroundColor = [UIColor clearColor];
        oneLabel1.textAlignment = NSTextAlignmentCenter;
        oneLabel1.font = [UIFont boldSystemFontOfSize:14];
        oneLabel1.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        oneLabel1.text = @"设置手势密码更方便";
        [backImageV addSubview:oneLabel1];
        [oneLabel1 release];
        
        UILabel * twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(oneLabel1) + 8, 262, 20)];
        twoLabel.backgroundColor = [UIColor clearColor];
        twoLabel.textAlignment = NSTextAlignmentCenter;
        twoLabel.font = [UIFont boldSystemFontOfSize:10];
        twoLabel.textColor = [UIColor  lightGrayColor];
        twoLabel.text = @"去“设置”可开启/关闭手势密码";
        [backImageV addSubview:twoLabel];
        [twoLabel release];
    
    
    }else if (alertTpye == explainType){
        
        UIFont * font = [UIFont systemFontOfSize:14];
        CGSize  size = CGSizeMake(230, 1000);
        CGSize labelSize = [self.message sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        UITextView *lable = nil;
        if(self.title){
            lable = [[UITextView alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(titleLabel) + 15, backImageV.frame.size.width-20, labelSize.height+30)];

        }
        else{
            lable = [[UITextView alloc] initWithFrame:CGRectMake(10, 15, backImageV.frame.size.width-20, labelSize.height+30)];

        }
        lable.text = self.message;
        lable.userInteractionEnabled = NO;
        [backImageV addSubview:lable];
        lable.font = [UIFont systemFontOfSize:14];
        lable.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
        lable.backgroundColor = [UIColor clearColor];
        [lable release];
        
         backImageV.frame = CGRectMake(25, 100, 270, ORIGIN_Y(lable) + 44);
    
    }
    else if (alertTpye == segementType){
        
        UILabel * titleLable = [[UILabel alloc] init];
        titleLable.text = self.title;
        titleLable.font = [UIFont systemFontOfSize:17];
        titleLable.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize labelSize = [self.title sizeWithFont:titleLable.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        titleLabel.frame =  CGRectMake(0, 21, backImageV.frame.size.width, labelSize.height);
        [backImageV addSubview:titleLable];
        titleLable.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        titleLable.backgroundColor = [UIColor clearColor];
        [titleLable release];
        
        NSArray * segementArray = @[@"公开",@"保密",@"截止后公开",@"隐藏"];
        
        alertSegement = [[CP_UISegement alloc] initWithItems:segementArray];
        alertSegement.frame = CGRectMake(12.5, ORIGIN_Y(titleLabel) + 27, 247, 40);
        [alertSegement setBackgroudImage:UIImageGetImageFromName(@"SegementBG.png")];
        [backImageV addSubview:alertSegement];
        for (int i = 0; i < segementArray.count; i++) {
            if ([self.message isEqualToString:[segementArray objectAtIndex:i]]) {
                [alertSegement setSelectIndex:i];
            }
        }
        

        NSArray * leftTextArray = @[@"公          开:",@"保          密:",@"截止后公开:",@"",@"隐          藏:"];
        NSArray * rightTextArray = @[@"方案和投注内容所有人可见",@"方案可见,投注内容保密",@"方案可见,停售前投注内容保密",@"停售后投注内容公开",@"方案和投注内容只有自己可见"];


        UILabel * lastLabel;
        for (int i = 0; i < 5; i++) {
            UILabel * leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(alertSegement.frame.origin.x, ORIGIN_Y(alertSegement) + 16 + i * 19, 75, 14)];
            leftLabel.text = [leftTextArray objectAtIndex:i];
            leftLabel.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1];
            leftLabel.font = [UIFont systemFontOfSize:12];
            leftLabel.backgroundColor = [UIColor clearColor];
            [backImageV addSubview:leftLabel];
            
            UILabel * rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(leftLabel), leftLabel.frame.origin.y, alertSegement.frame.size.width + 5 - leftLabel.frame.size.width, leftLabel.frame.size.height)];
            rightLabel.text = [rightTextArray objectAtIndex:i];
            rightLabel.textColor = leftLabel.textColor;
            rightLabel.font = leftLabel.font;
            rightLabel.backgroundColor = [UIColor clearColor];
            [backImageV addSubview:rightLabel];
            
            lastLabel = rightLabel;
        }
        
        backImageV.frame = CGRectMake(25, 100, 270, ORIGIN_Y(lastLabel) + 75);
        
    }
    else if (alertTpye == switchType) {
        
        UIImageView *titleImage2 = [[UIImageView alloc] init];
        titleImage2.image = [UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        titleImage2.frame = CGRectMake(22, 38, 256, 103);
        titleImage2.userInteractionEnabled = YES;
        [backImageV addSubview:titleImage2];
        [titleImage2 release];
        
        UILabel * switchLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleImage2.frame.size.width/2 - 70, titleImage2.frame.size.height/2 - 10, 70, 20)];
        switchLabel.backgroundColor = [UIColor clearColor];
        switchLabel.text = message;
        switchLabel.font = [UIFont systemFontOfSize:15];
        switchLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        [titleImage2 addSubview:switchLabel];
        [switchLabel release];
        
        CP_SWButton * yiLouSwitch = [[CP_SWButton alloc] initWithFrame:CGRectMake(titleImage2.frame.size.width/2 + 8, switchLabel.frame.origin.y - 4, 77, 27)];
        yiLouSwitch.onImageName = @"heji2-640_10.png";
        yiLouSwitch.offImageName = @"heji2-640_11.png";
        yiLouSwitch.on = [[[NSUserDefaults standardUserDefaults] valueForKey:@"YiLouSwitch"] boolValue];
        yiLouSwitch.tag = 99;
        [titleImage2 addSubview:yiLouSwitch];
        [yiLouSwitch release];
        
    }else if (alertTpye == jieQiType) {
//        UIImageView * bgImageView = [[UIImageView alloc] init];
//        bgImageView.image = [UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//        bgImageView.frame = CGRectMake(22, 38, 256, 103);
//        bgImageView.userInteractionEnabled = YES;
//        [backImageV addSubview:bgImageView];
        
        ColorView * messageView = [[[ColorView alloc] initWithFrame:CGRectMake(backImageV.frame.size.width/2 - 106.5, backImageV.frame.size.height/2 - 45, 213, 60)] autorelease];
        [backImageV addSubview:messageView];
        messageView.isN = YES;
        messageView.text = message;
        messageView.jianjuHeight = 14;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
            messageView.jianjuHeight = 8;
        }
        messageView.backgroundColor = [UIColor clearColor];
        messageView.font = [UIFont systemFontOfSize:14];
        messageView.colorfont = [UIFont systemFontOfSize:17];
        messageView.changeColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        messageView.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        
    }
    else if (alertTpye == basketballChuPiaoType)
    {
        if (message && [message length]) {
            CGSize titleLabelSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
            titleLabel.frame = CGRectMake(0, 22, backImageV.frame.size.width, titleLabelSize.height);
            titleLabel.font = [UIFont systemFontOfSize:17];
            
            UILabel * ruLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
            ruLabel.font = [UIFont systemFontOfSize:14];
            ruLabel.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            ruLabel.backgroundColor = [UIColor clearColor];
            [backImageV addSubview:ruLabel];
            
            
            ColorView * contentLabel = [[[ColorView alloc] initWithFrame:CGRectZero] autorelease];
            contentLabel.font = [UIFont systemFontOfSize:14];
            contentLabel.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            contentLabel.backgroundColor = [UIColor clearColor];
//            contentLabel.numberOfLines = 0;
            contentLabel.jianjuHeight = 10;
//            contentLabel.pianyiHeight = 0;
            [backImageV addSubview:contentLabel];
            
            if ([message hasPrefix:@"如:"]) {
                ruLabel.text = @"如:";
                CGSize ruSize = [ruLabel.text sizeWithFont:ruLabel.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX)];
                ruLabel.frame = CGRectMake(12, ORIGIN_Y(titleLabel) + 15, ruSize.width, ruSize.height);
                
                contentLabel.text = [message substringFromIndex:2];
//                CGSize contentSize = [contentLabel.text sizeWithFont:contentLabel.font constrainedToSize:CGSizeMake(backImageV.frame.size.width - ORIGIN_X(ruLabel) - ruLabel.frame.origin.x, 98)];
                contentLabel.frame = CGRectMake(ORIGIN_X(ruLabel) + 2, ORIGIN_Y(titleLabel) + 5, backImageV.frame.size.width - ORIGIN_X(ruLabel) - ruLabel.frame.origin.x, 98);
            }else{
                contentLabel.text = message;
//                CGSize contentSize = [contentLabel.text sizeWithFont:contentLabel.font constrainedToSize:CGSizeMake(backImageV.frame.size.width - ORIGIN_X(ruLabel) - ruLabel.frame.origin.x, 98)];
                contentLabel.frame = CGRectMake(12, ORIGIN_Y(titleLabel) + 5, backImageV.frame.size.width - 12 * 2, 98);
            }
        }else{
            CGSize titleLabelSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
            titleLabel.frame = CGRectMake(0, 60, backImageV.frame.size.width, titleLabelSize.height);
        }
    }
    else if (alertTpye == horseRaceType) {
        float lastY = 0;
        
        if ([title isEqualToString:@"玩法选择"]) {
            NSArray * msgArr = [message componentsSeparatedByString:@";"];
            int horseCount = 0;
            if (msgArr.count) {
                horseCount = [[msgArr objectAtIndex:0] intValue];
            }
            if (horseCount > 3) {
                horseCount = 3;
            }
            NSArray * selectedArray = [[[NSArray alloc] init] autorelease];
            if (msgArr.count > 1) {
                selectedArray = [[msgArr objectAtIndex:1] componentsSeparatedByString:@","];
            }
            
            NSArray * selectedTitleArr = @[@"独赢",@"连赢",@"单T"];
            NSArray * desArr = @[@"独赢：至少押一匹马。",@"连赢：至少押两匹马。",@"单 T：至少押三匹马。"];
            
            UIButton * lastButton;
            
            NSString * desString = @"";
            
            for (int i = 0; i < horseCount; i++) {
                UIButton * methodButton = [[UIButton alloc] initWithFrame:CGRectMake(12 + i * ((272 - 9 * (horseCount - 1))/horseCount + 9), ORIGIN_Y(titleLabel) + 18, (272 - 9 * (horseCount - 1))/horseCount, 32.5)];
                [methodButton setTitle:[selectedTitleArr objectAtIndex:i] forState:UIControlStateNormal];
                [methodButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                [methodButton setTitleColor:[SharedMethod getColorByHexString:@"454545"] forState:UIControlStateNormal];
                [methodButton setBackgroundImage:[UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
                [methodButton setBackgroundImage:[UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateSelected];
                methodButton.backgroundColor = [UIColor clearColor];
                [backImageV addSubview:methodButton];
                methodButton.tag = 10 + i;
                [methodButton addTarget:self action:@selector(selectHMBtn:) forControlEvents:UIControlEventTouchUpInside];
                [methodButton release];
                
                if (selectedArray && [selectedArray containsObject:[selectedTitleArr objectAtIndex:i]]) {
                    methodButton.selected = YES;
                }
                
                lastButton = methodButton;
                
                if (i != 2) {
                    desString = [desString stringByAppendingString:[desArr objectAtIndex:i]];
                }
            }
            
            
            UILabel * desLabel = [[[UILabel alloc] initWithFrame:CGRectMake(12, ORIGIN_Y(lastButton) + 15, 260, 13)] autorelease];
            desLabel.text = desString;
            desLabel.textColor = [SharedMethod getColorByHexString:@"858585"];
            desLabel.backgroundColor = [UIColor clearColor];
            desLabel.font = [UIFont systemFontOfSize:11];
            [backImageV addSubview:desLabel];
            
            lastY = -18;
            
            if (horseCount == 3) {
                UILabel * desLabel1 = [[[UILabel alloc] initWithFrame:CGRectMake(desLabel.frame.origin.x, ORIGIN_Y(desLabel) + 8, desLabel.frame.size.width, desLabel.frame.size.height)] autorelease];
                desLabel1.text = [desArr objectAtIndex:2];
                desLabel1.textColor = [SharedMethod getColorByHexString:@"858585"];
                desLabel1.backgroundColor = [UIColor clearColor];
                desLabel1.font = [UIFont systemFontOfSize:11];
                [backImageV addSubview:desLabel1];
                
                lastY = 2;
            }
            

        }
        else if ([title isEqualToString:@"温馨提示"]) {
            
            CGSize size = [message sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(INT_MAX, INT_MAX)];
            
            UIImageView * imageView = [[[UIImageView alloc] initWithFrame:CGRectMake((296 - (35 + 13 + size.width))/2, ORIGIN_Y(titleLabel) + 19, 35, 35)] autorelease];
            imageView.image = UIImageGetImageFromName(@"chongzhi_fail.png");
            [backImageV addSubview:imageView];
            
            UILabel * label = [[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(imageView) + 13, ORIGIN_Y(titleLabel) + 29, size.width, size.height)] autorelease];
            label.text = message;
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [SharedMethod getColorByHexString:@"454545"];
            label.backgroundColor = [UIColor clearColor];
            [backImageV addSubview:label];

            lastY = - 20;
        }
        else if ([title isEqualToString:@"恭喜您"]) {
            
            CGSize size = [message sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(INT_MAX, INT_MAX)];
            
            UIImageView * imageView = [[[UIImageView alloc] initWithFrame:CGRectMake((296 - (35 + 13 + size.width))/2, ORIGIN_Y(titleLabel) + 19, 35, 35)] autorelease];
            imageView.image = UIImageGetImageFromName(@"chongzhi_ok.png");
            [backImageV addSubview:imageView];
            
            UILabel * label = [[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(imageView) + 13, ORIGIN_Y(titleLabel) + 29, size.width, size.height)] autorelease];
            label.text = message;
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [SharedMethod getColorByHexString:@"454545"];
            label.backgroundColor = [UIColor clearColor];
            [backImageV addSubview:label];
            
            lastY = - 20;
        }
        else{
            
            NSArray * betsArray = [[[message componentsSeparatedByString:@";"] objectAtIndex:0] componentsSeparatedByString:@","];
            NSString * totalBets = [[message componentsSeparatedByString:@";"] objectAtIndex:1];
            UILabel * lastLabel;
            
            lastY = 30 + 28 * betsArray.count;
            
            for (int i = 0; i < betsArray.count; i++) {
                UILabel * betsLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, ORIGIN_Y(titleLabel) + 18 + 25 * i, 296 - 24, 16)];
                betsLabel.backgroundColor = [UIColor clearColor];
                betsLabel.text = [betsArray objectAtIndex:i];
                betsLabel.textColor = [SharedMethod getColorByHexString:@"656565"];
                betsLabel.font = [UIFont systemFontOfSize:14];
                [backImageV addSubview:betsLabel];
                [betsLabel release];
                
                lastLabel = betsLabel;
                
            }
            
            UIView * line = [[[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(lastLabel) + 15, 296, 0.5)] autorelease];
            line.backgroundColor = [SharedMethod getColorByHexString:@"cccccc"];
            [backImageV addSubview:line];
            
            UILabel * betsLabel = [[[UILabel alloc] initWithFrame:CGRectMake(12, ORIGIN_Y(line) + 15, 100, 16)] autorelease];
            betsLabel.backgroundColor = [UIColor clearColor];
            betsLabel.textColor = [SharedMethod getColorByHexString:@"454545"];
            betsLabel.text = [NSString stringWithFormat:@"共%@注",totalBets];
            betsLabel.font = [UIFont systemFontOfSize:14];
            [backImageV addSubview:betsLabel];
            
            UILabel * jifenLabel = [[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(betsLabel), betsLabel.frame.origin.y, backImageV.frame.size.width - betsLabel.frame.size.width, betsLabel.frame.size.height)] autorelease];
            jifenLabel.backgroundColor = [UIColor clearColor];
            jifenLabel.textColor = [SharedMethod getColorByHexString:@"454545"];
            
            NSString * jiFenString = [NSString stringWithFormat:@"%d",[totalBets intValue] * 2];
            NSString * newString = @"";
            if ([jiFenString length] < 4) {
                for (int i = 0; i < (4 - (int)[jiFenString length]); i++) {
                    newString = [newString stringByAppendingString:@"  "];
                }
                jiFenString = [NSString stringWithFormat:@"%@%@",newString,jiFenString];
            }
            jifenLabel.text = [NSString stringWithFormat:@"应付：%@金币",jiFenString];
            jifenLabel.font = [UIFont systemFontOfSize:14];
            jifenLabel.textAlignment = 2;
            jifenLabel.tag = 10;
            [backImageV addSubview:jifenLabel];
            
            NSString * yuEString = [[Info getInstance] goal_amount];
            newString = @"";
            if ([yuEString length] < 4) {
                for (int i = 0; i < (4 - (long long)[yuEString length]); i++) {
                    newString = [newString stringByAppendingString:@"  "];
                }
                yuEString = [NSString stringWithFormat:@"%@%@",newString,yuEString];
            }
            
            if (![[Info getInstance] goal_amount]) {
                yuEString = @"        ";
            }
            yuEString = [NSString stringWithFormat:@"余额：<%@>金币",yuEString];
            CGSize yuESize = [yuEString sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(INT_MAX, INT_MAX)];
            
            ColorView * yuE = [[[ColorView alloc] initWithFrame:CGRectMake(296 - yuESize.width - 0.5, ORIGIN_Y(jifenLabel) + 5, yuESize.width, betsLabel.frame.size.height)] autorelease];
            yuE.backgroundColor = [UIColor clearColor];
            yuE.textColor = [SharedMethod getColorByHexString:@"454545"];
            yuE.font = [UIFont systemFontOfSize:14];
            yuE.changeColor = [SharedMethod getColorByHexString:@"ff3b30"];
            yuE.colorfont = [UIFont systemFontOfSize:14];
            yuE.text = yuEString;
            yuE.tag = 50;
            [backImageV addSubview:yuE];
            
            UIButton * keyButton = [[[UIButton alloc] initWithFrame:CGRectMake(12, ORIGIN_Y(yuE) + 15, 173, 30)] autorelease];
            [keyButton setBackgroundImage:[UIImageGetImageFromName(@"XuanYanBG.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
            [backImageV addSubview:keyButton];
            keyButton.tag = 40;
            keyButton.backgroundColor = [UIColor clearColor];
            [keyButton addTarget:self action:@selector(showKeyboard:) forControlEvents:UIControlEventTouchUpInside];
            
            gckeyView = [[GC_UIkeyView alloc] initWithFrame:self.bounds withType:upShowKey];
            caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
            gckeyView.hightFloat = app.window.frame.size.height - gckeyView.frame.size.height;
            [self addSubview:gckeyView];
            gckeyView.tag = 890;
            isShowingKeyboard = NO;
            
            UILabel * beiLabel = [[[UILabel alloc] initWithFrame:CGRectMake(14, 0, 40, keyButton.frame.size.height)] autorelease];
            beiLabel.text = @"倍投";
            beiLabel.backgroundColor = [UIColor clearColor];
            beiLabel.textColor = [SharedMethod getColorByHexString:@"cdcdcd"];
            beiLabel.font = [UIFont systemFontOfSize:14];
            [keyButton addSubview:beiLabel];
            
            myTextField = [[UITextField alloc] initWithFrame:CGRectMake(ORIGIN_X(beiLabel), 0, keyButton.frame.size.width - ORIGIN_X(beiLabel) - beiLabel.frame.origin.x, keyButton.frame.size.height)];
            myTextField.text = @"1";
            myTextField.backgroundColor = [UIColor clearColor];
            myTextField.textColor = [SharedMethod getColorByHexString:@"cdcdcd"];
            myTextField.font = [UIFont systemFontOfSize:14];
            myTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            myTextField.userInteractionEnabled = NO;
            [keyButton addSubview:myTextField];
            
            CP_PTButton * addbutton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
            addbutton.frame = CGRectMake(ORIGIN_X(keyButton) + 9, keyButton.frame.origin.y, 44, keyButton.frame.size.height);
            [addbutton loadButonImage:@"zhuihaojia_normal.png" LabelName:nil];
            [addbutton setHightImage:UIImageGetImageFromName(@"zhuihaojia_selected.png")];
            addbutton.buttonName.frame = CGRectMake(0, -3, 45, 30);
            addbutton.buttonName.font = [UIFont systemFontOfSize:28];
            addbutton.tag = 20;
            [backImageV addSubview:addbutton];
            
            CP_PTButton * jianbutton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
            jianbutton.frame = CGRectMake(ORIGIN_X(addbutton) + 0.5, keyButton.frame.origin.y, 44, keyButton.frame.size.height);
            [jianbutton loadButonImage:@"zhuihaojian_normal.png" LabelName:nil];
            [jianbutton setHightImage:UIImageGetImageFromName(@"zhuihaojian_selected.png")];
            jianbutton.buttonName.frame = CGRectMake(0, -3, 45, 30);
            jianbutton.buttonName.font = [UIFont systemFontOfSize:28];
            jianbutton.tag = 30;
            [backImageV addSubview:jianbutton];
            
            alertBgButton = [[UIButton alloc] initWithFrame:self.frame];
            [self addSubview:alertBgButton];
            alertBgButton.backgroundColor = [UIColor clearColor];
            [self sendSubviewToBack:alertBgButton];
            
        }
        backImageV.frame = CGRectMake((self.frame.size.width - 296)/2, backImageV.frame.origin.y - 50, 296, backImageV.frame.size.height + lastY);
        oY = backImageV.frame.origin.y;
        
        titleLabel.frame = CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y, backImageV.frame.size.width, titleLabel.frame.size.height);
        backImageV.tag = 333;
    }
    
    else if (alertTpye == chongzhidiyici){
        
        UIFont * font = [UIFont systemFontOfSize:14];
        CGSize  size = CGSizeMake(236, 1000);
        CGSize labelSize = [self.message sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        
        
        if (labelSize.height > 103 ) {
            
            backImageV.image = nil;
        
            NSInteger countint =  0;
            
            if (labelSize.height < 240) {
                countint = (labelSize.height - 103)/10+1;
            }else{
                countint = (240 - 103)/10+1;
            }
            
            caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
            backImageV.frame = CGRectMake(25, (app.window.frame.size.height - (97+97+10*countint))/2, 270, 97+97+10*countint);
            
        }
        UIImageView *titleImage2 = [[UIImageView alloc] init];
        
        titleImage2.frame = CGRectMake(0, 38, backImageV.frame.size.width, 103);
        titleImage2.userInteractionEnabled = YES;
        [backImageV addSubview:titleImage2];
        
        

            titleImage2.frame = CGRectMake(19, 0, backImageV.frame.size.width - 38, backImageV.frame.size.height - 44);
            
            ColorView *lable = [[ColorView alloc] initWithFrame:CGRectMake(2, ORIGIN_Y(titleLabel) + 20, titleImage2.frame.size.width-4, titleImage2.frame.size.height - ORIGIN_Y(titleLabel))];
            lable.text = self.message;

            [titleImage2 addSubview:lable];
        
            lable.font = [UIFont systemFontOfSize:14];
        lable.colorfont = [UIFont systemFontOfSize:14];
        lable.changeColor = [UIColor redColor];
            lable.backgroundColor = [UIColor clearColor];
            [lable release];
            

        [titleImage2 release];
    
    
    }
    
    else{
    
        if (self.message || self.attributedMessage) {
            

            UIFont * font = [UIFont systemFontOfSize:14];
            CGSize  size = CGSizeMake(236, 1000);
            CGSize labelSize;
            if (self.attributedMessage && [self.attributedMessage isKindOfClass:[NSMutableAttributedString class]] && self.attributedMessage.length) {
                [attributedMessage addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, attributedMessage.length)];
                CGRect rewardRect = [attributedMessage boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
                
                labelSize = rewardRect.size;
            }else{
                labelSize = [self.message sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
            }
            
            
            UIFont * font2 = [UIFont systemFontOfSize:14];
            CGSize  size2 = CGSizeMake(236, 1000);
            CGSize labelSize2;
            if (self.attributedMessage && [self.attributedMessage isKindOfClass:[NSMutableAttributedString class]] && self.attributedMessage.length) {
                [attributedMessage addAttributes:@{NSFontAttributeName:font2} range:NSMakeRange(0, attributedMessage.length)];
                CGRect rewardRect = [attributedMessage boundingRectWithSize:size2 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
                
                labelSize2 = rewardRect.size;
            }else{
                labelSize2 = [self.message sizeWithFont:font2 constrainedToSize:size2 lineBreakMode:NSLineBreakByWordWrapping];
            }
            
            
            if (labelSize.height > 103 ) {
                
                backImageV.image = nil;
//                UIImageView * shangimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 97)];
//                shangimage.image = UIImageGetImageFromName(@"shang123.png");
//                shangimage.backgroundColor = [UIColor clearColor];
//                [backImageV addSubview:shangimage];
//                [shangimage release];
                
                NSInteger countint =  0;
                
                if (labelSize.height < 240) {
                    countint = (labelSize.height - 103)/10+1;
                }else{
                    countint = (240 - 103)/10+1;
                }
                
//                for (int i = 0; i < countint; i++) {
//                    UIImageView * zhongimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 97+(10*i), 300, 10)];
//                    zhongimage.image = UIImageGetImageFromName(@"zhong789.png");
//                    zhongimage.backgroundColor = [UIColor clearColor];
//                    [backImageV addSubview:zhongimage];
//                    [zhongimage release];
//                }
                
                
                
//                UIImageView * xiaImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 97+10*countint, 300, 97)];
//                xiaImage.image = UIImageGetImageFromName(@"xia456.png");
//                xiaImage.backgroundColor = [UIColor clearColor];
//                [backImageV addSubview:xiaImage];
//                [xiaImage release];
                
                
                caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
                backImageV.frame = CGRectMake(25, (app.window.frame.size.height - (97+97+10*countint))/2, 270, 97+97+10*countint);
                
            }
            UIImageView *titleImage2 = [[UIImageView alloc] init];
//            titleImage2.image = [UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
            titleImage2.frame = CGRectMake(0, 38, backImageV.frame.size.width, 103);
            titleImage2.userInteractionEnabled = YES;
            [backImageV addSubview:titleImage2];
            
            
            if (labelSize.height > 240) {

                if (title && title.length) {
                    backImageV.frame = CGRectMake(backImageV.frame.origin.x, backImageV.frame.origin.y, backImageV.frame.size.width, backImageV.frame.size.height + ORIGIN_Y(titleLabel) + 10);
                    titleImage2.frame = CGRectMake(19, ORIGIN_Y(titleLabel), backImageV.frame.size.width - 38, backImageV.frame.size.height - 44);
                }else{
                    titleImage2.frame = CGRectMake(19, 0, backImageV.frame.size.width - 38, backImageV.frame.size.height - 44);
                }
                msgTextView = [[UITextView alloc] initWithFrame:titleImage2.bounds];
                if (self.attributedMessage && [self.attributedMessage isKindOfClass:[NSMutableAttributedString class]] && self.attributedMessage.length) {
                    msgTextView.attributedText = self.attributedMessage;
                }else{
                    msgTextView.text = self.message;
                }
                if (labelSize2.width < 256) {
                    msgTextView.textAlignment = NSTextAlignmentCenter;
                }else{
                    msgTextView.textAlignment = NSTextAlignmentLeft;
                }
                if (self.textAlignment) {
                    msgTextView.textAlignment = self.textAlignment;
                }
                if(alertTpye == robCaiJinType || alertTpye == longBtnTitle)
                {
                    msgTextView.textAlignment = NSTextAlignmentCenter;
                    
                }
                
                msgTextView.backgroundColor = [UIColor clearColor];
                msgTextView.font = [UIFont systemFontOfSize:14];
                msgTextView.delegate = self;
                [titleImage2 addSubview:msgTextView];
                
                //            if (labelSize.height > 180) {
                //
                //                 backImageV.frame = CGRectMake(10, 50, 300, 390);
                //                backImageV.image = [backImageV.image imageFromImage:backImageV.image inRect:backImageV.bounds];
                //                titleImage2.image = [UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
                //                titleImage2.frame = CGRectMake(22, 38, 256, 298);
                //                msgTextView.frame = titleImage2.bounds;
                ////                 titleImage.frame = CGRectMake(87.5, 10, 125, 30);
                //                heightrect = 342;
                //            }else{
                //                heightrect = 150;
                //            }
                
                
            }else{
//                if (labelSize.height < 103) {
//
//                    titleImage2.frame = CGRectMake(0, 0, backImageV.frame.size.width, 103);
//                }else{
//                    
//                    titleImage2.frame = CGRectMake(0, 0, backImageV.frame.size.width, labelSize.height);
//                }
                titleImage2.frame = CGRectMake(19, 0, backImageV.frame.size.width - 38, backImageV.frame.size.height - 44);
                
                messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, ORIGIN_Y(titleLabel), titleImage2.frame.size.width-4, titleImage2.frame.size.height - ORIGIN_Y(titleLabel))];
                if (attributedMessage && [attributedMessage isKindOfClass:[NSMutableAttributedString class]] && attributedMessage.length) {
                    messageLabel.attributedText = attributedMessage;
                    
                }else{
                    if (alertTpye!=purchasePaln) {
                        messageLabel.text = self.message;
                    }
                }
                messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
                messageLabel.numberOfLines = 0;
                [titleImage2 addSubview:messageLabel];
                if (labelSize2.width < messageLabel.frame.size.width) {
                    
                    messageLabel.textAlignment = NSTextAlignmentCenter;
                }else{
                    
                    messageLabel.textAlignment = NSTextAlignmentLeft;
                    if(alertTpye == robCaiJinType || alertTpye == autoRemoveType || alertTpye == longBtnTitle)
                    {
                        messageLabel.textAlignment = NSTextAlignmentCenter;
                        
                    }
                }
                if (self.textAlignment) {
                    messageLabel.textAlignment = self.textAlignment;
                }
                //            lable.textAlignment = NSTextAlignmentCenter;
                messageLabel.font = [UIFont systemFontOfSize:14];
                messageLabel.backgroundColor = [UIColor clearColor];
                if (alertTpye==purchasePaln) {
                    [messageLabel setFrame:CGRectMake(2, ORIGIN_Y(titleLabel), titleImage2.frame.size.width-4, titleImage2.frame.size.height - ORIGIN_Y(titleLabel))];
                    messageLabel.font=FONTTWENTY_EIGHT;
                    
                    CGSize dealSize = [SharedMethod getSizeByText:@"彩民购买彩票专家方案协议" font:FONTTWENTY_FOUR constrainedToSize:CGSizeMake(messageLabel.frame.size.width, MAXFLOAT) lineBreakMode:messageLabel.lineBreakMode];
                    if (self.message) {
                        dealSize = [SharedMethod getSizeByText:self.message font:FONTTWENTY_EIGHT constrainedToSize:CGSizeMake(240, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    }
                    UILabel *purPlanLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 15, dealSize.width, dealSize.height  + 4)];
                    purPlanLab.font=FONTTWENTY_EIGHT;
                    purPlanLab.textAlignment=NSTextAlignmentCenter;
                    purPlanLab.textColor=BLACK_EIGHTYSEVER;
                    purPlanLab.backgroundColor=[UIColor clearColor];
                    purPlanLab.lineBreakMode = NSLineBreakByWordWrapping;
                    purPlanLab.numberOfLines = 0;
                    purPlanLab.text=self.message;
                    [messageLabel addSubview:purPlanLab];
                    [purPlanLab release];
                    
                    UIImageView *imgV=[[UIImageView alloc] initWithFrame:CGRectMake(messageLabel.frame.size.width/2-dealSize.width/2-14, ORIGIN_Y(purPlanLab)+20, 18, 18)];
                    imgV.image=[UIImage imageNamed:@"勾选中"];
                    if (imgV.frame.origin.x < 2) {
                        imgV.frame = CGRectMake(2, ORIGIN_Y(purPlanLab)+15, 18, 18);
                    }
                    if(dealSize.height > 35){//如果是三行
                        purPlanLab.frame = CGRectMake(0, 10, dealSize.width, dealSize.height  + 4);
                        imgV.frame = CGRectMake(2, ORIGIN_Y(purPlanLab)+5, 18, 18);
                    }
                    imgV.tag=101;
                    [messageLabel addSubview:imgV];
                    
                    messageLabel.userInteractionEnabled=YES;
                    titleImage2.userInteractionEnabled=YES;
                    backImageV.userInteractionEnabled=YES;
                    UITapGestureRecognizer *clickTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
                    imgV.userInteractionEnabled=YES;
                    [imgV addGestureRecognizer:clickTap];
                    
                    UILabel *dealLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgV.frame)+10, CGRectGetMinY(imgV.frame), dealSize.width + 20, 18)];
                    dealLabel.text=@"彩民购买彩票专家方案协议";
                    if (self.agreeTitle) {
                        dealLabel.text = self.agreeTitle;
                    }
                    dealLabel.backgroundColor = [UIColor clearColor];
                    dealLabel.font=FONTTWENTY_FOUR;
                    dealLabel.textColor=BLACK_EIGHTYSEVER;
                    [messageLabel addSubview:dealLabel];
                    
                    UITapGestureRecognizer *clickDealTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPuchsPlanDealTap:)];
                    dealLabel.userInteractionEnabled=YES;
                    [dealLabel addGestureRecognizer:clickDealTap];
                }
                //            heightrect = 150;
            }
            [titleImage2 release];
            
            
            
            
        }
    }
    
    
    
//    if (alertTpye == explainType) {
//        titleImage.frame = CGRectMake(87.5, 2, 125, 30);
//    }
    if ([customButtons count] > 3) {
        float btnWith = backImageV.frame.size.width/[customButtons count];
        for (int i = 0; i < [self.customButtons count]; i++) {
            CP_PTButton *btn = [customButtons objectAtIndex:i];
            
            btn.frame = CGRectMake(btnWith*i, backImageV.frame.size.height - 44, btnWith, 44);
            btn.buttonName.frame = btn.bounds;
            btn.buttonName.textColor = [UIColor blueColor];
            
#ifdef CRAZYSPORTS
            btn.buttonName.textColor = CS_NAVAGATION_COLOR;
#endif
            btn.buttonName.font = [UIFont systemFontOfSize:18];
            btn.backgroundColor = [UIColor clearColor];
            [backImageV addSubview:btn];
        }
    }
    else {
        float btnWith = backImageV.frame.size.width/[customButtons count];
        for (int i = 0; i < [self.customButtons count]; i++) {
            CP_PTButton *btn = [customButtons objectAtIndex:i];
            
            btn.frame = CGRectMake(btnWith*i, backImageV.frame.size.height - 44, btnWith, 44);
            btn.buttonName.frame = btn.bounds;
            btn.buttonName.font = [UIFont systemFontOfSize:18];
            btn.backgroundColor = [UIColor clearColor];
            [backImageV addSubview:btn];
            
            if ((alertTpye == horseRaceType || alertTpye == checkUpdateType || alertTpye == purchasePaln) && i == 0 && customButtons.count != 1) {
                btn.buttonName.textColor = [UIColor blackColor];
                if(alertTpye == purchasePaln){
                    btn.buttonName.textColor = BLACK_EIGHTYSEVER;
                }
            }
            
#ifdef CRAZYSPORTS
            btn.buttonName.textColor = CS_NAVAGATION_COLOR;
#endif
            
            if(alertTpye == longBtnTitle){
            
                btn.buttonName.font = [UIFont systemFontOfSize:15];

            }
            if (alertTpye == checkUpdateType) {
                btn.backgroundColor = [UIColor whiteColor];
                btn.tag = 10 + i;
            }
        }
    }
       backImageV.image = [backImageV.image imageFromImage:backImageV.image inRect:backImageV.bounds];
//    if (heightrect == 150) {
//        titleImage.frame = CGRectMake(87.5, 0 , 125, 30);
//    }else{
//        titleImage.frame = CGRectMake(87.5, 4, 125, 30);
//    }
    
    [backImageV release];
#ifdef isCaiPiaoForIPad
    if (delegate && [delegate isKindOfClass:[UIViewController class]]) {
        self.frame = [(UIViewController *)delegate view].bounds;
        backImageV.center = self.center;
        [[(UIViewController *)delegate view] addSubview:self];
    }
#else
    NSLog(@"%@",[UIApplication sharedApplication].windows);
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
#endif
    
    if (alertTpye == passWordType || alertTpye == textViewType) {
        if (IS_IPHONE_5) {
            backImageV.center = CGPointMake(self.center.x, self.center.y - 100);
        }else{
            backImageV.center = CGPointMake(self.center.x, self.center.y - 120);
        }
        
    }

    if (customButtons.count == 1) {
        backImageV.image = [UIImageGetImageFromName(@"shuZiAlertBG.png") stretchableImageWithLeftCapWidth:0 topCapHeight:22];
    }else{
        backImageV.image = [UIImageGetImageFromName(@"shuZiAlertBG1.png") stretchableImageWithLeftCapWidth:0 topCapHeight:22];
    }
    if (alertTpye == checkUpdateType) {
        backImageV.image = nil;
        backImageV.backgroundColor = [SharedMethod getColorByHexString:@"f4f4f4"];
        backImageV.layer.cornerRadius = 10;
        backImageV.layer.masksToBounds = YES;
        backImageV.frame = CGRectMake(backImageV.frame.origin.x, backImageV.frame.origin.y - 24, backImageV.frame.size.width, backImageV.frame.size.height + 48);
        
        checkMarkButton = [[UIButton alloc] initWithFrame:CGRectMake(0, backImageV.frame.size.height - 48, 48, 48)];
        checkMarkButton.backgroundColor = [UIColor clearColor];
        [backImageV addSubview:checkMarkButton];
        [checkMarkButton addTarget:self action:@selector(changeTick:) forControlEvents:UIControlEventTouchUpInside];
        
        checkMarkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, backImageV.frame.size.height - 48 + 15, 18, 18)];
        checkMarkImageView.image = [UIImage imageNamed:@"CheckMark.png"];
        [backImageV addSubview:checkMarkImageView];
        
        UILabel * tickLabel = [[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(checkMarkImageView) + 10, checkMarkImageView.frame.origin.y, backImageV.frame.size.width - (ORIGIN_X(checkMarkImageView) + 10), checkMarkImageView.frame.size.height)] autorelease];
        tickLabel.text = @"本版本不再提示";
        tickLabel.backgroundColor = [UIColor clearColor];
        tickLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.87];
        [backImageV addSubview:tickLabel];
        
        UIButton * leftButton = (UIButton *)[backImageV viewWithTag:10];
        UIView * lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, leftButton.frame.origin.y - 1, backImageV.frame.size.width, 1)] autorelease];
        lineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [backImageV addSubview:lineView];
        
        UIView * lineView1 = [[[UIView alloc] initWithFrame:CGRectMake(0, checkMarkButton.frame.origin.y, backImageV.frame.size.width, 1)] autorelease];
        lineView1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [backImageV addSubview:lineView1];
        
        UIView * lineView2 = [[[UIView alloc] initWithFrame:CGRectMake(ORIGIN_X(leftButton) - 0.5, leftButton.frame.origin.y, 1, leftButton.frame.size.height)] autorelease];
        lineView2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [backImageV addSubview:lineView2];
    }
    if (alertTpye == checkMarkType) {
        
        titleLabel.hidden = YES;
        
        messageLabel.frame = CGRectMake(messageLabel.frame.origin.x, 0, messageLabel.frame.size.width, messageLabel.frame.size.height);
        messageLabel.backgroundColor = [UIColor clearColor];
        
        checkMarkButton = [[UIButton alloc] initWithFrame:CGRectMake(8, backImageV.frame.size.height - 52 - 44, 48, 48)];
        checkMarkButton.backgroundColor = [UIColor clearColor];
        [backImageV addSubview:checkMarkButton];
        [checkMarkButton addTarget:self action:@selector(changeTick:) forControlEvents:UIControlEventTouchUpInside];
        
        checkMarkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(23, checkMarkButton.frame.origin.y + (checkMarkButton.frame.size.height - 18)/2, 18, 18)];
        checkMarkImageView.image = [UIImage imageNamed:@"CheckMark.png"];
        [backImageV addSubview:checkMarkImageView];
        
        UILabel * tickLabel = [[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(checkMarkImageView) + 10, checkMarkImageView.frame.origin.y, backImageV.frame.size.width - (ORIGIN_X(checkMarkImageView) + 10), checkMarkImageView.frame.size.height)] autorelease];
        tickLabel.text = @"不再提示";
        tickLabel.backgroundColor = [UIColor clearColor];
        tickLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.87];
        [backImageV addSubview:tickLabel];

    }
    if (alertTpye == explanationType) {
        backImageV.image = [UIImage imageNamed:@"GenDanExplanationBG.png"];
        backImageV.frame = CGRectMake((MyWidth - 290)/2.0, (MyHight - 180)/2.0, 290, 180);
        
        titleLabel.frame = CGRectMake(0, 15, backImageV.frame.size.width, 15);
        titleLabel.textColor = [SharedMethod getColorByHexString:@"13a3ff"];
        titleLabel.font = [UIFont systemFontOfSize:15];
        
        UIButton * xButton = [[[UIButton alloc] initWithFrame:CGRectMake(backImageV.frame.size.width - 44, 0, 44, 44)] autorelease];
        [xButton setImage:[UIImage imageNamed:@"GenDanExplanationX.png"] forState:UIControlStateNormal];
        [xButton setImageEdgeInsets:UIEdgeInsetsMake(10, 20, 20, 10)];
        [backImageV addSubview:xButton];
        [xButton addTarget:self action:@selector(dismissWithCancleClickedButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [backImageV addSubview:messageLabel];
        NSMutableAttributedString * attributedString = [[[NSMutableAttributedString alloc] initWithString:messageLabel.text] autorelease];
        NSMutableParagraphStyle *paragraphStyle = [[[NSMutableParagraphStyle alloc] init] autorelease];
        
        [paragraphStyle setLineSpacing:7];//调整行间距
        
        [attributedString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:DEFAULT_TEXTBLACKCOLOR, NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, messageLabel.text.length)];
        
        messageLabel.attributedText = attributedString;
        
        CGRect messageRect = [attributedString boundingRectWithSize:CGSizeMake(backImageV.frame.size.width - 13 * 2, backImageV.frame.size.height - (ORIGIN_Y(titleLabel) + 15)) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        
        messageLabel.frame = CGRectMake(13, ORIGIN_Y(titleLabel) + 15, messageRect.size.width, messageRect.size.height);

    }
}

-(void)changeTick:(UIButton *)tickButton
{
    tickButton.selected = !tickButton.selected;
    if (tickButton.selected) {
        checkMarkImageView.image = [UIImage imageNamed:@"CheckMark_1.png"];
    }else{
        checkMarkImageView.image = [UIImage imageNamed:@"CheckMark.png"];
    }
}

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.allFlagWinningList.count)
    {
        return [self.allFlagWinningList count]+1;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeaderLabel *header = [[[HeaderLabel alloc] initWithFrame:CGRectMake(0, 0, 292, 30) andLabel1Text:@"日期" andLabelWed:56 andLabel2Text:@"用户名" andLabel2Wed:92 andLabelText3:@"国旗数(枚)" andLabel3Wed:78 andLaelText4:@"彩金(元)" andLabel4Frame:66 isJiangJiDouble:NO] autorelease];
    return header;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.allFlagWinningList count]) {
        static NSString *moreCellIdentifier = @"Cell2";
        moreCell = (MoreLoadCell *)[tableView dequeueReusableCellWithIdentifier:moreCellIdentifier];
        if (!moreCell) {
            moreCell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:moreCellIdentifier] autorelease];
            [moreCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [moreCell setInfoText:@"加载更多"];
        }
        
        moreCell.backgroundColor = [UIColor clearColor];
        return moreCell;
    }

    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //纵线
        for(int i = 0;i<5;i++)
        {
            UIImageView *xianImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1, 30)];
            xianImage.tag = 100+i;
            if(i==1)
                xianImage.frame = CGRectMake(56, 0, 1, 30);
            if(i == 2)
                xianImage.frame = CGRectMake(148, 0, 1, 30);
            if(i == 3)
                xianImage.frame = CGRectMake(226, 0, 1, 30);
            if(i == 4)
                xianImage.frame = CGRectMake(291, 0, 1, 30);
            [cell.contentView addSubview:xianImage];
            [xianImage release];
        }
        
        
        //时间
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 56, 30)];
        timeLabel.numberOfLines = 0;
        timeLabel.tag = 111;
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.font = [UIFont systemFontOfSize:13];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
        [cell.contentView addSubview:timeLabel];
        [timeLabel release];
        //用户名
        UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(56, 0, 92, 30)];
        nickLabel.numberOfLines = 0;
        nickLabel.tag = 112;
        nickLabel.textAlignment = NSTextAlignmentCenter;
        nickLabel.font = [UIFont systemFontOfSize:13];
        nickLabel.backgroundColor = [UIColor clearColor];
        nickLabel.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
        [cell.contentView addSubview:nickLabel];
        [nickLabel release];
        
        //国旗数
        
        UILabel *flagLabel = [[UILabel alloc] initWithFrame:CGRectMake(148, 0, 78, 30)];
        flagLabel.backgroundColor = [UIColor clearColor];
        flagLabel.tag = 113;
        flagLabel.textAlignment = NSTextAlignmentCenter;
        flagLabel.font = [UIFont systemFontOfSize:13];
        [cell.contentView addSubview:flagLabel];
        [flagLabel release];
        //彩金
        
        UILabel *caijinLabel = [[UILabel alloc] initWithFrame:CGRectMake(226, 0, 66, 30)];
        caijinLabel.backgroundColor = [UIColor clearColor];
        caijinLabel.tag = 114;
        caijinLabel.textAlignment = NSTextAlignmentCenter;
        caijinLabel.font = [UIFont systemFontOfSize:13];
        [cell.contentView addSubview:caijinLabel];
        [caijinLabel release];
        
        //横线
        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 29, 320, 1)];
        xian.tag = 105;
        [cell.contentView addSubview:xian];
        [xian release];

    }
    cell.backgroundColor = [UIColor whiteColor];
    
    WorldCupWinningList *worldcup = nil;
    if(indexPath.row < [self.allFlagWinningList count])
    {
        worldcup = [self.allFlagWinningList objectAtIndex:indexPath.row];
    }
    
    UILabel *timeLabel = (UILabel *)[cell.contentView viewWithTag:111];
    UILabel *nickLabel = (UILabel *)[cell.contentView viewWithTag:112];
    
    UILabel *getLabel = (UILabel *)[cell.contentView viewWithTag:113];
  
    UILabel *postLabel = (UILabel *)[cell.contentView viewWithTag:114];
    
    if(![worldcup.winningTime isEqualToString:@"null"] && worldcup.winningTime != nil && worldcup.winningTime.length !=0)
        timeLabel.text = worldcup.winningTime;
    if(![worldcup.name isEqualToString:@"null"] && worldcup.name != nil && worldcup.name.length != 0)
        nickLabel.text = worldcup.name;
    if(![worldcup.flagCount isEqualToString:@"null"] && worldcup.flagCount != nil && worldcup.flagCount.length != 0)
        getLabel.text = worldcup.flagCount;
    if(![worldcup.caijin isEqualToString:@"null"] && worldcup.caijin != nil && worldcup.caijin.length != 0)
        postLabel.text = worldcup.caijin;
    
    
    for(int i = 0;i<5;i++)
    {
        UIImageView *xianImage = (UIImageView *)[cell.contentView viewWithTag:100+i];
        [xianImage setImage:[UIImage imageNamed:@"wf_xian.png"]];
        
    }
    
    UIImageView *xian = (UIImageView *)[cell.contentView viewWithTag:105];
    [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
    
    return cell;
}
//世界杯活动规则
-(void)PressRule:(UIButton *)sender
{
    NSLog(@"世界杯活动规则");
    [self alertViewclickButton:sender];
}


-(void)loadWinningListWith:(NSArray *)_arr
{
    [moreCell spinnerStopAnimating];
    
    self.allFlagWinningList = [NSMutableArray arrayWithArray:_arr];
    
    if(self.allFlagWinningList.count < curPage*10)
    {
        [moreCell setInfoText:@"加载完毕"];
        [moreCell setType:MSG_TYPE_LOAD_NODATA];
    }
    
    curPage ++;
    
    [myTableView reloadData];
}
#pragma mark UIScrollView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.allFlagWinningList)
    {
        if (indexPath.row == [self.allFlagWinningList count] && [self.allFlagWinningList count]%10 ==0) {
            [moreCell spinnerStartAnimating];
            
            if(self.allFlagWinningList.count > (curPage-1)*10)
            {
                if(delegate && [delegate respondsToSelector:@selector(CP_alertView:againRequestWithPage:)])
                {
                    [delegate CP_alertView:self againRequestWithPage:curPage+1];
                }
            }
            else
            {
                [moreCell spinnerStopAnimating];
                [moreCell setInfoText:@"加载完毕"];
                [moreCell setType:MSG_TYPE_LOAD_NODATA];
            }
        }
    }

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    NSLog(@"我的积分 %f  %f",myTableView.contentSize.height,scrollView.contentOffset.y);
    
    if (myTableView.contentSize.height-scrollView.contentOffset.y<=360) {
        if (moreCell && moreCell.type != MSG_TYPE_LOAD_NODATA) {
            [moreCell spinnerStartAnimating];
            
            if(self.allFlagWinningList.count == (curPage-1)*10)
            {
                if(delegate && [delegate respondsToSelector:@selector(CP_alertView:againRequestWithPage:)])
                {
                    [delegate CP_alertView:self againRequestWithPage:curPage];
                }
            }
            else
            {
                [moreCell spinnerStopAnimating];
                [moreCell setInfoText:@"加载完毕"];
                [moreCell setType:MSG_TYPE_LOAD_NODATA];
            }

        }
	}
}



- (void)dismissWithCancleClickedButton:(UIButton *)sender {
    if(sender != nil)
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissWithCancleClickedButton:) object:nil];
    [self alertViewclickButton:sender];
}

- (void)alertViewclickButton:(UIButton *)sender {
    
    if(self.allFlagWinningList.count > 0)
    {
        [self.allFlagWinningList removeAllObjects];
        curPage = 0;
    }
    
    if (delegate &&[delegate respondsToSelector:@selector(CP_alertView:didDismissWithButtonIndex:)]) {
        [delegate CP_alertView:self didDismissWithButtonIndex:sender.tag];
    }
    
    if (delegate && [delegate respondsToSelector:@selector(CP_alertView:didDismissWithButtonIndex:returnString:)]) {
        [delegate CP_alertView:self didDismissWithButtonIndex:sender.tag returnString:myTextField.text];
    }

    if (!dontDismiss) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [UIView beginAnimations:@"nddd" context:NULL];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.alpha = 0;
        [UIView commitAnimations];
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5];
    }
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    return NO;
//}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    [self performSelector:@selector(sleepTextField) withObject:nil afterDelay:0.1];

    return YES;
}

- (void)sleepTextField{

    if ([myTextField.text isEqualToString:@""]) {
        textLabel.hidden = NO;
    }else{
        textLabel.hidden = YES;
    }
}

-(void)selectHMBtn:(UIButton *)selectedButton
{
    selectedButton.selected = !selectedButton.selected;
}

-(void)showKeyboard:(UIButton *)button
{
    UIImageView * backImageView = (UIImageView *)[self viewWithTag:333];
    NSArray * betsArray = [[[message componentsSeparatedByString:@";"] objectAtIndex:0] componentsSeparatedByString:@","];
    float yyy = 27 * (betsArray.count - 1);
    if (!(IS_IPHONE_5)) {
        yyy = 25.5 * betsArray.count;
    }
    
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];

    if (isShowingKeyboard) {
        [gckeyView dissKeyFunc];
        isShowingKeyboard = NO;

        [UIView animateWithDuration:0.2 animations:^{
//            backImageView.frame = CGRectMake(backImageView.frame.origin.x, backImageView.frame.origin.y + yyy, backImageView.frame.size.width, backImageView.frame.size.height);
            backImageView.frame = CGRectMake(backImageView.frame.origin.x, oY, backImageView.frame.size.width, backImageView.frame.size.height);

        }];
        
    }else{
        [gckeyView showKeyFunc];
        isShowingKeyboard = YES;
        
        [UIView animateWithDuration:0.2 animations:^{
//            backImageView.frame = CGRectMake(backImageView.frame.origin.x, backImageView.frame.origin.y - yyy, backImageView.frame.size.width, backImageView.frame.size.height);
            backImageView.frame = CGRectMake(backImageView.frame.origin.x, app.window.frame.size.height - gckeyView.frame.size.height - backImageView.frame.size.height, backImageView.frame.size.width, backImageView.frame.size.height);

        }];
    }
}


- (void)clickTap:(UITapGestureRecognizer *)sender{
    NSLog(@"%@",sender.view);
    UIImageView *imgView=(UIImageView *)sender.view;
    CP_PTButton *btn = [customButtons objectAtIndex:[customButtons count]-1];
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
    if (delegate&&[delegate respondsToSelector:@selector(CP_alertView:clickPuchsPlanDealTap:)]) {
        [delegate CP_alertView:self clickPuchsPlanDealTap:sender];
    }
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