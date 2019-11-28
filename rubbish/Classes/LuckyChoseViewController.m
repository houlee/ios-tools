//
//  LuckyChoseViewController.m
//  caibo
//
//  Created by yaofuyu on 12-11-5.
//
//

#import "LuckyChoseViewController.h"
#import "Info.h"
#import <QuartzCore/QuartzCore.h>
#import "GouCaiViewController.h"
#import "NSDate-Helper.h"
#import "caiboAppDelegate.h"
#import "NSStringExtra.h"
#import "GC_LotteryUtil.h"
#import "LoginViewController.h"
#import "ShuangSeQiuCell.h"
#import "GouCaiShuZiInfoViewController.h"
#import "CP_PTButton.h"

@interface LuckyChoseViewController ()

@end

@implementation LuckyChoseViewController

@synthesize caiZhong;
@synthesize dataArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        caiZhongArray = [[NSArray arrayWithObjects:@"双色球",@"大乐透",@"广东11选5",@"山东11选5",@"黑龙江时时彩",@"重庆时时彩",@"七星彩",@"七乐彩",@"排列5",@"快乐十分", nil] retain];
        zhushu = 5;
        self.caiZhong = 2;
        lotterytype = TYPE_GD11XUAN5_8;
        self.dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(showLuckNum) object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}


