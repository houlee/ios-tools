    //
//  Xieyi365ViewController.m
//  caibo
//
//  Created by yao on 12-5-10.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "Xieyi365ViewController.h"
#import "Info.h"
#import <QuartzCore/QuartzCore.h>

#import "ColorView.h"
#import "FAQView.h"
#import "HeaderLabel.h"
#import "WanfaInfoCell.h"
#import "QuestionViewController.h"
#import "MobClick.h"
#import "GC_LotteryType.h"
#import "SharedDefine.h"
#import "SharedMethod.h"

#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define TITLE_COLOR [UIColor blackColor]



@implementation Xieyi365ViewController

@synthesize infoText;
@synthesize ALLWANFA;
@synthesize myTableView, caizhongJQ;
@synthesize cell1Array;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		
    }
    return self;
}

- (id)init {
	self = [super init];
	if (self) {
		infoText = [[UITextView alloc] init];
		infoText.frame = CGRectMake(5, 5, 310, 400);
		infoText.backgroundColor = [UIColor clearColor];
        infoText.font = [UIFont boldSystemFontOfSize:16];
		infoText.editable = NO;
        //
	}
	return self;
}
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)goBackTo {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)pressJiQiao:(UIButton *)sender {
    if (ALLWANFA == BeiJingDanChang || ALLWANFA == bdbanquanchang || ALLWANFA == bdbifen || ALLWANFA == bdshangxiadanshuang || ALLWANFA == bdzongjinqiu || ALLWANFA == beidanshengfu) {
        [MobClick event:@"event_goucai_wanfashuoming_touzhujiqiao_caizong" label:@"北单"];
    }
    else if (ALLWANFA == JingCaiZuQiu || ALLWANFA == huntou || (ALLWANFA >= JingCaiZuQiuZJQS && ALLWANFA <= JingCaiZuQiuRQSPF) || ALLWANFA == hunTouErXuanYi) {
        [MobClick event:@"event_goucai_wanfashuoming_touzhujiqiao_caizong" label:@"竞彩足球"];
    }
    else if (ALLWANFA == lanqiuhuntouwf || (ALLWANFA >= JingCaiLanQiuDXF && ALLWANFA <= JingCaiLanQiuSF)) {
        [MobClick event:@"event_goucai_wanfashuoming_touzhujiqiao_caizong" label:@"竞彩篮球"];
    }
    else {
        [MobClick event:@"event_goucai_wanfashuoming_touzhujiqiao_caizong" label:self.CP_navigation.title];
    }
    

    TouzhujiqiaoViewController *jq = [[TouzhujiqiaoViewController alloc] init];
    [self.navigationController pushViewController:jq animated:YES];
    [jq Jiqiao:caizhongJQ];
    [jq release];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(goBackTo)];
	self.CP_navigation.leftBarButtonItem =left;

    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    //  backImage.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage.frame = CGRectMake(0, 44, backImage.frame.size.width, backImage.frame.size.height);
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
	[self.view insertSubview:backImage atIndex:0];
    self.mainView.backgroundColor = [UIColor clearColor];
    [backImage release];

    
    if (ALLWANFA == Xieyi) {
#ifdef isCaiPiaoForIPad
        [self.navigationController setNavigationBarHidden:YES];
        self.CP_navigation.image = UIImageGetImageFromName(@"daohangtiao.png");
        self.CP_navigation.frame = CGRectMake(0, -2, 540, 44);
        
        infoText.frame = CGRectMake(0, 0, 540, 630);
        [self.mainView addSubview:infoText];

#else
//        infoText.frame = self.mainView.bounds;
//        [self.mainView addSubview:infoText];

        self.CP_navigation.titleLabel.frame = CGRectMake(45, 0, 240, 44);
        UIScrollView * mainScrollView = [[[UIScrollView alloc] initWithFrame:self.mainView.bounds] autorelease];
        [self.mainView addSubview:mainScrollView];
        
      
        
        NSString * path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"365xieyi.docx"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        
        UIWebView * xieyiWebView = [[[UIWebView alloc] initWithFrame:self.mainView.bounds] autorelease];
        xieyiWebView.scalesPageToFit = YES;
        xieyiWebView.scrollView.bounces = NO;
        xieyiWebView.scrollView.bouncesZoom = NO;
        [xieyiWebView loadRequest:request];
        [mainScrollView addSubview:xieyiWebView];
        
        
//        ColorView * mainColorView = [[[ColorView alloc] initWithFrame:CGRectMake(19, 28.5, 282, 4000)] autorelease];
//        if (IS_IOS7) {
//            mainColorView.frame = CGRectMake(mainColorView.frame.origin.x, mainColorView.frame.origin.y, mainColorView.frame.size.width, mainColorView.frame.size.height - 20*9);
//        }
//        [mainScrollView addSubview:mainColorView];
//        mainColorView.font = [UIFont systemFontOfSize:14];
//        mainColorView.textColor = [UIColor colorWithRed:35/255.0 green:35/255.0 blue:35/255.0 alpha:1];
//        mainColorView.colorfont = [UIFont boldSystemFontOfSize:14];
//        mainColorView.changeColor = [UIColor colorWithRed:35/255.0 green:35/255.0 blue:35/255.0 alpha:1];
//        mainColorView.backgroundColor = [UIColor clearColor];
//        mainColorView.isN = YES;
//        mainColorView.jianjuHeight = 11;
//        mainColorView.text = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
//        
//        mainScrollView.contentSize = CGSizeMake(0, mainColorView.frame.size.height + 60);
//        
//        ColorView * colorView = [[[ColorView alloc] initWithFrame:CGRectMake(mainColorView.frame.origin.x - 2, 57.5, mainColorView.frame.size.width, 22)] autorelease];
//        colorView.textColor = TITLE_COLOR;
//        colorView.backgroundColor = [UIColor clearColor];
//        colorView.font = [UIFont boldSystemFontOfSize:17];
//        colorView.text = @"特别提示：";
//        [mainScrollView addSubview:colorView];
//        
//        ColorView * colorView1 = [[[ColorView alloc] initWithFrame:CGRectMake(mainColorView.frame.origin.x - 2, 289.5, mainColorView.frame.size.width, 22)] autorelease];
//        if (IS_IOS7) {
//            colorView1.frame = CGRectMake(colorView1.frame.origin.x, colorView1.frame.origin.y - 20, colorView1.frame.size.width, colorView1.frame.size.height);
//        }
//        colorView1.textColor = TITLE_COLOR;
//        colorView1.backgroundColor = [UIColor clearColor];
//        colorView1.font = [UIFont boldSystemFontOfSize:17];
//        colorView1.text = @"一、相关定义";
//        [mainScrollView addSubview:colorView1];
//        
//        ColorView * colorView2 = [[[ColorView alloc] initWithFrame:CGRectMake(mainColorView.frame.origin.x - 2, 898, mainColorView.frame.size.width, 22)] autorelease];
//        if (IS_IOS7) {
//            colorView2.frame = CGRectMake(colorView2.frame.origin.x, colorView2.frame.origin.y - 20*2, colorView2.frame.size.width, colorView2.frame.size.height);
//        }
//        colorView2.textColor = TITLE_COLOR;
//        colorView2.backgroundColor = [UIColor clearColor];
//        colorView2.font = [UIFont boldSystemFontOfSize:17];
//        colorView2.text = @"二、用户的权利";
//        [mainScrollView addSubview:colorView2];
//        
//        ColorView * colorView3 = [[[ColorView alloc] initWithFrame:CGRectMake(mainColorView.frame.origin.x - 2, 1710.5, mainColorView.frame.size.width, 22)] autorelease];
//        if (IS_IOS7) {
//            colorView3.frame = CGRectMake(colorView3.frame.origin.x, colorView3.frame.origin.y - 20*4, colorView3.frame.size.width, colorView3.frame.size.height);
//        }
//        colorView3.textColor = TITLE_COLOR;
//        colorView3.backgroundColor = [UIColor clearColor];
//        colorView3.font = [UIFont boldSystemFontOfSize:17];
//        colorView3.text = @"三、投注站的权利";
//        [mainScrollView addSubview:colorView3];
//        
//        ColorView * colorView4 = [[[ColorView alloc] initWithFrame:CGRectMake(mainColorView.frame.origin.x - 2, 2609.5, mainColorView.frame.size.width, 22)] autorelease];
//        if (IS_IOS7) {
//            colorView4.frame = CGRectMake(colorView4.frame.origin.x, colorView4.frame.origin.y - 20*6, colorView4.frame.size.width, colorView4.frame.size.height);
//        }
//        colorView4.textColor = TITLE_COLOR;
//        colorView4.backgroundColor = [UIColor clearColor];
//        colorView4.font = [UIFont boldSystemFontOfSize:17];
//        colorView4.text = @"四、投注站的微博服务";
//        [mainScrollView addSubview:colorView4];
//        
//        ColorView * colorView5 = [[[ColorView alloc] initWithFrame:CGRectMake(mainColorView.frame.origin.x - 2, 3653.5, mainColorView.frame.size.width, 22)] autorelease];
//        if (IS_IOS7) {
//            colorView5.frame = CGRectMake(colorView5.frame.origin.x, colorView5.frame.origin.y - 20*8, colorView5.frame.size.width, colorView5.frame.size.height);
//        }
//        colorView5.textColor = TITLE_COLOR;
//        colorView5.backgroundColor = [UIColor clearColor];
//        colorView5.font = [UIFont boldSystemFontOfSize:17];
//        colorView5.text = @"五、法律适用和管辖";
//        [mainScrollView addSubview:colorView5];
//        
//        ColorView * colorView6 = [[[ColorView alloc] initWithFrame:CGRectMake(mainColorView.frame.origin.x - 2, 3932, mainColorView.frame.size.width, 70)] autorelease];
//        if (IS_IOS7) {
//            colorView6.frame = CGRectMake(colorView6.frame.origin.x, colorView6.frame.origin.y - 20*9, colorView6.frame.size.width, colorView6.frame.size.height);
//        }
//        colorView6.textColor = TITLE_COLOR;
//        colorView6.backgroundColor = [UIColor clearColor];
//        colorView6.font = [UIFont boldSystemFontOfSize:17];
//        colorView6.text = @"六、本协议最终解释权归北京溢彩阳光（北京）科技有限公司所有";
//        colorView6.jianjuHeight = 11;
//        [mainScrollView addSubview:colorView6];
#endif
                
    }
    else {
#ifdef isCaiPiaoForIPad
        self.mainView.frame = CGRectMake(35, 44, 390, self.mainView.frame.size.height);
        
#endif
        [self WanFaInfo];
    }

}

