//
//  GCLiushuiXiangqingController.m
//  caibo
//
//  Created by  on 12-5-23.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GCLiushuiXiangqingController.h"
#import "Info.h"
#import "ColorView.h"

#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] doubleValue] >= 7

@implementation GCLiushuiXiangqingController
@synthesize xiangqingtype;
@synthesize allarray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.CP_navigation.title = @"详情";
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgimage.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    [self.mainView addSubview:bgimage];
    [bgimage release];
    
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = left;
    
    UIScrollView * liuShuiScrollView = [[[UIScrollView alloc] initWithFrame:self.mainView.bounds] autorelease];
    [self.mainView addSubview:liuShuiScrollView];
    
    
    
    
    UIView *backGroundView = [[[UIView alloc] init] autorelease];
    backGroundView.backgroundColor = [UIColor whiteColor];
    [liuShuiScrollView addSubview:backGroundView];
    
    
    
    
    // 交易时间
    ColorView * time = [[[ColorView alloc] initWithFrame:CGRectMake(13, 15, 266, 20)] autorelease];
    time.changeColor = [UIColor colorWithRed:162.0/255.0 green:162.0/255.0 blue:162.0/255.0 alpha:1];
    [liuShuiScrollView addSubview:time];
    time.backgroundColor = [UIColor clearColor];
    time.colorfont = [UIFont systemFontOfSize:12];
    time.font = time.colorfont;
    CGSize  timeSize = [time.text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(192,2000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    ColorView *timeR = [[ColorView alloc] initWithFrame: CGRectMake(13, 30 + timeSize.height+6, 135, 20)];
    timeR.changeColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1];
    timeR.backgroundColor = [UIColor clearColor];
    timeR.colorfont = [UIFont systemFontOfSize:16];
    timeR.font = timeR.colorfont;
    [liuShuiScrollView addSubview:timeR];
    [timeR release];

    
    
    // 交易金额
    ColorView * money = [[[ColorView alloc] initWithFrame:CGRectMake(13, 82, 266, 40)] autorelease];
    money.changeColor =[UIColor colorWithRed:162.0/255.0 green:162.0/255.0 blue:162.0/255.0 alpha:1];
    money.backgroundColor = [UIColor clearColor];
    money.colorfont = [UIFont systemFontOfSize:12];
    money.font = money.colorfont;
    [liuShuiScrollView addSubview:money];

    ColorView * moneyR = [[[ColorView alloc] init] autorelease];
    moneyR.changeColor =[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1];
    moneyR.textAlignment = NSTextAlignmentRight;
    moneyR.backgroundColor = [UIColor clearColor];
    moneyR.colorfont = [UIFont systemFontOfSize:30];
    moneyR.font = moneyR.colorfont;
    moneyR.frame = CGRectMake(200, 103, 103.5, 30);
    [liuShuiScrollView addSubview:moneyR];

    
    
    
    
    ColorView * moneyYuan = [[[ColorView alloc] initWithFrame:CGRectMake(265+20, 121, 40, 30)] autorelease];
    [liuShuiScrollView addSubview:moneyYuan];
    moneyYuan.textColor =[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1];
    moneyYuan.text = @"元";
    moneyYuan.backgroundColor = [UIColor clearColor];
    moneyYuan.colorfont = [UIFont systemFontOfSize:12];
    moneyYuan.font = moneyYuan.colorfont;
    
    
    
    
    
    ColorView * decimalsMoney = [[[ColorView alloc] initWithFrame:CGRectMake(265, 120, 40, 20)] autorelease];
    [liuShuiScrollView addSubview:decimalsMoney];
    decimalsMoney.textColor =[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1];
    decimalsMoney.backgroundColor = [UIColor clearColor];
    decimalsMoney.colorfont = [UIFont systemFontOfSize:12];
    decimalsMoney.font = moneyYuan.colorfont;
    
    
    
    // 交易类型
    ColorView * type = [[[ColorView alloc] initWithFrame:CGRectMake(13, 159.5, 266, 20)] autorelease];
    type.changeColor = [UIColor colorWithRed:162.0/255.0 green:162.0/255.0 blue:162.0/255.0 alpha:1];
    [liuShuiScrollView addSubview:type];
    type.backgroundColor = [UIColor clearColor];
    type.colorfont = [UIFont systemFontOfSize:12];
    type.font = type.colorfont;
    
    ColorView * typeR = [[[ColorView alloc] initWithFrame:CGRectMake(13, 187, 266, 22)] autorelease];
    typeR.changeColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1];
    [liuShuiScrollView addSubview:typeR];
    typeR.backgroundColor = [UIColor clearColor];
    typeR.colorfont = [UIFont systemFontOfSize:16];
    typeR.font = typeR.colorfont;
    
    
    