- (void)LoadIphoneView {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(85, 8, 128, 30);
    [self.CP_navigation addSubview:btn];
    for (UIImageView *v in self.CP_navigation.subviews) {
        if ([v isKindOfClass:[UIImageView class]]) {
            v.image = nil;
            v.backgroundColor = [UIColor clearColor];
        }
    }
    self.CP_navigation.titleLabel.text = nil;
    self.CP_navigation.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(changeCaiZhong) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:UIImageGetImageFromName(@"luckxuanze.png") forState:UIControlStateNormal];
    [btn setImage:UIImageGetImageFromName(@"luckxuanze_anxia.png") forState:UIControlStateHighlighted];
    
    caizhongLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 105, 28)];
    [btn addSubview:caizhongLable];
    caizhongLable.textColor = [UIColor whiteColor];
    caizhongLable.textAlignment = NSTextAlignmentCenter;
    caizhongLable.text = [caiZhongArray objectAtIndex:self.caiZhong];
    caizhongLable.backgroundColor = [UIColor clearColor];
    caizhongLable.font = [UIFont systemFontOfSize:15];
    [caizhongLable release];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(217, 8, 98, 30);
    [self.CP_navigation addSubview:btn3];
    [btn3 setImage:UIImageGetImageFromName(@"luckxuanze.png") forState:UIControlStateNormal];
    [btn3 setImage:UIImageGetImageFromName(@"luckxuanze_anxia.png") forState:UIControlStateHighlighted];
    [btn3 addTarget:self action:@selector(changeZhuShu) forControlEvents:UIControlEventTouchUpInside];
    
    zhushuLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    [btn3 addSubview:zhushuLable];
    
    zhushuLable.text = @"5注";
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"luckZhushu"]) {
        zhushuLable.text = [NSString stringWithFormat:@"%@注",[[NSUserDefaults standardUserDefaults] valueForKey:@"luckZhushu"]];
        zhushu = [[[NSUserDefaults standardUserDefaults] valueForKey:@"luckZhushu"] integerValue] -1;
    }
    zhushuLable.textAlignment = NSTextAlignmentCenter;
    zhushuLable.textColor = [UIColor whiteColor];
    zhushuLable.backgroundColor = [UIColor clearColor];
    zhushuLable.font = [UIFont systemFontOfSize:15];
    [zhushuLable release];
    
    backimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.mainView.bounds.size.height - 568, 320, 568)];
    [self.mainView addSubview:backimage];
    backimage.image = UIImageGetImageFromName(@"luckyback.png");
    backimage.userInteractionEnabled = YES;
    [backimage release];
    
    wenzi = [[UIImageView alloc] init];
    [backimage addSubview:wenzi];
    wenzi.frame = CGRectMake(60, 110, 200, 65);
    wenzi.image = UIImageGetImageFromName(@"luck_wenzi.png");
    [wenzi release];
    
    mofaQiu = [[UIImageView alloc] init];
    mofaQiu.frame = CGRectMake(0, 160, 320, 321.5);
    [backimage addSubview:mofaQiu];
    mofaQiu.image = UIImageGetImageFromName(@"luckBall.png");
    [mofaQiu release];
    
    
    xingmangImage = [[UIImageView alloc] init];
    [backimage addSubview:xingmangImage];
    xingmangImage.hidden = YES;
    xingmangImage.frame = CGRectMake(0, 355, 320, 170);
    xingmangImage.image = UIImageGetImageFromName(@"luckyliumang.png");
    [xingmangImage release];
    
    shandianImage = [[UIImageView alloc] init];
    [backimage addSubview:shandianImage];
    shandianImage.image = UIImageGetImageFromName(@"luckylinght.png");
    shandianImage.frame = CGRectMake(0, 100, 320, 470);
    shandianImage.hidden = YES;
    [shandianImage release];
    
    if (IS_IPHONE_5) {
    
    }
    else {
        wenzi.frame = CGRectMake(60, 150, 200, 65);
        mofaQiu.frame = CGRectMake(0, 180, 320, 321.5);
        shandianImage.frame = CGRectMake(0, 120, 320, 470);
    }
    
    for (int i = 1; i <= 10; i ++) {
        UIImageView *ImagV1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 27, 27)];
        [backimage insertSubview:ImagV1 belowSubview:mofaQiu];
        NSString *imageName = [NSString stringWithFormat:@"luckyball%d.png",i];
        ImagV1.image = UIImageGetImageFromName(imageName);
        ImagV1.tag = 200+i;
        NSInteger x= 0, y = 0;
        y  = mofaQiu.bounds.size.height / 2 - arc4random() % 15;
        x = sqrt(160 * 160 - y * y);
        if (arc4random()%2 ==0) {
            ImagV1.center = CGPointMake(mofaQiu.center.x + (x -  arc4random() % 15 - 20), mofaQiu.center.y + y - 60);
        }
        else {
            ImagV1.center = CGPointMake(mofaQiu.center.x - (x - arc4random() % 15 - 20), mofaQiu.center.y + y - 60);
        }
        
        ImagV1.hidden = NO;
        [ImagV1 release];
        
        UIImageView *ImagV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, shandianImage.frame.origin.y + 80, 320, 320)];
        [backimage insertSubview:ImagV2 belowSubview:shandianImage];
        ImagV2.hidden = YES;
        NSString *imageName2 = [NSString stringWithFormat:@"luckshandian%d.png",i];
        ImagV2.image = UIImageGetImageFromName(imageName2);
        ImagV2.tag = 100+i;
        [ImagV2 release];
        
    
    }
    
    UIButton *dianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dianBtn.frame = mofaQiu.frame;
    [self.mainView addSubview:dianBtn];
    [dianBtn addTarget:self action:@selector(beginDongHua) forControlEvents:UIControlEventTouchDown];
    [dianBtn addTarget:self action:@selector(endDonhua) forControlEvents:UIControlEventTouchCancel| UIControlEventTouchUpInside];
    dianBtn.backgroundColor = [UIColor clearColor];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"幸运选号";
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
    UIButton *btn = (UIButton *)left.customView;
    if ([btn isKindOfClass:[UIButton class]]) {
        [btn setBackgroundImage:nil forState:(UIControlStateNormal)];
        [btn setImage:UIImageGetImageFromName(@"luckyback_2.png") forState:UIControlStateNormal];
        [btn setImage:UIImageGetImageFromName(@"luckyback_1.png") forState:UIControlStateHighlighted];
    }
    self.CP_navigation.leftBarButtonItem = left;
    self.CP_navigation.image = nil;
    
    isOnSound = [[[NSUserDefaults standardUserDefaults] valueForKey:@"SoundSetPage_setSound"] boolValue];
    
#ifdef isCaiPiaoForIPad
    [self LoadIpadView];
#else
    [self LoadIphoneView];
#endif

    

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [infoPlayer release];
    [caiZhongArray release];
    self.dataArray  = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Action

- (void)doBack {

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pickerHidden {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    //dataPicker.frame = CGRectMake(0, self.mainView.bounds.size.height +44, 320, 162.0);
    [UIView commitAnimations];
}



- (void)finish {

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView commitAnimations];
}


- (void)showPicker {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView commitAnimations];
}