#pragma mark -
#pragma mark UITableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(cell1Array)
        return [cell1Array count];
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (ALLWANFA == ShuangSeQiu)
    {
        if(indexPath.row == 3 || indexPath.row == 4)
            return 36+22;
        if(indexPath.row == 5)
            return 36+44;
    }
    else if(ALLWANFA == DaLeTou)
    {
        if(indexPath.row == 4)
            return 36+44;
        if(indexPath.row == 3 || indexPath.row == 2)
            return 36+22;
        if(indexPath.row == 5)
            return 36+66;
    }
    else if(ALLWANFA == FuCai3D)
    {
        if(indexPath.row == 0 ||indexPath.row == 4)
            return 36;
        else
            return 36+22;
    }
    else if(ALLWANFA == Pai3)
    {
        if(indexPath.row == 0 || indexPath.row == 2 ||indexPath.row == 3)
            return 36;
        else
            return 36+22;
    }
    else if(ALLWANFA == KuaiLeShiFen)
    {
        if(indexPath.row == 10 || indexPath.row == 11)
            return 36+22+22;
        else
            return 36+22;
    }
    else if(ALLWANFA == QiXinCai)
    {
        return 36+22;
    }
    else if(ALLWANFA == QiLeCai)
    {
        return 36+22+22;
    }
    else if(ALLWANFA == ShiYiXuan5)
    {
        if(indexPath.row == 7 ||indexPath.row == 8 ||indexPath.row == 9 ||indexPath.row == 10 ||indexPath.row == 11)
            return 36+22;
    }
    else if(ALLWANFA == GDShiYiXuan5)
    {
        if(indexPath.row == 7 ||indexPath.row == 8 ||indexPath.row == 9 ||indexPath.row == 10 ||indexPath.row == 11)
            return 36+22;
    }
    else if(ALLWANFA == JXShiYiXuan5)
    {
        if(indexPath.row == 7 ||indexPath.row == 8 ||indexPath.row == 9 ||indexPath.row == 10 ||indexPath.row == 11)
            return 36+22;
    }
    else if(ALLWANFA == HBShiYiXuan5)
    {
        if(indexPath.row == 7 ||indexPath.row == 8 ||indexPath.row == 9 ||indexPath.row == 10 ||indexPath.row == 11)
            return 36+22;
    }
    else if(ALLWANFA == ShanXiShiYiXuan5)
    {
        if(indexPath.row == 7 ||indexPath.row == 8 ||indexPath.row == 9 ||indexPath.row == 10 ||indexPath.row == 11)
            return 36+22;
    }
    else if(ALLWANFA == ShiShiCai)
    {
        if(indexPath.row == 4)
            return 36+22+22+22;
        else if(indexPath.row == 8)
            return (36+22)*3;
        else if(indexPath.row == 0)
            return 36+22+22;

        else
            return 36+22;
    }
    else if(ALLWANFA == ChongQShiShiCai)
    {
        
        if(indexPath.row == 10)
            return (36+22)*3;
        else if(indexPath.row == 0)
            return 36+22+22;
        else
            return 36+22;
    }
    else if(ALLWANFA == kuailepuke)
    {
        return 36+22+22;
    }
    else if (ALLWANFA == SendAwardTime)
    {
        if (indexPath.row == 1) {
            return 53 + 71;
        }else if (indexPath.row == 2) {
            return 53 + 53;
        }else if (indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 8 || indexPath.row == 9) {
            return 53;
        }
        else
            return 35;
    }
    else if (ALLWANFA == Kuai3 || ALLWANFA == JSKuai3 || ALLWANFA == HBKuai3 || ALLWANFA == JLKuai3 || ALLWANFA == AHKuai3)
    {
        if (indexPath.row == 0) {
            return 36;
        }
        else
            return 58;
    }
    else if (ALLWANFA == Horse) {
        return 53;
    }
    return 36;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    WanfaInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(ALLWANFA == ShuangSeQiu)
    {
        if(!cell)
        {
            cell =[[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;
            
            if(indexPath.row ==3 || indexPath.row == 4)
            {
                UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 36+22-1, 320, 1)];
                [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
                [cell.contentView addSubview:xian];
                [xian release];
                cell.hangofCell = 2;

            }
            else if(indexPath.row == 5)
            {
                UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 36+22+22-1, 320, 1)];
                [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
                [cell.contentView addSubview:xian];
                [xian release];
                cell.hangofCell = 3;

            }
            
            else
            {
                UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 320, 1)];
                [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
                [cell.contentView addSubview:xian];
                [xian release];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        NSArray *cell3Array = [NSArray arrayWithObjects:@"中6红+1蓝",@"中6红",@"中5红+1蓝",@"中5红,中4红+1蓝",@"中4红,中3红+1蓝",@"中2红+1蓝,中1红+1蓝,中1蓝", nil];
        NSArray *cell4Array = [NSArray arrayWithObjects:@"浮动",@"浮动",@"3000元",@"200元",@"10元",@"5元", nil];
        
        [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:1 andWedith:61];
        if(indexPath.row == 0)
        {
            [cell addCell2WithRedBordNum:6 andBlueBordNum:1 andCellNum:1 andWedith:87];
            [cell addCell3WithBord:[cell3Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:87];

        }
        else if(indexPath.row == 1)
        {
            [cell addCell2WithRedBordNum:6 andBlueBordNum:0 andCellNum:1 andWedith:87];
            [cell addCell3WithBord:[cell3Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:87];


        }
        else if(indexPath.row == 2)
        {
            [cell addCell2WithRedBordNum:5 andBlueBordNum:1 andCellNum:1 andWedith:87];
            [cell addCell3WithBord:[cell3Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:87];


        }
        else if(indexPath.row == 3)
        {
            [cell addCell2WithRedBordNum:5 andBlueBordNum:0 andCellNum:1 andWedith:87];
            [cell addCell2WithRedBordNum:4 andBlueBordNum:1 andCellNum:2 andWedith:87];
            NSString *string = [cell3Array objectAtIndex:indexPath.row];
            NSArray *array = [string componentsSeparatedByString:@","];
            for(int i = 0;i<[array count];i++)
            {
                [cell addCell3WithBord:[array objectAtIndex:i] andCellNum:i+1 andWedith:87];

            }


        }
        else if(indexPath.row == 4)
        {
            [cell addCell2WithRedBordNum:4 andBlueBordNum:0 andCellNum:1 andWedith:87];
            [cell addCell2WithRedBordNum:3 andBlueBordNum:1 andCellNum:2 andWedith:87];
            
            NSString *string = [cell3Array objectAtIndex:indexPath.row];
            NSArray *array = [string componentsSeparatedByString:@","];
            for(int i = 0;i<[array count];i++)
            {
                [cell addCell3WithBord:[array objectAtIndex:i] andCellNum:i+1 andWedith:87];
                
            }
        }
        else
        {
            [cell addCell2WithRedBordNum:2 andBlueBordNum:1 andCellNum:1 andWedith:87];
            [cell addCell2WithRedBordNum:1 andBlueBordNum:1 andCellNum:2 andWedith:87];
            [cell addCell2WithRedBordNum:0 andBlueBordNum:1 andCellNum:3 andWedith:87];
            
            NSString *string = [cell3Array objectAtIndex:indexPath.row];
            NSArray *array = [string componentsSeparatedByString:@","];
            for(int i = 0;i<[array count];i++)
            {
                [cell addCell3WithBord:[array objectAtIndex:i] andCellNum:i+1 andWedith:87];
                
            }

        }

        [cell addCell4:[cell4Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:61];

        
        
        
    }
    else if(ALLWANFA == DaLeTou)
    {
        if(!cell)
        {
            cell =[[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;


        }
        if(indexPath.row == 3 || indexPath.row == 2)
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 36+22-1, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            cell.hangofCell = 2;
        }
        else if(indexPath.row == 4)
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 36+22+22-1, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            cell.hangofCell = 3;
        }
        else if(indexPath.row == 5)
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 36+22+22+22-1, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            cell.hangofCell = 4;
        }
        else
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *cell3Array = [NSArray arrayWithObjects:@"中5红+2蓝",@"中5红+1蓝",@"中5红,中4红+2蓝",@"中4红+1蓝,中3红+2蓝",@"中4红,中3红+1蓝,中2红+2蓝",@"中3红,中2红+1蓝,中1红+2蓝,中2蓝", nil];
        
        NSArray *cell4Array = [NSArray arrayWithObjects:@"浮动",@"浮动",@"浮动",@"200元",@"10元",@"5元", nil];
        
        [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:1 andWedith:61];
        if(indexPath.row == 0)
        {
            [cell addCell2WithRedBordNum:5 andBlueBordNum:2 andCellNum:1 andWedith:87];
            [cell addCell3WithBord:[cell3Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:87];

            
        }
        else if(indexPath.row == 1)
        {
            [cell addCell2WithRedBordNum:5 andBlueBordNum:1 andCellNum:1 andWedith:87];
            [cell addCell3WithBord:[cell3Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:87];

            
        }
        else if(indexPath.row == 2)
        {
            [cell addCell2WithRedBordNum:5 andBlueBordNum:0 andCellNum:1 andWedith:87];
            [cell addCell2WithRedBordNum:4 andBlueBordNum:2 andCellNum:2 andWedith:87];
            NSString *string = [cell3Array objectAtIndex:indexPath.row];
            NSArray *array = [string componentsSeparatedByString:@","];
            for(int i = 0;i<[array count];i++)
            {
                [cell addCell3WithBord:[array objectAtIndex:i] andCellNum:i+1 andWedith:87];
                
            }

            
        }
        else if(indexPath.row == 3)
        {
            [cell addCell2WithRedBordNum:4 andBlueBordNum:1 andCellNum:1 andWedith:87];
            [cell addCell2WithRedBordNum:3 andBlueBordNum:2 andCellNum:2 andWedith:87];
            NSString *string = [cell3Array objectAtIndex:indexPath.row];
            NSArray *array = [string componentsSeparatedByString:@","];
            for(int i = 0;i<[array count];i++)
            {
                [cell addCell3WithBord:[array objectAtIndex:i] andCellNum:i+1 andWedith:87];
                
            }

        }
        else if(indexPath.row == 4)
        {
            [cell addCell2WithRedBordNum:4 andBlueBordNum:0 andCellNum:1 andWedith:87];
            [cell addCell2WithRedBordNum:3 andBlueBordNum:1 andCellNum:2 andWedith:87];
            [cell addCell2WithRedBordNum:2 andBlueBordNum:2 andCellNum:3 andWedith:87];
            NSString *string = [cell3Array objectAtIndex:indexPath.row];
            NSArray *array = [string componentsSeparatedByString:@","];
            for(int i = 0;i<[array count];i++)
            {
                [cell addCell3WithBord:[array objectAtIndex:i] andCellNum:i+1 andWedith:87];
                
            }
        }
        else
        {
            [cell addCell2WithRedBordNum:3 andBlueBordNum:0 andCellNum:1 andWedith:87];
            [cell addCell2WithRedBordNum:2 andBlueBordNum:1 andCellNum:2 andWedith:87];
            [cell addCell2WithRedBordNum:1 andBlueBordNum:2 andCellNum:3 andWedith:87];
            [cell addCell2WithRedBordNum:0 andBlueBordNum:2 andCellNum:4 andWedith:87];
            NSString *string = [cell3Array objectAtIndex:indexPath.row];
            NSArray *array = [string componentsSeparatedByString:@","];
            for(int i = 0;i<[array count];i++)
            {
                [cell addCell3WithBord:[array objectAtIndex:i] andCellNum:i+1 andWedith:87];
                
            }

        }
        [cell addCell4:[cell4Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:61];
    }
    else if(ALLWANFA == QiLeCai)
    {
        if(!cell)
        {
            cell =[[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;
            

        }
        cell.isQiLeCai = YES;

        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 36+22+22-1, 320, 1)];
        [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
        [cell.contentView addSubview:xian];
        [xian release];
        cell.hangofCell = 3;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *cell3Array = [NSArray arrayWithObjects:@"中7基",@"中6基+1特",@"中6基",@"中5基+1特",@"中5基",@"中4基+1特",@"中4基", nil];
        NSArray *cell4Array = [NSArray arrayWithObjects:@"浮动\n单注限额500万",@"浮动",@"浮动",@"200元",@"50元",@"10元",@"5元", nil];
        
        [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:3 andWedith:30];
        if(indexPath.row == 0)
        {
            [cell addCell2WithRedBordNum:7 andBlueBordNum:0 andCellNum:2 andWedith:76];
            
        }
        else if(indexPath.row == 1)
        {
            [cell addCell2WithRedBordNum:6 andBlueBordNum:1 andCellNum:2 andWedith:76];
            
        }
        else if(indexPath.row == 2)
        {
            [cell addCell2WithRedBordNum:6 andBlueBordNum:0 andCellNum:2 andWedith:76];
            
        }
        else if(indexPath.row == 3)
        {
            [cell addCell2WithRedBordNum:5 andBlueBordNum:1 andCellNum:2 andWedith:76];
            
        }
        else if(indexPath.row == 4)
        {
            [cell addCell2WithRedBordNum:5 andBlueBordNum:0 andCellNum:2 andWedith:76];
        }
        else if(indexPath.row == 5)
        {
            [cell addCell2WithRedBordNum:4 andBlueBordNum:1 andCellNum:2 andWedith:76];
        }
        else
        {
            [cell addCell2WithRedBordNum:4 andBlueBordNum:0 andCellNum:2 andWedith:76];
        }
        
        [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:3 andWedith:87];

        [cell addCell4:[cell4Array objectAtIndex:indexPath.row] andCellNum:3 andWedith:108];
        
    }
    else if(ALLWANFA == FuCai3D)
    {
        if(!cell)
        {
            cell =[[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;


            if(indexPath.row == 0 ||indexPath.row == 4)
            {
                UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 320, 1)];
                [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
                [cell.contentView addSubview:xian];
                [xian release];
            }
            else
            {
                UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35+22-1, 320, 1)];
                [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
                [cell.contentView addSubview:xian];
                [xian release];
                
                cell.hangofCell = 2;


            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *cell2Array = [NSArray arrayWithObjects:@"中全部3个号码,顺序一致",@"与开奖号码和值一致",@"中全部3个号码，顺序不限",@"中全部3个号码，顺序不限",@"中全部3个号码，顺序不限",@"与开奖号码和值一致",@"与开奖号码和值一致",@"中全部3个号码，顺序不限",@"中全部3个号码，顺序不限", nil];
        NSArray *cell3Array = [NSArray arrayWithObjects:@"1040元",@"1040元",@"346元",@"346元",@"173元",@"346元",@"173元",@"346元",@"173元", nil];
        if(indexPath.row == 0 ||indexPath.row == 4)
        {
            [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:1 andWedith:61];
            [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:174];
            [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:61];

        }
        else
        {
            [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:2 andWedith:61];
            [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:2 andWedith:174];
            [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:2 andWedith:61];

        }
    }
    else if(ALLWANFA == Pai3)
    {
        if(!cell)
        {
            cell =[[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;

            
            if(indexPath.row == 0 || indexPath.row == 2 ||indexPath.row == 3)
            {
                UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 320, 1)];
                [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
                [cell.contentView addSubview:xian];
                [xian release];
            }
            else
            {
                UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35+22-1, 320, 1)];
                [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
                [cell.contentView addSubview:xian];
                [xian release];
                
                cell.hangofCell = 2;
                
                
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *cell2Array = [NSArray arrayWithObjects:@"中全部3个号码,顺序一致",@"与开奖号码和值一致",@"中全部3个号码，顺序不限",@"中全部3个号码，顺序不限",@"与开奖号码和值一致",@"与开奖号码和值一致",@"中全部3个号码，顺序不限",@"中全部3个号码，顺序不限", nil];
        NSArray *cell3Array = [NSArray arrayWithObjects:@"1040元",@"1040元",@"346元",@"173元",@"346元",@"173元",@"346元",@"173元", nil];
        if(indexPath.row == 0 || indexPath.row == 2 ||indexPath.row == 3)
        {
            [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:1 andWedith:61];
            [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:174];
            [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:61];
            
        }
        else
        {
            [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:2 andWedith:61];
            [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:2 andWedith:174];
            [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:2 andWedith:61];
            
        }
    }
    
    else if(ALLWANFA == KuaiLeShiFen)
    {
        if(!cell)
        {
            cell =[[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;


        }
        
        if(indexPath.row == 10 || indexPath.row == 11){
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35+22+22-1, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
        }
        else
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35+22-1, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
        }

        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *cell2Array = [NSArray arrayWithObjects:@"选1个号与开奖号第一位相同", @"选1个红号，开奖号第一位为红号（19、20为红号）",@"任选2个号，开奖号包含选号",@"每位各选1个号，与开奖号连续两位相同，顺序一致",@"任选2个号，与开奖号连续两位相同，顺序不限",@"任选3个号，开奖号包含选号",@"每位选1个号，与开奖号前三位相同，顺序一致",@"任选3个号，与开奖号前三位相同，顺序不限",@"任选4个号，开奖号包含选号",@"任选5个号，开奖号包含选号",@"与开奖号中出现大区数号码个数相同(11-20为大区数)",@"与开奖号中出现单数号码个数相同(1、3、5...19为单数号码)",@"开奖号为01至18的数字号码(不含19、20两个红号)",nil];
        NSArray *cell3Array = [NSArray arrayWithObjects:@"24元",@"8元",@"8元",@"62元",@"31元",@"24元",@"8000元",@"1300元",@"80元",@"320元", @"5-3200元",@"5-3200元",@"3元",nil];
        if(indexPath.row == 10 || indexPath.row == 11){
            [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:3 andWedith:61 lineHeight:80];
            [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:3 andWedith:174];
            [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:3 andWedith:61];
        }
        else{
            [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:2 andWedith:61 lineHeight:58];
            [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:2 andWedith:174];
            [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:2 andWedith:61];
        }

    }
    else if(ALLWANFA == kuailepuke)
    {
        if(!cell)
        {
            cell =[[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;

        }
        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 36+22+22-1, 320, 1)];
        [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
        [cell.contentView addSubview:xian];
        [xian release];
        cell.hangofCell = 3;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *cell2Array = [NSArray arrayWithObjects:@"任选1个号码投注，选号与奖号任意1号码相同（不分花色）",@"任选2个号码投注，选号与奖号任意2号码相同（不分花色）",@"任选3个号码投注，投注号码包含开奖号码(不分花色)",@"任选4个号码投注，投注号码包含开奖号码（不分花色）",@"任选5个号码投注，投注号码包含开奖号码（不分花色）",@"任选6个号码投注，投注号码包含开奖号码（不分花色）",@"开奖号花色都相同且与投注花色相同",@"开奖号花色都相同",@"开奖号3个数字是连续的且都是所投注的花色",@"开奖号3个数字是连续的且花色都相同",@"开奖号的3个数字是连续且与投注号码相同（不分花色）",@"开奖号的3个数字是连续（不分花色）",@"开奖号的3个数字相同且与投注号码相同（不分花色）",@"开奖号的3个数字相同（不分花色）",@"开奖号有且只有2个数字相同且与投注号码相同（不分花色）",@"开奖号有且只有2个数字相同（不分花色）", nil];
        NSArray *cell3Array = [NSArray arrayWithObjects:@"5元",@"33元",@"116元",@"46元",@"22元",@"12元",@"90元",@"22元",@"2150元",@"535元",@"400元",@"33元",@"6400元",@"500元",@"88元",@"7元", nil];
        
        [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:3 andWedith:61];
        [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:3 andWedith:174];
        [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:3 andWedith:61];
    }

    else if(ALLWANFA == Pai5)
    {

        if(!cell)
        {
            cell =[[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;


            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *cell2Array = [NSArray arrayWithObjects:@"中全部5个号码，顺序一致", nil];
        NSArray *cell3Array = [NSArray arrayWithObjects:@"100000元", nil];
        
        [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:1 andWedith:61];
        [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:174];
        [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:61];

    }

    else if(ALLWANFA == QiXinCai)
    {
        if(!cell)
        {
            cell =[[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;


            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35+22-1, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *cell2Array = [NSArray arrayWithObjects:@"中全部7个号码，顺序一致",@"中连续6个号码，顺序一致",@"中连续5个号码，顺序一致",@"中连续4个号码，顺序一致",@"中连续3个号码，顺序一致",@"中连续2个号码，顺序一致", nil];
        NSArray *cell3Array = [NSArray arrayWithObjects:@"浮动\n单注限额500万",@"10%奖池",@"1800元",@"300元",@"20元",@"5元", nil];
        
        [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:2 andWedith:61 lineHeight:58];
        [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:2 andWedith:127];
        [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:2 andWedith:108];
    }
    else if(ALLWANFA == ShiYiXuan5)
    {
        if(!cell)
        {
            cell =[[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;


        }
        if(indexPath.row == 7||indexPath.row == 8||indexPath.row == 9||indexPath.row == 10||indexPath.row ==11)
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35+22-1, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            
            cell.hangofCell = 2;

        }
        else
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];

        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *cell2Array = [NSArray arrayWithObjects:@"任选2个号，猜中开奖号的任意2个号",@"任选3个号，猜中开奖号的任意3个号",@"任选4个号，猜中开奖号的任意4个号",@"任选5个号，猜中开奖号的全部5个号",@"任选6个号，猜中开奖号的全部5个号",@"任选7个号，猜中开奖号的全部5个号",@"任选8个号，猜中开奖号的全部5个号",@"任选1个号，与开奖号码的第一位号码相同",@"选2个号，与开奖号码的前两位号码相同，顺序一致",@"选3个号，与开奖号码的前三位号码相同，顺序一致",@"选2个号与开奖号的前2个号相同，顺序不限",@"选3个号与开奖号的前3个号相同，顺序不限", nil];
        NSArray *cell3Array = [NSArray arrayWithObjects:@"6元",@"19元",@"78元",@"540元",@"90元",@"26元",@"9元",@"13元",@"130元",@"1170元",@"65元",@"195元", nil];
        
        [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:1 andWedith:61];
        [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:174];
        [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:61];
    }
    else if(ALLWANFA == GDShiYiXuan5)
    {
        if(!cell)
        {
            cell =[[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;

            
        }
        if(indexPath.row == 7||indexPath.row == 8||indexPath.row == 9||indexPath.row == 10||indexPath.row ==11)
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35+22-1, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            
            cell.hangofCell = 2;
            
        }
        else
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *cell2Array = [NSArray arrayWithObjects:@"任选2个号，猜中开奖号的任意2个号",@"任选3个号，猜中开奖号的任意3个号",@"任选4个号，猜中开奖号的任意4个号",@"任选5个号，猜中开奖号的全部5个号",@"任选6个号，猜中开奖号的全部5个号",@"任选7个号，猜中开奖号的全部5个号",@"任选8个号，猜中开奖号的全部5个号",@"任选1个号，与开奖号码的第一位号码相同",@"选2个号，与开奖号码的前两位号码相同，顺序一致",@"选3个号，与开奖号码的前三位号码相同，顺序一致",@"选2个号与开奖号的前2个号相同，顺序不限",@"选3个号与开奖号的前3个号相同，顺序不限", nil];
        NSArray *cell3Array = [NSArray arrayWithObjects:@"6元",@"19元",@"78元",@"540元",@"90元",@"26元",@"9元",@"13元",@"130元",@"1170元",@"65元",@"195元", nil];
        
        [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:1 andWedith:61];
        [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:174];
        [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:61];
    }
    else if(ALLWANFA == JXShiYiXuan5)
    {
        if(!cell)
        {
            cell =[[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;
            
            
        }
        if(indexPath.row == 7||indexPath.row == 8||indexPath.row == 9||indexPath.row == 10||indexPath.row ==11)
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35+22-1, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            
            cell.hangofCell = 2;
            
        }
        else
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *cell2Array = [NSArray arrayWithObjects:@"任选2个号，猜中开奖号的任意2个号",@"任选3个号，猜中开奖号的任意3个号",@"任选4个号，猜中开奖号的任意4个号",@"任选5个号，猜中开奖号的全部5个号",@"任选6个号，猜中开奖号的全部5个号",@"任选7个号，猜中开奖号的全部5个号",@"任选8个号，猜中开奖号的全部5个号",@"任选1个号，与开奖号码的第一位号码相同",@"选2个号，与开奖号码的前两位号码相同，顺序一致",@"选3个号，与开奖号码的前三位号码相同，顺序一致",@"选2个号与开奖号的前2个号相同，顺序不限",@"选3个号与开奖号的前3个号相同，顺序不限", nil];
        NSArray *cell3Array = [NSArray arrayWithObjects:@"6元",@"19元",@"78元",@"540元",@"90元",@"26元",@"9元",@"13元",@"130元",@"1170元",@"65元",@"195元", nil];
        
        [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:1 andWedith:61];
        [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:174];
        [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:61];
    }
    else if(ALLWANFA == HBShiYiXuan5)
    {
        if(!cell)
        {
            cell =[[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;
            
            
        }
        if(indexPath.row == 7||indexPath.row == 8||indexPath.row == 9||indexPath.row == 10||indexPath.row ==11)
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35+22-1, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            
            cell.hangofCell = 2;
            
        }
        else
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *cell2Array = [NSArray arrayWithObjects:@"任选2个号，猜中开奖号的任意2个号",@"任选3个号，猜中开奖号的任意3个号",@"任选4个号，猜中开奖号的任意4个号",@"任选5个号，猜中开奖号的全部5个号",@"任选6个号，猜中开奖号的全部5个号",@"任选7个号，猜中开奖号的全部5个号",@"任选8个号，猜中开奖号的全部5个号",@"任选1个号，与开奖号码的第一位号码相同",@"选2个号，与开奖号码的前两位号码相同，顺序一致",@"选3个号，与开奖号码的前三位号码相同，顺序一致",@"选2个号与开奖号的前2个号相同，顺序不限",@"选3个号与开奖号的前3个号相同，顺序不限", nil];
        NSArray *cell3Array = [NSArray arrayWithObjects:@"6元",@"19元",@"78元",@"540元",@"90元",@"26元",@"9元",@"13元",@"130元",@"1170元",@"65元",@"195元", nil];
        
        [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:1 andWedith:61];
        [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:174];
        [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:61];
    }
    else if(ALLWANFA == ShanXiShiYiXuan5)
    {
        if(!cell)
        {
            cell =[[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;
            
            
        }
        if(indexPath.row == 7||indexPath.row == 8||indexPath.row == 9||indexPath.row == 10||indexPath.row ==11)
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35+22-1, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            
            cell.hangofCell = 2;
            
        }
        else
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *cell2Array = [NSArray arrayWithObjects:@"任选2个号，猜中开奖号的任意2个号",@"任选3个号，猜中开奖号的任意3个号",@"任选4个号，猜中开奖号的任意4个号",@"任选5个号，猜中开奖号的全部5个号",@"任选6个号，猜中开奖号的全部5个号",@"任选7个号，猜中开奖号的全部5个号",@"任选8个号，猜中开奖号的全部5个号",@"任选1个号，与开奖号码的第一位号码相同",@"选2个号，与开奖号码的前两位号码相同，顺序一致",@"选3个号，与开奖号码的前三位号码相同，顺序一致",@"选2个号与开奖号的前2个号相同，顺序不限",@"选3个号与开奖号的前3个号相同，顺序不限", nil];
        NSArray *cell3Array = [NSArray arrayWithObjects:@"6元",@"19元",@"78元",@"540元",@"90元",@"26元",@"9元",@"13元",@"130元",@"1170元",@"65元",@"195元", nil];
        
        [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:1 andWedith:61];
        [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:174];
        [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:61];
    }
    else if(ALLWANFA == ChongQShiShiCai)
    {
        if(!cell)
        {
            cell = [[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;

        }
        if(indexPath.row == 0)
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35+22+20, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            cell.hangofCell = 3;
        }
        else if(indexPath.row == 10)
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, (35+22)*3, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            
            UIImageView *xian2 = [[UIImageView alloc] initWithFrame:CGRectMake(61, 58, 320, 1)];
            [xian2 setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian2];
            [xian2 release];
            
            UIImageView *xian3 = [[UIImageView alloc] initWithFrame:CGRectMake(61, 116, 320, 1)];
            [xian3 setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian3];
            [xian3 release];
        }
        else
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35+22-1, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            cell.hangofCell = 2;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *cell2Array = [NSArray arrayWithObjects:@"中十、个位大小单双，顺序一致\n(大5-9; 小0-4; 奇数为单; 偶数为双)",@"中个位号码",@"中十、个位号码，顺序一致",@"中十、个位号码，顺序不限",@"中十、个位号码之和",@"中百、十、个位号码，顺序一致",@"中百、十、个位号码之和",@"中百、十、个位号码（2位相同）,顺序不限",@"中百、十、个位号码（各不相同）,顺序不限",@"中万、千、百、十、个位号码，顺序一致",@"与开奖号完全相同，顺序一致",@"中前3号码或后3号码，顺序一致",@"中前2号码或后2号码，顺序一致", nil];
        NSArray *cell3Array = [NSArray arrayWithObjects:@"4元",@"10元",@"100元",@"50元",@"100元",@"1000元",@"1000元",@"320元",@"160元",@"10万元",@"一等奖\n20220元",@"二等奖\n220",@"三等奖\n20元",nil];
        
        if(indexPath.row == 10)
        {
//            [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:9 andWedith:61];
            [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:9 andWedith:61 lineHeight:(36+22)*3];
            
            [cell addCell2Another:[cell2Array objectAtIndex:indexPath.row] andCellNum:2 andWedith:174 andX:0];
            [cell addCell3Another:[cell3Array objectAtIndex:indexPath.row] andCellNum:2 andWedith:61 andX:0];
            
            [cell addCell2Another:[cell2Array objectAtIndex:indexPath.row+1] andCellNum:2 andWedith:174 andX:58];
            [cell addCell3Another:[cell3Array objectAtIndex:indexPath.row+1] andCellNum:2 andWedith:61 andX:58];
            
            [cell addCell2Another:[cell2Array objectAtIndex:indexPath.row+2] andCellNum:2 andWedith:174 andX:116];
            [cell addCell3Another:[cell3Array objectAtIndex:indexPath.row+2] andCellNum:2 andWedith:61 andX:116];
        }
        if(indexPath.row < 10)
        {
            [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:1 andWedith:61];
            
            [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:174];
            
            [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:61];
            
        }
        
        if(indexPath.row > 10)
        {
            [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:1 andWedith:61];
            
            [cell addCell2:[cell2Array objectAtIndex:indexPath.row+2] andCellNum:1 andWedith:174];
            
            [cell addCell3:[cell3Array objectAtIndex:indexPath.row+2] andCellNum:1 andWedith:61];
            
        }
        
        
    }
    else if(ALLWANFA == ShiShiCai)
    {
        if(!cell)
        {
            cell =[[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;


        }
        if(indexPath.row == 0)
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35+22+20, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            cell.hangofCell = 3;
        }
        else if(indexPath.row == 4)
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35+22+22+18, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            
            cell.hangofCell = 4;
        }
        else if(indexPath.row == 8)
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, (35+22)*3, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            
            UIImageView *xian2 = [[UIImageView alloc] initWithFrame:CGRectMake(61, 58, 320, 1)];
            [xian2 setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian2];
            [xian2 release];
            
            UIImageView *xian3 = [[UIImageView alloc] initWithFrame:CGRectMake(61, 116, 320, 1)];
            [xian3 setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian3];
            [xian3 release];

            
            
            
//            cell.hangofCell = 7;
        }
        else
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35+22-1, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            
            cell.hangofCell = 2;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *cell2Array = [NSArray arrayWithObjects:@"中十、个位大小单双，顺序一致\n(大5-9;小0-4;奇数为单;偶数为双)",@"中个位号码",@"中十、个位号码，顺序一致",@"中十、个位号码，顺序不限",@"选1个胆码，选2个或多个拖码投注，与开奖号码中的十、个位号码相同，顺序不限",@"中、百、十、个位号码，顺序一致",@"中、千、百、十、个位号码，顺序一致",@"中万、千、百、十、个位号码，顺序一致",@"与开奖号完全相同，顺序一致",@"中前3号码或后3号码，顺序一致",@"中前2号码或后2号码，顺序一致",@"定位选择1个号码为1注，与开奖号码数字和位置相符",@"定位选择2个号码为1注，与开奖号码数字和位置相符",@"定位选择3个号码为1注，与开奖号码数字和位置相符", nil];
        NSArray *cell3Array = [NSArray arrayWithObjects:@"4元",@"10元",@"100元",@"50元",@"50元",@"1000元",@"1 万元",@"10万",@"一等奖\n20220元",@"二等奖\n220",@"三等奖\n20元",@"10元",@"100元",@"1000元", nil];
        

        if(indexPath.row == 8)
        {

//            [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:7 andWedith:61];
            [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:7 andWedith:61 lineHeight:(36+22)*3];
            
            [cell addCell2Another:[cell2Array objectAtIndex:indexPath.row] andCellNum:2 andWedith:174 andX:0];
            [cell addCell3Another:[cell3Array objectAtIndex:indexPath.row] andCellNum:2 andWedith:61 andX:0];

            [cell addCell2Another:[cell2Array objectAtIndex:indexPath.row+1] andCellNum:2 andWedith:174 andX:58];
            [cell addCell3Another:[cell3Array objectAtIndex:indexPath.row+1] andCellNum:2 andWedith:61 andX:58];
            
            [cell addCell2Another:[cell2Array objectAtIndex:indexPath.row+2] andCellNum:2 andWedith:174 andX:116];
            [cell addCell3Another:[cell3Array objectAtIndex:indexPath.row+2] andCellNum:2 andWedith:61 andX:116];


        }
        if(indexPath.row < 8)
        {
            [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:1 andWedith:61];
            
            [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:174];
            
            [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:61];
            
        }

        if(indexPath.row > 8)
        {
            [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:1 andWedith:61];
            
            [cell addCell2:[cell2Array objectAtIndex:indexPath.row+2] andCellNum:1 andWedith:174];
            
            [cell addCell3:[cell3Array objectAtIndex:indexPath.row+2] andCellNum:1 andWedith:61];

        }

    }
    else if (ALLWANFA == SendAwardTime)
    {
        if(!cell)
        {
            cell =[[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;


            if(indexPath.row == 1)
            {
                UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 53+71-2, 320, 1)];
                [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
                [cell.contentView addSubview:xian];
                [xian release];
                
                UIImageView *xian1 = [[UIImageView alloc] initWithFrame:CGRectMake(56, 53-1, 320-56, 1)];
                [xian1 setImage:[UIImage imageNamed:@"wf_xian2.png"]];
                [cell.contentView addSubview:xian1];
                [xian1 release];
                
            }
            else if (indexPath.row == 2)
            {
                UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 53+53-2, 320, 1)];
                [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
                [cell.contentView addSubview:xian];
                [xian release];
                
                UIImageView *xian1 = [[UIImageView alloc] initWithFrame:CGRectMake(56, 53-1, 320-56, 1)];
                [xian1 setImage:[UIImage imageNamed:@"wf_xian2.png"]];
                [cell.contentView addSubview:xian1];
                [xian1 release];
                
            }
            else if (indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 8 || indexPath.row == 9) {
                UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 53-1, 320, 1)];
                [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
                [cell.contentView addSubview:xian];
                [xian release];
            }
            else {
                UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35-1, 320, 1)];
                [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
                [cell.contentView addSubview:xian];
                [xian release];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *cell2Array = [NSArray arrayWithObjects:@"赛后1-2小时",@"(当日22点-次日9点)\n10点-11点半",@"(当日9点-次日22点)\n最后一场比赛结束30分钟-60分钟之内",@"(最后一场9点前结束)\n当天11-12点",@"(最后一场9点-12点)\n当天15点左右",@"周二、四、日 21:30",@"每天 20:30",@"周一、三、六 20:30",@"每天 20:30",@"每天 20:30",@"周二、五、日 20:30",@"周一、三、五 21:30", nil];
        NSArray *cell3Array = [NSArray arrayWithObjects:@"赛后1-2小时",@"(当日22点-次日9点)\n10点-11点半",@"(当日9点-次日22点)最后一场比赛结束30分钟-60分钟之内",@"(最后一场9点前结束)\n当天11-12点",@"(最后一场9点-12点)\n当天15点左右",@"周二、四、日 23:00-23:30",@"每日 20:40-21:00",@"周一、三、六 21:20-21:40",@"每日 20:50-21:00",@"每日 20:50-21:00",@"周二、五、日 21:20-21:30",@"周一、三、五 23:00-23:30", nil];
        if (indexPath.row == 0)
        {
            [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:1 andWedith:56];
            [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:127];
            [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:127];
        }
        else if (indexPath.row == 1)
        {
            [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:5 andWedith:56 lineHeight:53+71];
            
            [cell addCell2Another:[cell2Array objectAtIndex:indexPath.row] andCellNum:2 andWedith:127 andX:0];
            [cell addCell2Another:[cell2Array objectAtIndex:indexPath.row+1] andCellNum:3 andWedith:127 andX:53];
            
            [cell addCell3Another:[cell3Array objectAtIndex:indexPath.row] andCellNum:2 andWedith:127 andX:0];
            [cell addCell3Another:[cell3Array objectAtIndex:indexPath.row+1] andCellNum:3 andWedith:127 andX:53];
        }
        else if(indexPath.row == 2)
        {
            [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:4 andWedith:56 lineHeight:53+53];
            
            [cell addCell2Another:[cell2Array objectAtIndex:indexPath.row+1] andCellNum:2 andWedith:127 andX:0];
            [cell addCell2Another:[cell2Array objectAtIndex:indexPath.row+2] andCellNum:2 andWedith:127 andX:53];
            
            [cell addCell3Another:[cell3Array objectAtIndex:indexPath.row+1] andCellNum:2 andWedith:127 andX:0];
            [cell addCell3Another:[cell3Array objectAtIndex:indexPath.row+2] andCellNum:2 andWedith:127 andX:53];
        }
        else
        {
            if(indexPath.row == 4 || indexPath.row == 6 || indexPath.row == 7)
            {
                [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:1 andWedith:56 lineHeight:35];
                [cell addCell2:[cell2Array objectAtIndex:indexPath.row+2] andCellNum:1 andWedith:127];
                [cell addCell3:[cell3Array objectAtIndex:indexPath.row+2] andCellNum:1 andWedith:127];

            }
            else
            {
                [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:2 andWedith:56 lineHeight:53];
                [cell addCell2:[cell2Array objectAtIndex:indexPath.row+2] andCellNum:2 andWedith:127];
                [cell addCell3:[cell3Array objectAtIndex:indexPath.row+2] andCellNum:2 andWedith:127];

            }
        }

    }
    else if(ALLWANFA == Kuai3 || ALLWANFA == JSKuai3 || ALLWANFA == HBKuai3 || ALLWANFA == JLKuai3 || ALLWANFA == AHKuai3)
    {
        if(!cell)
        {
            cell =[[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;
            
            
        }
        if(indexPath.row == 0)
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
        }
        else
        {
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 58 - 1, 320, 1)];
            [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
            [cell.contentView addSubview:xian];
            [xian release];
            
            cell.hangofCell = 2;
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *cell2Array = [NSArray arrayWithObjects:@"猜中开奖号相加之和",@"猜中111、222、333、444、555、666指定一个",@"111、222、333、444、555、666任意一个开出",@"猜中3个号（有2个号相同，如112）",@"猜中开奖中相同的2个号",@"猜中开奖中各不相同的3个号",@"猜中开奖中不相同的2个号",@"123、234、345、456任意一个开出", nil];
        NSArray *cell3Array = [NSArray arrayWithObjects:@"9~240元",@"240元",@"40元",@"80元",@"15元",@"40元",@"8元",@"10元", nil];
        
        [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:1 andWedith:61];
        [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:174];
        [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:61];
    }
    else if (ALLWANFA == Horse) {
        if(!cell)
        {
            cell =[[[WanfaInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.hangofCell = 1;
        }
        
        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 58 - 1, 320, 1)];
        [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
        [cell.contentView addSubview:xian];
        [xian release];
        
        cell.hangofCell = 2;

        NSArray *cell2Array = [NSArray arrayWithObjects:@"任选一匹马，猜中第一名马匹",@"任选两匹马，猜中前两名马匹，毋需顺序",@"任选三匹马，猜中前三名马匹，毋需顺序", nil];
        NSArray *cell3Array = [NSArray arrayWithObjects:@"1赔6.5",@"1赔32.5",@"1赔97.5", nil];
        
        [cell addCell1:[cell1Array objectAtIndex:indexPath.row] andCellNUm:1 andWedith:61];
        [cell addCell2:[cell2Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:174 textAlignment:0];
        [cell addCell3:[cell3Array objectAtIndex:indexPath.row] andCellNum:1 andWedith:61];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)WanFaInfo {

    if (ALLWANFA != SendAwardTime && ALLWANFA != Horse) {
        UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"投注技巧" Target:self action:@selector(pressJiQiao:) ImageName:nil Size:CGSizeMake(80, 30)];
        self.CP_navigation.rightBarButtonItem = rightItem;
    }
    
    UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
    backScrollView.userInteractionEnabled = YES;
    
    UILabel *mkjTime = [[UILabel alloc] initWithFrame:CGRectMake(12, 17, 308, 15)];
    mkjTime.text = @"开奖时间";
    mkjTime.font = [UIFont boldSystemFontOfSize:14.0];
    mkjTime.backgroundColor = [UIColor clearColor];
    [backScrollView addSubview:mkjTime];
    [mkjTime release];
    
    UILabel *mkjTime1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 44, 296, 15)];
    mkjTime1.font = [UIFont systemFontOfSize:14.0];
    mkjTime1.lineBreakMode = NSLineBreakByWordWrapping;
    mkjTime1.numberOfLines = 0;
    mkjTime1.backgroundColor = [UIColor clearColor];
    [backScrollView addSubview:mkjTime1];
    [mkjTime1 release];
    
    UILabel *mWFInfo = [[UILabel alloc] initWithFrame:CGRectMake(12, 81, 308, 15)];
    mWFInfo.text = @"玩法规则&奖项设置";
    mWFInfo.font = [UIFont boldSystemFontOfSize:14.0];
    mWFInfo.backgroundColor = [UIColor clearColor];
    [backScrollView addSubview:mWFInfo];
    [mWFInfo release];

    
    if (ALLWANFA == ShuangSeQiu) {
        self.CP_navigation.title = @"双色球";
        caizhongJQ = shuangsheqiu;

        [backScrollView setContentSize:CGSizeMake(320, 490)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];

        mkjTime1.text = @"每周二、四、日 21:30 开奖";
        
        ColorView *mWFInfo1 = [[ColorView alloc] initWithFrame:CGRectMake(12, 108, 70, 15)];
        mWFInfo1.backgroundColor = [UIColor clearColor];
        mWFInfo1.text = @"<6个红球> + ";
        mWFInfo1.font = [UIFont systemFontOfSize:14];
        mWFInfo1.colorfont = [UIFont boldSystemFontOfSize:14];
//        mWFInfo1.textColor =[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        mWFInfo1.changeColor = [UIColor redColor];
        [backScrollView addSubview:mWFInfo1];
        [mWFInfo1 release];
        
        ColorView *mWFInfo2 = [[ColorView alloc] initWithFrame:CGRectMake(82, 108, 296, 15)];
        mWFInfo2.backgroundColor = [UIColor clearColor];
        mWFInfo2.text = @"<1个蓝球> = 1 注 (2元)";
        mWFInfo2.font = [UIFont systemFontOfSize:14];
        mWFInfo2.colorfont = [UIFont boldSystemFontOfSize:14];
        //        mWFInfo1.textColor =[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        mWFInfo2.changeColor = [UIColor blueColor];
        [backScrollView addSubview:mWFInfo2];
        [mWFInfo2 release];
        
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(12, mWFInfo2.frame.origin.y+15+12, 296, 30) andLabel1Text:@"奖级" andLabelWed:61 andLabel2Text:@"中奖条件" andLabel2Wed:87 andLabelText3:@"中奖说明" andLabel3Wed:87 andLaelText4:@"奖金" andLabel4Frame:61 isJiangJiDouble:NO];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];
        
        cell1Array = [[NSArray alloc] initWithObjects:@"一等奖",@"二等奖",@"三等奖",@"四等奖",@"五等奖",@"六等奖" , nil];

        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, header.frame.origin.y+header.frame.size.height, 296, 304) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];
        
        

    }
    else if (ALLWANFA == ErErXuan5) {
    
        self.CP_navigation.title = @"22选5";
        caizhongJQ = ererX5;

        [backScrollView setContentSize:CGSizeMake(320, 500)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];

        UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
        kjTime.backgroundColor = [UIColor clearColor];
        kjTime.text = @"开奖时间";
        kjTime.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime];
        [kjTime release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 48, 235, 12)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @"每晚开奖";
        kjTime2.font = [UIFont boldSystemFontOfSize:12];
        kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime2];
        [kjTime2 release];
        
        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 73, 300, 2)];
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = UIImageGetImageFromName(@"SZTG960.png") ;
        [backScrollView addSubview:xian];
        [xian release];

        UILabel *wfgz = [[UILabel alloc] initWithFrame:CGRectMake(20, 88, 125, 15)];
        wfgz.backgroundColor = [UIColor clearColor];
        wfgz.text = @"玩法规则";
        wfgz.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:wfgz];
        [wfgz release];
        
        UILabel *wfgz3 = [[UILabel alloc] initWithFrame:CGRectMake(27, 116, 30, 12)];
        wfgz3.backgroundColor = [UIColor clearColor];
        wfgz3.text = @"任选";
        wfgz3.font = [UIFont systemFontOfSize:12];
        wfgz3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:wfgz3];
        [wfgz3 release];

        UILabel *SZ = [[UILabel alloc] initWithFrame:CGRectMake(55, 114, 10, 14)];
        SZ.backgroundColor = [UIColor clearColor];
        SZ.text = @"5";
        SZ.font = [UIFont boldSystemFontOfSize:14];
        SZ.textColor = [UIColor redColor];
        [backScrollView addSubview:SZ];
        [SZ release];
        
        UILabel *wfgz2 = [[UILabel alloc] initWithFrame:CGRectMake(65, 116, 70, 12)];
        wfgz2.backgroundColor = [UIColor clearColor];
        wfgz2.text = @"个号码  = ";
        wfgz2.font = [UIFont systemFontOfSize:12];
        wfgz2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:wfgz2];
        [wfgz2 release];
        
        UILabel *SZ3 = [[UILabel alloc] initWithFrame:CGRectMake(120, 114, 10, 14)];
        SZ3.backgroundColor = [UIColor clearColor];
        SZ3.text = @"1";
        SZ3.font = [UIFont boldSystemFontOfSize:14];
        SZ3.textColor = [UIColor redColor];
        [backScrollView addSubview:SZ3];
        [SZ3 release];
        
        UILabel *wfgz4 = [[UILabel alloc] initWithFrame:CGRectMake(130, 116, 15, 12)];
        wfgz4.backgroundColor = [UIColor clearColor];
        wfgz4.text = @"注";
        wfgz4.font = [UIFont systemFontOfSize:12];
        wfgz4.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:wfgz4];
        [wfgz4 release];
        
        UIImageView *xian2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 141, 300, 2)];
        xian2.backgroundColor  = [UIColor clearColor];
        xian2.image = UIImageGetImageFromName(@"SZTG960.png") ;
        [backScrollView addSubview:xian2];
        [xian2 release];
        
        UILabel *jxsz = [[UILabel alloc] initWithFrame:CGRectMake(20, 156, 125, 15)];
        jxsz.backgroundColor = [UIColor clearColor];
        jxsz.text = @"奖项设置";
        jxsz.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:jxsz];
        [jxsz release];
        
        UILabel *ydj = [[UILabel alloc] initWithFrame:CGRectMake(27, 184, 60, 12)];
        ydj.backgroundColor = [UIColor clearColor];
        ydj.text = @"一等奖";
        ydj.font = [UIFont boldSystemFontOfSize:12];
        ydj.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:ydj];
        [ydj release];
        
        UILabel *jjfd = [[UILabel alloc] initWithFrame:CGRectMake(75, 184, 140, 12)];
        jjfd.backgroundColor = [UIColor clearColor];
        jjfd.text = @"奖金浮动、单注限额";
        jjfd.font = [UIFont boldSystemFontOfSize:12];
        jjfd.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd];
        [jjfd release];
        
        UILabel *wbw = [[UILabel alloc] initWithFrame:CGRectMake(188, 184, 60, 12)];
        wbw.backgroundColor = [UIColor clearColor];
        wbw.text = @"500";
        wbw.font = [UIFont boldSystemFontOfSize:12];
        wbw.textColor = [UIColor redColor];
        [backScrollView addSubview:wbw];
        [wbw release];
        
        UILabel *wbw2 = [[UILabel alloc] initWithFrame:CGRectMake(212, 184, 20, 12)];
        wbw2.backgroundColor = [UIColor clearColor];
        wbw2.text = @"万";
        wbw2.font = [UIFont boldSystemFontOfSize:12];
        wbw2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:wbw2];
        [wbw2 release];
        
        UILabel *qb1 = [[UILabel alloc] initWithFrame:CGRectMake(75, 201, 200, 10)];
        qb1.backgroundColor = [UIColor clearColor];
        qb1.text = @"与开奖号码完全相同。";
        qb1.font = [UIFont systemFontOfSize:10];
        qb1.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb1];
        [qb1 release];
        //
        UILabel *shidj = [[UILabel alloc] initWithFrame:CGRectMake(27, 221, 60, 12)];
        shidj.backgroundColor = [UIColor clearColor];
        shidj.text = @"二等奖";
        shidj.font = [UIFont boldSystemFontOfSize:12];
        shidj.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:shidj];
        [shidj release];
        
        UILabel *jjfd4 = [[UILabel alloc] initWithFrame:CGRectMake(75, 221, 50, 12)];
        jjfd4.backgroundColor = [UIColor clearColor];
        jjfd4.text = @"奖金";
        jjfd4.font = [UIFont boldSystemFontOfSize:12];
        jjfd4.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd4];
        [jjfd4 release];
        
        UILabel *eb = [[UILabel alloc] initWithFrame:CGRectMake(105, 221, 60, 12)];
        eb.backgroundColor = [UIColor clearColor];
        eb.text = @"50";
        eb.font = [UIFont boldSystemFontOfSize:12];
        eb.textColor = [UIColor redColor];
        [backScrollView addSubview:eb];
        [eb release];
        
        UILabel *yuan2 = [[UILabel alloc] initWithFrame:CGRectMake(125, 221, 15, 12)];
        yuan2.backgroundColor = [UIColor clearColor];
        yuan2.text = @"元";
        yuan2.font = [UIFont boldSystemFontOfSize:12];
        yuan2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:yuan2];
        [yuan2 release];
        
        UILabel *qb4 = [[UILabel alloc] initWithFrame:CGRectMake(75, 238, 250, 10)];
        qb4.backgroundColor = [UIColor clearColor];
        qb4.text = @"与开奖号码中的 5 个数字有 4 个相同。";
        qb4.font = [UIFont systemFontOfSize:10];
        qb4.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb4];
        [qb4 release];
        //
        UILabel *sdj = [[UILabel alloc] initWithFrame:CGRectMake(27, 258, 60, 12)];
        sdj.backgroundColor = [UIColor clearColor];
        sdj.text = @"三等奖";
        sdj.font = [UIFont boldSystemFontOfSize:12];
        sdj.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:sdj];
        [sdj release];
        
        UILabel *jjfd3 = [[UILabel alloc] initWithFrame:CGRectMake(75, 258, 50, 12)];
        jjfd3.backgroundColor = [UIColor clearColor];
        jjfd3.text = @"奖金";
        jjfd3.font = [UIFont boldSystemFontOfSize:12];
        jjfd3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd3];
        [jjfd3 release];
        
        UILabel *sq = [[UILabel alloc] initWithFrame:CGRectMake(105, 258, 20, 12)];
        sq.backgroundColor = [UIColor clearColor];
        sq.text = @"5";
        sq.font = [UIFont boldSystemFontOfSize:12];
        sq.textColor = [UIColor redColor];
        [backScrollView addSubview:sq];
        [sq release];
        
        UILabel *yuan = [[UILabel alloc] initWithFrame:CGRectMake(120, 258, 15, 12)];
        yuan.backgroundColor = [UIColor clearColor];
        yuan.text = @"元";
        yuan.font = [UIFont boldSystemFontOfSize:12];
        yuan.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:yuan];
        [yuan release];
        
        UILabel *qb3 = [[UILabel alloc] initWithFrame:CGRectMake(75, 275, 200, 10)];
        qb3.backgroundColor = [UIColor clearColor];
        qb3.text = @"与开奖号码中的 5 个数字有 3 个相同。";
        qb3.font = [UIFont systemFontOfSize:10];
        qb3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb3];
        [qb3 release];


    }
    else if (ALLWANFA == QiXinCai) {
    
        self.CP_navigation.title = @"七星彩";
        caizhongJQ = qixincai;

        [backScrollView setContentSize:CGSizeMake(320, 530)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];

        mkjTime1.text = @"每周二、五、日 20:30 开奖";
        
        UILabel *mqixingcaiwfInfo1 = [[UILabel alloc] initWithFrame:CGRectMake(12, ORIGIN_Y(mWFInfo)+12, 296, 15)];
        mqixingcaiwfInfo1.text =@"任选7个号码＝1注(2元)";
        mqixingcaiwfInfo1.backgroundColor = [UIColor clearColor];
        mqixingcaiwfInfo1.font = [UIFont systemFontOfSize:14.0];
        [backScrollView addSubview:mqixingcaiwfInfo1];
        [mqixingcaiwfInfo1 release];
        
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(12, mqixingcaiwfInfo1.frame.origin.y+15+12, 296, 30) andLabel1Text:@"玩法" andLabelWed:61 andLabel2Text:@"中奖号码" andLabel2Wed:127 andLabelText3:@"奖金" andLabel3Wed:108 andLaelText4:nil andLabel4Frame:61 isJiangJiDouble:NO];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];
        
        cell1Array = [[NSArray alloc] initWithObjects:@"一等奖",@"二等奖",@"三等奖",@"四等奖",@"五等奖",@"六等奖", nil];
        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, header.frame.origin.y+header.frame.size.height, 296, 347) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];
        

        
    }
    else if (ALLWANFA == RenXuanJiu) {
    
        self.CP_navigation.title = @"任选九";
        caizhongJQ = ticai;
        
        backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
        backScrollView.userInteractionEnabled = YES;
        [backScrollView setContentSize:CGSizeMake(320, 400)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];

        UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
        kjTime.backgroundColor = [UIColor clearColor];
        kjTime.text = @"玩法规则";
        kjTime.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime];
        [kjTime release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 48, 260, 10)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @"对 14 场足球比赛中的任意 9 场的比赛结果进行预测,竞猜";
        kjTime2.font = [UIFont boldSystemFontOfSize:10];
        kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime2];
        [kjTime2 release];
        UILabel *kjTime21 = [[UILabel alloc] initWithFrame:CGRectMake(27, 66, 260, 10)];
        kjTime21.backgroundColor = [UIColor clearColor];
        kjTime21.text = @"每场比赛在全场 90 分钟(含伤停补时)比赛的胜平负的结果";
        kjTime21.font = [UIFont boldSystemFontOfSize:10];
        kjTime21.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime21];
        [kjTime21 release];
        UILabel *kjTime22 = [[UILabel alloc] initWithFrame:CGRectMake(27, 84, 260, 10)];
        kjTime22.backgroundColor = [UIColor clearColor];
        kjTime22.text = @"并进行投注。竞猜胜平负时用 3、1、0 分别代表主队胜、";
        kjTime22.font = [UIFont boldSystemFontOfSize:10];
        kjTime22.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime22];
        [kjTime22 release];
        UILabel *kjTime23 = [[UILabel alloc] initWithFrame:CGRectMake(27, 102, 260, 10)];
        kjTime23.backgroundColor = [UIColor clearColor];
        kjTime23.text = @"主客战平和主队负。";
        kjTime23.font = [UIFont boldSystemFontOfSize:10];
        kjTime23.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime23];
        [kjTime23 release];
        
        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 125, 300, 2)];
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = UIImageGetImageFromName(@"SZTG960.png") ;
        [backScrollView addSubview:xian];
        [xian release];

        UILabel *jxsz = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 125, 15)];
        jxsz.backgroundColor = [UIColor clearColor];
        jxsz.text = @"奖项设置";
        jxsz.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:jxsz];
        [jxsz release];
        
        UILabel *ydj = [[UILabel alloc] initWithFrame:CGRectMake(27, 168, 60, 12)];
        ydj.backgroundColor = [UIColor clearColor];
        ydj.text = @"一等奖";
        ydj.font = [UIFont boldSystemFontOfSize:12];
        ydj.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:ydj];
        [ydj release];
        
        UILabel *jjfd = [[UILabel alloc] initWithFrame:CGRectMake(75, 168, 140, 12)];
        jjfd.backgroundColor = [UIColor clearColor];
        jjfd.text = @"奖金浮动、单注限额";
        jjfd.font = [UIFont boldSystemFontOfSize:12];
        jjfd.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd];
        [jjfd release];
        
        UILabel *wbw = [[UILabel alloc] initWithFrame:CGRectMake(190, 168, 60, 12)];
        wbw.backgroundColor = [UIColor clearColor];
        wbw.text = @"500";
        wbw.font = [UIFont boldSystemFontOfSize:12];
        wbw.textColor = [UIColor redColor];
        [backScrollView addSubview:wbw];
        [wbw release];
        
        UILabel *wbw2 = [[UILabel alloc] initWithFrame:CGRectMake(215, 168, 20, 12)];
        wbw2.backgroundColor = [UIColor clearColor];
        wbw2.text = @"万";
        wbw2.font = [UIFont boldSystemFontOfSize:12];
        wbw2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:wbw2];
        [wbw2 release];
        
        UILabel *qb1 = [[UILabel alloc] initWithFrame:CGRectMake(75, 185, 200, 10)];
        qb1.backgroundColor = [UIColor clearColor];
        qb1.text = @"9 场比赛全部猜中。";
        qb1.font = [UIFont systemFontOfSize:10];
        qb1.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb1];
        [qb1 release];

    }
    else if (ALLWANFA == ShenFuCai) {
    
        self.CP_navigation.title = @"胜负彩";
        caizhongJQ = ticai;
        
        UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
        backScrollView.userInteractionEnabled = YES;
        [backScrollView setContentSize:CGSizeMake(320, 400)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];

        UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
        kjTime.backgroundColor = [UIColor clearColor];
        kjTime.text = @"玩法规则";
        kjTime.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime];
        [kjTime release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 48, 260, 10)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @"对 14 场足球比赛结果进行预测,竞猜每场比赛在全场 90 分";
        kjTime2.font = [UIFont boldSystemFontOfSize:10];
        kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime2];
        [kjTime2 release];
        UILabel *kjTime21 = [[UILabel alloc] initWithFrame:CGRectMake(27, 66, 260, 10)];
        kjTime21.backgroundColor = [UIColor clearColor];
        kjTime21.text = @"钟(含伤停补时)比赛的胜平负的结果并进行投注。竞猜胜平";
        kjTime21.font = [UIFont boldSystemFontOfSize:10];
        kjTime21.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime21];
        [kjTime21 release];
        UILabel *kjTime22 = [[UILabel alloc] initWithFrame:CGRectMake(27, 84, 260, 10)];
        kjTime22.backgroundColor = [UIColor clearColor];
        kjTime22.text = @"负时用 3、1、0 分别代表主队胜、主客战平和主队负。";
        kjTime22.font = [UIFont boldSystemFontOfSize:10];
        kjTime22.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime22];
        [kjTime22 release];
        
        
        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 107, 300, 2)];
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = UIImageGetImageFromName(@"SZTG960.png") ;
        [backScrollView addSubview:xian];
        [xian release];
        
        UILabel *jxsz = [[UILabel alloc] initWithFrame:CGRectMake(20, 122, 125, 15)];
        jxsz.backgroundColor = [UIColor clearColor];
        jxsz.text = @"奖项设置";
        jxsz.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:jxsz];
        [jxsz release];
        
        UILabel *ydj = [[UILabel alloc] initWithFrame:CGRectMake(27, 150, 60, 12)];
        ydj.backgroundColor = [UIColor clearColor];
        ydj.text = @"一等奖";
        ydj.font = [UIFont boldSystemFontOfSize:12];
        ydj.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:ydj];
        [ydj release];
        
        UILabel *jjfd = [[UILabel alloc] initWithFrame:CGRectMake(75, 150, 140, 12)];
        jjfd.backgroundColor = [UIColor clearColor];
        jjfd.text = @"奖金浮动、单注限额";
        jjfd.font = [UIFont boldSystemFontOfSize:12];
        jjfd.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd];
        [jjfd release];
        
        UILabel *wbw = [[UILabel alloc] initWithFrame:CGRectMake(190, 150, 60, 12)];
        wbw.backgroundColor = [UIColor clearColor];
        wbw.text = @"500";
        wbw.font = [UIFont boldSystemFontOfSize:12];
        wbw.textColor = [UIColor redColor];
        [backScrollView addSubview:wbw];
        [wbw release];
        
        UILabel *wbw2 = [[UILabel alloc] initWithFrame:CGRectMake(215, 150, 20, 12)];
        wbw2.backgroundColor = [UIColor clearColor];
        wbw2.text = @"万";
        wbw2.font = [UIFont boldSystemFontOfSize:12];
        wbw2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:wbw2];
        [wbw2 release];
        
        UILabel *qb1 = [[UILabel alloc] initWithFrame:CGRectMake(75, 167, 200, 10)];
        qb1.backgroundColor = [UIColor clearColor];
        qb1.text = @"14 场比赛全部猜中。";
        qb1.font = [UIFont systemFontOfSize:10];
        qb1.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
        [backScrollView addSubview:qb1];
        [qb1 release];
        //
        UILabel *edj = [[UILabel alloc] initWithFrame:CGRectMake(27, 190, 60, 12)];
        edj.backgroundColor = [UIColor clearColor];
        edj.text = @"二等奖";
        edj.font = [UIFont boldSystemFontOfSize:12];
        edj.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:edj];
        [edj release];
        
        UILabel *jjfd2 = [[UILabel alloc] initWithFrame:CGRectMake(75, 190, 200, 12)];
        jjfd2.backgroundColor = [UIColor clearColor];
        jjfd2.text = @"奖金浮动、当期奖金总额的";
        jjfd2.font = [UIFont boldSystemFontOfSize:12];
        jjfd2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd2];
        [jjfd2 release];
        
        UILabel *bss = [[UILabel alloc] initWithFrame:CGRectMake(225, 190, 60, 12)];
        bss.backgroundColor = [UIColor clearColor];
        bss.text = @"30%";
        bss.font = [UIFont boldSystemFontOfSize:12];
        bss.textColor = [UIColor redColor];
        [backScrollView addSubview:bss];
        [bss release];
        
        UILabel *qb2 = [[UILabel alloc] initWithFrame:CGRectMake(75, 207, 200, 10)];
        qb2.backgroundColor = [UIColor clearColor];
        qb2.text = @"猜中 13 场比赛。";
        qb2.font = [UIFont systemFontOfSize:10];
        qb2.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
        [backScrollView addSubview:qb2];
        [qb2 release];
        

    }
    else if (ALLWANFA == QiLeCai) {
    
        self.CP_navigation.title = @"七乐彩";
        caizhongJQ = qilecai;
        //投注技巧

        [backScrollView setContentSize:CGSizeMake(320, 890)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        
        mkjTime1.text = @"每周一、三、五 21:30 开奖";
        
        UILabel *mqilecaiwfInfo1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 108, 296, 15)];
        mqilecaiwfInfo1.text =@"任选7个号码＝1注(2元)";
        mqilecaiwfInfo1.backgroundColor = [UIColor clearColor];
        mqilecaiwfInfo1.font = [UIFont systemFontOfSize:14.0];
        [backScrollView addSubview:mqilecaiwfInfo1];
        [mqilecaiwfInfo1 release];
        
        
        ColorView *mWFInfo1 = [[ColorView alloc] initWithFrame:CGRectMake(12, mqilecaiwfInfo1.frame.size.height+mqilecaiwfInfo1.frame.origin.y+5, 296, 15)];
        mWFInfo1.backgroundColor = [UIColor clearColor];
        mWFInfo1.text = @"开奖时先开出7个号码作为<基本号码>，再开出1个";
        mWFInfo1.font = [UIFont systemFontOfSize:14];
        mWFInfo1.colorfont = [UIFont boldSystemFontOfSize:14];
        //        mWFInfo1.textColor =[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        mWFInfo1.changeColor = [UIColor redColor];
        [backScrollView addSubview:mWFInfo1];
        [mWFInfo1 release];
        
        ColorView *mWFInfo2 = [[ColorView alloc] initWithFrame:CGRectMake(12, mWFInfo1.frame.size.height+mWFInfo1.frame.origin.y+5, 296, 15)];
        mWFInfo2.backgroundColor = [UIColor clearColor];
        mWFInfo2.text = @"号码作为<特别号码>。";
        mWFInfo2.font = [UIFont systemFontOfSize:14];
        mWFInfo2.colorfont = [UIFont boldSystemFontOfSize:14];
        //        mWFInfo1.textColor =[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        mWFInfo2.changeColor = [UIColor blueColor];
        [backScrollView addSubview:mWFInfo2];
        [mWFInfo2 release];
        
        
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(12, ORIGIN_Y(mWFInfo2)+12, 296, 45) andLabel1Text:@"奖\n级" andLabelWed:30 andLabel2Text:@"中奖条件" andLabel2Wed:76 andLabelText3:@"中奖说明" andLabel3Wed:82 andLaelText4:@"奖金" andLabel4Frame:108 isJiangJiDouble:YES];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];
        
        cell1Array = [[NSArray alloc] initWithObjects:@"一\n等\n奖",@"二\n等\n奖",@"三\n等\n奖",@"四\n等\n奖",@"五\n等\n奖",@"六\n等\n奖",@"七\n等\n奖", nil];

        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, header.frame.origin.y+header.frame.size.height, 296, 560) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];
        

        UILabel *tbsm1Label = [[UILabel alloc] initWithFrame:CGRectMake(12, myTableView.frame.size.height+myTableView.frame.origin.y+12, 60, 15)];
        tbsm1Label.text = @"特别号码 \"";
        tbsm1Label.backgroundColor = [UIColor clearColor];
        tbsm1Label.font = [UIFont boldSystemFontOfSize:12];
        [backScrollView addSubview:tbsm1Label];
        [tbsm1Label release];
        
        UIImageView *tbsmImage = [[UIImageView alloc] initWithFrame:CGRectMake(tbsm1Label.frame.origin.x+tbsm1Label.frame.size.width, tbsm1Label.frame.origin.y+4, 7, 7)];
        [tbsmImage setImage:UIImageGetImageFromName(@"wf_blueBord.jpg")];
        [backScrollView addSubview:tbsmImage];
        [tbsmImage release];
        
        UILabel *tbsm2Label  = [[UILabel alloc] initWithFrame:CGRectMake(tbsmImage.frame.origin.x+7+1, tbsm1Label.frame.origin.y, 120, 15)];
        tbsm2Label.text = @"\" 说明:";
        tbsm2Label.backgroundColor = [UIColor clearColor];
        tbsm2Label.font = [UIFont boldSystemFontOfSize:12];
        [backScrollView addSubview:tbsm2Label];
        [tbsm2Label release];
        
        UILabel *tebieNum = [[UILabel alloc] initWithFrame:CGRectMake(12, myTableView.frame.origin.y+myTableView.frame.size.height+11, 296, 93)];
        tebieNum.backgroundColor = [UIColor clearColor];
        tebieNum.text = @"特别号码仅做二、四、六等奖使用，即开出7个奖号后再从30个号中再随机摇出一个作为特别号码，只要跟您买的7个号码中的任意1个号相符，就算中特别号。";
        tebieNum.lineBreakMode = NSLineBreakByWordWrapping;
        tebieNum.numberOfLines = 0;
        tebieNum.font = [UIFont systemFontOfSize:12];
        [backScrollView addSubview:tebieNum];
        [tebieNum release];


    }
    else if (ALLWANFA == DaLeTou) {
    
        self.CP_navigation.title = @"大乐透";
        caizhongJQ = daletou;

        [backScrollView setContentSize:CGSizeMake(320, 566)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        
        mkjTime1.text = @"每周一、三、六 20:30 开奖";
        
        ColorView *mWFInfo1 = [[ColorView alloc] initWithFrame:CGRectMake(12, 108, 70, 15)];
        mWFInfo1.backgroundColor = [UIColor clearColor];
        mWFInfo1.text = @"<5个红球> + ";
        mWFInfo1.font = [UIFont systemFontOfSize:14];
        mWFInfo1.colorfont = [UIFont boldSystemFontOfSize:14];
        //        mWFInfo1.textColor =[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        mWFInfo1.changeColor = [UIColor redColor];
        [backScrollView addSubview:mWFInfo1];
        [mWFInfo1 release];
        
        ColorView *mWFInfo2 = [[ColorView alloc] initWithFrame:CGRectMake(82, 108, 296, 15)];
        mWFInfo2.backgroundColor = [UIColor clearColor];
        mWFInfo2.text = @"<2个蓝球> = 1 注 (2元)";
        mWFInfo2.font = [UIFont systemFontOfSize:14];
        mWFInfo2.colorfont = [UIFont boldSystemFontOfSize:14];
        //        mWFInfo1.textColor =[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        mWFInfo2.changeColor = [UIColor blueColor];
        [backScrollView addSubview:mWFInfo2];
        [mWFInfo2 release];
        
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(12, mWFInfo2.frame.origin.y+15+12, 296, 30) andLabel1Text:@"奖级" andLabelWed:61 andLabel2Text:@"中奖条件" andLabel2Wed:87 andLabelText3:@"中奖说明" andLabel3Wed:87 andLaelText4:@"奖金" andLabel4Frame:61 isJiangJiDouble:NO];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];
        
        cell1Array = [[NSArray alloc] initWithObjects:@"一等奖",@"二等奖",@"三等奖",@"四等奖",@"五等奖",@"六等奖" , nil];

        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, header.frame.origin.y+header.frame.size.height, 296, 370) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];
        


    }
    else if (ALLWANFA == ShiYiXuan5) {
    
        self.CP_navigation.title = @"山东11选5";
        caizhongJQ = shiyixuan5;

        [backScrollView setContentSize:CGSizeMake(320, 740)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        mkjTime.text = @"开售时间";
        
        mkjTime1.text = @"08:55-21:55  10分钟1期  每天78期";
        
        UILabel *msd11x5fInfo1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 108, 296, 15)];
        msd11x5fInfo1.text =@"每期从01-11开出5个号码作为中奖号码";
        msd11x5fInfo1.font = [UIFont systemFontOfSize:14.0];
        msd11x5fInfo1.backgroundColor = [UIColor clearColor];
        [backScrollView addSubview:msd11x5fInfo1];
        [msd11x5fInfo1 release];
        
        
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(12, msd11x5fInfo1.frame.origin.y+15+12, 296, 30) andLabel1Text:@"玩法" andLabelWed:61 andLabel2Text:@"中奖条件" andLabel2Wed:174 andLabelText3:@"奖金" andLabel3Wed:61 andLaelText4:nil andLabel4Frame:61 isJiangJiDouble:NO];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];
        
        cell1Array = [[NSArray alloc] initWithObjects:@"任选二",@"任选三",@"任选四",@"任选五",@"任选六",@"任选七",@"任选八",@"前一直选",@"前二直选",@"前三直选",@"前二组选",@"前三组选", nil];
        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, header.frame.origin.y+header.frame.size.height, 296, 541) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];
        


    }
    else if (ALLWANFA == GDShiYiXuan5) {
        self.CP_navigation.title = @"广东11选5";
        caizhongJQ = shiyixuan5;

        [backScrollView setContentSize:CGSizeMake(320, 740)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        
        mkjTime.text = @"开售时间";
        
        mkjTime1.text = @"09:00-23:00  10分钟1期  每天84期";
        
        UILabel *msd11x5fInfo1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 108, 296, 15)];
        msd11x5fInfo1.text =@"每期从01-11开出5个号码作为中奖号码";
        msd11x5fInfo1.font = [UIFont systemFontOfSize:14.0];
        [backScrollView addSubview:msd11x5fInfo1];
        msd11x5fInfo1.backgroundColor = [UIColor clearColor];
        [msd11x5fInfo1 release];
        
        
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(12, msd11x5fInfo1.frame.origin.y+15+12, 296, 30) andLabel1Text:@"玩法" andLabelWed:61 andLabel2Text:@"中奖条件" andLabel2Wed:174 andLabelText3:@"奖金" andLabel3Wed:61 andLaelText4:nil andLabel4Frame:61 isJiangJiDouble:NO];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];
        
        cell1Array = [[NSArray alloc] initWithObjects:@"任选二",@"任选三",@"任选四",@"任选五",@"任选六",@"任选七",@"任选八",@"前一直选",@"前二直选",@"前三直选",@"前二组选",@"前三组选", nil];

        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, header.frame.origin.y+header.frame.size.height, 296, 541) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];

    }
    else if (ALLWANFA == JXShiYiXuan5) {
        self.CP_navigation.title = @"江西11选5";
        caizhongJQ = shiyixuan5;
        
        [backScrollView setContentSize:CGSizeMake(320, 740)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        
        mkjTime.text = @"开售时间";
        
        mkjTime1.text = @"09:00-22:00  10分钟1期  每天78期";
        
        UILabel *msd11x5fInfo1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 108, 296, 15)];
        msd11x5fInfo1.text =@"每期从01-11开出5个号码作为中奖号码";
        msd11x5fInfo1.font = [UIFont systemFontOfSize:14.0];
        [backScrollView addSubview:msd11x5fInfo1];
        msd11x5fInfo1.backgroundColor = [UIColor clearColor];
        [msd11x5fInfo1 release];
        
        
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(12, msd11x5fInfo1.frame.origin.y+15+12, 296, 30) andLabel1Text:@"玩法" andLabelWed:61 andLabel2Text:@"中奖条件" andLabel2Wed:174 andLabelText3:@"奖金" andLabel3Wed:61 andLaelText4:nil andLabel4Frame:61 isJiangJiDouble:NO];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];
        
        cell1Array = [[NSArray alloc] initWithObjects:@"任选二",@"任选三",@"任选四",@"任选五",@"任选六",@"任选七",@"任选八",@"前一直选",@"前二直选",@"前三直选",@"前二组选",@"前三组选", nil];
        
        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, header.frame.origin.y+header.frame.size.height, 296, 541) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];

    }
    else if (ALLWANFA == HBShiYiXuan5) {
        
        self.CP_navigation.title = @"河北11选5";
        caizhongJQ = shiyixuan5;
        
        [backScrollView setContentSize:CGSizeMake(320, 740)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        mkjTime.text = @"开售时间";
        
        mkjTime1.text = @"08:50-22:00  10分钟1期  每天79期";
        
        UILabel *msd11x5fInfo1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 108, 296, 15)];
        msd11x5fInfo1.text =@"每期从01-11开出5个号码作为中奖号码";
        msd11x5fInfo1.font = [UIFont systemFontOfSize:14.0];
        msd11x5fInfo1.backgroundColor = [UIColor clearColor];
        [backScrollView addSubview:msd11x5fInfo1];
        [msd11x5fInfo1 release];
        
        
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(12, msd11x5fInfo1.frame.origin.y+15+12, 296, 30) andLabel1Text:@"玩法" andLabelWed:61 andLabel2Text:@"中奖条件" andLabel2Wed:174 andLabelText3:@"奖金" andLabel3Wed:61 andLaelText4:nil andLabel4Frame:61 isJiangJiDouble:NO];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];
        
        cell1Array = [[NSArray alloc] initWithObjects:@"任选二",@"任选三",@"任选四",@"任选五",@"任选六",@"任选七",@"任选八",@"前一直选",@"前二直选",@"前三直选",@"前二组选",@"前三组选", nil];
        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, header.frame.origin.y+header.frame.size.height, 296, 541) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];
        
        
        
    }
    else if (ALLWANFA == ShanXiShiYiXuan5) {
        
        self.CP_navigation.title = @"新11选5";
        caizhongJQ = shiyixuan5;
        
        [backScrollView setContentSize:CGSizeMake(320, 740)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        mkjTime.text = @"开售时间";
        
        mkjTime1.text = @"08:30-23:00  10分钟1期  每天88期";
        
        UILabel *msd11x5fInfo1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 108, 296, 15)];
        msd11x5fInfo1.text =@"每期从01-11开出5个号码作为中奖号码";
        msd11x5fInfo1.font = [UIFont systemFontOfSize:14.0];
        msd11x5fInfo1.backgroundColor = [UIColor clearColor];
        [backScrollView addSubview:msd11x5fInfo1];
        [msd11x5fInfo1 release];
        
        
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(12, msd11x5fInfo1.frame.origin.y+15+12, 296, 30) andLabel1Text:@"玩法" andLabelWed:61 andLabel2Text:@"中奖条件" andLabel2Wed:174 andLabelText3:@"奖金" andLabel3Wed:61 andLaelText4:nil andLabel4Frame:61 isJiangJiDouble:NO];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];
        
        cell1Array = [[NSArray alloc] initWithObjects:@"任选二",@"任选三",@"任选四",@"任选五",@"任选六",@"任选七",@"任选八",@"前一直选",@"前二直选",@"前三直选",@"前二组选",@"前三组选", nil];
        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, header.frame.origin.y+header.frame.size.height, 296, 541) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];
        
        
        
    }
    else if (ALLWANFA == Horse) {
        self.CP_navigation.title = Lottery_Name_Horse;

        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        
        mkjTime.text = @"开售时间";
        mkjTime.font = [UIFont boldSystemFontOfSize:18];
        mkjTime.backgroundColor = [UIColor clearColor];
        mkjTime.frame = CGRectMake(mkjTime.frame.origin.x, 15, mkjTime.frame.size.width, 20);
        
        mkjTime1.text = @"08:55-21:55 10分钟1场 每天78场";
        mkjTime1.textColor = [SharedMethod getColorByHexString:@"454545"];
        mkjTime1.backgroundColor = [UIColor clearColor];
        mkjTime1.frame = CGRectMake(mkjTime.frame.origin.x, ORIGIN_Y(mkjTime) + 13, mkjTime1.frame.size.width, mkjTime1.frame.size.height);
        
        mWFInfo.text = @"规则";
        mWFInfo.font = [UIFont boldSystemFontOfSize:18];
        mWFInfo.frame = CGRectMake(mkjTime.frame.origin.x, ORIGIN_Y(mkjTime1) + 25, mWFInfo.frame.size.width, 20);
        
        UILabel *msd11x5fInfo1 = [[UILabel alloc] initWithFrame:CGRectMake(12, ORIGIN_Y(mWFInfo) + 13, 296, 60)];
        msd11x5fInfo1.text =@"11选5赛马场是山东11选5的娱乐投注方式，三种玩法独赢、连赢和单T分别对应11选5彩种中前一直选、前二组选和前三组选";
        msd11x5fInfo1.font = [UIFont systemFontOfSize:14.0];
        [backScrollView addSubview:msd11x5fInfo1];
        msd11x5fInfo1.numberOfLines = 0;
        msd11x5fInfo1.textColor = [SharedMethod getColorByHexString:@"454545"];
        msd11x5fInfo1.backgroundColor = [UIColor clearColor];
        [msd11x5fInfo1 release];
        
        UILabel *msd11x5fInfo2 = [[UILabel alloc] initWithFrame:CGRectMake(12, ORIGIN_Y(msd11x5fInfo1), 296, 40)];
        msd11x5fInfo2.text =@"11选5赛马场押注时使用积分购买，中奖后根据赔率奖励积分，单注消耗2个积分。";
        msd11x5fInfo2.font = [UIFont systemFontOfSize:14.0];
        [backScrollView addSubview:msd11x5fInfo2];
        msd11x5fInfo2.textColor = [SharedMethod getColorByHexString:@"454545"];
        msd11x5fInfo2.numberOfLines = 0;
        msd11x5fInfo2.backgroundColor = [UIColor clearColor];
        [msd11x5fInfo2 release];
        
        UILabel *msd11x5fInfo4 = [[UILabel alloc] initWithFrame:CGRectMake(12, ORIGIN_Y(msd11x5fInfo2), 145, 55)];
        msd11x5fInfo4.text =@"力——前一直选遗漏值速——前二组选遗漏值耐——前三组选遗漏值";
        msd11x5fInfo4.font = [UIFont systemFontOfSize:14.0];
        [backScrollView addSubview:msd11x5fInfo4];
        msd11x5fInfo4.textColor = [SharedMethod getColorByHexString:@"454545"];
        msd11x5fInfo4.numberOfLines = 0;
        msd11x5fInfo4.backgroundColor = [UIColor clearColor];
        [msd11x5fInfo4 release];
        
        UILabel *msd11x5fInfo3 = [[UILabel alloc] initWithFrame:CGRectMake(12, ORIGIN_Y(msd11x5fInfo4) + 25, 308, 20)];
        msd11x5fInfo3.text = @"派彩条件&赔率";
        msd11x5fInfo3.font = [UIFont boldSystemFontOfSize:18];
        msd11x5fInfo3.backgroundColor = [UIColor clearColor];
        [backScrollView addSubview:msd11x5fInfo3];
        [msd11x5fInfo3 release];
        
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(12, ORIGIN_Y(msd11x5fInfo3) + 13, 296, 30) andLabel1Text:@"玩法" andLabelWed:61 andLabel2Text:@"派彩条件" andLabel2Wed:174 andLabelText3:@"赔率" andLabel3Wed:61 andLaelText4:nil andLabel4Frame:61 isJiangJiDouble:NO];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];
        
        cell1Array = [[NSArray alloc] initWithObjects:@"独赢",@"连赢",@"单T", nil];
        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, header.frame.origin.y+header.frame.size.height, 296, 165) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];
        
        [backScrollView setContentSize:CGSizeMake(320, ORIGIN_Y(myTableView) + 10)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
    }
    else if (ALLWANFA == ChongQShiShiCai)
    {
        self.CP_navigation.title = @"老时时彩";
        caizhongJQ = shishicai;
        
        [backScrollView setContentSize:CGSizeMake(320, 1150)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        
        mkjTime.text = @"开售时间";
        
        mkjTime1.frame = CGRectMake(12, ORIGIN_Y(mkjTime)+12, 296, 50);
        mkjTime1.text = @"白天10点至22点  夜场22点至凌晨2点\n白天72期，夜场48期，共120期";
        
        UILabel *kjplLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, ORIGIN_Y(mkjTime1)+12, 80, 15)];
        kjplLabel.text = @"开奖频率";
        kjplLabel.font = [UIFont boldSystemFontOfSize:14.0];
        kjplLabel.backgroundColor = [UIColor clearColor];
        [backScrollView addSubview:kjplLabel];
        [kjplLabel release];
        
        UILabel *kjplLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(12, ORIGIN_Y(kjplLabel)+12, 296, 15)];
        kjplLabel1.text = @"白天10分钟 夜场5分钟";
        kjplLabel1.font = [UIFont systemFontOfSize:14];
        kjplLabel1.backgroundColor = [UIColor clearColor];
        [backScrollView addSubview:kjplLabel1];
        [kjplLabel1 release];
    
        
        mWFInfo.frame = CGRectMake(12, kjplLabel1.frame.origin.y+kjplLabel1.frame.size.height+22,308,15);
        
        UILabel *cqshishicaiLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, mWFInfo.frame.origin.y+mWFInfo.frame.size.height+12, 296, 42)];
        cqshishicaiLabel.backgroundColor = [UIColor clearColor];
        cqshishicaiLabel.text = @"每期开出一个 5 位数作为中奖号码, 万、千、百、十、个位每位号码为0-9.";
        cqshishicaiLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cqshishicaiLabel.numberOfLines = 0;
        cqshishicaiLabel.font = [UIFont systemFontOfSize:14];
        [backScrollView addSubview:cqshishicaiLabel];
        [cqshishicaiLabel release];
        
        
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(12, cqshishicaiLabel.frame.origin.y+42+12, 296, 30) andLabel1Text:@"玩法" andLabelWed:61 andLabel2Text:@"中奖条件" andLabel2Wed:174 andLabelText3:@"奖金" andLabel3Wed:61 andLaelText4:nil andLabel4Frame:61 isJiangJiDouble:NO];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];
        
        cell1Array = [[NSArray alloc] initWithObjects:@"大小\n单双",@"一星\n直选",@"二星\n直选",@"二星\n组选",@"二星\n和值",@"三星\n直选",@"三星\n和值",@"三星\n组三",@"三星\n组六",@"五星\n直选",@"五星\n通选", nil];

        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, header.frame.origin.y+header.frame.size.height, 296, 774) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];
        
        
        UILabel *wuxingTX = [[UILabel alloc] initWithFrame:CGRectMake(12, myTableView.frame.origin.y+myTableView.frame.size.height+12, 296, 15)];
        wuxingTX.text = @"五星通选:";
        wuxingTX.backgroundColor = [UIColor clearColor];
        wuxingTX.font = [UIFont boldSystemFontOfSize:12];
        [backScrollView addSubview:wuxingTX];
        [wuxingTX release];
        
        UILabel *wuxingTX1 = [[UILabel alloc] initWithFrame:CGRectMake(12, wuxingTX.frame.origin.y+15+12, 296, 40)];
        wuxingTX1.text = @"一等奖奖金：1注一等奖+1注二等奖+1注三等奖\n二等奖奖金：1注二等奖+1注三等奖";
        wuxingTX1.font = [UIFont systemFontOfSize:12];
        wuxingTX1.backgroundColor = [UIColor clearColor];
        wuxingTX1.lineBreakMode = NSLineBreakByWordWrapping;
        wuxingTX1.numberOfLines = 0;
        [backScrollView addSubview:wuxingTX1];
        [wuxingTX1 release];


    }
    else if (ALLWANFA == ShiShiCai) {
    
        self.CP_navigation.title = @"黑龙江时时彩";
        caizhongJQ = shishicai;
        [backScrollView setContentSize:CGSizeMake(320, 1175)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        
        mkjTime.text = @"开售时间";
        mkjTime1.text = @"8:40-22:40 10分钟 1 期 每天84期";
        
        UILabel *mshishicaiInfo = [[UILabel alloc] initWithFrame:CGRectMake(12, 108, 296, 40)];
        mshishicaiInfo.text =@"每期开出一个5位数作为中奖号码，万、千、百、十、个位每位号码为0-9.";
        mshishicaiInfo.lineBreakMode = NSLineBreakByWordWrapping;
        mshishicaiInfo.numberOfLines = 0;
        mshishicaiInfo.backgroundColor = [UIColor clearColor];
        mshishicaiInfo.font = [UIFont systemFontOfSize:14.0];
        [backScrollView addSubview:mshishicaiInfo];
        [mshishicaiInfo release];
        
        
        
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(12, mshishicaiInfo.frame.origin.y+40+12, 296, 30) andLabel1Text:@"玩法" andLabelWed:61 andLabel2Text:@"中奖条件" andLabel2Wed:174 andLabelText3:@"奖金" andLabel3Wed:61 andLaelText4:nil andLabel4Frame:61 isJiangJiDouble:NO];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];
        

        cell1Array = [[NSArray alloc] initWithObjects:@"大小\n单双",@"一星\n复式",@"二星\n复式",@"二星\n组选",@"二星\n组选\n胆拖",@"三星\n复式",@"四星\n复式",@"五星\n复式",@"五星\n通选",@"任选一",@"任选二",@"任选三", nil];

        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, header.frame.origin.y+header.frame.size.height, 296, 877) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];
        
        
        
        UILabel *wuxingTX = [[UILabel alloc] initWithFrame:CGRectMake(12, myTableView.frame.origin.y+myTableView.frame.size.height+12, 296, 15)];
        wuxingTX.text = @"五星通选:";
        wuxingTX.backgroundColor = [UIColor clearColor];
        wuxingTX.font = [UIFont boldSystemFontOfSize:12];
        [backScrollView addSubview:wuxingTX];
        [wuxingTX release];
    
        UILabel *wuxingTX1 = [[UILabel alloc] initWithFrame:CGRectMake(12, wuxingTX.frame.origin.y+15+12, 296, 40)];
        wuxingTX1.text = @"一等奖奖金：1注一等奖+1注二等奖+1注三等奖\n二等奖奖金：1注二等奖+1注三等奖";
        wuxingTX1.font = [UIFont systemFontOfSize:12];
        wuxingTX1.lineBreakMode = NSLineBreakByWordWrapping;
        wuxingTX1.numberOfLines = 0;
        wuxingTX1.backgroundColor = [UIColor clearColor];
        [backScrollView addSubview:wuxingTX1];
        [wuxingTX1 release];
        
    }
    else if (ALLWANFA == FuCai3D) {
    
        
        self.CP_navigation.title = @"福彩3D";
        caizhongJQ = fucai3d;

        [backScrollView setContentSize:CGSizeMake(320, 795)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];

        mkjTime1.text = @"每天 20:30 开奖";
        
        
        UILabel *mfucai3dwfInfo1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 108, 296, 40)];
        mfucai3dwfInfo1.text =@"每期开出一个3位数作为中奖号码百、十、个位\n每位号码为0-9";

        mfucai3dwfInfo1.lineBreakMode = NSLineBreakByWordWrapping;
        mfucai3dwfInfo1.numberOfLines = 0;
        mfucai3dwfInfo1.backgroundColor = [UIColor clearColor];
        mfucai3dwfInfo1.font = [UIFont systemFontOfSize:14.0];
        [backScrollView addSubview:mfucai3dwfInfo1];
        [mfucai3dwfInfo1 release];
        
        
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(12, mfucai3dwfInfo1.frame.origin.y+40+12, 296, 30) andLabel1Text:@"玩法" andLabelWed:61 andLabel2Text:@"中奖号码" andLabel2Wed:174 andLabelText3:@"奖金" andLabel3Wed:61 andLaelText4:nil andLabel4Frame:61 isJiangJiDouble:NO];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];
        
        cell1Array = [[NSArray alloc] initWithObjects:@"直选",@"直选\n和值",@"组三\n单式",@"组三\n复式",@"组六",@"组三\n和值",@"组六\n和值",@"组三\n胆拖",@"组六\n胆拖",  nil];

        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, header.frame.origin.y+header.frame.size.height, 296, 477) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];
        
        
        UILabel *zusan = [[UILabel alloc] initWithFrame:CGRectMake(12, myTableView.frame.origin.y+myTableView.frame.size.height+11, 296, 93)];
        zusan.text = @"* 组三  3个开奖号码中有两个重复号码，即为组三。\n* 组六  3个开奖号码各不相同，即为组六。\n* 胆拖玩法  胆码是您认为必出的号码，拖码是您认为可能出的号码。";
        zusan.lineBreakMode = NSLineBreakByWordWrapping;
        zusan.numberOfLines = 0;
        zusan.backgroundColor = [UIColor clearColor];
        zusan.font = [UIFont systemFontOfSize:12];
        [backScrollView addSubview:zusan];
        [zusan release];
        
        
        

    }
    else if (ALLWANFA == SendAwardTime)
    {
        self.CP_navigation.title = @"开奖派奖时间";

        [backScrollView setContentSize:CGSizeMake(320, 640)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        
        mkjTime.hidden = YES;
        mkjTime1.hidden = YES;
        mWFInfo.hidden = YES;
        
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(5, 5, 310, 30) andLabel1Text:@"彩种" andLabelWed:56 andLabel2Text:@"开奖时间" andLabel2Wed:127 andLabelText3:@"派奖时间" andLabel3Wed:127 andLaelText4:nil andLabel4Frame:61 isJiangJiDouble:NO];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];
        
        cell1Array = [[NSArray alloc] initWithObjects:@"竞彩",@"北京\n单场",@"足球",@"双色球",@"福彩3D",@"超级\n大乐透",@"排列3",@"排列5",@"七星彩",@"七乐彩",  nil];
        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, ORIGIN_Y(header), 310, 582) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];
        
    }
    else if (ALLWANFA == BeiJingDanChang || ALLWANFA == bdbanquanchang || ALLWANFA == bdbifen || ALLWANFA == bdshangxiadanshuang || ALLWANFA == bdzongjinqiu || ALLWANFA == beidanshengfu) {
    
        //self.CP_navigation.title = @"北京单场";
        caizhongJQ = bjdanchang;

        
        
        if (ALLWANFA == bdzongjinqiu) {
            UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            titleV.backgroundColor = [UIColor clearColor];
            titleV.userInteractionEnabled = YES;
            
            UILabel *nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 55, 44)];
            nameLable2.backgroundColor = [UIColor clearColor];
            nameLable2.textColor = [UIColor whiteColor];
            nameLable2.text = @"单场";
            nameLable2.shadowColor = [UIColor blackColor];
            nameLable2.shadowOffset = CGSizeMake(0.0f, 1.0f);
            nameLable2.font = [UIFont boldSystemFontOfSize:20];
            nameLable2.textAlignment = NSTextAlignmentRight;
            [titleV addSubview:nameLable2];
            [nameLable2 release];
            
            
            UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(137+28, 0, 80, 44)];
            nameLable.backgroundColor = [UIColor clearColor];
            nameLable.textColor = [UIColor whiteColor];
            nameLable.text = @"进球数";
            nameLable.shadowColor = [UIColor blackColor];
            nameLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
            nameLable.font = [UIFont boldSystemFontOfSize:15];
            nameLable.textAlignment = NSTextAlignmentLeft;
            [titleV addSubview:nameLable];
            self.CP_navigation.titleView = titleV;
            [titleV release];
            [nameLable release];
            
            UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
            backScrollView.userInteractionEnabled = YES;
            [backScrollView setContentSize:CGSizeMake(320, 600)];
            if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
                backScrollView.scrollEnabled = NO;
            }
            [self.mainView addSubview:backScrollView];
            [backScrollView release];
            
            
            UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
            kjTime.backgroundColor = [UIColor clearColor];
            kjTime.text = @"玩法规则";
            kjTime.font = [UIFont boldSystemFontOfSize:15];
            [backScrollView addSubview:kjTime];
            [kjTime release];
            
            UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 43, 266, 10)];
            kjTime2.backgroundColor = [UIColor clearColor];
            kjTime2.text = @"竞猜某场比赛,对该场比赛在全场90分钟(含伤停补时)双方的";
            kjTime2.font = [UIFont boldSystemFontOfSize:10];
            kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime2];
            [kjTime2 release];
            UILabel *kjTime21 = [[UILabel alloc] initWithFrame:CGRectMake(27, 61, 266, 10)];
            kjTime21.backgroundColor = [UIColor clearColor];
            kjTime21.text = @"进球总数结果进行投注,每场比赛工有8个投注选项。";
            kjTime21.font = [UIFont boldSystemFontOfSize:10];
            kjTime21.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime21];
            [kjTime21 release];
            
            
            UILabel *kjTime5 = [[UILabel alloc] initWithFrame:CGRectMake(27, 104-10, 230, 10)];
            kjTime5.backgroundColor = [UIColor clearColor];
            kjTime5.text = @"”0“ 双方进球之和为0,即没有进球。";
            kjTime5.font = [UIFont systemFontOfSize:10];
            kjTime5.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime5];
            [kjTime5 release];
            UILabel *kjTime51 = [[UILabel alloc] initWithFrame:CGRectMake(27, 122-10, 230, 10)];
            kjTime51.backgroundColor = [UIColor clearColor];
            kjTime51.text = @"”1“ 双方进球之和为1。";
            kjTime51.font = [UIFont systemFontOfSize:10];
            kjTime51.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime51];
            [kjTime51 release];
            
            UILabel *kjTime53 = [[UILabel alloc] initWithFrame:CGRectMake(27, 140-10, 230, 10)];
            kjTime53.backgroundColor = [UIColor clearColor];
            kjTime53.text = @"“2” 双方进球之和为2。";
            kjTime53.font = [UIFont systemFontOfSize:10];
            kjTime53.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime53];
            [kjTime53 release];
            UILabel *kjTime54 = [[UILabel alloc] initWithFrame:CGRectMake(27, 158-10, 230, 10)];
            kjTime54.backgroundColor = [UIColor clearColor];
            kjTime54.text = @"“3” 双方进球之和为3。";
            kjTime54.font = [UIFont systemFontOfSize:10];
            kjTime54.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime54];
            [kjTime54 release];

            
            UILabel *kjTime12 = [[UILabel alloc] initWithFrame:CGRectMake(27, 176-10, 230, 10)];
            kjTime12.backgroundColor = [UIColor clearColor];
            kjTime12.text = @"“4” 双方进球之和为4。";
            kjTime12.font = [UIFont systemFontOfSize:10];
            kjTime12.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime12];
            [kjTime12 release];
            UILabel *kjTime121 = [[UILabel alloc] initWithFrame:CGRectMake(27, 194-10, 230, 10)];
            kjTime121.backgroundColor = [UIColor clearColor];
            kjTime121.text = @"“5” 双方进球之和为5。";
            kjTime121.font = [UIFont systemFontOfSize:10];
            kjTime121.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime121];
            [kjTime121 release];
            UILabel *kjTime122 = [[UILabel alloc] initWithFrame:CGRectMake(27, 212-10, 230, 10)];
            kjTime122.backgroundColor = [UIColor clearColor];
            kjTime122.text = @"“6” 双方进球之和为6。";
            kjTime122.font = [UIFont systemFontOfSize:10];
            kjTime122.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime122];
            [kjTime122 release];
            UILabel *kjTime123 = [[UILabel alloc] initWithFrame:CGRectMake(27, 230-10, 230, 10)];
            kjTime123.backgroundColor = [UIColor clearColor];
            kjTime123.text = @"“7+” 双方进球之和为7或7以上。";
            kjTime123.font = [UIFont systemFontOfSize:10];
            kjTime123.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime123];
            [kjTime123 release];
            
    
            
            UILabel *kjTime6 = [[UILabel alloc] initWithFrame:CGRectMake(27, 255-10, 30, 10)];
            kjTime6.backgroundColor = [UIColor clearColor];
            kjTime6.text = @"单关:";
            kjTime6.font = [UIFont boldSystemFontOfSize:10];
            kjTime6.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime6];
            [kjTime6 release];
            
            UILabel *kjTime7 = [[UILabel alloc] initWithFrame:CGRectMake(60, 256-10, 250, 10)];
            kjTime7.backgroundColor = [UIColor clearColor];
            kjTime7.text = @"任意选择 1 场或多场比赛投注（1 场比赛可投注多种";
            kjTime7.font = [UIFont systemFontOfSize:10];
            kjTime7.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime7];
            [kjTime7 release];
            UILabel *kjTime71 = [[UILabel alloc] initWithFrame:CGRectMake(60, 274-10, 230, 10)];
            kjTime71.backgroundColor = [UIColor clearColor];
            kjTime71.text = @"比赛结果），每个比赛结果构成 1 注。";
            kjTime71.font = [UIFont systemFontOfSize:10];
            kjTime71.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime71];
            [kjTime71 release];
            
            
            UILabel *kjTime8 = [[UILabel alloc] initWithFrame:CGRectMake(27, 299-10, 30, 10)];
            kjTime8.backgroundColor = [UIColor clearColor];
            kjTime8.text = @"过关:";
            kjTime8.font = [UIFont boldSystemFontOfSize:10];
            kjTime8.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime8];
            [kjTime8 release];
            
            UILabel *kjTime9 = [[UILabel alloc] initWithFrame:CGRectMake(60, 300-10, 266, 10)];
            kjTime9.backgroundColor = [UIColor clearColor];
            kjTime9.text = @"选择 2 场（或以上）比赛进行投注。";
            kjTime9.font = [UIFont systemFontOfSize:10];
            kjTime9.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime9];
            [kjTime9 release];
            
            [self jiangJin:backScrollView y:300+15-10];
            
        }else if (ALLWANFA == bdbanquanchang ){
            
            UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            titleV.backgroundColor = [UIColor clearColor];
            titleV.userInteractionEnabled = YES;
            
            UILabel *nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(95, 0, 55, 44)];
            nameLable2.backgroundColor = [UIColor clearColor];
            nameLable2.textColor = [UIColor whiteColor];
            nameLable2.text = @"单场";
            nameLable2.shadowColor = [UIColor blackColor];
            nameLable2.shadowOffset = CGSizeMake(0.0f, 1.0f);
            nameLable2.font = [UIFont boldSystemFontOfSize:20];
            nameLable2.textAlignment = NSTextAlignmentRight;
            [titleV addSubview:nameLable2];
            [nameLable2 release];
            
            
            UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(137+16, 0, 100, 44)];
            nameLable.backgroundColor = [UIColor clearColor];
            nameLable.textColor = [UIColor whiteColor];
            nameLable.text = @"半全场胜平负";
            nameLable.shadowColor = [UIColor blackColor];
            nameLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
            nameLable.font = [UIFont boldSystemFontOfSize:15];
            nameLable.textAlignment = NSTextAlignmentLeft;
            [titleV addSubview:nameLable];
            self.CP_navigation.titleView = titleV;
            [titleV release];
            [nameLable release];
            
            UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
            backScrollView.userInteractionEnabled = YES;
            [backScrollView setContentSize:CGSizeMake(320, 600)];
            if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
                backScrollView.scrollEnabled = NO;
            }
            [self.mainView addSubview:backScrollView];
            [backScrollView release];
            
            
            UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
            kjTime.backgroundColor = [UIColor clearColor];
            kjTime.text = @"玩法规则";
            kjTime.font = [UIFont boldSystemFontOfSize:15];
            [backScrollView addSubview:kjTime];
            [kjTime release];
            
            UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 43, 266, 10)];
            kjTime2.backgroundColor = [UIColor clearColor];
            kjTime2.text = @"竞猜某场比赛,对主队在上半场45分钟(含伤停 补时)和全场";
            kjTime2.font = [UIFont boldSystemFontOfSize:10];
            kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime2];
            [kjTime2 release];
            UILabel *kjTime21 = [[UILabel alloc] initWithFrame:CGRectMake(27, 61, 266, 10)];
            kjTime21.backgroundColor = [UIColor clearColor];
            kjTime21.text = @"90分钟(含伤停补时)的“胜”、“平”、 “负”结果分别进行投";
            kjTime21.font = [UIFont boldSystemFontOfSize:10];
            kjTime21.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime21];
            [kjTime21 release];
            
            UILabel *kjTime22 = [[UILabel alloc] initWithFrame:CGRectMake(27, 79, 266, 10)];
            kjTime22.backgroundColor = [UIColor clearColor];
            kjTime22.text = @"注,每场比赛共有9个投注选项。";
            kjTime22.font = [UIFont boldSystemFontOfSize:10];
            kjTime22.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime22];
            [kjTime22 release];

            
            
            UILabel *kjTime5 = [[UILabel alloc] initWithFrame:CGRectMake(60, 104, 230, 10)];
            kjTime5.backgroundColor = [UIColor clearColor];
            kjTime5.text = @"“胜胜”即上半场主队胜,全场主队胜。";
            kjTime5.font = [UIFont systemFontOfSize:10];
            kjTime5.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime5];
            [kjTime5 release];
            UILabel *kjTime51 = [[UILabel alloc] initWithFrame:CGRectMake(60, 122, 230, 10)];
            kjTime51.backgroundColor = [UIColor clearColor];
            kjTime51.text = @"“胜平”即上半场主队胜,全场主队平。";
            kjTime51.font = [UIFont systemFontOfSize:10];
            kjTime51.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime51];
            [kjTime51 release];
            
            UILabel *kjTime53 = [[UILabel alloc] initWithFrame:CGRectMake(60, 130+10, 230, 10)];
            kjTime53.backgroundColor = [UIColor clearColor];
            kjTime53.text = @"“胜负”即上半场主队胜,全场主队负。";
            kjTime53.font = [UIFont systemFontOfSize:10];
            kjTime53.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime53];
            [kjTime53 release];
            UILabel *kjTime54 = [[UILabel alloc] initWithFrame:CGRectMake(60, 148+10, 230, 10)];
            kjTime54.backgroundColor = [UIColor clearColor];
            kjTime54.text = @"“平胜”即上半场主队平,全场主队胜。";
            kjTime54.font = [UIFont systemFontOfSize:10];
            kjTime54.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime54];
            [kjTime54 release];
            
            
            UILabel *kjTime12 = [[UILabel alloc] initWithFrame:CGRectMake(60, 158+8+10, 230, 10)];
            kjTime12.backgroundColor = [UIColor clearColor];
            kjTime12.text = @"“平平”即上半场主队平,全场主队平。";
            kjTime12.font = [UIFont systemFontOfSize:10];
            kjTime12.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime12];
            [kjTime12 release];
            UILabel *kjTime121 = [[UILabel alloc] initWithFrame:CGRectMake(60, 174+8+10, 230, 10)];
            kjTime121.backgroundColor = [UIColor clearColor];
            kjTime121.text = @"“平负”即上半场主队平,全场主队负。";
            kjTime121.font = [UIFont systemFontOfSize:10];
            kjTime121.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime121];
            [kjTime121 release];
            UILabel *kjTime122 = [[UILabel alloc] initWithFrame:CGRectMake(60, 192+8+10, 230, 10)];
            kjTime122.backgroundColor = [UIColor clearColor];
            kjTime122.text = @"“负胜”即上半场主队负,全场主队胜。";
            kjTime122.font = [UIFont systemFontOfSize:10];
            kjTime122.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime122];
            [kjTime122 release];
            UILabel *kjTime123 = [[UILabel alloc] initWithFrame:CGRectMake(60, 210+8+10, 230, 10)];
            kjTime123.backgroundColor = [UIColor clearColor];
            kjTime123.text = @"“负平”即上半场主队负,全场主队平。";
            kjTime123.font = [UIFont systemFontOfSize:10];
            kjTime123.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime123];
            [kjTime123 release];
            
            UILabel *kjTime124 = [[UILabel alloc] initWithFrame:CGRectMake(60, 228+8+10, 230, 10)];
            kjTime124.backgroundColor = [UIColor clearColor];
            kjTime124.text = @"“负负”即上半场主队负,全场主队负。";
            kjTime124.font = [UIFont systemFontOfSize:10];
            kjTime124.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime124];
            [kjTime124 release];
            
            
            
            UILabel *kjTime6 = [[UILabel alloc] initWithFrame:CGRectMake(27, 252+8+10, 30, 10)];
            kjTime6.backgroundColor = [UIColor clearColor];
            kjTime6.text = @"单关:";
            kjTime6.font = [UIFont boldSystemFontOfSize:10];
            kjTime6.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime6];
            [kjTime6 release];
            
            UILabel *kjTime7 = [[UILabel alloc] initWithFrame:CGRectMake(60, 253+8+10, 250, 10)];
            kjTime7.backgroundColor = [UIColor clearColor];
            kjTime7.text = @"任意选择 1 场或多场比赛投注（1 场比赛可投注多种";
            kjTime7.font = [UIFont systemFontOfSize:10];
            kjTime7.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime7];
            [kjTime7 release];
            UILabel *kjTime71 = [[UILabel alloc] initWithFrame:CGRectMake(60, 271+8+10, 230, 10)];
            kjTime71.backgroundColor = [UIColor clearColor];
            kjTime71.text = @"比赛结果），每个比赛结果构成 1 注。";
            kjTime71.font = [UIFont systemFontOfSize:10];
            kjTime71.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime71];
            [kjTime71 release];
            
            
            UILabel *kjTime8 = [[UILabel alloc] initWithFrame:CGRectMake(27, 296+8+10, 30, 10)];
            kjTime8.backgroundColor = [UIColor clearColor];
            kjTime8.text = @"过关:";
            kjTime8.font = [UIFont boldSystemFontOfSize:10];
            kjTime8.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime8];
            [kjTime8 release];
            
            UILabel *kjTime9 = [[UILabel alloc] initWithFrame:CGRectMake(60, 297+8+10, 266, 10)];
            kjTime9.backgroundColor = [UIColor clearColor];
            kjTime9.text = @"选择 2 场（或以上）比赛进行投注。";
            kjTime9.font = [UIFont systemFontOfSize:10];
            kjTime9.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime9];
            [kjTime9 release];
            
            [self jiangJin:backScrollView y:307+15+8];
        
        }else if (ALLWANFA == bdbifen){
            UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            titleV.backgroundColor = [UIColor clearColor];
            titleV.userInteractionEnabled = YES;
            
            UILabel *nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 55, 44)];
            nameLable2.backgroundColor = [UIColor clearColor];
            nameLable2.textColor = [UIColor whiteColor];
            nameLable2.text = @"单场";
            nameLable2.shadowColor = [UIColor blackColor];
            nameLable2.shadowOffset = CGSizeMake(0.0f, 1.0f);
            nameLable2.font = [UIFont boldSystemFontOfSize:20];
            nameLable2.textAlignment = NSTextAlignmentRight;
            [titleV addSubview:nameLable2];
            [nameLable2 release];
            
            
            UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(137+28, 0, 80, 44)];
            nameLable.backgroundColor = [UIColor clearColor];
            nameLable.textColor = [UIColor whiteColor];
            nameLable.text = @"比分";
            nameLable.shadowColor = [UIColor blackColor];
            nameLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
            nameLable.font = [UIFont boldSystemFontOfSize:15];
            nameLable.textAlignment = NSTextAlignmentLeft;
            [titleV addSubview:nameLable];
            self.CP_navigation.titleView = titleV;
            [titleV release];
            [nameLable release];

            UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
            backScrollView.userInteractionEnabled = YES;
            [backScrollView setContentSize:CGSizeMake(320, 600)];
            if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
                backScrollView.scrollEnabled = NO;
            }
            [self.mainView addSubview:backScrollView];
            [backScrollView release];
            
            
            UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
            kjTime.backgroundColor = [UIColor clearColor];
            kjTime.text = @"玩法规则";
            kjTime.font = [UIFont boldSystemFontOfSize:15];
            [backScrollView addSubview:kjTime];
            [kjTime release];
            
            UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 43, 266, 10)];
            kjTime2.backgroundColor = [UIColor clearColor];
            kjTime2.text = @"竞猜某场比赛,对该场比赛在全场90分钟(含伤停补时)正确";
            kjTime2.font = [UIFont boldSystemFontOfSize:10];
            kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime2];
            [kjTime2 release];
            UILabel *kjTime21 = [[UILabel alloc] initWithFrame:CGRectMake(27, 61, 266, 10)];
            kjTime21.backgroundColor = [UIColor clearColor];
            kjTime21.text = @"预测比赛双方各自的进球数量。";
            kjTime21.font = [UIFont boldSystemFontOfSize:10];
            kjTime21.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime21];
            [kjTime21 release];
            
            UILabel *kjTime1 = [[UILabel alloc] initWithFrame:CGRectMake(27, 81, 50, 12)];
            kjTime1.backgroundColor = [UIColor clearColor];
            kjTime1.text = @" 主 胜 ";
            kjTime1.font = [UIFont boldSystemFontOfSize:12];
            kjTime1.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime1];
            [kjTime1 release];
            
            UILabel *kjTime5 = [[UILabel alloc] initWithFrame:CGRectMake(79, 82, 230, 10)];
            kjTime5.backgroundColor = [UIColor clearColor];
            kjTime5.text = @"“ 1:0 ”、“ 2:0 ”、“ 2:1 ”、“ 3:0 ”、“ 3:1”";
            kjTime5.font = [UIFont systemFontOfSize:10];
            kjTime5.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime5];
            [kjTime5 release];
            UILabel *kjTime51 = [[UILabel alloc] initWithFrame:CGRectMake(79, 100, 230, 10)];
            kjTime51.backgroundColor = [UIColor clearColor];
            kjTime51.text = @" 3:2 ”、“ 4:0 ”、“ 4:1 ”、“ 4:2 ”、以及 “胜其它";
            kjTime51.font = [UIFont systemFontOfSize:10];
            kjTime51.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime51];
            [kjTime51 release];

            UILabel *kjTime53 = [[UILabel alloc] initWithFrame:CGRectMake(79, 118, 230, 10)];
            kjTime53.backgroundColor = [UIColor clearColor];
            kjTime53.text = @"(胜其他:除去上诉比分外,主队获胜的其他 比";
            kjTime53.font = [UIFont systemFontOfSize:10];
            kjTime53.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime53];
            [kjTime53 release];
            UILabel *kjTime54 = [[UILabel alloc] initWithFrame:CGRectMake(79, 136, 230, 10)];
            kjTime54.backgroundColor = [UIColor clearColor];
            kjTime54.text = @"分,如”5:3“或”6:1“)。";
            kjTime54.font = [UIFont systemFontOfSize:10];
            kjTime54.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime54];
            [kjTime54 release];
            
            UILabel *kjTime11 = [[UILabel alloc] initWithFrame:CGRectMake(27, 161, 50, 12)];
            kjTime11.backgroundColor = [UIColor clearColor];
            kjTime11.text = @" 平 局 ";
            kjTime11.font = [UIFont boldSystemFontOfSize:12];
            kjTime11.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime11];
            [kjTime11 release];
            
            UILabel *kjTime12 = [[UILabel alloc] initWithFrame:CGRectMake(79, 162, 230, 10)];
            kjTime12.backgroundColor = [UIColor clearColor];
            kjTime12.text = @"“ 0:0 ”、“ 1:1 ”、“ 2:2 ”、“ 3:3 ”以及 “平";
            kjTime12.font = [UIFont systemFontOfSize:10];
            kjTime12.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime12];
            [kjTime12 release];
            UILabel *kjTime121 = [[UILabel alloc] initWithFrame:CGRectMake(79, 180, 230, 10)];
            kjTime121.backgroundColor = [UIColor clearColor];
            kjTime121.text = @"其它”";
            kjTime121.font = [UIFont systemFontOfSize:10];
            kjTime121.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime121];
            [kjTime121 release];
            UILabel *kjTime122 = [[UILabel alloc] initWithFrame:CGRectMake(79, 198, 230, 10)];
            kjTime122.backgroundColor = [UIColor clearColor];
            kjTime122.text = @"(平其它:除了上述比分外,主客队打平的 其他";
            kjTime122.font = [UIFont systemFontOfSize:10];
            kjTime122.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime122];
            [kjTime122 release];
            UILabel *kjTime123 = [[UILabel alloc] initWithFrame:CGRectMake(79, 216, 230, 10)];
            kjTime123.backgroundColor = [UIColor clearColor];
            kjTime123.text = @"比分,如“4:4”)。";
            kjTime123.font = [UIFont systemFontOfSize:10];
            kjTime123.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime123];
            [kjTime123 release];
            
            UILabel *kjTime13 = [[UILabel alloc] initWithFrame:CGRectMake(27, 241, 50, 12)];
            kjTime13.backgroundColor = [UIColor clearColor];
            kjTime13.text = @" 客 胜 ";
            kjTime13.font = [UIFont boldSystemFontOfSize:12];
            kjTime13.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime13];
            [kjTime13 release];
            
            UILabel *kjTime14 = [[UILabel alloc] initWithFrame:CGRectMake(79, 242, 230, 10)];
            kjTime14.backgroundColor = [UIColor clearColor];
            kjTime14.text = @"“ 0:1 ”、“ 0:2 ”、“ 1:2 ”、“ 0:3 ”、“ 1:3 ”、";
            kjTime14.font = [UIFont systemFontOfSize:10];
            kjTime14.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime14];
            [kjTime14 release];
            UILabel *kjTime15 = [[UILabel alloc] initWithFrame:CGRectMake(79, 260, 230, 10)];
            kjTime15.backgroundColor = [UIColor clearColor];
            kjTime15.text = @"“ 2:3 ”、“ 0:4 ”、“ 1:4 ”、“ 2:4 ”、“ 0:5 ” 以及";
            kjTime15.font = [UIFont systemFontOfSize:10];
            kjTime15.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime15];
            [kjTime15 release];

            UILabel *kjTime17 = [[UILabel alloc] initWithFrame:CGRectMake(79, 278, 230, 10)];
            kjTime17.backgroundColor = [UIColor clearColor];
            kjTime17.text = @"“负其它”(负其它:除去上述比分以外,主队落败的";
            kjTime17.font = [UIFont systemFontOfSize:10];
            kjTime17.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime17];
            [kjTime17 release];
            UILabel *kjTime18 = [[UILabel alloc] initWithFrame:CGRectMake(79, 296, 230, 10)];
            kjTime18.backgroundColor = [UIColor clearColor];
            kjTime18.text = @"其它比分,如“4:5”或“0:8”)。";
            kjTime18.font = [UIFont systemFontOfSize:10];
            kjTime18.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime18];
            [kjTime18 release];
            
            UILabel *kjTime6 = [[UILabel alloc] initWithFrame:CGRectMake(27, 321, 30, 10)];
            kjTime6.backgroundColor = [UIColor clearColor];
            kjTime6.text = @"单关:";
            kjTime6.font = [UIFont boldSystemFontOfSize:10];
            kjTime6.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime6];
            [kjTime6 release];
            
            UILabel *kjTime7 = [[UILabel alloc] initWithFrame:CGRectMake(60, 322, 250, 10)];
            kjTime7.backgroundColor = [UIColor clearColor];
            kjTime7.text = @"任意选择 1 场或多场比赛投注（1 场比赛可投注多种";
            kjTime7.font = [UIFont systemFontOfSize:10];
            kjTime7.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime7];
            [kjTime7 release];
            UILabel *kjTime71 = [[UILabel alloc] initWithFrame:CGRectMake(60, 340, 230, 10)];
            kjTime71.backgroundColor = [UIColor clearColor];
            kjTime71.text = @"比赛结果），每个比赛结果构成 1 注。";
            kjTime71.font = [UIFont systemFontOfSize:10];
            kjTime71.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime71];
            [kjTime71 release];
            
            
            UILabel *kjTime8 = [[UILabel alloc] initWithFrame:CGRectMake(27, 365, 30, 10)];
            kjTime8.backgroundColor = [UIColor clearColor];
            kjTime8.text = @"过关:";
            kjTime8.font = [UIFont boldSystemFontOfSize:10];
            kjTime8.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime8];
            [kjTime8 release];
            
            UILabel *kjTime9 = [[UILabel alloc] initWithFrame:CGRectMake(60, 366, 266, 10)];
            kjTime9.backgroundColor = [UIColor clearColor];
            kjTime9.text = @"选择 2 场（或以上）比赛进行投注。";
            kjTime9.font = [UIFont systemFontOfSize:10];
            kjTime9.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime9];
            [kjTime9 release];
            
            [self jiangJin:backScrollView y:376+15];

        }else if (ALLWANFA == bdshangxiadanshuang){
            UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            titleV.backgroundColor = [UIColor clearColor];
            titleV.userInteractionEnabled = YES;
            
            UILabel *nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 55, 44)];
            nameLable2.backgroundColor = [UIColor clearColor];
            nameLable2.textColor = [UIColor whiteColor];
            nameLable2.text = @"单场";
            nameLable2.shadowColor = [UIColor blackColor];
            nameLable2.shadowOffset = CGSizeMake(0.0f, 1.0f);
            nameLable2.font = [UIFont boldSystemFontOfSize:20];
            nameLable2.textAlignment = NSTextAlignmentRight;
            [titleV addSubview:nameLable2];
            [nameLable2 release];
            
            
            UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(137+28, 0, 80, 44)];
            nameLable.backgroundColor = [UIColor clearColor];
            nameLable.textColor = [UIColor whiteColor];
            nameLable.text = @"上下单双";
            nameLable.shadowColor = [UIColor blackColor];
            nameLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
            nameLable.font = [UIFont boldSystemFontOfSize:15];
            nameLable.textAlignment = NSTextAlignmentLeft;
            [titleV addSubview:nameLable];
            self.CP_navigation.titleView = titleV;
            [titleV release];
            [nameLable release];
            
            UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
            backScrollView.userInteractionEnabled = YES;
            [backScrollView setContentSize:CGSizeMake(320, 600)];
            if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
                backScrollView.scrollEnabled = NO;
            }
            [self.mainView addSubview:backScrollView];
            [backScrollView release];
            
            
            UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
            kjTime.backgroundColor = [UIColor clearColor];
            kjTime.text = @"玩法规则";
            kjTime.font = [UIFont boldSystemFontOfSize:15];
            [backScrollView addSubview:kjTime];
            [kjTime release];
            
            UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 43, 266, 10)];
            kjTime2.backgroundColor = [UIColor clearColor];
            kjTime2.text = @"竞猜某场比赛,对该场比赛在全场90分钟(含伤停 补时)同时正";
            kjTime2.font = [UIFont boldSystemFontOfSize:10];
            kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime2];
            [kjTime2 release];
            UILabel *kjTime21 = [[UILabel alloc] initWithFrame:CGRectMake(27, 61, 266, 10)];
            kjTime21.backgroundColor = [UIColor clearColor];
            kjTime21.text = @"确预测比赛的进球数量之和是否大于等 于3球以及进球数之";
            kjTime21.font = [UIFont boldSystemFontOfSize:10];
            kjTime21.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime21];
            [kjTime21 release];
            
            UILabel *kjTime22 = [[UILabel alloc] initWithFrame:CGRectMake(27, 79, 266, 10)];
            kjTime22.backgroundColor = [UIColor clearColor];
            kjTime22.text = @"和的奇偶数。";
            kjTime22.font = [UIFont boldSystemFontOfSize:10];
            kjTime22.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime22];
            [kjTime22 release];
            
            UILabel *jjfd = [[UILabel alloc] initWithFrame:CGRectMake(27, 104, 220, 13)];
            jjfd.backgroundColor = [UIColor clearColor];
            jjfd.text = @"共有4个投注选项:";
            jjfd.font = [UIFont boldSystemFontOfSize:13];
            jjfd.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:jjfd];
            [jjfd release];
            
            UILabel *kjTime5 = [[UILabel alloc] initWithFrame:CGRectMake(40, 125, 230, 10)];
            kjTime5.backgroundColor = [UIColor clearColor];
            kjTime5.text = @"上单 上盘+单数";
            kjTime5.font = [UIFont systemFontOfSize:10];
            kjTime5.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime5];
            [kjTime5 release];
            UILabel *kjTime51 = [[UILabel alloc] initWithFrame:CGRectMake(40, 143, 230, 10)];
            kjTime51.backgroundColor = [UIColor clearColor];
            kjTime51.text = @"上双 上盘+双数";
            kjTime51.font = [UIFont systemFontOfSize:10];
            kjTime51.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime51];
            [kjTime51 release];
            
            UILabel *kjTime53 = [[UILabel alloc] initWithFrame:CGRectMake(40, 161, 230, 10)];
            kjTime53.backgroundColor = [UIColor clearColor];
            kjTime53.text = @"下单 下盘+单数";
            kjTime53.font = [UIFont systemFontOfSize:10];
            kjTime53.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime53];
            [kjTime53 release];
            UILabel *kjTime54 = [[UILabel alloc] initWithFrame:CGRectMake(40, 179, 230, 10)];
            kjTime54.backgroundColor = [UIColor clearColor];
            kjTime54.text = @"下双 下盘+双数";
            kjTime54.font = [UIFont systemFontOfSize:10];
            kjTime54.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime54];
            [kjTime54 release];
            
            UILabel *kjTime66 = [[UILabel alloc] initWithFrame:CGRectMake(27, 204, 30, 10)];
            kjTime66.backgroundColor = [UIColor clearColor];
            kjTime66.text = @"上盘:";
            kjTime66.font = [UIFont boldSystemFontOfSize:10];
            kjTime66.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime66];
            [kjTime66 release];
            
            UILabel *kjTime77 = [[UILabel alloc] initWithFrame:CGRectMake(60, 205, 250, 10)];
            kjTime77.backgroundColor = [UIColor clearColor];
            kjTime77.text = @"主队和客队的进球数之和大于等于3个, 称为上盘,俗";
            kjTime77.font = [UIFont systemFontOfSize:10];
            kjTime77.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime77];
            [kjTime77 release];
            
            UILabel *kjTime78 = [[UILabel alloc] initWithFrame:CGRectMake(60, 224, 250, 10)];
            kjTime78.backgroundColor = [UIColor clearColor];
            kjTime78.text = @"称大球。";
            kjTime78.font = [UIFont systemFontOfSize:10];
            kjTime78.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime78];
            [kjTime78 release];
            
            
            UILabel *kjTime67 = [[UILabel alloc] initWithFrame:CGRectMake(27, 249-7, 30, 10)];
            kjTime67.backgroundColor = [UIColor clearColor];
            kjTime67.text = @"下盘:";
            kjTime67.font = [UIFont boldSystemFontOfSize:10];
            kjTime67.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime67];
            [kjTime67 release];
            
            UILabel *kjTime79 = [[UILabel alloc] initWithFrame:CGRectMake(60, 250-7, 250, 10)];
            kjTime79.backgroundColor = [UIColor clearColor];
            kjTime79.text = @"主队和客队的进球数之和小于3个,称为 下盘,俗";
            kjTime79.font = [UIFont systemFontOfSize:10];
            kjTime79.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime79];
            [kjTime79 release];
            
            UILabel *kjTime80 = [[UILabel alloc] initWithFrame:CGRectMake(60, 268-7, 250, 10)];
            kjTime80.backgroundColor = [UIColor clearColor];
            kjTime80.text = @"称小球;";
            kjTime80.font = [UIFont systemFontOfSize:10];
            kjTime80.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime80];
            [kjTime80 release];
            
            
            UILabel *kjTime661 = [[UILabel alloc] initWithFrame:CGRectMake(27, 293-7, 30, 10)];
            kjTime661.backgroundColor = [UIColor clearColor];
            kjTime661.text = @"单数:";
            kjTime661.font = [UIFont boldSystemFontOfSize:10];
            kjTime661.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime661];
            [kjTime661 release];
            
            UILabel *kjTime771 = [[UILabel alloc] initWithFrame:CGRectMake(60, 294-7, 250, 10)];
            kjTime771.backgroundColor = [UIColor clearColor];
            kjTime771.text = @"主客队进球数之和是奇数。";
            kjTime771.font = [UIFont systemFontOfSize:10];
            kjTime771.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime771];
            [kjTime771 release];
            
            UILabel *kjTime662 = [[UILabel alloc] initWithFrame:CGRectMake(27, 312-7, 30, 10)];
            kjTime662.backgroundColor = [UIColor clearColor];
            kjTime662.text = @"双数:";
            kjTime662.font = [UIFont boldSystemFontOfSize:10];
            kjTime662.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime662];
            [kjTime662 release];
            
            UILabel *kjTime772 = [[UILabel alloc] initWithFrame:CGRectMake(60, 313-7, 250, 10)];
            kjTime772.backgroundColor = [UIColor clearColor];
            kjTime772.text = @"主客队进球数之和是偶数。";
            kjTime772.font = [UIFont systemFontOfSize:10];
            kjTime772.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime772];
            [kjTime772 release];
            
            
            UILabel *kjTime6 = [[UILabel alloc] initWithFrame:CGRectMake(27, 338-7, 30, 10)];
            kjTime6.backgroundColor = [UIColor clearColor];
            kjTime6.text = @"单关:";
            kjTime6.font = [UIFont boldSystemFontOfSize:10];
            kjTime6.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime6];
            [kjTime6 release];
            
            UILabel *kjTime7 = [[UILabel alloc] initWithFrame:CGRectMake(60, 339-7, 250, 10)];
            kjTime7.backgroundColor = [UIColor clearColor];
            kjTime7.text = @"任意选择 1 场或多场比赛投注（1 场比赛可投注多种";
            kjTime7.font = [UIFont systemFontOfSize:10];
            kjTime7.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime7];
            [kjTime7 release];
            UILabel *kjTime71 = [[UILabel alloc] initWithFrame:CGRectMake(60, 357-7, 230, 10)];
            kjTime71.backgroundColor = [UIColor clearColor];
            kjTime71.text = @"比赛结果），每个比赛结果构成 1 注。";
            kjTime71.font = [UIFont systemFontOfSize:10];
            kjTime71.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime71];
            [kjTime71 release];
            
            
            UILabel *kjTime8 = [[UILabel alloc] initWithFrame:CGRectMake(27, 382-14, 30, 10)];
            kjTime8.backgroundColor = [UIColor clearColor];
            kjTime8.text = @"过关:";
            kjTime8.font = [UIFont boldSystemFontOfSize:10];
            kjTime8.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime8];
            [kjTime8 release];
            
            UILabel *kjTime9 = [[UILabel alloc] initWithFrame:CGRectMake(60, 383-14, 266, 10)];
            kjTime9.backgroundColor = [UIColor clearColor];
            kjTime9.text = @"选择 2 场（或以上）比赛进行投注。";
            kjTime9.font = [UIFont systemFontOfSize:10];
            kjTime9.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime9];
            [kjTime9 release];
            
            
             [self jiangJin:backScrollView y:393+1];
            
        }else if (ALLWANFA == beidanshengfu){
        
            UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
            backScrollView.userInteractionEnabled = YES;
            [backScrollView setContentSize:CGSizeMake(320, 500)];
            if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
                backScrollView.scrollEnabled = NO;
            }
            [self.mainView addSubview:backScrollView];
            [backScrollView release];
            
            
            UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            titleV.backgroundColor = [UIColor clearColor];
            titleV.userInteractionEnabled = YES;
            
            UILabel *nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 80, 44)];
            nameLable2.backgroundColor = [UIColor clearColor];
            nameLable2.textColor = [UIColor whiteColor];
            nameLable2.text = @"北京单场";
            nameLable2.shadowColor = [UIColor blackColor];
            nameLable2.shadowOffset = CGSizeMake(0.0f, 1.0f);
            nameLable2.font = [UIFont boldSystemFontOfSize:20];
            //nameLable2.textAlignment = NSTextAlignmentRight;
            [titleV addSubview:nameLable2];
            [nameLable2 release];
            
            
            UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(150, 2, 80, 44)];
            nameLable.backgroundColor = [UIColor clearColor];
            nameLable.textColor = [UIColor whiteColor];
            nameLable.text = @"胜负过关";
            nameLable.shadowColor = [UIColor blackColor];
            nameLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
            nameLable.font = [UIFont boldSystemFontOfSize:15];
            nameLable.textAlignment = NSTextAlignmentRight;
            [titleV addSubview:nameLable];
            self.CP_navigation.titleView = titleV;
            [titleV release];
            [nameLable release];
            
            UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
            kjTime.backgroundColor = [UIColor clearColor];
            kjTime.text = @"玩法规则";
            kjTime.font = [UIFont boldSystemFontOfSize:15];
            [backScrollView addSubview:kjTime];
            [kjTime release];
            
            UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 43, 286, 10)];
            kjTime2.backgroundColor = [UIColor clearColor];
            kjTime2.text = @"单场胜负过关游戏竞猜对象,包括足球、篮球、网球、橄榄";
            kjTime2.font = [UIFont boldSystemFontOfSize:10];
            kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime2];
            [kjTime2 release];
            UILabel *kjTime21 = [[UILabel alloc] initWithFrame:CGRectMake(27, 61, 286, 10)];
            kjTime21.backgroundColor = [UIColor clearColor];
            kjTime21.text = @"球、排球、羽毛球、乒乓球、沙滩排球、 冰球、曲棍球、手";
            kjTime21.font = [UIFont boldSystemFontOfSize:10];
            kjTime21.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime21];
            [kjTime21 release];
            UILabel *kjTime22 = [[UILabel alloc] initWithFrame:CGRectMake(27, 79, 286, 10)];
            kjTime22.backgroundColor = [UIColor clearColor];
            kjTime22.text = @"球、水球比赛。所竞猜的比赛根 据赛事特点确定比赛结果。";
            kjTime22.font = [UIFont boldSystemFontOfSize:10];
            kjTime22.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime22];
            [kjTime22 release];
            UILabel *kjTime23 = [[UILabel alloc] initWithFrame:CGRectMake(27, 97+10, 286, 10)];
            kjTime23.backgroundColor = [UIColor clearColor];
            kjTime23.text = @"网球、排球、羽毛球、乒乓球、沙滩排球比赛为全场 比赛结果。";
            kjTime23.font = [UIFont boldSystemFontOfSize:10];
            kjTime23.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime23];
            [kjTime23 release];
            UILabel *kjTime24 = [[UILabel alloc] initWithFrame:CGRectMake(27, 115+20, 286, 10)];
            kjTime24.backgroundColor = [UIColor clearColor];
            kjTime24.text = @"足球、手球、曲棍球、水球、冰球比赛为全场常规时 间(含伤停";
            kjTime24.font = [UIFont boldSystemFontOfSize:10];
            kjTime24.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime24];
            [kjTime24 release];
            UILabel *kjTime25 = [[UILabel alloc] initWithFrame:CGRectMake(27, 133+20, 266, 10)];
            kjTime25.backgroundColor = [UIColor clearColor];
            kjTime25.text = @"补时,不含加时赛及点球)的比赛结果。";
            kjTime25.font = [UIFont boldSystemFontOfSize:10];
            kjTime25.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime25];
            [kjTime25 release];
            
            UILabel *kjTime26 = [[UILabel alloc] initWithFrame:CGRectMake(27, 151+30, 266, 10)];
            kjTime26.backgroundColor = [UIColor clearColor];
            kjTime26.text = @"篮球、橄榄球比赛为全场(含加时赛)的比赛结果。";
            kjTime26.font = [UIFont boldSystemFontOfSize:10];
            kjTime26.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime26];
            [kjTime26 release];
            
            UILabel *kjTime27 = [[UILabel alloc] initWithFrame:CGRectMake(27, 169+40, 266, 10)];
            kjTime27.backgroundColor = [UIColor clearColor];
            kjTime27.text = @"一次最少投注3场最多投注15场比赛。最多可以设14个胆。";
            kjTime27.font = [UIFont boldSystemFontOfSize:10];
            kjTime27.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime27];
            [kjTime27 release];
            
            
            
            [self jiangJin:backScrollView y:257];
        
        }else{
            
            UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
            backScrollView.userInteractionEnabled = YES;
            [backScrollView setContentSize:CGSizeMake(320, 500)];
            if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
                backScrollView.scrollEnabled = NO;
            }
            [self.mainView addSubview:backScrollView];
            [backScrollView release];
            
            
            UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            titleV.backgroundColor = [UIColor clearColor];
            titleV.userInteractionEnabled = YES;
            
            UILabel *nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 80, 44)];
            nameLable2.backgroundColor = [UIColor clearColor];
            nameLable2.textColor = [UIColor whiteColor];
            nameLable2.text = @"北京单场";
            nameLable2.shadowColor = [UIColor blackColor];
            nameLable2.shadowOffset = CGSizeMake(0.0f, 1.0f);
            nameLable2.font = [UIFont boldSystemFontOfSize:20];
            //nameLable2.textAlignment = NSTextAlignmentRight;
            [titleV addSubview:nameLable2];
            [nameLable2 release];
            
            
            UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(163, 0, 80, 44)];
            nameLable.backgroundColor = [UIColor clearColor];
            nameLable.textColor = [UIColor whiteColor];
            nameLable.text = @"让球胜平负";
            nameLable.shadowColor = [UIColor blackColor];
            nameLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
            nameLable.font = [UIFont boldSystemFontOfSize:15];
            nameLable.textAlignment = NSTextAlignmentRight;
            [titleV addSubview:nameLable];
            self.CP_navigation.titleView = titleV;
            [titleV release];
            [nameLable release];
            
            UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
            kjTime.backgroundColor = [UIColor clearColor];
            kjTime.text = @"玩法规则";
            kjTime.font = [UIFont boldSystemFontOfSize:15];
            [backScrollView addSubview:kjTime];
            [kjTime release];
            
            UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 43, 266, 10)];
            kjTime2.backgroundColor = [UIColor clearColor];
            kjTime2.text = @"竞猜某场比赛，对主队在全场 90 分钟(含伤停补时)的 “胜“";
            kjTime2.font = [UIFont boldSystemFontOfSize:10];
            kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime2];
            [kjTime2 release];
            UILabel *kjTime21 = [[UILabel alloc] initWithFrame:CGRectMake(27, 61, 266, 10)];
            kjTime21.backgroundColor = [UIColor clearColor];
            kjTime21.text = @"“平”、“负” 结果进行投注。竞猜胜平负时用 3、1、0 分别";
            kjTime21.font = [UIFont boldSystemFontOfSize:10];
            kjTime21.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime21];
            [kjTime21 release];
            UILabel *kjTime22 = [[UILabel alloc] initWithFrame:CGRectMake(27, 79, 266, 10)];
            kjTime22.backgroundColor = [UIColor clearColor];
            kjTime22.text = @"代表主队胜、主客战平和主队负。";
            kjTime22.font = [UIFont boldSystemFontOfSize:10];
            kjTime22.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime22];
            [kjTime22 release];
            UILabel *kjTime23 = [[UILabel alloc] initWithFrame:CGRectMake(27, 97, 286, 10)];
            kjTime23.backgroundColor = [UIColor clearColor];
            kjTime23.text = @"当两支球队实力悬殊较大时，采取让球的方式确定双方的胜平";
            kjTime23.font = [UIFont boldSystemFontOfSize:10];
            kjTime23.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime23];
            [kjTime23 release];
            UILabel *kjTime24 = [[UILabel alloc] initWithFrame:CGRectMake(27, 115, 266, 10)];
            kjTime24.backgroundColor = [UIColor clearColor];
            kjTime24.text = @"负关系。让球的数量确定后将维持不变。";
            kjTime24.font = [UIFont boldSystemFontOfSize:10];
            kjTime24.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime24];
            [kjTime24 release];
            
            
            UILabel *jjfd = [[UILabel alloc] initWithFrame:CGRectMake(27, 150, 110, 12)];
            jjfd.backgroundColor = [UIColor clearColor];
            jjfd.text = @"例：曼联（主队）";
            jjfd.font = [UIFont boldSystemFontOfSize:12];
            jjfd.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:jjfd];
            [jjfd release];
            
            UILabel *jjfd2 = [[UILabel alloc] initWithFrame:CGRectMake(125, 151, 20, 10)];
            jjfd2.backgroundColor = [UIColor clearColor];
            jjfd2.text = @"-2";
            jjfd2.font = [UIFont boldSystemFontOfSize:10];
            jjfd2.textColor = [UIColor redColor];
            [backScrollView addSubview:jjfd2];
            [jjfd2 release];
            
            UILabel *jjfd3 = [[UILabel alloc] initWithFrame:CGRectMake(143, 150, 120, 12)];
            jjfd3.backgroundColor = [UIColor clearColor];
            jjfd3.text = @"VS 利物浦（客队）";
            jjfd3.font = [UIFont boldSystemFontOfSize:12];
            jjfd3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:jjfd3];
            [jjfd3 release];
            
            UILabel *qb1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 170, 250, 10)];
            qb1.backgroundColor = [UIColor clearColor];
            qb1.text = @"曼联 3 ： 0 利物浦  主队胜  选择 ”胜“ 中奖";
            qb1.font = [UIFont systemFontOfSize:10];
            qb1.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:qb1];
            [qb1 release];
            
            UILabel *qb2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 188, 250, 10)];
            qb2.backgroundColor = [UIColor clearColor];
            qb2.text = @"曼联 2 ： 0 利物浦  平局     选择 ”平“ 中奖";
            qb2.font = [UIFont systemFontOfSize:10];
            qb2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:qb2];
            [qb2 release];
            
            UILabel *qb3 = [[UILabel alloc] initWithFrame:CGRectMake(50, 207, 250, 10)];
            qb3.backgroundColor = [UIColor clearColor];
            qb3.text = @"曼联 1 ： 0 利物浦  主队负  选择 ”负“ 中奖";
            qb3.font = [UIFont systemFontOfSize:10];
            qb3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:qb3];
            [qb3 release];
            
            [self jiangJin:backScrollView y:217];
        
        }
        
        
        
        
        

    }
    else if (ALLWANFA == JingCaiZuQiu || ALLWANFA == huntou ) {
    
        UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        titleV.backgroundColor = [UIColor clearColor];
        titleV.userInteractionEnabled = YES;
        
        UILabel *nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 80, 44)];
        nameLable2.backgroundColor = [UIColor clearColor];
        nameLable2.textColor = [UIColor whiteColor];
        nameLable2.text = @"竞彩足球";
        nameLable2.shadowColor = [UIColor blackColor];
        nameLable2.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable2.font = [UIFont boldSystemFontOfSize:20];
        [titleV addSubview:nameLable2];
        [nameLable2 release];
        
        
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(152, 0, 80, 44)];
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.textColor = [UIColor whiteColor];
        if (ALLWANFA == huntou) {
            nameLable2.frame = CGRectMake(85, 0, 80, 44);
            nameLable.text = @"胜平负混合";
            nameLable.frame=  CGRectMake(160, 0, 84, 44);
        }else if (ALLWANFA == hunTouErXuanYi ){
            nameLable.text = @"混合二选一";
            nameLable2.frame = CGRectMake(85, 0, 80, 44);
            nameLable.frame=  CGRectMake(160, 0, 84, 44);
        }else{
            nameLable.text = @"胜平负";
        }
        
        nameLable.shadowColor = [UIColor blackColor];
        nameLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable.font = [UIFont boldSystemFontOfSize:15];
        nameLable.textAlignment = NSTextAlignmentRight;
        [titleV addSubview:nameLable];
        self.CP_navigation.titleView = titleV;
        [titleV release];
        [nameLable release];
        
        caizhongJQ = jincaizuqiu;
        
        UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
        backScrollView.userInteractionEnabled = YES;
        [backScrollView setContentSize:CGSizeMake(320, 600)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];

        UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
        kjTime.backgroundColor = [UIColor clearColor];
        kjTime.text = @"开奖时间";
        kjTime.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime];
        [kjTime release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 48, 280, 12)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @"每周一至周五 9:00 - 23:40  周六/日 9:00 - 00:40";
        kjTime2.font = [UIFont boldSystemFontOfSize:12];
        kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime2];
        [kjTime2 release];
        
        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 73, 300, 2)];
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = UIImageGetImageFromName(@"SZTG960.png") ;
        [backScrollView addSubview:xian];
        [xian release];
        
        UILabel *kjTime4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 88, 125, 15)];
        kjTime4.backgroundColor = [UIColor clearColor];
        kjTime4.text = @"玩法规则";
        kjTime4.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime4];
        [kjTime4 release];
        
        UILabel *kjTime3 = [[UILabel alloc] initWithFrame:CGRectMake(27, 116, 266, 10)];
        kjTime3.backgroundColor = [UIColor clearColor];
        kjTime3.text = @"竞猜某场比赛，对主队在全场 90 分钟(含伤停补时)的 “胜“";
        kjTime3.font = [UIFont systemFontOfSize:10];
        kjTime3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime3];
        [kjTime3 release];
        UILabel *kjTime31 = [[UILabel alloc] initWithFrame:CGRectMake(27, 134, 266, 10)];
        kjTime31.backgroundColor = [UIColor clearColor];
        kjTime31.text = @"“平”、“负” 结果进行投注。竞猜胜平负时用 3、1、0 分别代";
        kjTime31.font = [UIFont systemFontOfSize:10];
        kjTime31.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime31];
        [kjTime31 release];
        UILabel *kjTime333 = [[UILabel alloc] initWithFrame:CGRectMake(27, 152, 266, 10)];
        kjTime333.backgroundColor = [UIColor clearColor];
        kjTime333.text = @"表主队胜、主客战平和主队负。";
        kjTime333.font = [UIFont systemFontOfSize:10];
        kjTime333.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime333];
        [kjTime333 release];
        
        
        UILabel *jjfd = [[UILabel alloc] initWithFrame:CGRectMake(27, 187, 220, 13)];
        jjfd.backgroundColor = [UIColor clearColor];
        jjfd.text = @"例：曼联（主队）VS 利物浦（客队）";
        jjfd.font = [UIFont boldSystemFontOfSize:13];
        jjfd.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd];
        [jjfd release];
        
        UILabel *qb1 = [[UILabel alloc] initWithFrame:CGRectMake(53, 206, 250, 10)];
        qb1.backgroundColor = [UIColor clearColor];
        qb1.text = @"曼联 3 ： 0 利物浦  主队胜  选择 ”胜“ 中奖";
        qb1.font = [UIFont systemFontOfSize:10];
        qb1.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb1];
        [qb1 release];
        
        UILabel *qb2 = [[UILabel alloc] initWithFrame:CGRectMake(53, 224, 250, 10)];
        qb2.backgroundColor = [UIColor clearColor];
        qb2.text = @"曼联 1 ： 1 利物浦  平局     选择 ”平“ 中奖";
        qb2.font = [UIFont systemFontOfSize:10];
        qb2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb2];
        [qb2 release];
        
        UILabel *qb3 = [[UILabel alloc] initWithFrame:CGRectMake(53, 242, 250, 10)];
        qb3.backgroundColor = [UIColor clearColor];
        qb3.text = @"曼联 0 ： 2 利物浦  主队负  选择 ”负“ 中奖";
        qb3.font = [UIFont systemFontOfSize:10];
        qb3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb3];
        [qb3 release];
        
        
        UILabel *kjTime6 = [[UILabel alloc] initWithFrame:CGRectMake(27, 281, 30, 10)];
        kjTime6.backgroundColor = [UIColor clearColor];
        kjTime6.text = @"单关:";
        kjTime6.font = [UIFont boldSystemFontOfSize:10];
        kjTime6.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime6];
        [kjTime6 release];
        
        UILabel *kjTime7 = [[UILabel alloc] initWithFrame:CGRectMake(60, 281, 230, 10)];
        kjTime7.backgroundColor = [UIColor clearColor];
        kjTime7.text = @"任意选择 1 场或多场比赛投注（1 场比赛可投注多";
        kjTime7.font = [UIFont systemFontOfSize:10];
        kjTime7.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime7];
        [kjTime7 release];
        UILabel *kjTime71 = [[UILabel alloc] initWithFrame:CGRectMake(60, 299, 230, 10)];
        kjTime71.backgroundColor = [UIColor clearColor];
        kjTime71.text = @"种比赛结果），每个比赛结果构成 1 注。";
        kjTime71.font = [UIFont systemFontOfSize:10];
        kjTime71.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime71];
        [kjTime71 release];

        
        UILabel *kjTime8 = [[UILabel alloc] initWithFrame:CGRectMake(27, 320, 30, 10)];
        kjTime8.backgroundColor = [UIColor clearColor];
        kjTime8.text = @"过关:";
        kjTime8.font = [UIFont boldSystemFontOfSize:10];
        kjTime8.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime8];
        [kjTime8 release];
        
        UILabel *kjTime9 = [[UILabel alloc] initWithFrame:CGRectMake(60, 320, 266, 10)];
        kjTime9.backgroundColor = [UIColor clearColor];
        kjTime9.text = @"选择 2 场（或以上）比赛进行投注。";
        kjTime9.font = [UIFont systemFontOfSize:10];
        kjTime9.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime9];
        [kjTime9 release];

        if (ALLWANFA == huntou) {
            UILabel *kjTime10 = [[UILabel alloc] initWithFrame:CGRectMake(27, 359, 60, 10)];
            kjTime10.backgroundColor = [UIColor clearColor];
            kjTime10.text = @"让球胜平负:";
            kjTime10.font = [UIFont boldSystemFontOfSize:10];
            kjTime10.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime10];
            [kjTime10 release];
            
            UILabel *kjTime11 = [[UILabel alloc] initWithFrame:CGRectMake(90, 359, 230, 10)];
            kjTime11.backgroundColor = [UIColor clearColor];
            kjTime11.text = @"与胜平负唯一区别就是存在让球数字。当两支";
            
            kjTime11.font = [UIFont systemFontOfSize:10];
            kjTime11.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime11];
            [kjTime11 release];
            UILabel *kjTime12 = [[UILabel alloc] initWithFrame:CGRectMake(90, 376, 230, 10)];
            kjTime12.backgroundColor = [UIColor clearColor];
            kjTime12.text = @"球队实力悬殊较大时，采取让球的方式确定双";
            kjTime12.font = [UIFont systemFontOfSize:10];
            kjTime12.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime12];
            [kjTime12 release];
            
            UILabel *kjTime13 = [[UILabel alloc] initWithFrame:CGRectMake(90, 393, 230, 10)];
            kjTime13.backgroundColor = [UIColor clearColor];
            kjTime13.text = @"方的胜负关系。让球的数量确定后将维持不变。";
            kjTime13.font = [UIFont systemFontOfSize:10];
            kjTime13.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime13];
            [kjTime13 release];
            
            
            UILabel *kjTime14 = [[UILabel alloc] initWithFrame:CGRectMake(27, 414, 60, 10)];
            kjTime14.backgroundColor = [UIColor clearColor];
            kjTime14.text = @"胜平负混合:";
            kjTime14.font = [UIFont boldSystemFontOfSize:10];
            kjTime14.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime14];
            [kjTime14 release];
            
            UILabel *kjTime15 = [[UILabel alloc] initWithFrame:CGRectMake(90, 414, 266, 10)];
            kjTime15.backgroundColor = [UIColor clearColor];
            kjTime15.text = @"突破玩法界限，可以选择两种玩法混投的方式";
            kjTime15.font = [UIFont systemFontOfSize:10];
            kjTime15.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime15];
            [kjTime15 release];
            
            UILabel *kjTime16 = [[UILabel alloc] initWithFrame:CGRectMake(90, 431, 266, 10)];
            kjTime16.backgroundColor = [UIColor clearColor];
            kjTime16.text = @"进行投注。";
            kjTime16.font = [UIFont systemFontOfSize:10];
            kjTime16.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime16];
            [kjTime16 release];
            
            [self jiangJin:backScrollView y:441];
            
        }else if (ALLWANFA == hunTouErXuanYi){
        
            UILabel *kjTime10 = [[UILabel alloc] initWithFrame:CGRectMake(27, 359, 60, 10)];
            kjTime10.backgroundColor = [UIColor clearColor];
            kjTime10.text = @"混合二选一:";
            kjTime10.font = [UIFont boldSystemFontOfSize:10];
            kjTime10.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime10];
            [kjTime10 release];
            
            UILabel *kjTime11 = [[UILabel alloc] initWithFrame:CGRectMake(90, 359, 230, 10)];
            kjTime11.backgroundColor = [UIColor clearColor];
            kjTime11.text = @"竞彩足球在让(受让)一球的情况下,结合胜平负";
            
            kjTime11.font = [UIFont systemFontOfSize:10];
            kjTime11.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime11];
            [kjTime11 release];

            UILabel *kjTime12 = [[UILabel alloc] initWithFrame:CGRectMake(90, 376, 230, 10)];
            kjTime12.backgroundColor = [UIColor clearColor];
            kjTime12.text = @"及让球胜平负两个玩法进行混合过关的投注方";
            kjTime12.font = [UIFont systemFontOfSize:10];
            kjTime12.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime12];
            [kjTime12 release];
        
            UILabel *kjTime13 = [[UILabel alloc] initWithFrame:CGRectMake(90, 393, 230, 10)];
            kjTime13.backgroundColor = [UIColor clearColor];
            kjTime13.text = @"式。仅用“胜”和“不败”两个选项,代表一场比赛";
            kjTime13.font = [UIFont systemFontOfSize:10];
            kjTime13.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime13];
            [kjTime13 release];
            
            
            UILabel *kjTime14 = [[UILabel alloc] initWithFrame:CGRectMake(90, 393+17, 230, 10)];
            kjTime14.backgroundColor = [UIColor clearColor];
            kjTime14.text = @"的胜、平、 负三种结果,让投注更简单,中奖率";
            kjTime14.font = [UIFont systemFontOfSize:10];
            kjTime14.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime14];
            [kjTime14 release];
            
            UILabel *kjTime15 = [[UILabel alloc] initWithFrame:CGRectMake(90, 393+17+17, 230, 10)];
            kjTime15.backgroundColor = [UIColor clearColor];
            kjTime15.text = @"更高。";
            kjTime15.font = [UIFont systemFontOfSize:10];
            kjTime15.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            [backScrollView addSubview:kjTime15];
            [kjTime15 release];
            
            [self jiangJin:backScrollView y:441];
        
        }else{
            [self jiangJin:backScrollView y:330];
        }
        
       

    }
    else if (ALLWANFA == JingCaiZuQiuZJQS) {
    
        UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        titleV.backgroundColor = [UIColor clearColor];
        titleV.userInteractionEnabled = YES;
        
        UILabel *nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 80, 44)];
        nameLable2.backgroundColor = [UIColor clearColor];
        nameLable2.textColor = [UIColor whiteColor];
        nameLable2.text = @"竞彩足球";
        nameLable2.shadowColor = [UIColor blackColor];
        nameLable2.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable2.font = [UIFont boldSystemFontOfSize:20];
        [titleV addSubview:nameLable2];
        [nameLable2 release];
        
        
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(165, 0, 80, 44)];
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.textColor = [UIColor whiteColor];
        nameLable.text = @"总进球数";
        nameLable.shadowColor = [UIColor blackColor];
        nameLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable.font = [UIFont boldSystemFontOfSize:15];
        nameLable.textAlignment = NSTextAlignmentRight;
        [titleV addSubview:nameLable];
        self.CP_navigation.titleView = titleV;
        [titleV release];
        [nameLable release];
        
        caizhongJQ = jincaizuqiu;
        
        UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
        backScrollView.userInteractionEnabled = YES;
        [backScrollView setContentSize:CGSizeMake(320, 600)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];

        UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
        kjTime.backgroundColor = [UIColor clearColor];
        kjTime.text = @"开奖时间";
        kjTime.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime];
        [kjTime release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 48, 280, 12)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @"周一至周五 9:00 - 23:40  周六/日 9:00 - 00:40";
        kjTime2.font = [UIFont boldSystemFontOfSize:12];
        kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime2];
        [kjTime2 release];
        
        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 73, 300, 2)];
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = UIImageGetImageFromName(@"SZTG960.png") ;
        [backScrollView addSubview:xian];
        [xian release];
        
        UILabel *kjTime4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 88, 125, 15)];
        kjTime4.backgroundColor = [UIColor clearColor];
        kjTime4.text = @"玩法规则";
        kjTime4.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime4];
        [kjTime4 release];
        
        UILabel *kjTime3 = [[UILabel alloc] initWithFrame:CGRectMake(27, 116, 266, 10)];
        kjTime3.backgroundColor = [UIColor clearColor];
        kjTime3.text = @"竞猜某场比赛，对该场比赛在全场 90 分钟 (含伤停补时) 双";
        kjTime3.font = [UIFont systemFontOfSize:10];
        kjTime3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime3];
        [kjTime3 release];
        UILabel *kjTime31 = [[UILabel alloc] initWithFrame:CGRectMake(27, 134, 266, 10)];
        kjTime31.backgroundColor = [UIColor clearColor];
        kjTime31.text = @"方的进球总数结果进行投注，每场比赛共有8个投注选项：";
        kjTime31.font = [UIFont systemFontOfSize:10];
        kjTime31.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime31];
        [kjTime31 release];

        
        UILabel *kjTime1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 170, 30, 10)];
        kjTime1.backgroundColor = [UIColor clearColor];
        kjTime1.text = @"“ 0 ”";
        kjTime1.font = [UIFont boldSystemFontOfSize:10];
        kjTime1.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime1];
        [kjTime1 release];
        
        UILabel *kjTime5 = [[UILabel alloc] initWithFrame:CGRectMake(83, 170, 266, 10)];
        kjTime5.backgroundColor = [UIColor clearColor];
        kjTime5.text = @"双方进球之和为 0 ，即没有进球 。";
        kjTime5.font = [UIFont systemFontOfSize:10];
        kjTime5.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime5];
        [kjTime5 release];
        
        UILabel *kjTime11 = [[UILabel alloc] initWithFrame:CGRectMake(50, 185, 30, 10)];
        kjTime11.backgroundColor = [UIColor clearColor];
        kjTime11.text = @"“ 1 ”";
        kjTime11.font = [UIFont boldSystemFontOfSize:10];
        kjTime11.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime11];
        [kjTime11 release];
        
        UILabel *kjTime12 = [[UILabel alloc] initWithFrame:CGRectMake(83, 185, 266, 10)];
        kjTime12.backgroundColor = [UIColor clearColor];
        kjTime12.text = @"双方进球之和为 1 。";
        kjTime12.font = [UIFont systemFontOfSize:10];
        kjTime12.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime12];
        [kjTime12 release];

        UILabel *kjTime13 = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 30, 10)];
        kjTime13.backgroundColor = [UIColor clearColor];
        kjTime13.text = @"“ 2 ”";
        kjTime13.font = [UIFont boldSystemFontOfSize:10];
        kjTime13.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime13];
        [kjTime13 release];
        
        UILabel *kjTime14 = [[UILabel alloc] initWithFrame:CGRectMake(83, 200, 266, 10)];
        kjTime14.backgroundColor = [UIColor clearColor];
        kjTime14.text = @"双方进球之和为 2 。";
        kjTime14.font = [UIFont systemFontOfSize:10];
        kjTime14.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime14];
        [kjTime14 release];
        
        UILabel *kjTime15 = [[UILabel alloc] initWithFrame:CGRectMake(50, 215, 30, 10)];
        kjTime15.backgroundColor = [UIColor clearColor];
        kjTime15.text = @"“ 3 ”";
        kjTime15.font = [UIFont boldSystemFontOfSize:10];
        kjTime15.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime15];
        [kjTime15 release];
        
        UILabel *kjTime16 = [[UILabel alloc] initWithFrame:CGRectMake(83, 215, 266, 10)];
        kjTime16.backgroundColor = [UIColor clearColor];
        kjTime16.text = @"双方进球之和为 3 。";
        kjTime16.font = [UIFont systemFontOfSize:10];
        kjTime16.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime16];
        [kjTime16 release];
        
        UILabel *kjTime17 = [[UILabel alloc] initWithFrame:CGRectMake(50, 230, 30, 10)];
        kjTime17.backgroundColor = [UIColor clearColor];
        kjTime17.text = @"“ 4 ”";
        kjTime17.font = [UIFont boldSystemFontOfSize:10];
        kjTime17.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime17];
        [kjTime17 release];
        
        UILabel *kjTime18 = [[UILabel alloc] initWithFrame:CGRectMake(83, 230, 266, 10)];
        kjTime18.backgroundColor = [UIColor clearColor];
        kjTime18.text = @"双方进球之和为 4 。";
        kjTime18.font = [UIFont systemFontOfSize:10];
        kjTime18.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime18];
        [kjTime18 release];
        
        UILabel *kjTime19 = [[UILabel alloc] initWithFrame:CGRectMake(50, 245, 30, 10)];
        kjTime19.backgroundColor = [UIColor clearColor];
        kjTime19.text = @"“ 5 ”";
        kjTime19.font = [UIFont boldSystemFontOfSize:10];
        kjTime19.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime19];
        [kjTime19 release];
        
        UILabel *kjTime20 = [[UILabel alloc] initWithFrame:CGRectMake(83, 245, 266, 10)];
        kjTime20.backgroundColor = [UIColor clearColor];
        kjTime20.text = @"双方进球之和为 5 。";
        kjTime20.font = [UIFont systemFontOfSize:10];
        kjTime20.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime20];
        [kjTime20 release];
        
        UILabel *kjTime21 = [[UILabel alloc] initWithFrame:CGRectMake(50, 260, 30, 10)];
        kjTime21.backgroundColor = [UIColor clearColor];
        kjTime21.text = @"“ 6 ”";
        kjTime21.font = [UIFont boldSystemFontOfSize:10];
        kjTime21.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime21];
        [kjTime21 release];
        
        UILabel *kjTime22 = [[UILabel alloc] initWithFrame:CGRectMake(83, 260, 266, 10)];
        kjTime22.backgroundColor = [UIColor clearColor];
        kjTime22.text = @"双方进球之和为 6 。";
        kjTime22.font = [UIFont systemFontOfSize:10];
        kjTime22.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime22];
        [kjTime22 release];
        
        UILabel *kjTime23 = [[UILabel alloc] initWithFrame:CGRectMake(50, 275, 30, 10)];
        kjTime23.backgroundColor = [UIColor clearColor];
        kjTime23.text = @"“ 7+ ”";
        kjTime23.font = [UIFont boldSystemFontOfSize:10];
        kjTime23.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime23];
        [kjTime23 release];
        
        UILabel *kjTime24 = [[UILabel alloc] initWithFrame:CGRectMake(83, 275, 266, 10)];
        kjTime24.backgroundColor = [UIColor clearColor];
        kjTime24.text = @"双方进球之和为 7 或 7 以上 。";
        kjTime24.font = [UIFont systemFontOfSize:10];
        kjTime24.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime24];
        [kjTime24 release];
                
        UILabel *kjTime6 = [[UILabel alloc] initWithFrame:CGRectMake(27, 310, 30, 10)];
        kjTime6.backgroundColor = [UIColor clearColor];
        kjTime6.text = @"单关:";
        kjTime6.font = [UIFont boldSystemFontOfSize:10];
        kjTime6.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime6];
        [kjTime6 release];
        
        UILabel *kjTime7 = [[UILabel alloc] initWithFrame:CGRectMake(60, 310, 250, 10)];
        kjTime7.backgroundColor = [UIColor clearColor];
        kjTime7.text = @"任意选择 1 场或多场比赛投注（1 场比赛可投注多种";
        kjTime7.font = [UIFont systemFontOfSize:10];
        kjTime7.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime7];
        [kjTime7 release];
        UILabel *kjTime71 = [[UILabel alloc] initWithFrame:CGRectMake(60, 328, 230, 10)];
        kjTime71.backgroundColor = [UIColor clearColor];
        kjTime71.text = @"比赛结果），每个比赛结果构成 1 注。";
        kjTime71.font = [UIFont systemFontOfSize:10];
        kjTime71.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime71];
        [kjTime71 release];

        
        UILabel *kjTime8 = [[UILabel alloc] initWithFrame:CGRectMake(27, 351, 30, 10)];
        kjTime8.backgroundColor = [UIColor clearColor];
        kjTime8.text = @"过关:";
        kjTime8.font = [UIFont boldSystemFontOfSize:10];
        kjTime8.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime8];
        [kjTime8 release];
        
        UILabel *kjTime9 = [[UILabel alloc] initWithFrame:CGRectMake(60, 351, 266, 10)];
        kjTime9.backgroundColor = [UIColor clearColor];
        kjTime9.text = @"选择 2 场（或以上）比赛进行投注。";
        kjTime9.font = [UIFont systemFontOfSize:10];
        kjTime9.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime9];
        [kjTime9 release];

        [self jiangJin:backScrollView y:361];
    }
    else if (ALLWANFA == JingCaiZuQiuBCSPF) {
    
        UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        titleV.backgroundColor = [UIColor clearColor];
        titleV.userInteractionEnabled = YES;
        
        UILabel *nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 80, 44)];
        nameLable2.backgroundColor = [UIColor clearColor];
        nameLable2.textColor = [UIColor whiteColor];
        nameLable2.text = @"竞彩足球";
        nameLable2.shadowColor = [UIColor blackColor];
        nameLable2.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable2.font = [UIFont boldSystemFontOfSize:20];
        [titleV addSubview:nameLable2];
        [nameLable2 release];
        
        
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(137+6, 0, 100, 44)];
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.textColor = [UIColor whiteColor];
        nameLable.text = @"半全场胜平负";
        nameLable.shadowColor = [UIColor blackColor];
        nameLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable.font = [UIFont boldSystemFontOfSize:15];
        nameLable.textAlignment = NSTextAlignmentRight;
        [titleV addSubview:nameLable];
        self.CP_navigation.titleView = titleV;
        [titleV release];
        [nameLable release];
        
        caizhongJQ = jincaizuqiu;
        
        UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
        backScrollView.userInteractionEnabled = YES;
        [backScrollView setContentSize:CGSizeMake(320, 550)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];

        
        UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
        kjTime.backgroundColor = [UIColor clearColor];
        kjTime.text = @"开奖时间";
        kjTime.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime];
        [kjTime release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 48, 280, 12)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @"周一至周五 9:00 - 23:40  周六/日 9:00 - 00:40";
        kjTime2.font = [UIFont boldSystemFontOfSize:12];
        kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime2];
        [kjTime2 release];
        
        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 73, 300, 2)];
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = UIImageGetImageFromName(@"SZTG960.png") ;
        [backScrollView addSubview:xian];
        [xian release];
        
        UILabel *kjTime4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 88, 125, 15)];
        kjTime4.backgroundColor = [UIColor clearColor];
        kjTime4.text = @"玩法规则";
        kjTime4.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime4];
        [kjTime4 release];
        
        UILabel *kjTime3 = [[UILabel alloc] initWithFrame:CGRectMake(27, 116, 266, 10)];
        kjTime3.backgroundColor = [UIColor clearColor];
        kjTime3.text = @"竞猜某场比赛，对主队在上半场 45 分钟 (含伤停补时) 和";
        kjTime3.font = [UIFont systemFontOfSize:10];
        kjTime3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime3];
        [kjTime3 release];
        UILabel *kjTime31 = [[UILabel alloc] initWithFrame:CGRectMake(27, 134, 266, 10)];
        kjTime31.backgroundColor = [UIColor clearColor];
        kjTime31.text = @"全场 90 分钟 (含伤停补时) 的 “胜”、“平”、“负”结果";
        kjTime31.font = [UIFont systemFontOfSize:10];
        kjTime31.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime31];
        [kjTime31 release];
        UILabel *kjTime32 = [[UILabel alloc] initWithFrame:CGRectMake(27, 152, 266, 10)];
        kjTime32.backgroundColor = [UIColor clearColor];
        kjTime32.text = @"分别进行投注，每场比赛共有 9 个投注选项：";
        kjTime32.font = [UIFont systemFontOfSize:10];
        kjTime32.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime32];
        [kjTime32 release];
        
        UILabel *kjTime1 = [[UILabel alloc] initWithFrame:CGRectMake(63, 187, 50, 12)];
        kjTime1.backgroundColor = [UIColor clearColor];
        kjTime1.text = @"“ 胜 胜 ”";
        kjTime1.font = [UIFont boldSystemFontOfSize:12];
        kjTime1.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime1];
        [kjTime1 release];
        
        UILabel *kjTime5 = [[UILabel alloc] initWithFrame:CGRectMake(116, 187, 266, 10)];
        kjTime5.backgroundColor = [UIColor clearColor];
        kjTime5.text = @"即上半场主队胜，全场主队胜。";
        kjTime5.font = [UIFont systemFontOfSize:10];
        kjTime5.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime5];
        [kjTime5 release];
        
        UILabel *kjTime11 = [[UILabel alloc] initWithFrame:CGRectMake(63, 207, 50, 12)];
        kjTime11.backgroundColor = [UIColor clearColor];
        kjTime11.text = @"“ 胜 平 ”";
        kjTime11.font = [UIFont boldSystemFontOfSize:12];
        kjTime11.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime11];
        [kjTime11 release];
        
        UILabel *kjTime12 = [[UILabel alloc] initWithFrame:CGRectMake(116, 207, 266, 10)];
        kjTime12.backgroundColor = [UIColor clearColor];
        kjTime12.text = @"即上半场主队胜，全场主队平。";
        kjTime12.font = [UIFont systemFontOfSize:10];
        kjTime12.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime12];
        [kjTime12 release];
        
        UILabel *kjTime13 = [[UILabel alloc] initWithFrame:CGRectMake(63, 227, 50, 12)];
        kjTime13.backgroundColor = [UIColor clearColor];
        kjTime13.text = @"“ 胜 负 ”";
        kjTime13.font = [UIFont boldSystemFontOfSize:12];
        kjTime13.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime13];
        [kjTime13 release];
        
        UILabel *kjTime14 = [[UILabel alloc] initWithFrame:CGRectMake(116, 227, 266, 10)];
        kjTime14.backgroundColor = [UIColor clearColor];
        kjTime14.text = @"即上半场主队胜，全场主队负。";
        kjTime14.font = [UIFont systemFontOfSize:10];
        kjTime14.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime14];
        [kjTime14 release];
        
        UILabel *kjTime15 = [[UILabel alloc] initWithFrame:CGRectMake(63, 247, 50, 12)];
        kjTime15.backgroundColor = [UIColor clearColor];
        kjTime15.text = @"“ 平 胜 ”";
        kjTime15.font = [UIFont boldSystemFontOfSize:12];
        kjTime15.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime15];
        [kjTime15 release];
        
        UILabel *kjTime16 = [[UILabel alloc] initWithFrame:CGRectMake(116, 247, 266, 10)];
        kjTime16.backgroundColor = [UIColor clearColor];
        kjTime16.text = @"即上半场主队平，全场主队胜。";
        kjTime16.font = [UIFont systemFontOfSize:10];
        kjTime16.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime16];
        [kjTime16 release];
        
        UILabel *kjTime17 = [[UILabel alloc] initWithFrame:CGRectMake(63, 267, 50, 12)];
        kjTime17.backgroundColor = [UIColor clearColor];
        kjTime17.text = @"“ 平 平 ”";
        kjTime17.font = [UIFont boldSystemFontOfSize:12];
        kjTime17.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime17];
        [kjTime17 release];
        
        UILabel *kjTime18 = [[UILabel alloc] initWithFrame:CGRectMake(116, 267, 266, 10)];
        kjTime18.backgroundColor = [UIColor clearColor];
        kjTime18.text = @"即上半场主队平，全场主队平。";
        kjTime18.font = [UIFont systemFontOfSize:10];
        kjTime18.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime18];
        [kjTime18 release];
        
        UILabel *kjTime19 = [[UILabel alloc] initWithFrame:CGRectMake(63, 287, 50, 12)];
        kjTime19.backgroundColor = [UIColor clearColor];
        kjTime19.text = @"“ 平 负 ”";
        kjTime19.font = [UIFont boldSystemFontOfSize:12];
        kjTime19.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime19];
        [kjTime19 release];
        
        UILabel *kjTime20 = [[UILabel alloc] initWithFrame:CGRectMake(116, 287, 266, 10)];
        kjTime20.backgroundColor = [UIColor clearColor];
        kjTime20.text = @"即上半场主队平，全场主队负。";
        kjTime20.font = [UIFont systemFontOfSize:10];
        kjTime20.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime20];
        [kjTime20 release];
        
        UILabel *kjTime21 = [[UILabel alloc] initWithFrame:CGRectMake(63, 307, 50, 12)];
        kjTime21.backgroundColor = [UIColor clearColor];
        kjTime21.text = @"“ 负 胜 ”";
        kjTime21.font = [UIFont boldSystemFontOfSize:12];
        kjTime21.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime21];
        [kjTime21 release];
        
        UILabel *kjTime22 = [[UILabel alloc] initWithFrame:CGRectMake(116, 307, 266, 10)];
        kjTime22.backgroundColor = [UIColor clearColor];
        kjTime22.text = @"即上半场主队负，全场主队胜。";
        kjTime22.font = [UIFont systemFontOfSize:10];
        kjTime22.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime22];
        [kjTime22 release];
        
        UILabel *kjTime23 = [[UILabel alloc] initWithFrame:CGRectMake(63, 327, 50, 12)];
        kjTime23.backgroundColor = [UIColor clearColor];
        kjTime23.text = @"“ 负 平 ”";
        kjTime23.font = [UIFont boldSystemFontOfSize:12];
        kjTime23.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime23];
        [kjTime23 release];
        
        UILabel *kjTime24 = [[UILabel alloc] initWithFrame:CGRectMake(116, 327, 266, 10)];
        kjTime24.backgroundColor = [UIColor clearColor];
        kjTime24.text = @"即上半场主队负，全场主队平。";
        kjTime24.font = [UIFont systemFontOfSize:10];
        kjTime24.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime24];
        [kjTime24 release];
        
        UILabel *kjTime25 = [[UILabel alloc] initWithFrame:CGRectMake(63, 347, 50, 12)];
        kjTime25.backgroundColor = [UIColor clearColor];
        kjTime25.text = @"“ 负 负 ”";
        kjTime25.font = [UIFont boldSystemFontOfSize:12];
        kjTime25.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime25];
        [kjTime25 release];
        
        UILabel *kjTime26 = [[UILabel alloc] initWithFrame:CGRectMake(116, 347, 266, 10)];
        kjTime26.backgroundColor = [UIColor clearColor];
        kjTime26.text = @"即上半场主队负，全场主队负。";
        kjTime26.font = [UIFont systemFontOfSize:10];
        kjTime26.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime26];
        [kjTime26 release];

        
        UILabel *kjTime6 = [[UILabel alloc] initWithFrame:CGRectMake(27, 382, 30, 10)];
        kjTime6.backgroundColor = [UIColor clearColor];
        kjTime6.text = @"单关:";
        kjTime6.font = [UIFont boldSystemFontOfSize:10];
        kjTime6.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime6];
        [kjTime6 release];
        
        UILabel *kjTime7 = [[UILabel alloc] initWithFrame:CGRectMake(60, 382, 250, 10)];
        kjTime7.backgroundColor = [UIColor clearColor];
        kjTime7.text = @"任意选择 1 场或多场比赛投注（1 场比赛可投注多种";
        kjTime7.font = [UIFont systemFontOfSize:10];
        kjTime7.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime7];
        [kjTime7 release];
        UILabel *kjTime71 = [[UILabel alloc] initWithFrame:CGRectMake(60, 400, 230, 10)];
        kjTime71.backgroundColor = [UIColor clearColor];
        kjTime71.text = @"比赛结果），每个比赛结果构成 1 注。";
        kjTime71.font = [UIFont systemFontOfSize:10];
        kjTime71.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime71];
        [kjTime71 release];
        
        UILabel *kjTime8 = [[UILabel alloc] initWithFrame:CGRectMake(27, 423, 30, 10)];
        kjTime8.backgroundColor = [UIColor clearColor];
        kjTime8.text = @"过关:";
        kjTime8.font = [UIFont boldSystemFontOfSize:10];
        kjTime8.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime8];
        [kjTime8 release];
        
        UILabel *kjTime9 = [[UILabel alloc] initWithFrame:CGRectMake(60, 423, 266, 10)];
        kjTime9.backgroundColor = [UIColor clearColor];
        kjTime9.text = @"选择 2 场（或以上）比赛进行投注。";
        kjTime9.font = [UIFont systemFontOfSize:10];
        kjTime9.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime9];
        [kjTime9 release];

        [self jiangJin:backScrollView y:433];
    }
    else if (ALLWANFA == hunTouErXuanYi){
        UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        titleV.backgroundColor = [UIColor clearColor];
        titleV.userInteractionEnabled = YES;
        
        UILabel *nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 80, 44)];
        nameLable2.backgroundColor = [UIColor clearColor];
        nameLable2.textColor = [UIColor whiteColor];
        nameLable2.text = @"竞彩足球";
        nameLable2.shadowColor = [UIColor blackColor];
        nameLable2.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable2.font = [UIFont boldSystemFontOfSize:20];
        [titleV addSubview:nameLable2];
        [nameLable2 release];
        
        
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(152, 0, 80, 44)];
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.textColor = [UIColor whiteColor];
        nameLable.text = @"混合二选一";
        nameLable2.frame = CGRectMake(85, 0, 80, 44);
        nameLable.frame=  CGRectMake(160, 0, 84, 44);
        
        
        
        nameLable.shadowColor = [UIColor blackColor];
        nameLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable.font = [UIFont boldSystemFontOfSize:15];
        nameLable.textAlignment = NSTextAlignmentRight;
        [titleV addSubview:nameLable];
        self.CP_navigation.titleView = titleV;
        [titleV release];
        [nameLable release];
        
        UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
        backScrollView.userInteractionEnabled = YES;
        [backScrollView setContentSize:CGSizeMake(320, 400)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        
        UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
        kjTime.backgroundColor = [UIColor clearColor];
        kjTime.text = @"开奖时间";
        kjTime.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime];
        [kjTime release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 48, 280, 12)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @"周一至周五 9:00 - 23:40  周六/日 9:00 - 00:40";
        kjTime2.font = [UIFont boldSystemFontOfSize:12];
        kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime2];
        [kjTime2 release];
        
        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 73, 300, 2)];
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = UIImageGetImageFromName(@"SZTG960.png") ;
        [backScrollView addSubview:xian];
        [xian release];
        
        UILabel *kjTime4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 88, 125, 15)];
        kjTime4.backgroundColor = [UIColor clearColor];
        kjTime4.text = @"玩法规则";
        kjTime4.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime4];
        [kjTime4 release];
        
        UILabel *kjTime3 = [[UILabel alloc] initWithFrame:CGRectMake(27, 116, 280, 10)];
        kjTime3.backgroundColor = [UIColor clearColor];
        kjTime3.text = @"竞猜某场比赛，对全场90分钟（含伤停补时）的结果进行";
        kjTime3.font = [UIFont systemFontOfSize:10];
        kjTime3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime3];
        [kjTime3 release];
        UILabel *kjTime31 = [[UILabel alloc] initWithFrame:CGRectMake(27, 134, 266, 10)];
        kjTime31.backgroundColor = [UIColor clearColor];
        kjTime31.text = @"投注。";
        kjTime31.font = [UIFont systemFontOfSize:10];
        kjTime31.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime31];
        [kjTime31 release];
        
        UILabel *kjTime333 = [[UILabel alloc] initWithFrame:CGRectMake(27, 152, 266, 10)];
        kjTime333.backgroundColor = [UIColor clearColor];
        kjTime333.text = @"混合二选一： 竞彩足球在让（受让）一球的情况下，结合";
        kjTime333.font = [UIFont systemFontOfSize:10];
        kjTime333.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime333];
        [kjTime333 release];
        
        UILabel *kjTime444 = [[UILabel alloc] initWithFrame:CGRectMake(27, 170, 266, 10)];
        kjTime444.backgroundColor = [UIColor clearColor];
        kjTime444.text = @"胜平负及让球胜平负两个玩法进行混合过关的投注方式。仅";
        kjTime444.font = [UIFont systemFontOfSize:10];
        kjTime444.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime444];
        [kjTime444 release];
        
        UILabel *kjTime555 = [[UILabel alloc] initWithFrame:CGRectMake(27, 188, 266, 10)];
        kjTime555.backgroundColor = [UIColor clearColor];
        kjTime555.text = @"用“胜”和“不败”两个选项，代表一场比赛的胜、平、负三种";
        kjTime555.font = [UIFont systemFontOfSize:10];
        kjTime555.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime555];
        [kjTime555 release];
        
        UILabel *kjTime666 = [[UILabel alloc] initWithFrame:CGRectMake(27, 206, 266, 10)];
        kjTime666.backgroundColor = [UIColor clearColor];
        kjTime666.text = @"结果，让投注更简单，中奖率更高。";
        kjTime666.font = [UIFont systemFontOfSize:10];
        kjTime666.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime666];
        [kjTime666 release];
        
        
        UILabel *kjTime77 = [[UILabel alloc] initWithFrame:CGRectMake(27, 246, 266, 15)];
        kjTime77.backgroundColor = [UIColor clearColor];
        kjTime77.text = @"特别说明";
        kjTime77.font = [UIFont systemFontOfSize:12];
        kjTime77.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime77];
        [kjTime77 release];
        
        
        UILabel *kjTime777 = [[UILabel alloc] initWithFrame:CGRectMake(27, 264, 266, 10)];
        kjTime777.backgroundColor = [UIColor clearColor];
        kjTime777.text = @"本玩法仅针对竞彩足球让球胜平负赛程中，让球值（-1）和";
        kjTime777.font = [UIFont systemFontOfSize:10];
        kjTime777.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime777];
        [kjTime777 release];
        
        UILabel *kjTime888 = [[UILabel alloc] initWithFrame:CGRectMake(27, 282, 266, 10)];
        kjTime888.backgroundColor = [UIColor clearColor];
        kjTime888.text = @"（+1）的比赛进行模拟二选一投注。";
        kjTime888.font = [UIFont systemFontOfSize:10];
        kjTime888.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime888];
        [kjTime888 release];
        
        [self jiangJin:backScrollView y:288];
        
    }
    else if (ALLWANFA == JingCaiZuQiuBF) {
    
        UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        titleV.backgroundColor = [UIColor clearColor];
        titleV.userInteractionEnabled = YES;
        
        UILabel *nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 80, 44)];
        nameLable2.backgroundColor = [UIColor clearColor];
        nameLable2.textColor = [UIColor whiteColor];
        nameLable2.text = @"竞彩足球";
        nameLable2.shadowColor = [UIColor blackColor];
        nameLable2.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable2.font = [UIFont boldSystemFontOfSize:20];
        [titleV addSubview:nameLable2];
        [nameLable2 release];
        
        
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(137, 0, 80, 44)];
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.textColor = [UIColor whiteColor];
        nameLable.text = @"比分";
        nameLable.shadowColor = [UIColor blackColor];
        nameLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable.font = [UIFont boldSystemFontOfSize:15];
        nameLable.textAlignment = NSTextAlignmentRight;
        [titleV addSubview:nameLable];
        self.CP_navigation.titleView = titleV;
        [titleV release];
        [nameLable release];
        
        caizhongJQ = jincaizuqiu;
        
        UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
        backScrollView.userInteractionEnabled = YES;
        [backScrollView setContentSize:CGSizeMake(320, 600)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];

                
        UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
        kjTime.backgroundColor = [UIColor clearColor];
        kjTime.text = @"开奖时间";
        kjTime.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime];
        [kjTime release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 48, 280, 12)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @"周一至周五 9:00 - 23:40  周六/日 9:00 - 00:40";
        kjTime2.font = [UIFont boldSystemFontOfSize:12];
        kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime2];
        [kjTime2 release];
        
        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 73, 300, 2)];
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = UIImageGetImageFromName(@"SZTG960.png") ;
        [backScrollView addSubview:xian];
        [xian release];
        
        UILabel *kjTime4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 88, 125, 15)];
        kjTime4.backgroundColor = [UIColor clearColor];
        kjTime4.text = @"玩法规则";
        kjTime4.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime4];
        [kjTime4 release];
        
        UILabel *tianjiaLab1=[[UILabel alloc]initWithFrame:CGRectMake(27, 118, 320-27-20, 12)];
        tianjiaLab1.backgroundColor=[UIColor clearColor];
        tianjiaLab1.text=@"竞彩某场比赛，对该场比赛在全场90分钟（含伤停补时）的具";
        tianjiaLab1.textColor=[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        tianjiaLab1.font=[UIFont systemFontOfSize:10];
        [backScrollView addSubview:tianjiaLab1];
        [tianjiaLab1 release];
        
        UILabel *tianjiaLab2=[[UILabel alloc]initWithFrame:CGRectMake(27, 118+18, 320-27-20, 12)];
        tianjiaLab2.backgroundColor=[UIColor clearColor];
        tianjiaLab2.text=@"体比分结果进行投注，每场比赛共31个投注选项:";
        tianjiaLab2.textColor=[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        tianjiaLab2.font=[UIFont systemFontOfSize:10];
        [backScrollView addSubview:tianjiaLab2];
        [tianjiaLab2 release];
        
        
        UILabel *kjTime1 = [[UILabel alloc] initWithFrame:CGRectMake(27, 118+50, 50, 12)];
        kjTime1.backgroundColor = [UIColor clearColor];
        kjTime1.text = @" 主 胜 ";
        kjTime1.font = [UIFont boldSystemFontOfSize:12];
        kjTime1.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime1];
        [kjTime1 release];
        
        UILabel *kjTime5 = [[UILabel alloc] initWithFrame:CGRectMake(79, 119+50, 230, 10)];
        kjTime5.backgroundColor = [UIColor clearColor];
        kjTime5.text = @"“ 1:0 ”、“ 2:0 ”、“ 2:1 ”、“ 3:0 ”、“ 3:1”";
        kjTime5.font = [UIFont systemFontOfSize:10];
        kjTime5.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime5];
        [kjTime5 release];
        UILabel *kjTime51 = [[UILabel alloc] initWithFrame:CGRectMake(79, 137+50, 230, 10)];
        kjTime51.backgroundColor = [UIColor clearColor];
        kjTime51.text = @"“ 3:2 ”、“ 4:0 ”、“ 4:1 ”、“ 4:2 ”、“ 5:0 ”";
        kjTime51.font = [UIFont systemFontOfSize:10];
        kjTime51.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime51];
        [kjTime51 release];
        UILabel *kjTime52 = [[UILabel alloc] initWithFrame:CGRectMake(79, 155+50, 230, 10)];
        kjTime52.backgroundColor = [UIColor clearColor];
        kjTime52.text = @"“ 5:1 ”、“ 5:2 ” 以及 “胜其它”";
        kjTime52.font = [UIFont systemFontOfSize:10];
        kjTime52.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime52];
        [kjTime52 release];
        UILabel *kjTime53 = [[UILabel alloc] initWithFrame:CGRectMake(79, 173+50, 230, 10)];
        kjTime53.backgroundColor = [UIColor clearColor];
        kjTime53.text = @"胜其他：（除去上述比分以外，主队获胜的其它比";
        kjTime53.font = [UIFont systemFontOfSize:10];
        kjTime53.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime53];
        [kjTime53 release];
        UILabel *kjTime54 = [[UILabel alloc] initWithFrame:CGRectMake(79, 191+50, 230, 10)];
        kjTime54.backgroundColor = [UIColor clearColor];
        kjTime54.text = @"分，如 “5:3” 或 “6:1” ）";
        kjTime54.font = [UIFont systemFontOfSize:10];
        kjTime54.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime54];
        [kjTime54 release];
        
        UILabel *kjTime11 = [[UILabel alloc] initWithFrame:CGRectMake(27, 216+50, 50, 12)];
        kjTime11.backgroundColor = [UIColor clearColor];
        kjTime11.text = @" 平 局 ";
        kjTime11.font = [UIFont boldSystemFontOfSize:12];
        kjTime11.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime11];
        [kjTime11 release];
        
        UILabel *kjTime12 = [[UILabel alloc] initWithFrame:CGRectMake(79, 217+50, 230, 10)];
        kjTime12.backgroundColor = [UIColor clearColor];
        kjTime12.text = @"“ 0:0 ”、“ 1:1 ”、“ 2:2 ”、“ 3:3 ”以及 “平";
        kjTime12.font = [UIFont systemFontOfSize:10];
        kjTime12.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime12];
        [kjTime12 release];
        UILabel *kjTime121 = [[UILabel alloc] initWithFrame:CGRectMake(79, 235+50, 230, 10)];
        kjTime121.backgroundColor = [UIColor clearColor];
        kjTime121.text = @"其它”";
        kjTime121.font = [UIFont systemFontOfSize:10];
        kjTime121.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime121];
        [kjTime121 release];
        UILabel *kjTime122 = [[UILabel alloc] initWithFrame:CGRectMake(79, 253+50, 230, 10)];
        kjTime122.backgroundColor = [UIColor clearColor];
        kjTime122.text = @"平其他：（除去上述比分以外，主客队打平的其它";
        kjTime122.font = [UIFont systemFontOfSize:10];
        kjTime122.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime122];
        [kjTime122 release];
        UILabel *kjTime123 = [[UILabel alloc] initWithFrame:CGRectMake(79, 271+50, 230, 10)];
        kjTime123.backgroundColor = [UIColor clearColor];
        kjTime123.text = @"比分，如 “4:4” ）";
        kjTime123.font = [UIFont systemFontOfSize:10];
        kjTime123.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime123];
        [kjTime123 release];
        
        UILabel *kjTime13 = [[UILabel alloc] initWithFrame:CGRectMake(27, 296+50, 50, 12)];
        kjTime13.backgroundColor = [UIColor clearColor];
        kjTime13.text = @" 客 胜 ";
        kjTime13.font = [UIFont boldSystemFontOfSize:12];
        kjTime13.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime13];
        [kjTime13 release];
        
        UILabel *kjTime14 = [[UILabel alloc] initWithFrame:CGRectMake(79, 297+50, 230, 10)];
        kjTime14.backgroundColor = [UIColor clearColor];
        kjTime14.text = @"“ 0:1 ”、“ 0:2 ”、“ 1:2 ”、“ 0:3 ”、“ 1:3 ”、";
        kjTime14.font = [UIFont systemFontOfSize:10];
        kjTime14.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime14];
        [kjTime14 release];
        UILabel *kjTime15 = [[UILabel alloc] initWithFrame:CGRectMake(79, 315+50, 230, 10)];
        kjTime15.backgroundColor = [UIColor clearColor];
        kjTime15.text = @"“ 2:3 ”、“ 0:4 ”、“ 1:4 ”、“ 2:4 ”、“ 0:5 ”、";
        kjTime15.font = [UIFont systemFontOfSize:10];
        kjTime15.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime15];
        [kjTime15 release];
        UILabel *kjTime16 = [[UILabel alloc] initWithFrame:CGRectMake(79, 333+50, 230, 10)];
        kjTime16.backgroundColor = [UIColor clearColor];
        kjTime16.text = @"“ 1:5 ”、“ 2:5 ” 以及 “负其它”";
        kjTime16.font = [UIFont systemFontOfSize:10];
        kjTime16.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime16];
        [kjTime16 release];
        UILabel *kjTime17 = [[UILabel alloc] initWithFrame:CGRectMake(79, 351+50, 230, 10)];
        kjTime17.backgroundColor = [UIColor clearColor];
        kjTime17.text = @"负其他：（除去上述比分以外，主队落败的其它比";
        kjTime17.font = [UIFont systemFontOfSize:10];
        kjTime17.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime17];
        [kjTime17 release];
        UILabel *kjTime18 = [[UILabel alloc] initWithFrame:CGRectMake(79, 369+50, 230, 10)];
        kjTime18.backgroundColor = [UIColor clearColor];
        kjTime18.text = @"分，如 “4:5” 或 “0:8” ）";
        kjTime18.font = [UIFont systemFontOfSize:10];
        kjTime18.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime18];
        [kjTime18 release];

        UILabel *kjTime6 = [[UILabel alloc] initWithFrame:CGRectMake(27, 394+50, 30, 10)];
        kjTime6.backgroundColor = [UIColor clearColor];
        kjTime6.text = @"单关:";
        kjTime6.font = [UIFont boldSystemFontOfSize:10];
        kjTime6.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime6];
        [kjTime6 release];
        
        UILabel *kjTime7 = [[UILabel alloc] initWithFrame:CGRectMake(60, 394+50, 250, 10)];
        kjTime7.backgroundColor = [UIColor clearColor];
        kjTime7.text = @"任意选择 1 场或多场比赛投注（1 场比赛可投注多种比";
        kjTime7.font = [UIFont systemFontOfSize:10];
        kjTime7.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime7];
        [kjTime7 release];
        UILabel *kjTime71 = [[UILabel alloc] initWithFrame:CGRectMake(60, 412+50, 230, 10)];
        kjTime71.backgroundColor = [UIColor clearColor];
        kjTime71.text = @"赛结果），每个比赛结果构成 1 注。";
        kjTime71.font = [UIFont systemFontOfSize:10];
        kjTime71.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime71];
        [kjTime71 release];

        
        UILabel *kjTime8 = [[UILabel alloc] initWithFrame:CGRectMake(27, 437+50, 30, 10)];
        kjTime8.backgroundColor = [UIColor clearColor];
        kjTime8.text = @"过关:";
        kjTime8.font = [UIFont boldSystemFontOfSize:10];
        kjTime8.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime8];
        [kjTime8 release];
        
        UILabel *kjTime9 = [[UILabel alloc] initWithFrame:CGRectMake(60, 437+50, 266, 10)];
        kjTime9.backgroundColor = [UIColor clearColor];
        kjTime9.text = @"选择 2 场（或以上）比赛进行投注。";
        kjTime9.font = [UIFont systemFontOfSize:10];
        kjTime9.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime9];
        [kjTime9 release];

        [self jiangJin:backScrollView y:447];
    }
    else if (ALLWANFA == JingCaiZuQiuRQSPF) {
        
        UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        titleV.backgroundColor = [UIColor clearColor];
        titleV.userInteractionEnabled = YES;
        
        UILabel *nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 80, 44)];
        nameLable2.backgroundColor = [UIColor clearColor];
        nameLable2.textColor = [UIColor whiteColor];
        nameLable2.text = @"竞彩足球";
        nameLable2.shadowColor = [UIColor blackColor];
        nameLable2.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable2.font = [UIFont boldSystemFontOfSize:20];
        [titleV addSubview:nameLable2];
        [nameLable2 release];
        
        
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(157, 0, 100, 44)];
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.textColor = [UIColor whiteColor];
        nameLable.text = @"让球胜平负";
        nameLable.shadowColor = [UIColor blackColor];
        nameLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable.font = [UIFont boldSystemFontOfSize:15];
        nameLable.textAlignment = NSTextAlignmentRight;
        [titleV addSubview:nameLable];
        self.CP_navigation.titleView = titleV;
        [titleV release];
        [nameLable release];
        
        caizhongJQ = jincaizuqiu;
        
        UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
        backScrollView.userInteractionEnabled = YES;
        [backScrollView setContentSize:CGSizeMake(320, 600)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        
        UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
        kjTime.backgroundColor = [UIColor clearColor];
        kjTime.text = @"开奖时间";
        kjTime.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime];
        [kjTime release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 48, 280, 12)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @"每周一至周五 9:00 - 23:40  周六/日 9:00 - 00:40";
        kjTime2.font = [UIFont boldSystemFontOfSize:12];
        kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime2];
        [kjTime2 release];
        
        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 73, 300, 2)];
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = UIImageGetImageFromName(@"SZTG960.png") ;
        [backScrollView addSubview:xian];
        [xian release];
        
        UILabel *kjTime4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 88, 125, 15)];
        kjTime4.backgroundColor = [UIColor clearColor];
        kjTime4.text = @"玩法规则";
        kjTime4.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime4];
        [kjTime4 release];
        
        UILabel *kjTime3 = [[UILabel alloc] initWithFrame:CGRectMake(27, 116, 266, 10)];
        kjTime3.backgroundColor = [UIColor clearColor];
        kjTime3.text = @"竞猜某场比赛，对主队在全场 90 分钟(含伤停补时)的 “胜“";
        kjTime3.font = [UIFont systemFontOfSize:10];
        kjTime3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime3];
        [kjTime3 release];
        UILabel *kjTime31 = [[UILabel alloc] initWithFrame:CGRectMake(27, 134, 266, 10)];
        kjTime31.backgroundColor = [UIColor clearColor];
        kjTime31.text = @"“平”、“负” 结果进行投注。竞猜胜平负时用 3、1、0 分别代";
        kjTime31.font = [UIFont systemFontOfSize:10];
        kjTime31.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime31];
        [kjTime31 release];
        UILabel *kjTime333 = [[UILabel alloc] initWithFrame:CGRectMake(27, 152, 266, 10)];
        kjTime333.backgroundColor = [UIColor clearColor];
        kjTime333.text = @"表主队胜、主客战平和主队负。";
        kjTime333.font = [UIFont systemFontOfSize:10];
        kjTime333.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime333];
        [kjTime333 release];
        
        
        UILabel *jjfd = [[UILabel alloc] initWithFrame:CGRectMake(27, 187, 220, 13)];
        jjfd.backgroundColor = [UIColor clearColor];
        jjfd.text = @"例：曼联（主队）VS 利物浦（客队）";
        jjfd.font = [UIFont boldSystemFontOfSize:13];
        jjfd.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd];
        [jjfd release];
        
        UILabel *qb1 = [[UILabel alloc] initWithFrame:CGRectMake(53, 206, 250, 10)];
        qb1.backgroundColor = [UIColor clearColor];
        qb1.text = @"曼联 3 ： 0 利物浦  主队胜  选择 ”胜“ 中奖";
        qb1.font = [UIFont systemFontOfSize:10];
        qb1.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb1];
        [qb1 release];
        
        UILabel *qb2 = [[UILabel alloc] initWithFrame:CGRectMake(53, 224, 250, 10)];
        qb2.backgroundColor = [UIColor clearColor];
        qb2.text = @"曼联 1 ： 1 利物浦  平局     选择 ”平“ 中奖";
        qb2.font = [UIFont systemFontOfSize:10];
        qb2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb2];
        [qb2 release];
        
        UILabel *qb3 = [[UILabel alloc] initWithFrame:CGRectMake(53, 242, 250, 10)];
        qb3.backgroundColor = [UIColor clearColor];
        qb3.text = @"曼联 0 ： 2 利物浦  主队负  选择 ”负“ 中奖";
        qb3.font = [UIFont systemFontOfSize:10];
        qb3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb3];
        [qb3 release];
        
        UILabel *kjTime5 = [[UILabel alloc] initWithFrame:CGRectMake(27, 281, 266, 10)];
        kjTime5.backgroundColor = [UIColor clearColor];
        kjTime5.text = @"当两支球队实力悬殊较大时，采取让球的方式确定双方的胜平";
        [kjTime5 setNumberOfLines:0];
        kjTime5.lineBreakMode = NSLineBreakByCharWrapping;
        kjTime5.font = [UIFont systemFontOfSize:10];
        kjTime5.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime5];
        [kjTime5 release];
        UILabel *kjTime51 = [[UILabel alloc] initWithFrame:CGRectMake(27, 299, 266, 10)];
        kjTime51.backgroundColor = [UIColor clearColor];
        kjTime51.text = @"负关系。让球的数量确定后将维持不变。";
        [kjTime51 setNumberOfLines:0];
        kjTime51.lineBreakMode = NSLineBreakByCharWrapping;
        kjTime51.font = [UIFont systemFontOfSize:10];
        kjTime51.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime51];
        [kjTime51 release];
        
        
        UILabel *kjTime6 = [[UILabel alloc] initWithFrame:CGRectMake(27, 336, 30, 10)];
        kjTime6.backgroundColor = [UIColor clearColor];
        kjTime6.text = @"单关:";
        kjTime6.font = [UIFont boldSystemFontOfSize:10];
        kjTime6.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime6];
        [kjTime6 release];
        
        UILabel *kjTime7 = [[UILabel alloc] initWithFrame:CGRectMake(60, 336, 250, 10)];
        kjTime7.backgroundColor = [UIColor clearColor];
        kjTime7.text = @"任意选择 1 场或多场比赛投注（1 场比赛可投注多种";
        kjTime7.font = [UIFont systemFontOfSize:10];
        kjTime7.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime7];
        [kjTime7 release];
        UILabel *kjTime71 = [[UILabel alloc] initWithFrame:CGRectMake(60, 354, 230, 10)];
        kjTime71.backgroundColor = [UIColor clearColor];
        kjTime71.text = @"比赛结果），每个比赛结果构成 1 注。";
        kjTime71.font = [UIFont systemFontOfSize:10];
        kjTime71.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime71];
        [kjTime71 release];
        
        
        UILabel *kjTime8 = [[UILabel alloc] initWithFrame:CGRectMake(27, 375, 30, 10)];
        kjTime8.backgroundColor = [UIColor clearColor];
        kjTime8.text = @"过关:";
        kjTime8.font = [UIFont boldSystemFontOfSize:10];
        kjTime8.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime8];
        [kjTime8 release];
        
        UILabel *kjTime9 = [[UILabel alloc] initWithFrame:CGRectMake(60, 375, 266, 10)];
        kjTime9.backgroundColor = [UIColor clearColor];
        kjTime9.text = @"选择 2 场（或以上）比赛进行投注。";
        kjTime9.font = [UIFont systemFontOfSize:10];
        kjTime9.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime9];
        [kjTime9 release];
        
        [self jiangJin:backScrollView y:385];
        
    }
    else if (ALLWANFA == JingCaiLanQiuDXF) {
    
        UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        titleV.backgroundColor = [UIColor clearColor];
        titleV.userInteractionEnabled = YES;
        
        UILabel *nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 80, 44)];
        nameLable2.backgroundColor = [UIColor clearColor];
        nameLable2.textColor = [UIColor whiteColor];
        nameLable2.text = @"竞彩篮球";
        nameLable2.shadowColor = [UIColor blackColor];
        nameLable2.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable2.font = [UIFont boldSystemFontOfSize:20];
        [titleV addSubview:nameLable2];
        [nameLable2 release];
        
        
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(152, 0, 80, 44)];
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.textColor = [UIColor whiteColor];
        nameLable.text = @"大小分";
        nameLable.shadowColor = [UIColor blackColor];
        nameLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable.font = [UIFont boldSystemFontOfSize:15];
        nameLable.textAlignment = NSTextAlignmentRight;
        [titleV addSubview:nameLable];
        self.CP_navigation.titleView = titleV;
        [titleV release];
        [nameLable release];
        caizhongJQ = jingcailanqiu;

        
        UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
        backScrollView.userInteractionEnabled = YES;
        [backScrollView setContentSize:CGSizeMake(320, 650)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];

                
        UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
        kjTime.backgroundColor = [UIColor clearColor];
        kjTime.text = @"开奖时间";
        kjTime.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime];
        [kjTime release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 48, 280, 12)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @"周一至周五 9:00 - 23:40  周六/日 9:00 - 00:40";
        kjTime2.font = [UIFont boldSystemFontOfSize:12];
        kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime2];
        [kjTime2 release];
        
        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 73, 300, 2)];
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = UIImageGetImageFromName(@"SZTG960.png") ;
        [backScrollView addSubview:xian];
        [xian release];
        
        UILabel *kjTime4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 88, 125, 15)];
        kjTime4.backgroundColor = [UIColor clearColor];
        kjTime4.text = @"玩法规则";
        kjTime4.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime4];
        [kjTime4 release];
        
        UILabel *kjTime3 = [[UILabel alloc] initWithFrame:CGRectMake(27, 116, 266, 10)];
        kjTime3.backgroundColor = [UIColor clearColor];
        kjTime3.text = @"竞猜全场比赛(含加时赛)中两队得分总数与预设总分的大小关";
        kjTime3.font = [UIFont systemFontOfSize:10];
        kjTime3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime3];
        [kjTime3 release];
        UILabel *kjTime31 = [[UILabel alloc] initWithFrame:CGRectMake(27, 134, 266, 10)];
        kjTime31.backgroundColor = [UIColor clearColor];
        kjTime31.text = @"系。每场比赛有两种投注选项：";
        kjTime31.font = [UIFont systemFontOfSize:10];
        kjTime31.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime31];
        [kjTime31 release];
        UILabel *kjTime32 = [[UILabel alloc] initWithFrame:CGRectMake(27, 152, 266, 10)];
        kjTime32.backgroundColor = [UIColor clearColor];
        kjTime32.text = @"“大” 表示两队得分总数 > 预设总分；";
        kjTime32.font = [UIFont systemFontOfSize:10];
        kjTime32.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime32];
        [kjTime32 release];
        UILabel *kjTime33 = [[UILabel alloc] initWithFrame:CGRectMake(27, 170, 266, 10)];
        kjTime33.backgroundColor = [UIColor clearColor];
        kjTime33.text = @"“小” 表示两队得分总数 < 预设总分。";
        kjTime33.font = [UIFont systemFontOfSize:10];
        kjTime33.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime33];
        [kjTime33 release];
        
        UILabel *jjfd = [[UILabel alloc] initWithFrame:CGRectMake(27, 205, 180, 12)];
        jjfd.backgroundColor = [UIColor clearColor];
        jjfd.text = @"例：休斯顿火箭 VS 洛杉矶湖人";
        jjfd.font = [UIFont boldSystemFontOfSize:12];
        jjfd.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd];
        [jjfd release];
        
        UILabel *kd = [[UILabel alloc] initWithFrame:CGRectMake(190, 206, 130, 10)];
        kd.backgroundColor = [UIColor clearColor];
        kd.text = @"（客队在前，主队在后）";
        kd.font = [UIFont systemFontOfSize:10];
        kd.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kd];
        [kd release];

        UILabel *qb1 = [[UILabel alloc] initWithFrame:CGRectMake(53, 224, 250, 10)];
        qb1.backgroundColor = [UIColor clearColor];
        qb1.text = @"该场比赛预设总分为 178.5 分";
        qb1.font = [UIFont systemFontOfSize:10];
        qb1.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb1];
        [qb1 release];
        
        UILabel *qb2 = [[UILabel alloc] initWithFrame:CGRectMake(53, 249, 250, 10)];
        qb2.backgroundColor = [UIColor clearColor];
        qb2.text = @"休斯顿火箭 98 : 88 洛杉矶湖人";
        qb2.font = [UIFont systemFontOfSize:10];
        qb2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb2];
        [qb2 release];
        UILabel *qb21 = [[UILabel alloc] initWithFrame:CGRectMake(53, 267, 250, 10)];
        qb21.backgroundColor = [UIColor clearColor];
        qb21.text = @"98 + 88 = 186 选择 “大” 中奖。";
        qb21.font = [UIFont systemFontOfSize:10];
        qb21.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb21];
        [qb21 release];
        
        UILabel *qb3 = [[UILabel alloc] initWithFrame:CGRectMake(53, 292, 250, 10)];
        qb3.backgroundColor = [UIColor clearColor];
        qb3.text = @"休斯顿火箭 80 : 95 洛杉矶湖人";
        qb3.font = [UIFont systemFontOfSize:10];
        qb3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb3];
        [qb3 release];
        UILabel *qb31 = [[UILabel alloc] initWithFrame:CGRectMake(53, 310, 250, 10)];
        qb31.backgroundColor = [UIColor clearColor];
        qb31.text = @"80 + 95 = 175 选择 “小” 中奖。";
        qb31.font = [UIFont systemFontOfSize:10];
        qb31.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb31];
        [qb31 release];
                
        UILabel *kjTime6 = [[UILabel alloc] initWithFrame:CGRectMake(27, 345, 30, 10)];
        kjTime6.backgroundColor = [UIColor clearColor];
        kjTime6.text = @"单关:";
        kjTime6.font = [UIFont boldSystemFontOfSize:10];
        kjTime6.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime6];
        [kjTime6 release];
        
        UILabel *kjTime7 = [[UILabel alloc] initWithFrame:CGRectMake(60, 345, 250, 10)];
        kjTime7.backgroundColor = [UIColor clearColor];
        kjTime7.text = @"任意选择 1 场或多场比赛投注（1 场比赛可投注多种";
        kjTime7.font = [UIFont systemFontOfSize:10];
        kjTime7.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime7];
        [kjTime7 release];
        UILabel *kjTime71 = [[UILabel alloc] initWithFrame:CGRectMake(60, 363, 230, 10)];
        kjTime71.backgroundColor = [UIColor clearColor];
        kjTime71.text = @"比赛结果），每个比赛结果构成 1 注。";
        kjTime71.font = [UIFont systemFontOfSize:10];
        kjTime71.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime71];
        [kjTime71 release];
        
        UILabel *kjTime8 = [[UILabel alloc] initWithFrame:CGRectMake(27, 388, 30, 10)];
        kjTime8.backgroundColor = [UIColor clearColor];
        kjTime8.text = @"过关:";
        kjTime8.font = [UIFont boldSystemFontOfSize:10];
        kjTime8.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime8];
        [kjTime8 release];
        
        UILabel *kjTime9 = [[UILabel alloc] initWithFrame:CGRectMake(60, 388, 266, 10)];
        kjTime9.backgroundColor = [UIColor clearColor];
        kjTime9.text = @"选择 2 场（或以上）比赛进行投注。";
        kjTime9.font = [UIFont systemFontOfSize:10];
        kjTime9.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime9];
        [kjTime9 release];
        
        UILabel *wxts = [[UILabel alloc] initWithFrame:CGRectMake(20, ORIGIN_Y(kjTime9)+10, 125, 15)];
        wxts.backgroundColor = [UIColor clearColor];
        wxts.text = @"温馨提示";
        wxts.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:wxts];
        [wxts release];
        
        UILabel *wxts1 = [[UILabel alloc] initWithFrame:CGRectMake(27, ORIGIN_Y(wxts)+10, 320-54, 100)];
        wxts1.backgroundColor = [UIColor clearColor];
        wxts1.text = @"过关投注预设总分会由于官方调整发生改变，以投注出票时对应的预设总分为准\n\n当倍数大于99倍时，不能一张票全部出完，要分成多张进行出票，是否中奖要以每张票出票时对应的预设总分判断\n详情请咨询客服  QQ：3254056760";
        wxts1.lineBreakMode = NSLineBreakByWordWrapping;
        wxts1.numberOfLines = 0;
        wxts1.font = [UIFont boldSystemFontOfSize:10];
        wxts1.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:wxts1];
        [wxts1 release];
        
        [self jiangJin:backScrollView y:ORIGIN_Y(wxts1)-30];

    }
    else if (ALLWANFA == JingCaiLanQiuRFSF) {
    
        UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        titleV.backgroundColor = [UIColor clearColor];
        titleV.userInteractionEnabled = YES;
        
        UILabel *nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 80, 44)];
        nameLable2.backgroundColor = [UIColor clearColor];
        nameLable2.textColor = [UIColor whiteColor];
        nameLable2.text = @"竞彩篮球";
        nameLable2.shadowColor = [UIColor blackColor];
        nameLable2.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable2.font = [UIFont boldSystemFontOfSize:20];
        [titleV addSubview:nameLable2];
        [nameLable2 release];
        
        
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(162, 0, 80, 44)];
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.textColor = [UIColor whiteColor];
        nameLable.text = @"让分胜负";
        nameLable.shadowColor = [UIColor blackColor];
        nameLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable.font = [UIFont boldSystemFontOfSize:15];
        nameLable.textAlignment = NSTextAlignmentRight;
        [titleV addSubview:nameLable];
        self.CP_navigation.titleView = titleV;
        [titleV release];
        [nameLable release];
        caizhongJQ = jingcailanqiu;
        
        UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
        backScrollView.userInteractionEnabled = YES;
        [backScrollView setContentSize:CGSizeMake(320, 650)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];

                
        UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
        kjTime.backgroundColor = [UIColor clearColor];
        kjTime.text = @"开奖时间";
        kjTime.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime];
        [kjTime release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 48, 280, 12)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @"周一至周五 9:00 - 23:40  周六/日 9:00 - 00:40";
        kjTime2.font = [UIFont boldSystemFontOfSize:12];
        kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime2];
        [kjTime2 release];
        
        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 73, 300, 2)];
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = UIImageGetImageFromName(@"SZTG960.png") ;
        [backScrollView addSubview:xian];
        [xian release];
        
        UILabel *kjTime4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 88, 125, 15)];
        kjTime4.backgroundColor = [UIColor clearColor];
        kjTime4.text = @"玩法规则";
        kjTime4.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime4];
        [kjTime4 release];
        
        UILabel *kjTime3 = [[UILabel alloc] initWithFrame:CGRectMake(27, 116, 266, 10)];
        kjTime3.backgroundColor = [UIColor clearColor];
        kjTime3.text = @"选择某场比赛 (含加时赛) 中主队得分加减“让分数”后，主队";
        kjTime3.font = [UIFont systemFontOfSize:10];
        kjTime3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime3];
        [kjTime3 release];
        UILabel *kjTime31 = [[UILabel alloc] initWithFrame:CGRectMake(27, 134, 266, 10)];
        kjTime31.backgroundColor = [UIColor clearColor];
        kjTime31.text = @"的胜负情况，每场比赛有两种投注选项：";
        kjTime31.font = [UIFont systemFontOfSize:10];
        kjTime31.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime31];
        [kjTime31 release];
        UILabel *kjTime32 = [[UILabel alloc] initWithFrame:CGRectMake(27, 152, 266, 10)];
        kjTime32.backgroundColor = [UIColor clearColor];
        kjTime32.text = @"“主胜” 表示主队胜，客队负；";
        kjTime32.font = [UIFont systemFontOfSize:10];
        kjTime32.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime32];
        [kjTime32 release];
        UILabel *kjTime33 = [[UILabel alloc] initWithFrame:CGRectMake(27, 170, 266, 10)];
        kjTime33.backgroundColor = [UIColor clearColor];
        kjTime33.text = @"“主负” 表示主队负，客队胜。";
        kjTime33.font = [UIFont systemFontOfSize:10];
        kjTime33.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime33];
        [kjTime33 release];
        
        UILabel *jjfd = [[UILabel alloc] initWithFrame:CGRectMake(27, 205, 220, 13)];
        jjfd.backgroundColor = [UIColor clearColor];
        jjfd.text = @"例：休斯顿火箭 VS 洛杉矶湖人";
        jjfd.font = [UIFont boldSystemFontOfSize:13];
        jjfd.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd];
        [jjfd release];
        
        UILabel *kd2 = [[UILabel alloc] initWithFrame:CGRectMake(205, 207, 150, 10)];
        kd2.backgroundColor = [UIColor clearColor];
        kd2.text = @"（ －5.5 ）";
        kd2.font = [UIFont systemFontOfSize:10];
        kd2.textColor = [UIColor redColor];
        [backScrollView addSubview:kd2];
        [kd2 release];
        
        UILabel *kd = [[UILabel alloc] initWithFrame:CGRectMake(53, 225, 250, 10)];
        kd.backgroundColor = [UIColor clearColor];
        kd.text = @"（客队在前，主队在后。湖人队减 5.5 分）";
        kd.font = [UIFont systemFontOfSize:10];
        kd.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kd];
        [kd release];
                
        UILabel *qb2 = [[UILabel alloc] initWithFrame:CGRectMake(53, 250, 250, 10)];
        qb2.backgroundColor = [UIColor clearColor];
        qb2.text = @"休斯顿火箭 95 : 100 洛杉矶湖人";
        qb2.font = [UIFont systemFontOfSize:10];
        qb2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb2];
        [qb2 release];
        UILabel *qb21 = [[UILabel alloc] initWithFrame:CGRectMake(53, 268, 250, 10)];
        qb21.backgroundColor = [UIColor clearColor];
        qb21.text = @"让分后结果 95 : 94.5 选择 “主负” 中奖。";
        qb21.font = [UIFont systemFontOfSize:10];
        qb21.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb21];
        [qb21 release];
        
        UILabel *qb3 = [[UILabel alloc] initWithFrame:CGRectMake(53, 293, 250, 10)];
        qb3.backgroundColor = [UIColor clearColor];
        qb3.text = @"休斯顿火箭 95 : 101 洛杉矶湖人";
        qb3.font = [UIFont systemFontOfSize:10];
        qb3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb3];
        [qb3 release];
        UILabel *qb31= [[UILabel alloc] initWithFrame:CGRectMake(53, 311, 250, 10)];
        qb31.backgroundColor = [UIColor clearColor];
        qb31.text = @"让分后结果 95 : 95.5 选择 “主胜” 中奖。";
        qb31.font = [UIFont systemFontOfSize:10];
        qb31.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb31];
        [qb31 release];
        
        UILabel *kjTime6 = [[UILabel alloc] initWithFrame:CGRectMake(27, 346, 30, 10)];
        kjTime6.backgroundColor = [UIColor clearColor];
        kjTime6.text = @"单关:";
        kjTime6.font = [UIFont boldSystemFontOfSize:10];
        kjTime6.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime6];
        [kjTime6 release];
        
        UILabel *kjTime7 = [[UILabel alloc] initWithFrame:CGRectMake(60, 346, 250, 10)];
        kjTime7.backgroundColor = [UIColor clearColor];
        kjTime7.text = @"任意选择 1 场或多场比赛投注（1 场比赛可投注多种";
        kjTime7.font = [UIFont systemFontOfSize:10];
        kjTime7.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime7];
        [kjTime7 release];
        UILabel *kjTime71 = [[UILabel alloc] initWithFrame:CGRectMake(60, 364, 230, 10)];
        kjTime71.backgroundColor = [UIColor clearColor];
        kjTime71.text = @"比赛结果），每个比赛结果构成 1 注。";
        kjTime71.font = [UIFont systemFontOfSize:10];
        kjTime71.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime71];
        [kjTime71 release];

        
        UILabel *kjTime8 = [[UILabel alloc] initWithFrame:CGRectMake(27, 389, 30, 10)];
        kjTime8.backgroundColor = [UIColor clearColor];
        kjTime8.text = @"过关:";
        kjTime8.font = [UIFont boldSystemFontOfSize:10];
        kjTime8.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime8];
        [kjTime8 release];
        
        UILabel *kjTime9 = [[UILabel alloc] initWithFrame:CGRectMake(60, 389, 266, 10)];
        kjTime9.backgroundColor = [UIColor clearColor];
        kjTime9.text = @"选择 2 场（或以上）比赛进行投注。";
        kjTime9.font = [UIFont systemFontOfSize:10];
        kjTime9.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime9];
        [kjTime9 release];

        UILabel *wxts = [[UILabel alloc] initWithFrame:CGRectMake(20, ORIGIN_Y(kjTime9)+10, 125, 15)];
        wxts.backgroundColor = [UIColor clearColor];
        wxts.text = @"温馨提示";
        wxts.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:wxts];
        [wxts release];
        
        UILabel *wxts1 = [[UILabel alloc] initWithFrame:CGRectMake(27, ORIGIN_Y(wxts)+10, 320-54, 100)];
        wxts1.backgroundColor = [UIColor clearColor];
        wxts1.text = @"过关投注让分会由于官方调整发生改变，以投注出票对应的让分为准\n\n当倍数大于99倍时，不能一张票全部出完，要分成多张进行出票，是否中奖要以每张票出票时对应的让分判断\n详情请咨询客服  QQ：3254056760";
        wxts1.lineBreakMode = NSLineBreakByWordWrapping;
        wxts1.numberOfLines = 0;
        wxts1.font = [UIFont boldSystemFontOfSize:10];
        wxts1.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:wxts1];
        [wxts1 release];
        
        [self jiangJin:backScrollView y:ORIGIN_Y(wxts1)-30];
    }
    else if (ALLWANFA == JingCaiLanQiuSFC) {
    
        UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        titleV.backgroundColor = [UIColor clearColor];
        titleV.userInteractionEnabled = YES;
        
        UILabel *nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 80, 44)];
        nameLable2.backgroundColor = [UIColor clearColor];
        nameLable2.textColor = [UIColor whiteColor];
        nameLable2.text = @"竞彩篮球";
        nameLable2.shadowColor = [UIColor blackColor];
        nameLable2.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable2.font = [UIFont boldSystemFontOfSize:20];
        [titleV addSubview:nameLable2];
        [nameLable2 release];
        
        
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(152, 0, 80, 44)];
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.textColor = [UIColor whiteColor];
        nameLable.text = @"胜分差";
        nameLable.shadowColor = [UIColor blackColor];
        nameLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable.font = [UIFont boldSystemFontOfSize:15];
        nameLable.textAlignment = NSTextAlignmentRight;
        [titleV addSubview:nameLable];
        self.CP_navigation.titleView = titleV;
        [titleV release];
        [nameLable release];
        caizhongJQ = jingcailanqiu;
        
        UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
        backScrollView.userInteractionEnabled = YES;
        [backScrollView setContentSize:CGSizeMake(320, 550)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];

                
        UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
        kjTime.backgroundColor = [UIColor clearColor];
        kjTime.text = @"开奖时间";
        kjTime.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime];
        [kjTime release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 48, 280, 12)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @"周一至周五 9:00 - 23:40  周六/日 9:00 - 00:40";
        kjTime2.font = [UIFont boldSystemFontOfSize:12];
        kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime2];
        [kjTime2 release];
        
        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 73, 300, 2)];
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = UIImageGetImageFromName(@"SZTG960.png") ;
        [backScrollView addSubview:xian];
        [xian release];
        
        UILabel *kjTime4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 88, 125, 15)];
        kjTime4.backgroundColor = [UIColor clearColor];
        kjTime4.text = @"玩法规则";
        kjTime4.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime4];
        [kjTime4 release];
        
        UILabel *kjTime3 = [[UILabel alloc] initWithFrame:CGRectMake(27, 116, 266, 10)];
        kjTime3.backgroundColor = [UIColor clearColor];
        kjTime3.text = @"选择某场比赛 (含加时赛) 中两队的得分差。";
        kjTime3.font = [UIFont systemFontOfSize:10];
        kjTime3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime3];
        [kjTime3 release];
        UILabel *kjTime31 = [[UILabel alloc] initWithFrame:CGRectMake(27, 134, 266, 10)];
        kjTime31.backgroundColor = [UIColor clearColor];
        kjTime31.text = @"主胜 1-5 : ( 表示主队赢客队 1-5 分 ) ；";
        kjTime31.font = [UIFont systemFontOfSize:10];
        kjTime31.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime31];
        [kjTime31 release];
        UILabel *kjTime32 = [[UILabel alloc] initWithFrame:CGRectMake(27, 152, 266, 10)];
        kjTime32.backgroundColor = [UIColor clearColor];
        kjTime32.text = @"客胜 6-10 : ( 表示客队赢主队 6-10 分 ) 。";
        kjTime32.font = [UIFont systemFontOfSize:10];
        kjTime32.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime32];
        [kjTime32 release];

        
        UILabel *jjfd = [[UILabel alloc] initWithFrame:CGRectMake(27, 187, 220, 12)];
        jjfd.backgroundColor = [UIColor clearColor];
        jjfd.text = @"例：休斯顿火箭 VS 洛杉矶湖人";
        jjfd.font = [UIFont boldSystemFontOfSize:12];
        jjfd.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd];
        [jjfd release];
        
        UILabel *kd = [[UILabel alloc] initWithFrame:CGRectMake(190, 188, 150, 10)];
        kd.backgroundColor = [UIColor clearColor];
        kd.text = @"（客队在前，主队在后）";
        kd.font = [UIFont systemFontOfSize:10];
        kd.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kd];
        [kd release];
        
        UILabel *qb2 = [[UILabel alloc] initWithFrame:CGRectMake(53, 213, 250, 10)];
        qb2.backgroundColor = [UIColor clearColor];
        qb2.text = @"休斯顿火箭 88 : 96 洛杉矶湖人";
        qb2.font = [UIFont systemFontOfSize:10];
        qb2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb2];
        [qb2 release];
        UILabel *qb21 = [[UILabel alloc] initWithFrame:CGRectMake(53, 231, 250, 10)];
        qb21.backgroundColor = [UIColor clearColor];
        qb21.text = @"主队取胜 选择 “主胜 6-10 ” 中奖。";
        qb21.font = [UIFont systemFontOfSize:10];
        qb21.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb21];
        [qb21 release];
        
        UILabel *qb3 = [[UILabel alloc] initWithFrame:CGRectMake(53, 252, 250, 10)];
        qb3.backgroundColor = [UIColor clearColor];
        qb3.text = @"休斯顿火箭 96 : 88 洛杉矶湖人";
        qb3.font = [UIFont systemFontOfSize:10];
        qb3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb3];
        [qb3 release];
        UILabel *qb31 = [[UILabel alloc] initWithFrame:CGRectMake(53, 270, 250, 10)];
        qb31.backgroundColor = [UIColor clearColor];
        qb31.text = @"客队取胜 选择 “客胜 6-10 ” 中奖。";
        qb31.font = [UIFont systemFontOfSize:10];
        qb31.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb31];
        [qb31 release];

        
        UILabel *kjTime6 = [[UILabel alloc] initWithFrame:CGRectMake(27, 305, 30, 10)];
        kjTime6.backgroundColor = [UIColor clearColor];
        kjTime6.text = @"单关:";
        kjTime6.font = [UIFont boldSystemFontOfSize:10];
        kjTime6.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime6];
        [kjTime6 release];
        
        UILabel *kjTime7 = [[UILabel alloc] initWithFrame:CGRectMake(60, 305, 250, 10)];
        kjTime7.backgroundColor = [UIColor clearColor];
        kjTime7.text = @"任意选择 1 场或多场比赛投注（1 场比赛可投注多种";
        kjTime7.font = [UIFont systemFontOfSize:10];
        kjTime7.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime7];
        [kjTime7 release];
        UILabel *kjTime71 = [[UILabel alloc] initWithFrame:CGRectMake(60, 323, 230, 10)];
        kjTime71.backgroundColor = [UIColor clearColor];
        kjTime71.text = @"比赛结果），每个比赛结果构成 1 注。";
        kjTime71.font = [UIFont systemFontOfSize:10];
        kjTime71.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime71];
        [kjTime71 release];
        
        UILabel *kjTime8 = [[UILabel alloc] initWithFrame:CGRectMake(27, 348, 30, 10)];
        kjTime8.backgroundColor = [UIColor clearColor];
        kjTime8.text = @"过关:";
        kjTime8.font = [UIFont boldSystemFontOfSize:10];
        kjTime8.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime8];
        [kjTime8 release];
        
        UILabel *kjTime9 = [[UILabel alloc] initWithFrame:CGRectMake(60, 348, 266, 10)];
        kjTime9.backgroundColor = [UIColor clearColor];
        kjTime9.text = @"选择 2 场（或以上）比赛进行投注。";
        kjTime9.font = [UIFont systemFontOfSize:10];
        kjTime9.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime9];
        [kjTime9 release];
        
        [self jiangJin:backScrollView y:358];

    }
    else if (ALLWANFA == JingCaiLanQiuSF) {
    
        UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        titleV.backgroundColor = [UIColor clearColor];
        titleV.userInteractionEnabled = YES;
        
        UILabel *nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 80, 44)];
        nameLable2.backgroundColor = [UIColor clearColor];
        nameLable2.textColor = [UIColor whiteColor];
        nameLable2.text = @"竞彩篮球";
        nameLable2.shadowColor = [UIColor blackColor];
        nameLable2.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable2.font = [UIFont boldSystemFontOfSize:20];
        [titleV addSubview:nameLable2];
        [nameLable2 release];
        
        
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(137, 0, 80, 44)];
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.textColor = [UIColor whiteColor];
        nameLable.text = @"胜负";
        nameLable.shadowColor = [UIColor blackColor];
        nameLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable.font = [UIFont boldSystemFontOfSize:15];
        nameLable.textAlignment = NSTextAlignmentRight;
        [titleV addSubview:nameLable];
        self.CP_navigation.titleView = titleV;
        [titleV release];
        [nameLable release];
        caizhongJQ = jingcailanqiu;

        
        UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
        backScrollView.userInteractionEnabled = YES;
        [backScrollView setContentSize:CGSizeMake(320, 550)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        
        UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
        kjTime.backgroundColor = [UIColor clearColor];
        kjTime.text = @"开奖时间";
        kjTime.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime];
        [kjTime release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 48, 280, 12)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @"周一至周五 9:00 - 23:40  周六/日 9:00 - 00:40";
        kjTime2.font = [UIFont boldSystemFontOfSize:12];
        kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime2];
        [kjTime2 release];
        
        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 73, 300, 2)];
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = UIImageGetImageFromName(@"SZTG960.png") ;
        [backScrollView addSubview:xian];
        [xian release];
        
        UILabel *kjTime4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 88, 125, 15)];
        kjTime4.backgroundColor = [UIColor clearColor];
        kjTime4.text = @"玩法规则";
        kjTime4.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime4];
        [kjTime4 release];
        
        UILabel *kjTime3 = [[UILabel alloc] initWithFrame:CGRectMake(27, 116, 266, 10)];
        kjTime3.backgroundColor = [UIColor clearColor];
        kjTime3.text = @"选择某场比赛 (含加时赛) 中主队的的胜负情况。每场比赛有";
        kjTime3.font = [UIFont systemFontOfSize:10];
        kjTime3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime3];
        [kjTime3 release];
        UILabel *kjTime31 = [[UILabel alloc] initWithFrame:CGRectMake(27, 134, 266, 10)];
        kjTime31.backgroundColor = [UIColor clearColor];
        kjTime31.text = @"两种投注选项：";
        kjTime31.font = [UIFont systemFontOfSize:10];
        kjTime31.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime31];
        [kjTime31 release];
        UILabel *kjTime32 = [[UILabel alloc] initWithFrame:CGRectMake(27, 152, 266, 10)];
        kjTime32.backgroundColor = [UIColor clearColor];
        kjTime32.text = @"“主胜” 表示主队胜，客队负 ；";
        kjTime32.font = [UIFont systemFontOfSize:10];
        kjTime32.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime32];
        [kjTime32 release];
        UILabel *kjTime33 = [[UILabel alloc] initWithFrame:CGRectMake(27, 170, 266, 10)];
        kjTime33.backgroundColor = [UIColor clearColor];
        kjTime33.text = @"“主负” 表示主队负，客队胜。";
        kjTime33.font = [UIFont systemFontOfSize:10];
        kjTime33.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime33];
        [kjTime33 release];
        
        UILabel *jjfd = [[UILabel alloc] initWithFrame:CGRectMake(27, 205, 220, 12)];
        jjfd.backgroundColor = [UIColor clearColor];
        jjfd.text = @"例：休斯顿火箭 VS 洛杉矶湖人";
        jjfd.font = [UIFont boldSystemFontOfSize:12];
        jjfd.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd];
        [jjfd release];
        
        UILabel *kd = [[UILabel alloc] initWithFrame:CGRectMake(190, 206, 150, 10)];
        kd.backgroundColor = [UIColor clearColor];
        kd.text = @"（客队在前，主队在后）";
        kd.font = [UIFont systemFontOfSize:10];
        kd.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kd];
        [kd release];
        
        UILabel *qb2 = [[UILabel alloc] initWithFrame:CGRectMake(53, 224, 250, 10)];
        qb2.backgroundColor = [UIColor clearColor];
        qb2.text = @"休斯顿火箭 98 : 88 洛杉矶湖人  主队负";
        qb2.font = [UIFont systemFontOfSize:10];
        qb2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb2];
        [qb2 release];
        UILabel *qb22 = [[UILabel alloc] initWithFrame:CGRectMake(53, 242, 250, 10)];
        qb22.backgroundColor = [UIColor clearColor];
        qb22.text = @"选择 “主负” 中奖。";
        qb22.font = [UIFont systemFontOfSize:10];
        qb22.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb22];
        [qb22 release];
        
        UILabel *qb3 = [[UILabel alloc] initWithFrame:CGRectMake(53, 267, 250, 10)];
        qb3.backgroundColor = [UIColor clearColor];
        qb3.text = @"休斯顿火箭 88 : 98 洛杉矶湖人  主队胜";
        qb3.font = [UIFont systemFontOfSize:10];
        qb3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb3];
        [qb3 release];
        UILabel *qb31 = [[UILabel alloc] initWithFrame:CGRectMake(53, 285, 250, 10)];
        qb31.backgroundColor = [UIColor clearColor];
        qb31.text = @"选择 “主胜” 中奖。";
        qb31.font = [UIFont systemFontOfSize:10];
        qb31.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:qb31];
        [qb31 release];
        
        UILabel *kjTime6 = [[UILabel alloc] initWithFrame:CGRectMake(27, 320, 30, 10)];
        kjTime6.backgroundColor = [UIColor clearColor];
        kjTime6.text = @"单关:";
        kjTime6.font = [UIFont boldSystemFontOfSize:10];
        kjTime6.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime6];
        [kjTime6 release];
        
        UILabel *kjTime7 = [[UILabel alloc] initWithFrame:CGRectMake(60, 320, 250, 10)];
        kjTime7.backgroundColor = [UIColor clearColor];
        kjTime7.text = @"任意选择 1 场或多场比赛投注（1 场比赛可投注多种";
        kjTime7.font = [UIFont systemFontOfSize:10];
        kjTime7.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime7];
        [kjTime7 release];
        UILabel *kjTime71 = [[UILabel alloc] initWithFrame:CGRectMake(60, 338, 230, 10)];
        kjTime71.backgroundColor = [UIColor clearColor];
        kjTime71.text = @"比赛结果），每个比赛结果构成 1 注。";
        kjTime71.font = [UIFont systemFontOfSize:10];
        kjTime71.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime71];
        [kjTime71 release];
        
        UILabel *kjTime8 = [[UILabel alloc] initWithFrame:CGRectMake(27, 363, 30, 10)];
        kjTime8.backgroundColor = [UIColor clearColor];
        kjTime8.text = @"过关:";
        kjTime8.font = [UIFont boldSystemFontOfSize:10];
        kjTime8.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime8];
        [kjTime8 release];
        
        UILabel *kjTime9 = [[UILabel alloc] initWithFrame:CGRectMake(60, 363, 266, 10)];
        kjTime9.backgroundColor = [UIColor clearColor];
        kjTime9.text = @"选择 2 场（或以上）比赛进行投注。";
        kjTime9.font = [UIFont systemFontOfSize:10];
        kjTime9.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime9];
        [kjTime9 release];

        [self jiangJin:backScrollView y:373];
    }
    else if (ALLWANFA == lanqiuhuntouwf){

        UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        titleV.backgroundColor = [UIColor clearColor];
        titleV.userInteractionEnabled = YES;
        
        UILabel *nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 80, 44)];
        nameLable2.backgroundColor = [UIColor clearColor];
        nameLable2.textColor = [UIColor whiteColor];
        nameLable2.text = @"竞彩篮球";
        nameLable2.shadowColor = [UIColor blackColor];
        nameLable2.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable2.font = [UIFont boldSystemFontOfSize:20];
        [titleV addSubview:nameLable2];
        [nameLable2 release];
        
        
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(137, 0, 110, 44)];
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.textColor = [UIColor whiteColor];
        nameLable.text = @"混合过关";
        nameLable.shadowColor = [UIColor blackColor];
        nameLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
        nameLable.font = [UIFont boldSystemFontOfSize:15];
        nameLable.textAlignment = NSTextAlignmentRight;
        [titleV addSubview:nameLable];
        self.CP_navigation.titleView = titleV;
        [titleV release];
        [nameLable release];
        caizhongJQ = jingcailanqiu;
        
        UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
        backScrollView.userInteractionEnabled = YES;
        [backScrollView setContentSize:CGSizeMake(320, 550)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        
        UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
        kjTime.backgroundColor = [UIColor clearColor];
        kjTime.text = @"开奖时间";
        kjTime.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime];
        [kjTime release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 48, 280, 12)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @"周一至周五 9:00 - 22:40  周六/日 9:00 - 00:40";
        kjTime2.font = [UIFont boldSystemFontOfSize:12];
        kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime2];
        [kjTime2 release];
        
        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 73, 300, 2)];
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = UIImageGetImageFromName(@"SZTG960.png") ;
        [backScrollView addSubview:xian];
        [xian release];
        
        UILabel *kjTime4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 88, 125, 15)];
        kjTime4.backgroundColor = [UIColor clearColor];
        kjTime4.text = @"玩法规则";
        kjTime4.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime4];
        [kjTime4 release];
        
        UILabel *shidj = [[UILabel alloc] initWithFrame:CGRectMake(45, 116, 60, 12)];
        shidj.backgroundColor = [UIColor clearColor];
        shidj.text = @"胜负";
        shidj.font = [UIFont boldSystemFontOfSize:13];
        [backScrollView addSubview:shidj];
        [shidj release];
        
        UILabel *jjfd4 = [[UILabel alloc] initWithFrame:CGRectMake(80, 116, 222, 44)];
        jjfd4.backgroundColor = [UIColor clearColor];
        jjfd4.text = @"竞猜比赛（含加时赛）中主队的胜负情况。每场比赛有两种投注选项：“主胜”表示主队胜，“主负”表示主队负";
        jjfd4.font = [UIFont boldSystemFontOfSize:12];
        jjfd4.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        jjfd4.lineBreakMode = NSLineBreakByCharWrapping;
        jjfd4.numberOfLines = 0;
        [backScrollView addSubview:jjfd4];
        [jjfd4 release];

        UILabel *wdj = [[UILabel alloc] initWithFrame:CGRectMake(20, 171, 120, 12)];
        wdj.backgroundColor = [UIColor clearColor];
        wdj.text = @"让分胜负";
        wdj.font = [UIFont boldSystemFontOfSize:13];
        [backScrollView addSubview:wdj];
        [wdj release];
        
        UILabel *jjfd5 = [[UILabel alloc] initWithFrame:CGRectMake(80, 171, 222, 58)];
        jjfd5.backgroundColor = [UIColor clearColor];
        jjfd5.text = @"竞猜比赛（含加时赛）中主队得分加减“让分数”后，主队的胜负情况，每场比赛有两种投注选项：\n  “主胜”表示主队胜；“主负”表示主队负";
        jjfd5.font = [UIFont boldSystemFontOfSize:12];
        jjfd5.numberOfLines = 0;
        jjfd5.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd5];
        [jjfd5 release];

        //
        UILabel *ldj = [[UILabel alloc] initWithFrame:CGRectMake(32, 240, 60, 12)];
        ldj.backgroundColor = [UIColor clearColor];
        ldj.text = @"胜分差";
        ldj.font = [UIFont boldSystemFontOfSize:13];
        [backScrollView addSubview:ldj];
        [ldj release];
        
        UILabel *jjfd6 = [[UILabel alloc] initWithFrame:CGRectMake(80, 240, 222, 44)];
        jjfd6.backgroundColor = [UIColor clearColor];
        jjfd6.text = @"竞猜比赛（含加时赛）中两队的得分差。\n  主胜1-5:（表示主队赢客队1-5分）；\n  客胜6-10:（表示客队赢主队6-10分）。";
        jjfd6.font = [UIFont boldSystemFontOfSize:12];
        jjfd6.numberOfLines = 0;
        jjfd6.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd6];
        [jjfd6 release];
        
        UILabel *qdj = [[UILabel alloc] initWithFrame:CGRectMake(32, 294, 60, 12)];
        qdj.backgroundColor = [UIColor clearColor];
        qdj.text = @"大小分";
        qdj.font = [UIFont boldSystemFontOfSize:13];
        [backScrollView addSubview:qdj];
        [qdj release];
        
        UILabel *jjfd7 = [[UILabel alloc] initWithFrame:CGRectMake(80, 292, 222, 76)];
        jjfd7.backgroundColor = [UIColor clearColor];
        jjfd7.text = @"竞猜比赛（含加时赛）中两队得分总数与预设总分的大小关系。每场比赛有两种投注选项：\n   “大”表示两队得分总数 > 预设总分；\n   “小”表示两队得分总数 < 预设总分；";
        jjfd7.font = [UIFont boldSystemFontOfSize:12];
        jjfd7.numberOfLines = 0;
        jjfd7.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd7];
        [jjfd7 release];
        
        UILabel *qdj1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 379, 60, 12)];
        qdj1.backgroundColor = [UIColor clearColor];
        qdj1.text = @"混合过关";
        qdj1.font = [UIFont boldSystemFontOfSize:13];
        [backScrollView addSubview:qdj1];
        [qdj1 release];
        
        UILabel *jjfd8 = [[UILabel alloc] initWithFrame:CGRectMake(80, 376, 222, 35)];
        jjfd8.backgroundColor = [UIColor clearColor];
        jjfd8.text = @"突破玩法界限，可以选择4种玩法混投的方式进行投注。";
        jjfd8.font = [UIFont boldSystemFontOfSize:12];
        jjfd8.numberOfLines = 0;
        jjfd8.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd8];
        [jjfd8 release];

         [self jiangJin:backScrollView y:420];
    }
    else if (ALLWANFA == Pai3) {
    
        self.CP_navigation.title = @"排列三";
        caizhongJQ = pai3;


        [backScrollView setContentSize:CGSizeMake(320, 680)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        
        mkjTime1.text = @"每天 20:30 开奖";
        
        
        UILabel *mpai3wfInfo1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 108, 296, 40)];
        mpai3wfInfo1.text =@"每期开出一个三位数作为中奖号码百、十、个位\n每位号码为0-9";
        
        mpai3wfInfo1.lineBreakMode = NSLineBreakByWordWrapping;
        mpai3wfInfo1.numberOfLines = 0;
        mpai3wfInfo1.backgroundColor = [UIColor clearColor];
        mpai3wfInfo1.font = [UIFont systemFontOfSize:14.0];
        [backScrollView addSubview:mpai3wfInfo1];
        [mpai3wfInfo1 release];
        
        
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(12, mpai3wfInfo1.frame.origin.y+40+12, 296, 30) andLabel1Text:@"玩法" andLabelWed:61 andLabel2Text:@"中奖号码" andLabel2Wed:174 andLabelText3:@"奖金" andLabel3Wed:61 andLaelText4:nil andLabel4Frame:61 isJiangJiDouble:NO];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];

        cell1Array = [[NSArray alloc] initWithObjects:@"直选",@"直选\n和值",@"组三",@"组六",@"组三\n和值",@"组六\n和值",@"组三\n胆拖",@"组六\n胆拖", nil];
        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, header.frame.origin.y+header.frame.size.height, 296, 397) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];
        
        
        UILabel *zusan = [[UILabel alloc] initWithFrame:CGRectMake(12, myTableView.frame.origin.y+myTableView.frame.size.height+11, 296, 68)];
        zusan.text = @"* 组三  3个开奖号码中有两个重复号码，即为组三。\n* 组六  3个开奖号码各不相同，即为组六。\n* 胆拖玩法  胆码是您认为必出的号码，拖码是您认为可能出的号码。";
        zusan.backgroundColor = [UIColor clearColor];
        zusan.lineBreakMode = NSLineBreakByWordWrapping;
        zusan.numberOfLines = 0;
        zusan.font = [UIFont systemFontOfSize:12];
        [backScrollView addSubview:zusan];
        [zusan release];
        

    }
    else if (ALLWANFA == Pai5) {
    
        self.CP_navigation.title = @"排列五";
        caizhongJQ = pai5;

        [backScrollView setContentSize:CGSizeMake(320, 400)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];

        mkjTime1.text = @"每天 20:30 开奖";
        
        
        UILabel *mpai5wfInfo1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 108, 296, 40)];
        mpai5wfInfo1.text =@"每期开出一个5位数作为中奖号码万、千、百、十、个位每位号码为0-9";
        mpai5wfInfo1.backgroundColor = [UIColor clearColor];
        mpai5wfInfo1.lineBreakMode = NSLineBreakByWordWrapping;
        mpai5wfInfo1.numberOfLines = 0;
        
        mpai5wfInfo1.font = [UIFont systemFontOfSize:14.0];
        [backScrollView addSubview:mpai5wfInfo1];
        [mpai5wfInfo1 release];
        
        
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(12, mpai5wfInfo1.frame.origin.y+40+12, 296, 30) andLabel1Text:@"玩法" andLabelWed:61 andLabel2Text:@"中奖号码" andLabel2Wed:174 andLabelText3:@"奖金" andLabel3Wed:61 andLaelText4:nil andLabel4Frame:61 isJiangJiDouble:NO];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];
        

        cell1Array = [[NSArray alloc] initWithObjects:@"直选", nil];
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, header.frame.origin.y+header.frame.size.height, 296, 36) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];
        

    }
    else if (ALLWANFA == kuailepuke) {
        self.CP_navigation.title = @"快乐扑克";
        self.CP_navigation.rightBarButtonItem = nil;
        [backScrollView setContentSize:CGSizeMake(320, 1440)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        
        mkjTime.text = @"开售时间";
        mkjTime1.text = @"08:50 - 22:00 10分钟1期 每天79期";
        
        mWFInfo.text = @"玩法规则&奖项设置";
        
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(12, mWFInfo.frame.origin.y+15+12, 296, 30) andLabel1Text:@"玩法" andLabelWed:61 andLabel2Text:@"中奖条件" andLabel2Wed:174 andLabelText3:@"奖金" andLabel3Wed:61 andLaelText4:nil andLabel4Frame:61 isJiangJiDouble:NO];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];
        
        cell1Array = [[NSArray alloc] initWithObjects:@"任一",@"任二",@"任三",@"任四",@"任五",@"任六",@"同花单选",@"同花包选",@"同花顺单选",@"同花顺包选",@"顺子单选",@"顺子包选", @"豹子单选",@"豹子包选",@"对子单选",@"对子包选", nil];
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, header.frame.origin.y+header.frame.size.height, 296, 1280) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];
        
        
    }
    else if (ALLWANFA == HeMai) {
    
        self.CP_navigation.title = @"合买说明";
        
        UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
        backScrollView.userInteractionEnabled = YES;
        [backScrollView setContentSize:CGSizeMake(320, 900)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        
        UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(31, 29, 155, 15)];
        kjTime.backgroundColor = [UIColor clearColor];
        kjTime.text = @"什么是合买 ?";
        kjTime.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime];
        [kjTime release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(55, 59, 265, 13)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @"合买是指由多人共同出资购买彩票，包括1";
        kjTime2.font = [UIFont systemFontOfSize:13];
        kjTime2.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime2];
        [kjTime2 release];
        
        UILabel *kjTime21 = [[UILabel alloc] initWithFrame:CGRectMake(31, 72, 272, 25)];
        kjTime21.backgroundColor = [UIColor clearColor];
        kjTime21.text = @"个方案发起人和众多的合买参与人。这样可以";
        [kjTime21 setNumberOfLines:0];
        kjTime21.lineBreakMode = NSLineBreakByCharWrapping;
        kjTime21.font = [UIFont systemFontOfSize:13];
        kjTime21.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime21];
        [kjTime21 release];
        
        UILabel *kjTime211 = [[UILabel alloc] initWithFrame:CGRectMake(31, 92, 272, 25)];
        kjTime211.backgroundColor = [UIColor clearColor];
        kjTime211.text = @"在减少风险的前提下增加购买彩票的金额，增加";
        [kjTime211 setNumberOfLines:0];
        kjTime211.lineBreakMode = NSLineBreakByCharWrapping;
        kjTime211.font = [UIFont systemFontOfSize:13];
        kjTime211.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime211];
        [kjTime211 release];

        UILabel *kjTime2111 = [[UILabel alloc] initWithFrame:CGRectMake(31, 117, 272, 13)];
        kjTime2111.backgroundColor = [UIColor clearColor];
        kjTime2111.text = @"中奖的机率。";
        [kjTime211 setNumberOfLines:0];
        kjTime2111.lineBreakMode = NSLineBreakByCharWrapping;
        kjTime2111.font = [UIFont systemFontOfSize:13];
        kjTime2111.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime2111];
        [kjTime2111 release];
        
        

        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 147, 300, 2)];
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = [UIImage imageNamed:@"gexian.png"] ;
        [backScrollView addSubview:xian];
        [xian release];
        
        UILabel *kjTime3 = [[UILabel alloc] initWithFrame:CGRectMake(31, 167, 125, 15)];
        kjTime3.backgroundColor = [UIColor clearColor];
        kjTime3.text = @"什么是合买提成 ?";
        kjTime3.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime3];
        [kjTime3 release];
        
        UILabel *kjTime4 = [[UILabel alloc] initWithFrame:CGRectMake(55, 198, 265, 13)];
        kjTime4.backgroundColor = [UIColor clearColor];
        kjTime4.text = @"提成是发起人设置的中奖佣金， 在方案中";
        kjTime4.font = [UIFont systemFontOfSize:13];
        kjTime4.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime4];
        [kjTime4 release];
        
        UILabel *kjTime41 = [[UILabel alloc] initWithFrame:CGRectMake(31, 220, 265, 13)];
        kjTime41.backgroundColor = [UIColor clearColor];
        kjTime41.text = @"奖后系统会按用户设置的百分比， 在中奖的奖";
        kjTime41.font = [UIFont systemFontOfSize:13];
        kjTime41.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime41];
        [kjTime41 release];

        
        
        UILabel *kjTime5 = [[UILabel alloc] initWithFrame:CGRectMake(31, 240, 265, 13)];
        kjTime5.backgroundColor = [UIColor clearColor];
        kjTime5.text = @"金中提成奖励给发起人。";
        kjTime5.font = [UIFont systemFontOfSize:13];
        kjTime5.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime5];
        [kjTime5 release];
        
        UILabel *kjTime6 = [[UILabel alloc] initWithFrame:CGRectMake(50, 265, 265, 13)];
        kjTime6.backgroundColor = [UIColor clearColor];
        kjTime6.text = @"当奖金低于投注本金时，发起人是不会得到";
        kjTime6.font = [UIFont systemFontOfSize:13];
        kjTime6.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime6];
        [kjTime6 release];
        
        UILabel *kjTime61 = [[UILabel alloc] initWithFrame:CGRectMake(31, 287, 275, 13)];
        kjTime61.backgroundColor = [UIColor clearColor];
        kjTime61.text = @"提成的， 只有奖金大于投注本金有盈利的情况";
        kjTime61.font = [UIFont systemFontOfSize:13];
        kjTime61.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime61];
        [kjTime61 release];
        
        
        UILabel *kjTime7 = [[UILabel alloc] initWithFrame:CGRectMake(31, 312, 265, 13)];
        kjTime7.backgroundColor = [UIColor clearColor];
        kjTime7.text = @"下才可得到提成。";
        kjTime7.font = [UIFont systemFontOfSize:13];
        kjTime7.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime7];
        [kjTime7 release];
        
        UILabel *kjTime8 = [[UILabel alloc] initWithFrame:CGRectMake(50, 338, 265, 13)];
        kjTime8.backgroundColor = [UIColor clearColor];
        kjTime8.text = @"发单人可获得的提成=（中奖金额－方案金";
        kjTime8.font = [UIFont systemFontOfSize:13];
        kjTime8.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime8];
        [kjTime8 release];
        
        UILabel *kjTime9 = [[UILabel alloc] initWithFrame:CGRectMake(31, 363, 180, 13)];
        kjTime9.backgroundColor = [UIColor clearColor];
        kjTime9.text = @"额）* 设定的提成比例。";
        kjTime9.font = [UIFont systemFontOfSize:13];
        kjTime9.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime9];
        [kjTime9 release];
        
        UIImageView *xian2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 395, 300, 2)];
        xian2.backgroundColor  = [UIColor clearColor];
        xian2.image = [UIImage imageNamed:@"gexian.png"] ;
        [backScrollView addSubview:xian2];
        [xian2 release];
        
        UILabel *kjTime10 = [[UILabel alloc] initWithFrame:CGRectMake(31, 418, 125, 15)];
        kjTime10.backgroundColor = [UIColor clearColor];
        kjTime10.text = @"什么是方案流标 ?";
        kjTime10.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime10];
        [kjTime10 release];
        
        UILabel *kjTime11 = [[UILabel alloc] initWithFrame:CGRectMake(55, 448, 265, 13)];
        kjTime11.backgroundColor = [UIColor clearColor];
        kjTime11.text = @"方案流标指合买方案在该期截止后，方案进";
        kjTime11.font = [UIFont systemFontOfSize:13];
        kjTime11.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime11];
        [kjTime11 release];
        
        UILabel *kjTime111 = [[UILabel alloc] initWithFrame:CGRectMake(31, 468, 285, 13)];
        kjTime111.backgroundColor = [UIColor clearColor];
        kjTime111.text = @"度 ＋ 发起人保底 ＋ 网站保底都未能促使方案满";
        kjTime111.font = [UIFont systemFontOfSize:13];
        kjTime111.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime111];
        [kjTime111 release];

        
        
        
        UILabel *kjTime12 = [[UILabel alloc] initWithFrame:CGRectMake(31, 490, 265, 13)];
        kjTime12.backgroundColor = [UIColor clearColor];
        kjTime12.text = @"员，则该方案自动流标，即未能合买成功。";
        kjTime12.font = [UIFont systemFontOfSize:13];
        kjTime12.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime12];
        [kjTime12 release];
        