//    ColorView * remark = [[[ColorView alloc] init] autorelease];
//    remark.changeColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1];
//    [liuShuiScrollView addSubview:remark];
//    remark.backgroundColor = [UIColor clearColor];
//    remark.colorfont = [UIFont systemFontOfSize:15];
//    remark.font = [UIFont systemFontOfSize:16];
//    remark.jianjuHeight = 18;
  
    UILabel *remark = [[[UILabel alloc] init] autorelease];
    remark.textColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1];
    [liuShuiScrollView addSubview:remark];
    remark.backgroundColor = [UIColor clearColor];
    remark.font = [UIFont systemFontOfSize:16];
    remark.numberOfLines = 0;
    
    
    
    // 单号
    ColorView * status = [[[ColorView alloc] init] autorelease];
    [liuShuiScrollView addSubview:status];
    status.backgroundColor = [UIColor clearColor];
    status.changeColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1];
    status.colorfont = [UIFont systemFontOfSize:15];
    status.font = status.colorfont;
    status.jianjuHeight = 14;
   
    
    
    
    UILabel * status1 = [[[UILabel alloc] init] autorelease];
    [liuShuiScrollView addSubview:status1];
    status1.backgroundColor = [UIColor clearColor];
    status1.font = [UIFont systemFontOfSize:12];
    status1.text =@"状态";
    status1.textColor = [UIColor colorWithRed:162.0/255.0 green:162.0/255.0 blue:162.0/255.0 alpha:1];
    
    
    
    ColorView * num = [[[ColorView alloc] init] autorelease];
    [liuShuiScrollView addSubview:num];
    num.backgroundColor = [UIColor clearColor];
    num.colorfont = [UIFont systemFontOfSize:16];
    num.font = num.colorfont;
    num.textColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1];
     UILabel * num1 = [[[UILabel alloc] init] autorelease];
    [liuShuiScrollView addSubview:num1];
    num1.backgroundColor = [UIColor clearColor];
    num1.font = [UIFont systemFontOfSize:12];
    num1.text =@"单号";
    num1.frame = CGRectMake(10, 256, 60, 22);
    num1.textColor = [UIColor colorWithRed:162.0/255.0 green:162.0/255.0 blue:162.0/255.0 alpha:1];
  
    
    
    
#ifdef isCaiPiaoForIPad