- (void)changeCaiZhong {
    [self hidenLuckNum];
    MyPickerView * pickerView = [[[MyPickerView alloc] initWithContentArray:caiZhongArray] autorelease];
    pickerView.tag = 201;
    pickerView.delegate = self;
    UILabel *lable = [[UILabel alloc] init];
    lable.backgroundColor = [UIColor clearColor];
    lable.text = @"请选择彩种";
    lable.textColor = [UIColor whiteColor];
    [pickerView showWithTitle:caizhongLable.text];
    lable.font = [UIFont systemFontOfSize:12];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.frame = CGRectMake(0, 0, 320, 45);
    UIView *topView = [pickerView viewWithTag:2031];
    [topView addSubview:lable];
    [lable release];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (databackImageV && databackImageV.hidden == NO) {
        [self hidenLuckNum];
    }
    
}


-(void)myPickerView:(MyPickerView *)myPickerView content:(NSString *)content {
    if (myPickerView.tag == 200) {
        if ([content length]) {
            zhushuLable.text = content;
            zhushu = [[zhushuLable.text stringByReplacingOccurrencesOfString:@"注" withString:@""] intValue];
        }
        else {
            zhushuLable.text = @"1注";
            zhushu = 1;
        }
        
    }
    else if (myPickerView.tag == 201) {
        if ([content length]) {
            caizhongLable.text = content;
            if ([caizhongLable.text isEqualToString:@"双色球"]) {
                lotterytype = TYPE_SHUANGSEQIU;
            }
            
            else if ([caizhongLable.text isEqualToString:@"大乐透"]){
                lotterytype = TYPE_DALETOU;
            }
            else if ([caizhongLable.text isEqualToString:@"山东11选5"]){
                lotterytype = TYPE_11XUAN5_8;
            }
            else if ([caizhongLable.text isEqualToString:@"广东11选5"]){
                lotterytype = TYPE_GD11XUAN5_8;
            }
            else if ([caizhongLable.text isEqualToString:@"江西11选5"]){
                lotterytype = TYPE_JX11XUAN5_8;
            }
            else if ([caizhongLable.text isEqualToString:@"黑龙江时时彩"]){
                lotterytype = TYPE_SHISHICAI;
            }
            else if ([caizhongLable.text isEqualToString:@"重庆时时彩"]){
                lotterytype = TYPE_CQShiShi;
            }
            else if ([caizhongLable.text isEqualToString:@"七星彩"]){
                lotterytype = TYPE_QIXINGCAI;
            }
            else if ([caizhongLable.text isEqualToString:@"七乐彩"]){
                
                lotterytype = TYPE_7LECAI;
            }
            else if ([caizhongLable.text isEqualToString:@"排列5"]) {
                lotterytype = TYPE_PAILIE5;
                
            }
            else if ([caizhongLable.text isEqualToString:@"快乐十分"]) {
                lotterytype = TYPE_HappyTen;
                
            }
            else {
                [[caiboAppDelegate getAppDelegate] showMessage:@"彩种选择失败"];
            }
        }
        else {
            caizhongLable.text = @"双色球";
            lotterytype = TYPE_SHUANGSEQIU;
        }
    }
}

- (void)changeZhuShu {
    [self hidenLuckNum];
//    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.mainView.bounds.size.height - 209.5, 320, 209.5)];
//    pickerView.backgroundColor = [UIColor whiteColor];
//    [self.mainView addSubview:pickerView];
//    pickerView.showsSelectionIndicator = YES;
//    pickerView.delegate = self;
//    pickerView.dataSource = self;
//    UIView * topView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)] autorelease];
//    topView.userInteractionEnabled = YES;
//    topView.backgroundColor = [UIColor colorWithRed:21/255.0 green:136/255.0 blue:218/255.0 alpha:1];
//    pickerView.a
//    UIButton * cancelButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 45)] autorelease];
//    cancelButton.backgroundColor = [UIColor clearColor];
//    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
//    cancelButton.adjustsImageWhenHighlighted = NO;
//    [topView addSubview:cancelButton];
//    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton * rightButton = [[[UIButton alloc] initWithFrame:CGRectMake(topView.frame.size.width - 100, 0, 100, 45)] autorelease];
//    rightButton.backgroundColor = [UIColor clearColor];
//    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
//    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    rightButton.titleLabel.font = [UIFont systemFontOfSize:18];
//    rightButton.adjustsImageWhenHighlighted = NO;
//    [topView addSubview:rightButton];
//    [rightButton addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];
    MyPickerView * pickerView = [[[MyPickerView alloc] initWithContentArray:[NSArray arrayWithObjects:@"1注",@"2注",@"3注",@"4注",@"5注",@"6注",@"7注",@"8注",@"9注",@"10注", nil]] autorelease];
    pickerView.tag = 200;
    pickerView.delegate = self;
    [pickerView showWithTitle:zhushuLable.text];
    UILabel *lable = [[UILabel alloc] init];
    lable.backgroundColor = [UIColor clearColor];
    lable.text = @"请选择注数";
    lable.font = [UIFont systemFontOfSize:12];
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.frame = CGRectMake(0, 0, 320, 45);
    UIView *topView = [pickerView viewWithTag:2031];
    [topView addSubview:lable];
    [lable release];
    
}