//        UILabel *kjTime13 = [[UILabel alloc] initWithFrame:CGRectMake(31, 512, 265, 13)];
//        kjTime13.backgroundColor = [UIColor clearColor];
//        kjTime13.text = @"";
//        kjTime13.font = [UIFont systemFontOfSize:13];
//        kjTime13.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
//        [backScrollView addSubview:kjTime13];
//        [kjTime13 release];
        
        
        UILabel *kjTime14 = [[UILabel alloc] initWithFrame:CGRectMake(55, 512, 265, 13)];
        kjTime14.backgroundColor = [UIColor clearColor];
        kjTime14.text = @"方案流标后，系统自动将合买发起人的保底";
        kjTime14.font = [UIFont systemFontOfSize:13];
        kjTime14.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime14];
        [kjTime14 release];
        
        
        UILabel *kjTime141 = [[UILabel alloc] initWithFrame:CGRectMake(31, 535, 285, 13)];
        kjTime141.backgroundColor = [UIColor clearColor];
        kjTime141.text = @"资金和认购金额，各合买跟单人的认购金额将返";
        kjTime141.font = [UIFont systemFontOfSize:13];
        kjTime141.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime141];
        [kjTime141 release];
        
        
        UILabel *kjTime15 = [[UILabel alloc] initWithFrame:CGRectMake(31, 557, 265, 13)];
        kjTime15.backgroundColor = [UIColor clearColor];
        kjTime15.text = @"还至用户的帐户中。";
        kjTime15.font = [UIFont systemFontOfSize:13];
        kjTime15.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime15];
        [kjTime15 release];
        
        UIImageView *xian3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 591, 300, 2)];
        xian3.backgroundColor  = [UIColor clearColor];
        xian3.image = [UIImage imageNamed:@"gexian.png"] ;
        [backScrollView addSubview:xian3];
        [xian3 release];
        
        UILabel *kjTime16 = [[UILabel alloc] initWithFrame:CGRectMake(31, 617, 125, 15)];
        kjTime16.backgroundColor = [UIColor clearColor];
        kjTime16.text = @"什么是保底 ?";
        kjTime16.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime16];
        [kjTime16 release];
        
        UILabel *kjTime17 = [[UILabel alloc] initWithFrame:CGRectMake(55, 647, 260, 13)];
        kjTime17.backgroundColor = [UIColor clearColor];
        kjTime17.text = @"为保证合买方案最大可能成功，发起人可以";
        kjTime17.font = [UIFont systemFontOfSize:13];
        kjTime17.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime17];
        [kjTime17 release];
        
        
        UILabel *kjTime171 = [[UILabel alloc] initWithFrame:CGRectMake(31, 669, 285, 13)];
        kjTime171.backgroundColor = [UIColor clearColor];
        kjTime171.text = @"对合买方案承诺保底，合买方案保底发起后，承";
        kjTime171.font = [UIFont systemFontOfSize:13];
        kjTime171.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime171];
        [kjTime171 release];

        
        UILabel *kjTime18 = [[UILabel alloc] initWithFrame:CGRectMake(27, 690, 280, 13)];
        kjTime18.backgroundColor = [UIColor clearColor];
        kjTime18.text = @"诺的保底金额会被暂时冻结。";
        kjTime18.font = [UIFont systemFontOfSize:13];
        [kjTime18 setNumberOfLines:0];
        kjTime18.lineBreakMode = NSLineBreakByCharWrapping;
        kjTime18.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime18];
        [kjTime18 release];
        
        UILabel *kjTime19 = [[UILabel alloc] initWithFrame:CGRectMake(55, 710, 265, 13)];
        kjTime19.backgroundColor = [UIColor clearColor];
        kjTime19.text = @"在合买截止时间到后，若用户方案未全部跟";
        kjTime19.font = [UIFont systemFontOfSize:13];
        kjTime19.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime19];
        [kjTime19 release];
        
        
        UILabel *kjTime191 = [[UILabel alloc] initWithFrame:CGRectMake(31, 732, 275, 13)];
        kjTime191.backgroundColor = [UIColor clearColor];
        kjTime191.text = @"满，则会使用承诺的保底金额购买未满部分，若";
        kjTime191.font = [UIFont systemFontOfSize:13];
        kjTime191.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime191];
        [kjTime191 release];
        
        UILabel *kjTime20 = [[UILabel alloc] initWithFrame:CGRectMake(31, 753, 275, 13)];
        kjTime20.backgroundColor = [UIColor clearColor];
        kjTime20.text = @"承诺的保底金额还有剩余，则多余金额退回保底。";
        kjTime20.font = [UIFont systemFontOfSize:13];
        kjTime20.lineBreakMode = NSLineBreakByCharWrapping;
        kjTime20.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime20];
        [kjTime20 release];
        
        
        UILabel *kjTime201 = [[UILabel alloc] initWithFrame:CGRectMake(31, 775, 275, 13)];
        kjTime201.backgroundColor = [UIColor clearColor];
        kjTime201.text = @"人帐户；若承诺的保底金额不够买满方案，则方";
        kjTime201.font = [UIFont systemFontOfSize:13];
        kjTime201.lineBreakMode = NSLineBreakByCharWrapping;
        kjTime201.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime201];
        [kjTime201 release];

        
        UILabel *kjTime2011 = [[UILabel alloc] initWithFrame:CGRectMake(31, 796, 280, 13)];
        kjTime2011.backgroundColor = [UIColor clearColor];
        kjTime2011.text = @"案将被撤单，所有投注资金退回会员各自帐户。";
        kjTime2011.font = [UIFont systemFontOfSize:13];
        kjTime2011.lineBreakMode = NSLineBreakByCharWrapping;
        kjTime2011.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime2011];
        [kjTime2011 release];

        
        
        UILabel *kjTime22 = [[UILabel alloc] initWithFrame:CGRectMake(55, 817, 265, 13)];
        kjTime22.backgroundColor = [UIColor clearColor];
        kjTime22.text = @"保底金额 ＝ 保底份数 ＊ 每份方案金额。";
        kjTime22.font = [UIFont systemFontOfSize:13];
        kjTime22.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0  alpha:1];
        [backScrollView addSubview:kjTime22];
        [kjTime22 release];




    }
    else if (ALLWANFA == KuaiLeShiFen) {
    
        self.CP_navigation.title = @"快乐十分";
        caizhongJQ = kuaileshifen;
        [backScrollView setContentSize:CGSizeMake(320, 970)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];

        mkjTime.text = @"开售时间";
        mkjTime1.text = @"08:35 - 22:35 10分钟1期 每天84期";
        
        mWFInfo.text = @"玩法规则&奖项设置";
    
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(12, mWFInfo.frame.origin.y+15+12, 296, 30) andLabel1Text:@"玩法" andLabelWed:61 andLabel2Text:@"中奖条件" andLabel2Wed:174 andLabelText3:@"奖金" andLabel3Wed:61 andLaelText4:nil andLabel4Frame:61 isJiangJiDouble:NO];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];
        
        cell1Array = [[NSArray alloc] initWithObjects:@"选一\n数投",@"选一\n红投",@"任选二",@"选二\n连直",@"选二\n连组",@"任选三",@"选三\n前直",@"选三\n前组",@"任选四",@"任选五",@"猜大数",@"猜单数",@"猜全数", nil];
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, header.frame.origin.y+header.frame.size.height, 296, 797) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];
        
        
        
    }
    else if (ALLWANFA == Kuai3 || ALLWANFA == JSKuai3 || ALLWANFA == HBKuai3 || ALLWANFA == JLKuai3 || ALLWANFA == AHKuai3) {
        
        if (ALLWANFA == Kuai3) {
            self.CP_navigation.title = @"内蒙古快3";
            caizhongJQ = k3;
            mkjTime1.text = @"09:35-22:00  10分钟1期  每天73期";
        }
        else if (ALLWANFA == JSKuai3) {
            self.CP_navigation.title = @"江苏快3";
            caizhongJQ = k3;
            mkjTime1.text = @"08:30-22:10  10分钟1期  每天82期";
        }
        else if (ALLWANFA == HBKuai3) {
            self.CP_navigation.title = @"湖北快3";
            caizhongJQ = k3;
            mkjTime1.text = @"09:00-22:00  10分钟1期  每天78期";
        }
        else if (ALLWANFA == JLKuai3) {
            self.CP_navigation.title = @"吉林快3";
            caizhongJQ = k3;
            mkjTime1.text = @"08:20-21:30  10分钟1期  每天79期";
        }
        else if (ALLWANFA == AHKuai3) {
            self.CP_navigation.title = @"安徽快3";
            caizhongJQ = k3;
            mkjTime1.text = @"08:40-22:00  10分钟1期  每天80期";
        }
        
        mkjTime.text = @"开售时间";
        
        UILabel *msd11x5fInfo1 = [[UILabel alloc] init];
        msd11x5fInfo1.text =@"每期开出3个数字作为开奖号码，每个数字取值范围为1-6（相当于摇三个骰子）";
        msd11x5fInfo1.font = [UIFont systemFontOfSize:14.0];

        CGSize msdSize = [msd11x5fInfo1.text sizeWithFont:msd11x5fInfo1.font constrainedToSize:CGSizeMake(296, INT_MAX)];
        msd11x5fInfo1.frame = CGRectMake(12, 108, 296, msdSize.height);
        msd11x5fInfo1.numberOfLines = 0;
        msd11x5fInfo1.backgroundColor = [UIColor clearColor];
        [backScrollView addSubview:msd11x5fInfo1];
        [msd11x5fInfo1 release];
        
        
        HeaderLabel *header = [[HeaderLabel alloc] initWithFrame:CGRectMake(12, ORIGIN_Y(msd11x5fInfo1) + 12, 296, 30) andLabel1Text:@"玩法" andLabelWed:61 andLabel2Text:@"中奖条件" andLabel2Wed:174 andLabelText3:@"奖金" andLabel3Wed:61 andLaelText4:nil andLabel4Frame:61 isJiangJiDouble:NO];
        header.Horizontal = YES;
        [backScrollView addSubview:header];
        [header release];
        
        cell1Array = [[NSArray alloc] initWithObjects:@"和值",@"三同号单选",@"三同号通选",@"二同号单选",@"二同号复选",@"三不同号",@"二不同号",@"三连号通选", nil];
        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, header.frame.origin.y+header.frame.size.height, 296, 36 + 58 * 7) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [backScrollView addSubview:myTableView];
        
        UILabel * danTuoInfoLabel = [[UILabel alloc] init];
        danTuoInfoLabel.text =@"胆拖玩法\n胆码是您认为必出的号码，\n拖码是您认为可能出的号码。";
        danTuoInfoLabel.font = [UIFont systemFontOfSize:14.0];
        
        CGSize infoSize = [danTuoInfoLabel.text sizeWithFont:danTuoInfoLabel.font constrainedToSize:CGSizeMake(296, INT_MAX)];
        danTuoInfoLabel.frame = CGRectMake(12, ORIGIN_Y(myTableView) + 12, 296, infoSize.height);
        danTuoInfoLabel.numberOfLines = 0;
        danTuoInfoLabel.backgroundColor = [UIColor clearColor];
        [backScrollView addSubview:danTuoInfoLabel];
        [danTuoInfoLabel release];
        
        [backScrollView setContentSize:CGSizeMake(320, ORIGIN_Y(danTuoInfoLabel) + 15)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];

    }