#endif


    //  根据不同的类型传入不同的text
    // 充值
    if (xiangqingtype == xiangqingchongzhi) {
       
        
        backGroundView.frame = CGRectMake(0, 0, 320, 310 + 67);
        time.text = [NSString stringWithFormat:@"<充值时间>"];
        timeR.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:0]];
        
        money.text = [NSString stringWithFormat:@"<充值金额>"];
        float mon = [[NSString stringWithFormat:@"%@",[allarray objectAtIndex:1]] floatValue];
        NSString *mon1 = [NSString stringWithFormat:@"%.2f",mon];
        NSString *mon2 = [mon1 substringFromIndex:[mon1 length]-2];
        NSString *monr = [mon1 substringToIndex:[mon1 length]-2];
        moneyR.text = monr;
        decimalsMoney.text = mon2;
        moneyR.textAlignment = NSTextAlignmentRight;
        type.text = [NSString stringWithFormat:@"<充值类型>"];
        typeR.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:2]];
        remark.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:5]];
        
        
        status.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:3]];
        num.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:4]];
        type.frame = CGRectMake(13, 159.5, 70, 20);
        typeR.frame = CGRectMake(13, 159.5+25, 200, 20);
        if ([remark.text isEqualToString:@"-"]) {
            remark.text = @"";
            typeR.frame = CGRectMake(13, 159.5+25+25, 200, 20);
        }
    
    }else if(xiangqingtype == xiangqingdongjie){
        
        
        
        backGroundView.frame = CGRectMake(0, 0, 320, 310 + 67);

        time.text = [NSString stringWithFormat:@"<冻结时间> "];
        timeR.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:0]];
        money.text = [NSString stringWithFormat:@"<冻结金额>"];
        float mon = [[NSString stringWithFormat:@"%@",[allarray objectAtIndex:1]] floatValue];
        NSString *mon1 = [NSString stringWithFormat:@"%.2f",mon];
        NSString *mon2 = [mon1 substringFromIndex:[mon1 length]-2];
        NSString *monr = [mon1 substringToIndex:[mon1 length]-2];
        moneyR.text = monr;
        decimalsMoney.text = mon2;
        moneyR.textAlignment = NSTextAlignmentRight;
        
        
        type.text = [NSString stringWithFormat:@"<冻结类型>"];
        typeR.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:2]];
        remark.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:5]];
        
        
        status.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:3]];
        num.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:4]];
        

        
        
    }else if(xiangqingtype == xiangqingtixian){
        
        backGroundView.frame = CGRectMake(0, 0, 320, 310+67);

        time.text = [NSString stringWithFormat:@"<提款时间>"];
        timeR.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:0]];
        
        money.text = [NSString stringWithFormat:@"<提款金额>"];
        
        float mon = [[NSString stringWithFormat:@"%@",[allarray objectAtIndex:1]] floatValue];
        NSString *mon1 = [NSString stringWithFormat:@"%.2f",mon];
        NSString *mon2 = [mon1 substringFromIndex:[mon1 length]-2];
        NSString *monr = [mon1 substringToIndex:[mon1 length]-2];
        moneyR.text = monr;
        decimalsMoney.text = mon2;
        moneyR.textAlignment = NSTextAlignmentRight;
        
        type.text = [NSString stringWithFormat:@"<提款类型>"];
        typeR.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:2]];
        remark.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:5]];
        
        status.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:3]];
        num.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:4]];
       
        
        type.frame = CGRectMake(13, 159.5, 70, 20);
        typeR.frame = CGRectMake(13, 159.5+25, 200, 20);
        num1.frame = CGRectMake(15, 310+15, 60, 20);
        



   
    }else{
        
        backGroundView.frame = CGRectMake(0, 0, 320, 310);
        time.text = [NSString stringWithFormat:@"<交易时间> "];
        timeR.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:0]];
        money.text = [NSString stringWithFormat:@"<操作金额> "];
        moneyR.textAlignment = NSTextAlignmentRight;
  
        
        
        
        float mon = [[NSString stringWithFormat:@"%@",[allarray objectAtIndex:1]] floatValue];
        NSString *mon1 = [NSString stringWithFormat:@"%.2f",mon];
        NSString *mon2 = [mon1 substringFromIndex:[mon1 length]-2];
        NSString *monr = [mon1 substringToIndex:[mon1 length]-2];
        moneyR.text = monr;
        decimalsMoney.text = mon2;
        type.text = [NSString stringWithFormat:@"<交易类型> "];
        typeR.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:2]];
        typeR.font = [UIFont systemFontOfSize:16];
        remark.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:4]];

        if ([remark.text isEqualToString:typeR.text]) {
            remark.text = @"";
            typeR.frame = CGRectMake(13, 159.5+25 +25 , 200, 20);
        }
        
        num.text = [NSString stringWithFormat:@"%@",[allarray objectAtIndex:3]];

}

   
    
    if ([remark.text isEqualToString:@"<->"]) {
        remark.frame = CGRectMake(13+2,206, 180, 0);
    }else{
        if (IS_IOS7) {
            // remarkSize.height + (remarkSize.height/19 - 1) * 15
            remark.frame = CGRectMake(15,206, 290, 40);
        }else{
            remark.frame = CGRectMake(15,206, 290, 40);
        }
    }
    
    
    
    
    NSString * statusText = [NSString stringWithFormat:@"%@",status.text];
    CGSize statusSize = [statusText sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(180,2000) lineBreakMode:UILineBreakModeCharacterWrap];
    NSString * moneyRText = [NSString stringWithFormat:@"%@",moneyR.text];
    CGSize moneyRSize = [moneyRText sizeWithFont:[UIFont systemFontOfSize:30] constrainedToSize:CGSizeMake(180, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
    NSString * numText = [NSString stringWithFormat:@"%@",num.text];
    CGSize numSize = [numText sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(192,2000) lineBreakMode:UILineBreakModeCharacterWrap];
   
    
    
    
    
    moneyR.frame = CGRectMake(200, 103, moneyRSize.width+5, moneyRSize.height);
    num.textColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1];
    typeR.textColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1];
    remark.textColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1];
    timeR.textColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1];
    moneyR.textColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1];
    status.textColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1];

    
    // 共两种风格
    if (xiangqingtype != xiangqingquanbu) {
        
        // 线
        UIView *xianView = [[[UIView alloc] initWithFrame: CGRectMake(0, 67, 320, 0.5)] autorelease];
        xianView.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        [backGroundView addSubview:xianView];
        UIView *xianView1 = [[[UIView alloc] initWithFrame:CGRectMake(0, 144.5, 320, 0.5)] autorelease];
        xianView1.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        [backGroundView addSubview:xianView1];
        
        
        UIView *xianView2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 242.5, 320, 0.5)] autorelease];
        xianView2.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        [backGroundView addSubview:xianView2];
        
        UIView *xianView3 = [[[UIView alloc] initWithFrame:CGRectMake(0, 310, 320, 0.5)] autorelease];
        xianView3.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        [backGroundView addSubview:xianView3];

        
        UIView *xianView4 = [[[UIView alloc] init] autorelease];
        xianView4.frame = CGRectMake(0, 310+67, 320, 0.5);
        xianView4.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        [backGroundView addSubview:xianView4];
        
        if (IS_IOS7) {
            
            status.frame = CGRectMake(110,remark.frame.origin.y + remark.frame.size.height + 14, 180, statusSize.height);
            status1.text = @"状态";
            status1.frame = CGRectMake(15, status.frame.origin.y, 70, 20);
            num.frame = CGRectMake(111, status.frame.origin.y + status.frame.size.height + 40, 192, numSize.height + (numSize.height/19 - 1) * 15);
            num1.frame = CGRectMake(15, 320, 40, 20);
            status.frame = CGRectMake(13, 257.5+30, 180, statusSize.height);
            num.frame = CGRectMake(13, 325+28, 200, 20);
            moneyYuan.frame = CGRectMake(200+moneyRSize.width+20,118 , 40, 30);
            decimalsMoney.frame = CGRectMake(200+moneyRSize.width,120 , 40, 30);
            
        }else{
            
        // ***
        status.frame = CGRectMake(116.2,remark.frame.origin.y + remark.frame.size.height + 14, 180, statusSize.height);
        // 159.5
        status1.frame = CGRectMake(15, status.frame.origin.y, 70, 20);
        num.frame = CGRectMake(13,272.5+numSize.height , 192, numSize.height + (numSize.height/19 - 1) * 15);
            
        num1.frame = CGRectMake(15, 320, 40, 20);
        status.frame = CGRectMake(13+3.2, 257.5+30, 180, statusSize.height);
        num.frame = CGRectMake(15, 325+28, 200, 20);
        moneyYuan.frame = CGRectMake(200+moneyRSize.width+20,118 , 40, 30);
        decimalsMoney.frame = CGRectMake(200+moneyRSize.width,120 , 40, 30);

            
        }
        
    }else{
        
        UIView *xianView = [[[UIView alloc] initWithFrame: CGRectMake(0, 67, 320, 0.5)] autorelease];
        xianView.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        [backGroundView addSubview:xianView];
        UIView *xianView1 = [[[UIView alloc] initWithFrame:CGRectMake(0, 144.5, 320, 0.5)] autorelease];
        xianView1.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        [backGroundView addSubview:xianView1];
        
        
        UIView *xianView2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 242.5, 320, 0.5)] autorelease];
        xianView2.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        [backGroundView addSubview:xianView2];
        
        UIView *xianView3 = [[[UIView alloc] initWithFrame:CGRectMake(0, 310, 320, 0.5)] autorelease];
        xianView3.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        [backGroundView addSubview:xianView3];

        
        
        if (IS_IOS7) {
            if ([[allarray objectAtIndex:4] hasPrefix:@"合买"]) {
                num.frame = CGRectMake(13,263+numSize.height , 192, numSize.height + (numSize.height/19 - 1) * 15);
                num1.frame = CGRectMake(15, 257.5, 40, 20);
                moneyYuan.frame = CGRectMake(200+moneyRSize.width+20,118 , 40, 30);
                decimalsMoney.frame = CGRectMake(200+moneyRSize.width,120 , 40, 30);

            }else{
                num.frame = CGRectMake(13,263+numSize.height , 192, numSize.height + (numSize.height/19 - 1) * 15);
                num1.frame = CGRectMake(15, 257.5, 40, 20);
                moneyYuan.frame = CGRectMake(200+moneyRSize.width+20,118 , 40, 30);
                decimalsMoney.frame = CGRectMake(200+moneyRSize.width,120 , 40, 30);

            }
        }else{
            num.frame = CGRectMake(13,263+numSize.height , 192, numSize.height + (numSize.height/19 - 1) * 15);
            num1.frame = CGRectMake(15, 257.5, 40, 20);
            moneyYuan.frame = CGRectMake(200+moneyRSize.width+20,118 , 40, 30);
            decimalsMoney.frame = CGRectMake(200+moneyRSize.width,120 , 40, 30);

        }
    }
    
    if (IS_IOS7) {
        num1.text =@"单号";

    }
    liuShuiScrollView.contentSize = CGSizeMake(320, num.frame.origin.y + num.frame.size.height + 15);
    
}
- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    