- (void)hidenLuckNum {
    databackVie.hidden = YES;
    databackImageV.hidden = YES;
}

- (void)showLuckNum {
    if (infoPlayer) {
        [infoPlayer stop];
        [infoPlayer release];
        infoPlayer = nil;
    }
    if(isOnSound){
    
        infoPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString: [[NSBundle mainBundle]pathForResource:@"tanchu" ofType:@"mp3" inDirectory:@"/"]] error:nil];
        [infoPlayer play];
    
    }

//    [YDUtil playSound:@"haoma"];
    if ([[[Info getInstance] userId] integerValue] == 0) {
#ifdef isCaiPiaoForIPad
        [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
        LoginViewController *log = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        log.isShowDefultAccount = YES;
        [self.navigationController pushViewController:log animated:YES];
        
        [log release];
#endif

        return;
    }
    else {
        
        if (!databackImageV) {
            databackVie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.bounds.size.height + 60)];
            databackVie.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
            databackVie.layer.masksToBounds = YES;
            [self.view addSubview:databackVie];
            [databackVie release];
            
            databackImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 270, 300)];
            databackImageV.center = CGPointMake(self.mainView.bounds.size.width/2, self.mainView.bounds.size.height/2 - 10);
            [databackVie addSubview:databackImageV];
            databackImageV.alpha = 1.0;
            databackImageV.userInteractionEnabled = YES;
            databackImageV.image = [UIImageGetImageFromName(@"shuZiAlertBG1.png") stretchableImageWithLeftCapWidth:0 topCapHeight:22];
            [databackImageV release];
            
            UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(15, 48, 240, 0.5)];
            line1.backgroundColor = [UIColor lightGrayColor];
            [databackImageV addSubview:line1];
            [line1 release];
            
            
            UILabel *lable1 = [[UILabel alloc] init];
            lable1.backgroundColor = [UIColor clearColor];
            lable1.textColor = [UIColor blackColor];
            lable1.text = @"红球";
            lable1.tag = 301;
            lable1.textAlignment = NSTextAlignmentCenter;
            lable1.frame = CGRectMake(0, 0, 200, 48);
            [databackImageV addSubview:lable1];
            [lable1 release];
            
            UILabel *lable2 = [[UILabel alloc] init];
            lable2.backgroundColor = [UIColor clearColor];
            lable2.textColor = [UIColor blackColor];
            lable2.text = @"蓝球";
            lable2.tag = 302;
            lable2.textAlignment = NSTextAlignmentCenter;
            lable2.frame = CGRectMake(200, 0, 70, 48);
            [databackImageV addSubview:lable2];
            [lable2 release];
            
            UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(200, 52, 0.5, 195)];
            line2.backgroundColor = [UIColor lightGrayColor];
            line2.tag = 303;
            [databackImageV addSubview:line2];
            [line2 release];
            
            dateText = [[UITextView alloc] initWithFrame:CGRectMake(10, 55, 250, 190)];
            dateText.backgroundColor = [UIColor clearColor];
            dateText.textColor = [UIColor blackColor];
            [databackImageV addSubview:dateText];
            
            dateText.font = [UIFont systemFontOfSize:16];
            dateText.textAlignment = NSTextAlignmentCenter;
            [dateText release];
            dateText.editable = NO;
            
            senBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [databackImageV addSubview:senBtn];
            senBtn.frame = CGRectMake(135, 260, 135, 30);
            [senBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
            UILabel *beginLabel = [[UILabel alloc] initWithFrame:senBtn.bounds];
            beginLabel.backgroundColor = [UIColor clearColor];
            beginLabel.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
            beginLabel.text = @"去投注";
            beginLabel.textAlignment = NSTextAlignmentCenter;
            [senBtn addSubview:beginLabel];
            [beginLabel release];
            
            UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [databackImageV addSubview:cancleBtn];
            cancleBtn.frame = CGRectMake(0, 260, 135, 30);
            [cancleBtn addTarget:self action:@selector(hidenLuckNum) forControlEvents:UIControlEventTouchUpInside];
            UILabel *cancleLabel = [[UILabel alloc] initWithFrame:cancleBtn.bounds];
            cancleLabel.backgroundColor = [UIColor clearColor];
            cancleLabel.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
            cancleLabel.text = @"取消";
            cancleLabel.textAlignment = NSTextAlignmentCenter;
            [cancleBtn addSubview:cancleLabel];
            [cancleLabel release];
            
        }
        databackImageV.center = CGPointMake(self.mainView.bounds.size.width/2, -100);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        databackImageV.center = CGPointMake(self.mainView.bounds.size.width/2, self.mainView.bounds.size.height/2 - 10);
        [UIView commitAnimations];
        
        UILabel *view1 = (UILabel *)[databackImageV viewWithTag:301];
        UILabel *view2 = (UILabel *)[databackImageV viewWithTag:302];
        UIView *view3 = [databackImageV viewWithTag:303];
        
        if (lotterytype == TYPE_SHUANGSEQIU) {
            view1.hidden = NO;
            view1.text = @"红球";
            view2.text = @"蓝球";
            view1.frame = CGRectMake(0, 0, 215, 48);
            view2.frame = CGRectMake(215, 0, 55, 48);
            view3.frame = CGRectMake(215, 52, 0.5, 195);
            view2.hidden = NO;
            view3.hidden = NO;
        }
        else if (lotterytype == TYPE_DALETOU) {
            view1.hidden = NO;
            view1.text = @"前区";
            view2.text = @"后区";
            view1.frame = CGRectMake(0, 0, 185, 48);
            view2.frame = CGRectMake(185, 0, 85, 48);
            view3.frame = CGRectMake(185, 52, 0.5, 195);
            view2.hidden = NO;
            view3.hidden = NO;
        }
        else {
            view1.text = @"魔法号码";
            view1.frame = CGRectMake(0, 0, 270, 48);
            view2.text = @"蓝球";
            view1.hidden = NO;
            view2.hidden = YES;
            view3.hidden = YES;
        }
        dateText.text = nil;
        for (int i = 0;i<[dataArray count];i++) {
            NSString *num = nil;
            if (lotterytype == TYPE_GD11XUAN5_8 ||lotterytype == TYPE_11XUAN5_8 || lotterytype == TYPE_JX11XUAN5_8) {
                num =  [[dataArray objectAtIndex:i] objectForKey:@"Num"];
                dateText.text = [dateText.text stringByAppendingFormat:@"%@\n\n",[[[num stringByReplacingOccurrencesOfString:@"," withString:@"  "] stringByReplacingOccurrencesOfString:@"01#" withString:@""] stringByReplacingOccurrencesOfString:@"," withString:@"     "]];
            }
            else {
                num = [dataArray objectAtIndex:i];
                if (lotterytype == TYPE_SHISHICAI || lotterytype == TYPE_CQShiShi || lotterytype == TYPE_HappyTen) {
                    dateText.text = [dateText.text stringByAppendingFormat:@"%@\n\n",[[num stringByReplacingOccurrencesOfString:@"," withString:@"       "] stringByReplacingOccurrencesOfString:@"01#" withString:@""] ];
                }
                else {
                    dateText.text = [dateText.text stringByAppendingFormat:@"%@\n\n",[[[[[[[num stringByReplacingOccurrencesOfString:@"," withString:@"   "] stringByReplacingOccurrencesOfString:@"+" withString:@"      "] stringByReplacingOccurrencesOfString:@"_:_" withString:@"      "] stringByReplacingOccurrencesOfString:@"_" withString:@"   "] stringByReplacingOccurrencesOfString:@"|" withString:@"   "] stringByReplacingOccurrencesOfString:@"01#" withString:@""] stringByReplacingOccurrencesOfString:@"*" withString:@"       "]];
                }
                
            }
            
        }
        databackVie.hidden = NO;
        databackImageV.hidden = NO;
    }
    
}