//    else if (ALLWANFA == JSKuai3) {
//        
//        self.CP_navigation.title = @"江苏快3";
//        
//        
//        //  UIBarButtonItem *rightb = [Info backItemTarget:self action:@selector (pressJiQiao:)];
//        //self.CP_navigation.rightBarButtonItem = rightb;
//        caizhongJQ = k3;
//
//        UIScrollView *scroView=[[UIScrollView alloc]initWithFrame:self.mainView.bounds];
//        
//        [scroView setContentSize:CGSizeMake(320, 750)];
//        scroView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bgn.png"]];
//        [self.mainView addSubview:scroView];
//        [scroView release];
//        
//        
//        
//        UILabel *labeltime=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 30)];
//        labeltime.text=@"开售时间";
//        labeltime.font=[UIFont boldSystemFontOfSize:18];
//        labeltime.backgroundColor=[UIColor clearColor];
//        labeltime.textColor=[UIColor blackColor];
//        [scroView addSubview:labeltime];
//        [labeltime release];
//        
//        UILabel *labeltime1=[[UILabel alloc]initWithFrame:CGRectMake(20, 40, 300, 20)];
//        labeltime1.text=@"08：30-22：10      10分钟一期，每天82期";
//        labeltime1.font=[UIFont boldSystemFontOfSize:13];
//        labeltime1.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1];
//        labeltime1.backgroundColor=[UIColor clearColor];
//        [scroView addSubview:labeltime1];
//        [labeltime1 release];
//        
//        
//        UILabel *labelwanfa=[[UILabel alloc]initWithFrame:CGRectMake(20, 75, 200, 30)];
//        labelwanfa.text=@"玩法规则&奖项设置";
//        labelwanfa.textColor=[UIColor blackColor];
//        labelwanfa.backgroundColor=[UIColor clearColor];
//        labelwanfa.font=[UIFont boldSystemFontOfSize:18];
//        [scroView addSubview:labelwanfa];
//        [labelwanfa release];
//        
//        
//        UILabel *labelwanfajieshi=[[UILabel alloc]initWithFrame:CGRectMake(20, 110, 320, 15)];
//        labelwanfajieshi.text=@"每期开出  个数字作为开奖号码，每个数字取值";
//        
//        labelwanfajieshi.backgroundColor=[UIColor clearColor];
//        labelwanfajieshi.font=[UIFont boldSystemFontOfSize:13];
//        labelwanfajieshi.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1];
//        [scroView addSubview:labelwanfajieshi];
//        [labelwanfajieshi release];
//        
//        UILabel *labeljieshi1=[[UILabel alloc]initWithFrame:CGRectMake(72, 110, 15, 15)];
//        labeljieshi1.text=@"3";
//        labeljieshi1.textColor=[UIColor redColor];
//        labeljieshi1.font=[UIFont boldSystemFontOfSize:13];
//        labeljieshi1.backgroundColor=[UIColor clearColor];
//        [scroView addSubview:labeljieshi1];
//        [labeljieshi1 release];
//        
//        
//        
//        UILabel *labelwanfajieshi1=[[UILabel alloc]initWithFrame:CGRectMake(20, 128, 200, 15)];
//        labelwanfajieshi1.text=@"范围为       (相当于摇三个骰子)";
//        labelwanfajieshi1.backgroundColor=[UIColor clearColor];
//        labelwanfajieshi1.font=[UIFont boldSystemFontOfSize:13];
//        labelwanfajieshi1.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1];
//        [scroView addSubview:labelwanfajieshi1];
//        [labelwanfajieshi1 release];
//        
//        UILabel *labeljieshi2=[[UILabel alloc]initWithFrame:CGRectMake(60, 128, 20, 13)];
//        labeljieshi2.text=@"1-6";
//        labeljieshi2.textColor=[UIColor redColor];
//        labeljieshi2.font=[UIFont boldSystemFontOfSize:13];
//        labeljieshi2.backgroundColor=[UIColor clearColor];
//        [scroView addSubview:labeljieshi2];
//        [labeljieshi2 release];
//        
//        
//        
//        UIImageView *imagetubiao=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tubiao.png"]];
//        imagetubiao.frame=CGRectMake(10, 150, 300, 480);
//        [scroView addSubview:imagetubiao];
//        [imagetubiao release];
//        
//        
//        UILabel *labeldan=[[UILabel alloc]initWithFrame:CGRectMake(20, 650, 100, 20)];
//        labeldan.text=@"胆拖玩法";
//        labeldan.textColor=[UIColor blackColor];
//        labeldan.font=[UIFont boldSystemFontOfSize:18];
//        labeldan.backgroundColor=[UIColor clearColor];
//        [scroView addSubview:labeldan];
//        [labeldan release];
//        
//        UILabel *labeldan1=[[UILabel alloc]initWithFrame:CGRectMake(20, 675, 320, 15)];
//        labeldan1.text=@"胆码是您认为必出的号码，拖码是您认为可能出的";
//        labeldan1.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1];
//        labeldan1.font=[UIFont boldSystemFontOfSize:13];
//        labeldan1.backgroundColor=[UIColor clearColor];
//        [scroView addSubview:labeldan1];
//        [labeldan1 release];
//        
//        UILabel *labeldan2=[[UILabel alloc]initWithFrame:CGRectMake(20, 693, 320, 15)];
//        labeldan2.text=@"号码。";
//        labeldan2.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1];
//        labeldan2.font=[UIFont boldSystemFontOfSize:13];
//        labeldan2.backgroundColor=[UIColor clearColor];
//        [scroView addSubview:labeldan2];
//        [labeldan2 release];
//        
//        
//    }
//    else if (ALLWANFA == HBKuai3) {
//        
//        self.CP_navigation.title = @"湖北快3";
//        
//        
//        //  UIBarButtonItem *rightb = [Info backItemTarget:self action:@selector (pressJiQiao:)];
//        //self.CP_navigation.rightBarButtonItem = rightb;
//        caizhongJQ = k3;
//        
//        UIScrollView *scroView=[[UIScrollView alloc]initWithFrame:self.mainView.bounds];
//        
//        [scroView setContentSize:CGSizeMake(320, 750)];
//        scroView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bgn.png"]];
//        [self.mainView addSubview:scroView];
//        [scroView release];
//        
//        
//        
//        UILabel *labeltime=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 30)];
//        labeltime.text=@"开售时间";
//        labeltime.font=[UIFont boldSystemFontOfSize:18];
//        labeltime.backgroundColor=[UIColor clearColor];
//        labeltime.textColor=[UIColor blackColor];
//        [scroView addSubview:labeltime];
//        [labeltime release];
//        
//        UILabel *labeltime1=[[UILabel alloc]initWithFrame:CGRectMake(20, 40, 300, 20)];
//        labeltime1.text=@"09：00-22：00      10分钟一期，每天78期";
//        labeltime1.font=[UIFont boldSystemFontOfSize:13];
//        labeltime1.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1];
//        labeltime1.backgroundColor=[UIColor clearColor];
//        [scroView addSubview:labeltime1];
//        [labeltime1 release];
//        
//        
//        UILabel *labelwanfa=[[UILabel alloc]initWithFrame:CGRectMake(20, 75, 200, 30)];
//        labelwanfa.text=@"玩法规则&奖项设置";
//        labelwanfa.textColor=[UIColor blackColor];
//        labelwanfa.backgroundColor=[UIColor clearColor];
//        labelwanfa.font=[UIFont boldSystemFontOfSize:18];
//        [scroView addSubview:labelwanfa];
//        [labelwanfa release];
//        
//        
//        UILabel *labelwanfajieshi=[[UILabel alloc]initWithFrame:CGRectMake(20, 110, 320, 15)];
//        labelwanfajieshi.text=@"每期开出  个数字作为开奖号码，每个数字取值";
//        
//        labelwanfajieshi.backgroundColor=[UIColor clearColor];
//        labelwanfajieshi.font=[UIFont boldSystemFontOfSize:13];
//        labelwanfajieshi.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1];
//        [scroView addSubview:labelwanfajieshi];
//        [labelwanfajieshi release];
//        
//        UILabel *labeljieshi1=[[UILabel alloc]initWithFrame:CGRectMake(72, 110, 15, 15)];
//        labeljieshi1.text=@"3";
//        labeljieshi1.textColor=[UIColor redColor];
//        labeljieshi1.font=[UIFont boldSystemFontOfSize:13];
//        labeljieshi1.backgroundColor=[UIColor clearColor];
//        [scroView addSubview:labeljieshi1];
//        [labeljieshi1 release];
//        
//        
//        
//        UILabel *labelwanfajieshi1=[[UILabel alloc]initWithFrame:CGRectMake(20, 128, 200, 15)];
//        labelwanfajieshi1.text=@"范围为       (相当于摇三个骰子)";
//        labelwanfajieshi1.backgroundColor=[UIColor clearColor];
//        labelwanfajieshi1.font=[UIFont boldSystemFontOfSize:13];
//        labelwanfajieshi1.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1];
//        [scroView addSubview:labelwanfajieshi1];
//        [labelwanfajieshi1 release];
//        
//        UILabel *labeljieshi2=[[UILabel alloc]initWithFrame:CGRectMake(60, 128, 20, 13)];
//        labeljieshi2.text=@"1-6";
//        labeljieshi2.textColor=[UIColor redColor];
//        labeljieshi2.font=[UIFont boldSystemFontOfSize:13];
//        labeljieshi2.backgroundColor=[UIColor clearColor];
//        [scroView addSubview:labeljieshi2];
//        [labeljieshi2 release];
//        
//        
//        
//        UIImageView *imagetubiao=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tubiao.png"]];
//        imagetubiao.frame=CGRectMake(10, 150, 300, 480);
//        [scroView addSubview:imagetubiao];
//        [imagetubiao release];
//        
//        
//        UILabel *labeldan=[[UILabel alloc]initWithFrame:CGRectMake(20, 650, 100, 20)];
//        labeldan.text=@"胆拖玩法";
//        labeldan.textColor=[UIColor blackColor];
//        labeldan.font=[UIFont boldSystemFontOfSize:18];
//        labeldan.backgroundColor=[UIColor clearColor];
//        [scroView addSubview:labeldan];
//        [labeldan release];
//        
//        UILabel *labeldan1=[[UILabel alloc]initWithFrame:CGRectMake(20, 675, 320, 15)];
//        labeldan1.text=@"胆码是您认为必出的号码，拖码是您认为可能出的";
//        labeldan1.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1];
//        labeldan1.font=[UIFont boldSystemFontOfSize:13];
//        labeldan1.backgroundColor=[UIColor clearColor];
//        [scroView addSubview:labeldan1];
//        [labeldan1 release];
//        
//        UILabel *labeldan2=[[UILabel alloc]initWithFrame:CGRectMake(20, 693, 320, 15)];
//        labeldan2.text=@"号码。";
//        labeldan2.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1];
//        labeldan2.font=[UIFont boldSystemFontOfSize:13];
//        labeldan2.backgroundColor=[UIColor clearColor];
//        [scroView addSubview:labeldan2];
//        [labeldan2 release];
//        
//        
//    }
//    else if (ALLWANFA == JLKuai3) {
//        
//        self.CP_navigation.title = @"吉林快3";
//
//        caizhongJQ = k3;
//        
//        UIScrollView *scroView=[[UIScrollView alloc]initWithFrame:self.mainView.bounds];
//        
//        [scroView setContentSize:CGSizeMake(320, 750)];
//        scroView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bgn.png"]];
//        [self.mainView addSubview:scroView];
//        [scroView release];
//        
//        
//        
//        UILabel *labeltime=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 30)];
//        labeltime.text=@"开售时间";
//        labeltime.font=[UIFont boldSystemFontOfSize:18];
//        labeltime.backgroundColor=[UIColor clearColor];
//        labeltime.textColor=[UIColor blackColor];
//        [scroView addSubview:labeltime];
//        [labeltime release];
//        
//        UILabel *labeltime1=[[UILabel alloc]initWithFrame:CGRectMake(20, 40, 300, 20)];
//        labeltime1.text=@"08：20-21：30      10分钟一期，每天79期";
//        labeltime1.font=[UIFont boldSystemFontOfSize:13];
//        labeltime1.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1];
//        labeltime1.backgroundColor=[UIColor clearColor];
//        [scroView addSubview:labeltime1];
//        [labeltime1 release];
//        
//        
//        UILabel *labelwanfa=[[UILabel alloc]initWithFrame:CGRectMake(20, 75, 200, 30)];
//        labelwanfa.text=@"玩法规则&奖项设置";
//        labelwanfa.textColor=[UIColor blackColor];
//        labelwanfa.backgroundColor=[UIColor clearColor];
//        labelwanfa.font=[UIFont boldSystemFontOfSize:18];
//        [scroView addSubview:labelwanfa];
//        [labelwanfa release];
//        
//        
//        UILabel *labelwanfajieshi=[[UILabel alloc]initWithFrame:CGRectMake(20, 110, 320, 15)];
//        labelwanfajieshi.text=@"每期开出  个数字作为开奖号码，每个数字取值";
//        
//        labelwanfajieshi.backgroundColor=[UIColor clearColor];
//        labelwanfajieshi.font=[UIFont boldSystemFontOfSize:13];
//        labelwanfajieshi.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1];
//        [scroView addSubview:labelwanfajieshi];
//        [labelwanfajieshi release];
//        
//        UILabel *labeljieshi1=[[UILabel alloc]initWithFrame:CGRectMake(72, 110, 15, 15)];
//        labeljieshi1.text=@"3";
//        labeljieshi1.textColor=[UIColor redColor];
//        labeljieshi1.font=[UIFont boldSystemFontOfSize:13];
//        labeljieshi1.backgroundColor=[UIColor clearColor];
//        [scroView addSubview:labeljieshi1];
//        [labeljieshi1 release];
//        
//        
//        
//        UILabel *labelwanfajieshi1=[[UILabel alloc]initWithFrame:CGRectMake(20, 128, 200, 15)];
//        labelwanfajieshi1.text=@"范围为       (相当于摇三个骰子)";
//        labelwanfajieshi1.backgroundColor=[UIColor clearColor];
//        labelwanfajieshi1.font=[UIFont boldSystemFontOfSize:13];
//        labelwanfajieshi1.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1];
//        [scroView addSubview:labelwanfajieshi1];
//        [labelwanfajieshi1 release];
//        
//        UILabel *labeljieshi2=[[UILabel alloc]initWithFrame:CGRectMake(60, 128, 20, 13)];
//        labeljieshi2.text=@"1-6";
//        labeljieshi2.textColor=[UIColor redColor];
//        labeljieshi2.font=[UIFont boldSystemFontOfSize:13];
//        labeljieshi2.backgroundColor=[UIColor clearColor];
//        [scroView addSubview:labeljieshi2];
//        [labeljieshi2 release];
//        
//        
//        
//        UIImageView *imagetubiao=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tubiao.png"]];
//        imagetubiao.frame=CGRectMake(10, 150, 300, 480);
//        [scroView addSubview:imagetubiao];
//        [imagetubiao release];
//        
//        
//        UILabel *labeldan=[[UILabel alloc]initWithFrame:CGRectMake(20, 650, 100, 20)];
//        labeldan.text=@"胆拖玩法";
//        labeldan.textColor=[UIColor blackColor];
//        labeldan.font=[UIFont boldSystemFontOfSize:18];
//        labeldan.backgroundColor=[UIColor clearColor];
//        [scroView addSubview:labeldan];
//        [labeldan release];
//        
//        UILabel *labeldan1=[[UILabel alloc]initWithFrame:CGRectMake(20, 675, 320, 15)];
//        labeldan1.text=@"胆码是您认为必出的号码，拖码是您认为可能出的";
//        labeldan1.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1];
//        labeldan1.font=[UIFont boldSystemFontOfSize:13];
//        labeldan1.backgroundColor=[UIColor clearColor];
//        [scroView addSubview:labeldan1];
//        [labeldan1 release];
//        
//        UILabel *labeldan2=[[UILabel alloc]initWithFrame:CGRectMake(20, 693, 320, 15)];
//        labeldan2.text=@"号码。";
//        labeldan2.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1];
//        labeldan2.font=[UIFont boldSystemFontOfSize:13];
//        labeldan2.backgroundColor=[UIColor clearColor];
//        [scroView addSubview:labeldan2];
//        [labeldan2 release];
//        
//        
//    }
    else if (ALLWANFA == PKSai) {
        self.CP_navigation.title = @"玩法说明";
        
        UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 300, 2)];
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = UIImageGetImageFromName(@"SZTG960.png") ;
        [self.mainView addSubview:xian];
        [xian release];
        
        UILabel *titlte = [[UILabel alloc] init];
        titlte.backgroundColor = [UIColor clearColor];
        titlte.frame = CGRectMake(18, 12, 280, 18);
        titlte.font = [UIFont boldSystemFontOfSize:15];
        titlte.text = @"足彩胜负彩14场";
        [self.mainView addSubview:titlte];
        [titlte release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(18, 34, 280, 30)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @" 竞猜14场比赛90分钟内(含伤停补时)的胜平负的结果,3为胜,1为平,0为负。";
        kjTime2.numberOfLines = 0;
        kjTime2.font = [UIFont boldSystemFontOfSize:12];
        kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [self.mainView addSubview:kjTime2];
        [kjTime2 release];
        
        UILabel *lable1 = [[UILabel alloc] init];
        lable1.backgroundColor = [UIColor clearColor];
        lable1.frame = CGRectMake(22, 90, 100, 18);
        lable1.font = [UIFont boldSystemFontOfSize:12];
        lable1.text = @"单式投注";
        [self.mainView addSubview:lable1];
        [lable1 release];
        
        ColorView *lable11 = [[ColorView alloc] init];
        lable11.frame = CGRectMake(80, 92, 200, 18);
        lable11.font = [UIFont systemFontOfSize:10];
        lable11.text = @"对14场比赛各选 <1> 种比赛结果";
        lable11.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        lable11.backgroundColor = [UIColor clearColor];
        [self.mainView addSubview:lable11];
        [lable11 release];
        
        UILabel *lable2 = [[UILabel alloc] init];
        lable2.backgroundColor = [UIColor clearColor];
        lable2.frame = CGRectMake(22, 110, 100, 18);
        lable2.font = [UIFont boldSystemFontOfSize:12];
        lable2.text = @"复式投注";
        [self.mainView addSubview:lable2];
        [lable2 release];
        
        ColorView *lable21 = [[ColorView alloc] init];
        lable21.frame = CGRectMake(80, 115, 205, 30);
        lable21.backgroundColor = [UIColor clearColor];
        lable21.font = [UIFont systemFontOfSize:10];
        lable21.text = @"对14场比赛中某一场或几场比赛选择 <2> 种以上结果";
        lable21.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [self.mainView addSubview:lable21];
        [lable21 release];
    }
    else if (ALLWANFA == guanjunwanfaxy){
    
        self.CP_navigation.rightBarButtonItem = nil;
        UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
        backScrollView.userInteractionEnabled = YES;
        [backScrollView setContentSize:CGSizeMake(320, self.mainView.frame.size.height)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        
        
        self.title  = @"世界杯冠军";
        
        UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
        kjTime.backgroundColor = [UIColor clearColor];
        kjTime.text = @"玩法规则";
        kjTime.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime];
        [kjTime release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 43, 266, 10)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @"世界杯冠军竞猜游戏以国家体育总局体育彩票管理中心选定";
        kjTime2.font = [UIFont boldSystemFontOfSize:10];
        kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime2];
        [kjTime2 release];
        UILabel *kjTime21 = [[UILabel alloc] initWithFrame:CGRectMake(27, 61, 266, 10)];
        kjTime21.backgroundColor = [UIColor clearColor];
        kjTime21.text = @"的2014世界杯为竞猜对象,由用户对2014世界杯的冠军归";
        kjTime21.font = [UIFont boldSystemFontOfSize:10];
        kjTime21.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime21];
        [kjTime21 release];
        UILabel *kjTime22 = [[UILabel alloc] initWithFrame:CGRectMake(27, 79, 266, 10)];
        kjTime22.backgroundColor = [UIColor clearColor];
        kjTime22.text = @"属结果进行投注。";
        kjTime22.font = [UIFont boldSystemFontOfSize:10];
        kjTime22.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime22];
        [kjTime22 release];
        
        UILabel *kjTime23 = [[UILabel alloc] initWithFrame:CGRectMake(27, 117, 286, 10)];
        kjTime23.backgroundColor = [UIColor clearColor];
        kjTime23.text = @"竞猜某队伍获得世界杯的冠军。";
        kjTime23.font = [UIFont boldSystemFontOfSize:10];
        kjTime23.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime23];
        [kjTime23 release];
        
        
//        [self jiangJin:backScrollView y:134];
    }else if (ALLWANFA == guanyajunwanfaxy){
        self.CP_navigation.rightBarButtonItem = nil;
        UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
        backScrollView.userInteractionEnabled = YES;
        [backScrollView setContentSize:CGSizeMake(320, self.mainView.frame.size.height)];
        if (backScrollView.contentSize.height < backScrollView.bounds.size.height) {
            backScrollView.scrollEnabled = NO;
        }
        [self.mainView addSubview:backScrollView];
        [backScrollView release];
        
        
        self.title = @"世界杯冠亚军";
        
        UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 125, 15)];
        kjTime.backgroundColor = [UIColor clearColor];
        kjTime.text = @"玩法规则";
        kjTime.font = [UIFont boldSystemFontOfSize:15];
        [backScrollView addSubview:kjTime];
        [kjTime release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 43, 266, 10)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @"世界杯冠亚军竞猜游戏以国家体育总局体育彩票管理中心选";
        kjTime2.font = [UIFont boldSystemFontOfSize:10];
        kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime2];
        [kjTime2 release];
        UILabel *kjTime21 = [[UILabel alloc] initWithFrame:CGRectMake(27, 61, 266, 10)];
        kjTime21.backgroundColor = [UIColor clearColor];
        kjTime21.text = @"定的2014世界杯为竞猜对象,由用户对2014世界杯 冠亚军归";
        kjTime21.font = [UIFont boldSystemFontOfSize:10];
        kjTime21.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime21];
        [kjTime21 release];
        UILabel *kjTime22 = [[UILabel alloc] initWithFrame:CGRectMake(27, 79, 266, 10)];
        kjTime22.backgroundColor = [UIColor clearColor];
        kjTime22.text = @"属结果进行投注。";
        kjTime22.font = [UIFont boldSystemFontOfSize:10];
        kjTime22.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:kjTime22];
        [kjTime22 release];
        
        
        
        UILabel *jjfd = [[UILabel alloc] initWithFrame:CGRectMake(27, 114, 110, 10)];
        jjfd.backgroundColor = [UIColor clearColor];
        jjfd.text = @"结果选项包括2种:";
        jjfd.font = [UIFont boldSystemFontOfSize:10];
        jjfd.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd];
        [jjfd release];
        
        UILabel *jjfd2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 132, 266, 10)];
        jjfd2.backgroundColor = [UIColor clearColor];
        jjfd2.text = @"(一)“某队伍A _ 某队伍B”:";
        jjfd2.font = [UIFont boldSystemFontOfSize:10];
        jjfd2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd2];
        [jjfd2 release];
        
        UILabel *jjfd3 = [[UILabel alloc] initWithFrame:CGRectMake(27, 150, 266, 10)];
        jjfd3.backgroundColor = [UIColor clearColor];
        jjfd3.text = @"某队伍A和某队伍B以任意顺序获得世界杯的冠亚军。";
        jjfd3.font = [UIFont boldSystemFontOfSize:10];
        jjfd3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd3];
        [jjfd3 release];
        
        UILabel *jjfd4 = [[UILabel alloc] initWithFrame:CGRectMake(27, 180, 266, 10)];
        jjfd4.backgroundColor = [UIColor clearColor];
        jjfd4.text = @"(二)“其他”:";
        jjfd4.font = [UIFont boldSystemFontOfSize:10];
        jjfd4.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd4];
        [jjfd4 release];
        
        UILabel *jjfd5 = [[UILabel alloc] initWithFrame:CGRectMake(27, 198, 266, 10)];
        jjfd5.backgroundColor = [UIColor clearColor];
        jjfd5.text = @"任意未包含在“某队伍A _ 某队伍B”范围内的队伍获得世界杯";
        jjfd5.font = [UIFont boldSystemFontOfSize:10];
        jjfd5.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd5];
        [jjfd5 release];
        
        UILabel *jjfd6 = [[UILabel alloc] initWithFrame:CGRectMake(27, 216, 266, 10)];
        jjfd6.backgroundColor = [UIColor clearColor];
        jjfd6.text = @"的冠亚军。";
        jjfd6.font = [UIFont boldSystemFontOfSize:10];
        jjfd6.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backScrollView addSubview:jjfd6];
        [jjfd6 release];
        
        
    }

}