- (void)send {
    if ([self.dataArray count] == 0) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"获取幸运号码失败"];
        [self hidenLuckNum];
        return;
    }
    GouCaiShuZiInfoViewController   *infoViewController = [[GouCaiShuZiInfoViewController alloc] init];
        infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeShiXuanWu;
    infoViewController.lotteryType = lotterytype;
    infoViewController.dataArray = self.dataArray;
    if (lotterytype == TYPE_SHUANGSEQIU) {
        infoViewController.goucaishuziinfotype =GouCaiShuZiInfoTypeShuangSeqiu;
        infoViewController.modeType = Shuangseqiufushi;
    }

    else if (lotterytype == TYPE_DALETOU){
        infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeDaleTou;
        infoViewController.modeType = Daletoufushi;
    }
    else if (lotterytype == TYPE_11XUAN5_8){
        infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeShiXuanWu;
        infoViewController.modeType = M11XUAN5dingwei;
    }
    else if (lotterytype == TYPE_GD11XUAN5_8){
        infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeGDShiXuanWu;
        infoViewController.modeType = M11XUAN5dingwei;
    }
    else if (lotterytype == TYPE_JX11XUAN5_8){
        infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeJXShiXuanWu;
        infoViewController.modeType = M11XUAN5dingwei;
    }
    else if (lotterytype == TYPE_SHISHICAI){
        infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeShiShiCai;
        infoViewController.modeType = SSCwuxingtongxuan;
    }
    else if (lotterytype == TYPE_CQShiShi){
        infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeCQShiShiCai;
        infoViewController.modeType = SSCwuxingtongxuan;
    }
    else if (lotterytype == TYPE_QIXINGCAI){
        infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeQiXingCai;
        infoViewController.modeType = fushi;
    }
    else if (lotterytype == TYPE_7LECAI){
        infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeQiLeCai;
        infoViewController.modeType = Qilecaifushi;
    }
    else if (lotterytype == TYPE_PAILIE5) {
        infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypePaiLie5;
        infoViewController.modeType = fushi;
    }
    else if (lotterytype == TYPE_HappyTen) {
        infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeHappyTen;
        infoViewController.modeType = HappyTenRen5;
        
    }
    [self.navigationController pushViewController:infoViewController animated:YES];
    [infoViewController release];
    databackVie.hidden = YES;
    databackImageV.hidden = YES;
}