-(void)jiangJin:(UIScrollView *)backScrollView y:(float)y
{
    
    UILabel * jiangjin = [[[UILabel alloc] initWithFrame:CGRectMake(20, y + 10+30, 125, 15)] autorelease];
    jiangjin.backgroundColor = [UIColor clearColor];
    jiangjin.text = @"奖金";
    jiangjin.font = [UIFont boldSystemFontOfSize:15];
    [backScrollView addSubview:jiangjin];
    
    UILabel * how = [[[UILabel alloc] initWithFrame:CGRectMake(27, jiangjin.frame.origin.y + jiangjin.frame.size.height + 5, 266, 15)] autorelease];
    how.backgroundColor = [UIColor clearColor];
    how.text = @"如何计算奖金";
    how.font = [UIFont boldSystemFontOfSize:12];
    [backScrollView addSubview:how];
    how.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    
//@"竞彩足球：\n单关：2×出票赔率×倍数\n串关：2×出票赔率连乘×倍数\n竞彩篮球：\n单关：2×出票赔率×倍数\n串关：2×出票赔率连乘×倍数\n足球单场：\n单关：2×开奖赔率×倍数×65%\n串关：2×开奖赔率之积×倍数×65%"
    UILabel * info = [[[UILabel alloc] initWithFrame:CGRectMake(27, how.frame.origin.y + how.frame.size.height + 5, 266, 50)] autorelease];
    info.backgroundColor = [UIColor clearColor];
    if (ALLWANFA == BeiJingDanChang || ALLWANFA == bdbanquanchang || ALLWANFA == bdbifen || ALLWANFA == bdshangxiadanshuang || ALLWANFA == bdzongjinqiu || ALLWANFA == beidanshengfu) {
        info.text = @"足球单场：\n单关：2×开奖赔率×倍数×65%\n串关：2×开奖赔率之积×倍数×65%";
//        [MobClick event:@"event_goucai_wanfashuoming_touzhujiqiao_caizong" label:@"北单"];
    }
    else if (ALLWANFA == JingCaiZuQiu || ALLWANFA == huntou || (ALLWANFA >= JingCaiZuQiuZJQS && ALLWANFA <= JingCaiZuQiuRQSPF) || ALLWANFA == hunTouErXuanYi) {
        info.text = @"竞彩足球：\n单关：2×出票赔率×倍数\n串关：2×出票赔率连乘×倍数";
//        [MobClick event:@"event_goucai_wanfashuoming_touzhujiqiao_caizong" label:@"竞彩足球"];
    }
    else if (ALLWANFA == lanqiuhuntouwf || (ALLWANFA >= JingCaiLanQiuDXF && ALLWANFA <= JingCaiLanQiuSF)) {
        info.text = @"竞彩篮球：\n单关：2×出票赔率×倍数\n串关：2×出票赔率连乘×倍数";
//        [MobClick event:@"event_goucai_wanfashuoming_touzhujiqiao_caizong" label:@"竞彩篮球"];
    }
    info.numberOfLines = 0;
    info.font = [UIFont boldSystemFontOfSize:12];
    [backScrollView addSubview:info];
    info.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    
//    UIButton * howButton = [[[UIButton alloc] initWithFrame:CGRectMake(how.frame.origin.x + 65, how.frame.origin.y - 13, 40, 40)] autorelease];
//    [backScrollView addSubview:howButton];
//    [howButton addTarget:self action:@selector(howTo) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIImageView * wenhaoImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(howButton.frame.origin.x + 13, howButton.frame.origin.y + 12, 16, 16)] autorelease];
//    wenhaoImageView.image = UIImageGetImageFromName(@"faq-wenhao.png");
//    [backScrollView addSubview:wenhaoImageView];
}

-(void)howTo
{
//    FAQView *faq = [[FAQView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    faq.faqdingwei = JiangJinJiSuan;
//    [faq Show];
//    [faq release];
    
    QuestionViewController *qvc=[[QuestionViewController alloc]init];
    qvc.question = JiangJinJiSuanType;
    [self.navigationController pushViewController:qvc animated:YES];
    [qvc release];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[infoText release];
    [myTableView release];
    [cell1Array release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    