- (void)beginDongHua {
    donghuaShua = 0;
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(showLuckNum) object:nil];
    [self donghuaChange];
}

- (void)donghuaChange {
    if (donghuaShua > 2) {
        
        if(isOnSound){
            
            if (![infoPlayer.url isEqual:[NSURL URLWithString: [[NSBundle mainBundle]pathForResource:@"yao" ofType:@"mp3" inDirectory:@"/"]]]) {
                [infoPlayer stop];
                [infoPlayer release];
                infoPlayer = nil;
                infoPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString: [[NSBundle mainBundle]pathForResource:@"yao" ofType:@"mp3" inDirectory:@"/"]] error:nil];
                infoPlayer.numberOfLoops = -1;
                [infoPlayer play];
            }
        }
        
        xingmangImage.hidden = NO;
        shandianImage.hidden = NO;
        for (int i = 1;i <= 10; i++) {
            UIView *v = [backimage viewWithTag:100+i];
            int a = arc4random();
            if (a % 3 == 0) {
                v.hidden = YES;
            }
            else {
                v.hidden = NO;
            }
            
            
            UIView *ImagV1 = [backimage viewWithTag:200 + i];
            NSInteger x= 0, y = 0;
            y  = mofaQiu.bounds.size.height / 2 - a % 160;
            x = sqrt(160 * 160 - y * y);
            if (a% 4 == 0) {
                ImagV1.center = CGPointMake(mofaQiu.center.x + (x -  arc4random() % 15 - 100), mofaQiu.center.y + y - 60);
            }
            else if (a % 4 == 1) {
                ImagV1.center = CGPointMake(mofaQiu.center.x + (x -  arc4random() % 15 - 100), mofaQiu.center.y - (y - 60));
            }
            else if (a %4 == 2) {
                ImagV1.center = CGPointMake(mofaQiu.center.x - (x - arc4random() % 15 - 100), mofaQiu.center.y - (y - 60));
            }
            else {
                ImagV1.center = CGPointMake(mofaQiu.center.x - (x - arc4random() % 15 - 100), mofaQiu.center.y + y - 60);
            }
            
        }
    }
    [self performSelector:@selector(donghuaChange) withObject:nil afterDelay:0.1];
    donghuaShua ++;
}

- (void)endDonhua {
    if (infoPlayer) {
        [infoPlayer stop];
        [infoPlayer release];
        infoPlayer = nil;
    }
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(donghuaChange) object:nil];
    shandianImage.hidden = YES;
    xingmangImage.hidden = YES;
    if (donghuaShua > 2) {
        [self randmon];
    }
    donghuaShua = 0;
    for (int i = 1; i <= 10; i ++) {
        UIView *ImagV2 = [backimage viewWithTag:100 + i];
        ImagV2.hidden = YES;
    }
}


- (void)randmon {
    [self.dataArray removeAllObjects];
    if (lotterytype == TYPE_11XUAN5_8 || lotterytype == TYPE_GD11XUAN5_8 || lotterytype == TYPE_JX11XUAN5_8) {
        NSMutableArray *xuanwuArray = [NSMutableArray array];
        while ([xuanwuArray count] < zhushu) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:8 start:1 maxnum:11];
			
			NSString *selet = [redBalls componentsJoinedByString:@","];
			
            selet = [NSString stringWithFormat:@"01#%@",selet];
            if (![xuanwuArray containsObject:selet]) {
                [xuanwuArray addObject:selet];
            }
        }
        for (int i = 0;i < [xuanwuArray count];i++) {
            NSString *new = [xuanwuArray objectAtIndex:i];
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:new,@"Num",@"1",@"ZhuShu",[NSString stringWithFormat:@"%d",lotterytype],@"lotterytype",nil];
			[dataArray addObject:dic];
			[dic release];
        }
    }
    else {
        while ([dataArray count] < zhushu) {
            NSString *new = @"01#";
            
            if (lotterytype == TYPE_SHUANGSEQIU) {
                NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:6 start:1 maxnum:33];
                NSMutableArray *blueBalls = [GC_LotteryUtil getRandBalls:1 start:1 maxnum:16];
                for (int i = 0; i<[redBalls count]; i++) {
                    new = [new stringByAppendingString:[redBalls objectAtIndex:i]];
                    if (i !=[redBalls count] -1) {
                        new = [new stringByAppendingString:@","];
                    }
                }
                new = [new stringByAppendingString:@"+"];
                new = [new stringByAppendingString:[blueBalls objectAtIndex:0]];
            }
            else if (lotterytype == TYPE_DALETOU) {
                NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:5 start:1 maxnum:35];
                NSMutableArray *blueBalls = [GC_LotteryUtil getRandBalls:2 start:1 maxnum:12];
                for (int i = 0; i<[redBalls count]; i++) {
                    new = [new stringByAppendingString:[redBalls objectAtIndex:i]];
                    if (i !=[redBalls count] -1) {
                        new = [new stringByAppendingString:@"_"];
                    }
                }
                new = [new stringByAppendingString:@"_:_"];
                
                for (int i = 0; i<[blueBalls count]; i++) {
                    new = [new stringByAppendingString:[blueBalls objectAtIndex:i]];
                    if (i !=[blueBalls count] -1) {
                        new = [new stringByAppendingString:@"_"];
                    }
                }
            }
            
            else if (lotterytype == TYPE_SHISHICAI) {
                for (int a= 0; a<=4; a++) {
                    NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                    new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 objectAtIndex:0]];
                    if (a != 4) {
                        new = [NSString stringWithFormat:@"%@,",new];
                    }
                }
            }
            else if (lotterytype == TYPE_CQShiShi) {
                for (int a= 0; a<=4; a++) {
                    NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                    new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 objectAtIndex:0]];
                    if (a != 4) {
                        new = [NSString stringWithFormat:@"%@,",new];
                    }
                }
            }
            else if (lotterytype == TYPE_QIXINGCAI) {
                NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                NSMutableArray *blueBalls = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                NSMutableArray *blueBalls2 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                NSMutableArray *blueBalls4 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                NSMutableArray *blueBalls5 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                NSMutableArray *blueBalls6 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                NSMutableArray *blueBalls7 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                for (int i = 0; i<[redBalls count]; i++) {
                    new = [new stringByAppendingString:[redBalls objectAtIndex:i]];
                }
                new = [NSString stringWithFormat:@"%@*", new];
                for (int i = 0; i<[blueBalls count]; i++) {
                    new = [new stringByAppendingString:[blueBalls objectAtIndex:i]];
                }
                new = [NSString stringWithFormat:@"%@*", new];
                for (int i = 0; i<[blueBalls2 count]; i++) {
                    new = [new stringByAppendingString:[blueBalls2 objectAtIndex:i]];
                }
                new = [NSString stringWithFormat:@"%@*", new];
                for (int i = 0; i<[blueBalls4 count]; i++) {
                    new = [new stringByAppendingString:[blueBalls4 objectAtIndex:i]];
                }
                new = [NSString stringWithFormat:@"%@*", new];
                for (int i = 0; i<[blueBalls5 count]; i++) {
                    new = [new stringByAppendingString:[blueBalls5 objectAtIndex:i]];
                }
                new = [NSString stringWithFormat:@"%@*", new];
                for (int i = 0; i<[blueBalls6 count]; i++) {
                    new = [new stringByAppendingString:[blueBalls6 objectAtIndex:i]];
                }
                new = [NSString stringWithFormat:@"%@*", new];
                for (int i = 0; i<[blueBalls7 count]; i++) {
                    new = [new stringByAppendingString:[blueBalls7 objectAtIndex:i]];
                }
            }
            else if (lotterytype == TYPE_7LECAI) {
                NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:7 start:1 maxnum:30];
                for (int i = 0; i<[redBalls count]; i++) {
                    new = [new stringByAppendingString:[redBalls objectAtIndex:i]];
                    if (i !=[redBalls count] -1) {
                        new = [new stringByAppendingString:@"_"];
                    }
                }
            }
            else if (lotterytype == TYPE_PAILIE5) {
                NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                NSMutableArray *blueBalls = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                NSMutableArray *blueBalls2 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                NSMutableArray *blueBalls4 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                NSMutableArray *blueBalls5 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                for (int i = 0; i<[redBalls count]; i++) {
                    new = [new stringByAppendingString:[redBalls objectAtIndex:i]];
                }
                new = [NSString stringWithFormat:@"%@*", new];
                for (int i = 0; i<[blueBalls count]; i++) {
                    new = [new stringByAppendingString:[blueBalls objectAtIndex:i]];
                }
                new = [NSString stringWithFormat:@"%@*", new];
                for (int i = 0; i<[blueBalls2 count]; i++) {
                    new = [new stringByAppendingString:[blueBalls2 objectAtIndex:i]];
                }
                new = [NSString stringWithFormat:@"%@*", new];
                for (int i = 0; i<[blueBalls4 count]; i++) {
                    new = [new stringByAppendingString:[blueBalls4 objectAtIndex:i]];
                }
                new = [NSString stringWithFormat:@"%@*", new];
                for (int i = 0; i<[blueBalls5 count]; i++) {
                    new = [new stringByAppendingString:[blueBalls5 objectAtIndex:i]];
                }
            }
            else if (lotterytype == TYPE_HappyTen) {
                NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:5 start:1 maxnum:20];
                new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 componentsJoinedByString:@","]];
            }
            if (![self.dataArray containsObject:new]) {
                [self.dataArray addObject:new];
            }
            
        }
    }
    for (int i = 1; i <= 10; i ++) {
        UIView *ImagV1 = [backimage viewWithTag:200 + i];
        NSInteger x= 0, y = 0;
        y  = mofaQiu.bounds.size.height / 2 - arc4random() % 15;
        x = sqrt(160 * 160 - y * y);
        if (arc4random()%2 ==0) {
            ImagV1.center = CGPointMake(mofaQiu.center.x + (x -  arc4random() % 15 - 20), mofaQiu.center.y + y - 60);
        }
        else {
            ImagV1.center = CGPointMake(mofaQiu.center.x - (x - arc4random() % 15 - 20), mofaQiu.center.y + y - 60);
        }
    }
    
    [self performSelector:@selector(showLuckNum) withObject:nil afterDelay:0.5];
}


#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView.tag == 101) {
        if ([caiZhongArray count]>row) {
            return [caiZhongArray objectAtIndex:row];
        }
        
    }
    else if (pickerView.tag == 102) {
        return [NSString stringWithFormat:@"%d注",(int)row + 1];
    }
    return nil;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView.tag == 101) {
        return 1;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag == 101) {
        return [caiZhongArray count];
    }
    else if (pickerView.tag == 102) {
        return 10;
    }
    return 0;
}

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

}

#pragma mark -
#pragma mark UITextFieldDelegate 

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    