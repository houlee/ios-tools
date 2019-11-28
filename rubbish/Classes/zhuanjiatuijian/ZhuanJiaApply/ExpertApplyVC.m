//
//  ExpertApplyVC.m
//  Experts
//
//  Created by v1pin on 15/11/2.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "ExpertApplyVC.h"
#import "CommonProblemViewController.h"
#import "NetURL.h"
#import "UpLoadView.h"

#define EXTYPE 100
#define EXHEAD 101
#define EXNICK 102
#define EXINTROD 103
#define EXREASON 104

@interface ExpertApplyVC ()<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    UpLoadView * loadview;
    ASIHTTPRequest * applyRequest;
    BOOL agreement;
}
@property (nonatomic,strong) UITextView *nickTxtView;
@property (nonatomic,strong) UITextView *ex_introd_view;
@property (nonatomic,strong) UITextView *ex_reason_view;
@property (nonatomic,strong) UIView *ex_type_view;
@property (nonatomic,strong) UIImageView *headImgView;

@property (nonatomic,strong) NSString *exTypeStr;
@property (nonatomic,strong) NSString *exNickStr;
@property (nonatomic,strong) NSString *exIntrStr;
@property (nonatomic,strong) NSString *exResnStr;

@property (nonatomic,strong) NSData *headImgData;
@property (nonatomic,strong) UIButton *applyBtn;

@property (nonatomic,strong) UIImageView *duihaoImgV;

@property (nonatomic, retain) ASIHTTPRequest * applyRequest;

//@property (nonatomic,strong) UIView *bintrLine;//简介分割线
//@property (nonatomic,strong) UIView *botomLine;//底部分割线
//@property (nonatomic,strong) UILabel *serAgreeLab;

@end

@implementation ExpertApplyVC

@synthesize applyRequest;

NSInteger prewTag;
float prewMoveY; //编辑的时候移动的高度

- (void)dealloc
{
    [applyRequest clearDelegatesAndCancel];
    self.applyRequest = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _exTypeStr=@"";
    _exNickStr=@"";
    _exIntrStr=@"";
    _exResnStr=@"";
    
    _exTypeStr = @"001";
    
    self.title_nav=@"申请专家";
    [self creatNavView];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishEdit:) name:UITextViewTextDidEndEditingNotification object:nil];
    
    for (int i=0; i<5; i++) {
        float heightY=0;
        UIView *view=[[UIView alloc] init];
        [self.view addSubview:view];
        if (i==0) {
            heightY=40;
#if defined CRAZYSPORTS
            heightY=0;
            view.hidden = YES;
#endif
        }else if(i==1){
            heightY=55;
        }else if(i==2){
            heightY=45;
        }else if(i==3){
            heightY=80;
        }else if(i==4){
            heightY=80;
        }
        view.backgroundColor=[UIColor clearColor];
        
        UIView *sepratorLine=[[UIView alloc] init];
        if (i==0) {
            [sepratorLine setFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44+14, MyWidth, 1)];
        }else{
            if(i==1||i==2){
                [sepratorLine setFrame:CGRectMake(15, ORIGIN_Y(_ex_type_view), MyWidth-15, 1)];
            }else
                [sepratorLine setFrame:CGRectMake(95, ORIGIN_Y(_ex_type_view), MyWidth-95, 1)];
        }
        sepratorLine.backgroundColor=SEPARATORCOLOR;
        [self.view addSubview:sepratorLine];
        
        UILabel *ex_type_lab=[[UILabel alloc] initWithFrame:CGRectMake(15, 5, 65, 30)];
        ex_type_lab.textColor=BLACK_FIFITYFOUR;
        ex_type_lab.font=FONTTHIRTYBOLD;
        ex_type_lab.backgroundColor=[UIColor clearColor];
        [view addSubview:ex_type_lab];
        if (i==0) {
            view.tag=EXTYPE;
            ex_type_lab.text=@"专家类型";
        }else if(i==1){
            view.tag=EXHEAD;
            ex_type_lab.text=@"上传头像";
            [ex_type_lab setFrame:CGRectMake(15, 15, 65, 25)];
        }else if(i==2){
            view.tag=EXNICK;
            ex_type_lab.text=@"专家昵称";
            [ex_type_lab setFrame:CGRectMake(15, 15, 65, 15)];
        }else if(i==3){
            view.tag=EXINTROD;
            ex_type_lab.text=@"专家简介";
            [ex_type_lab setFrame:CGRectMake(15, 15, 65, 15)];
        }else if(i==4){
            view.tag=EXREASON;
            ex_type_lab.text=@"申请理由";
            [ex_type_lab setFrame:CGRectMake(15, 15, 65, 15)];
        }
        
        if (i==0) {
            [view setFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44+15, MyWidth, heightY)];
            _ex_type_view=view;
            
            NSInteger num = 2;
#if defined CRAZYSPORTS
            num = 1;
#endif
            for(int j=0;j<num;j++){
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                [btn setFrame:CGRectMake(CGRectGetMaxX(ex_type_lab.frame)+15+100*j, CGRectGetMinY(ex_type_lab.frame), 30, 30)];
                btn.layer.cornerRadius=15;
                btn.tag=1001+j;
                [btn setImage:[UIImage imageNamed:@"专家类型-未选"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"专家类型-选中按钮"] forState:UIControlStateSelected];
                [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_ex_type_view addSubview:btn];
                
                UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+5, CGRectGetMinY(btn.frame), 80, 30)];
                lab.textColor=BLACK_EIGHTYSEVER;
                lab.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
                lab.backgroundColor=[UIColor clearColor];
                lab.font=FONTTHIRTY;
                if (j==0) {
                    lab.text=@"竞彩专家";
                }else
                    lab.text=@"数字彩专家";
                [lab sizeToFit];
                
                CGRect rect=lab.frame;
                rect.origin.y=_ex_type_view.frame.size.height/2-rect.size.height/2;
                [lab setFrame:rect];
                
                [_ex_type_view addSubview:lab];
            }
        }else{
            [view setFrame:CGRectMake(0, ORIGIN_Y(_ex_type_view)+1, MyWidth, heightY)];
            _ex_type_view=view;
            
            if(i==1){
                UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(MyWidth-80, _ex_type_view.frame.size.height/2-15, 30, 30)];
                imgView.hidden=YES;
                imgView.layer.masksToBounds=YES;
                imgView.layer.cornerRadius=15;
                [_ex_type_view addSubview:imgView];
                _headImgView=imgView;
                
                UIImageView *indicatorView=[[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(imgView)+15, _ex_type_view.frame.size.height/2-7.5, 9, 14.5)];
                indicatorView.image=[UIImage imageNamed:@"箭头"];
                [_ex_type_view addSubview:indicatorView];
                
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addHeadClick:)];
                _ex_type_view.userInteractionEnabled = YES;
                [_ex_type_view addGestureRecognizer:tap];
                
            }else if(i==2){
                _nickTxtView=[[UITextView alloc] initWithFrame:CGRectMake(ORIGIN_X(ex_type_lab)+15, 5, MyWidth-ORIGIN_X(ex_type_lab)-35, 35)];
                _nickTxtView.delegate=self;
                _nickTxtView.returnKeyType=UIReturnKeyDefault;
                _nickTxtView.text=@"请输入昵称";
                _nickTxtView.font=FONTTHIRTY;
                _nickTxtView.textColor=BLACK_TWENTYSIX;
                _nickTxtView.tag=EXNICK;
                [_ex_type_view addSubview:_nickTxtView];
            }else if(i==3){
                _ex_introd_view=[[UITextView alloc] initWithFrame:CGRectMake(ORIGIN_X(ex_type_lab)+15, 5, MyWidth-ORIGIN_X(ex_type_lab)-35, 70)];
                _ex_introd_view.delegate=self;
                _ex_introd_view.returnKeyType=UIReturnKeyDefault;
                _ex_introd_view.text=@"请输入简介，30-100之间";
                _ex_introd_view.font=FONTTHIRTY;
                _ex_introd_view.textColor=BLACK_TWENTYSIX;
                _ex_introd_view.tag=EXINTROD;
                [_ex_type_view addSubview:_ex_introd_view];
            }else if(i==4){
                _ex_reason_view=[[UITextView alloc] initWithFrame:CGRectMake(ORIGIN_X(ex_type_lab)+15, 5, MyWidth-ORIGIN_X(ex_type_lab)-35, 70)];
                _ex_reason_view.delegate=self;
                _ex_reason_view.returnKeyType=UIReturnKeyDefault;
                _ex_reason_view.text=@"请输入申请理由";
                _ex_reason_view.font=FONTTHIRTY;
                _ex_reason_view.textColor=BLACK_TWENTYSIX;
                _ex_reason_view.tag=EXREASON;
                [_ex_type_view addSubview:_ex_reason_view];
            }
            UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, MyWidth, 30)];
            [topView setBarStyle:UIBarStyleDefault];
            topView.tintColor=[UIColor whiteColor];
            if (IS_IOS7) {
                topView.barTintColor=[UIColor colorWithRed:21.0/255 green:136.0/255 blue:218.0/255 alpha:1.0];
            }
            UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
            NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,btnSpace,doneButton,nil];
            [topView setItems:buttonsArray];
            _nickTxtView.inputView.backgroundColor=[UIColor clearColor];
            _ex_introd_view.inputView.backgroundColor=[UIColor clearColor];
            _ex_reason_view.inputView.backgroundColor=[UIColor clearColor];
            [_nickTxtView setInputAccessoryView:topView];
            [_ex_introd_view setInputAccessoryView:topView];
            [_ex_reason_view setInputAccessoryView:topView];
        }
    }
    UIView *sepratorLine=[[UIView alloc] init];
    [sepratorLine setFrame:CGRectMake(0, ORIGIN_Y(_ex_type_view), MyWidth, 1)];
    sepratorLine.backgroundColor=SEPARATORCOLOR;
    [self.view addSubview:sepratorLine];
    
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(MyWidth/2-60, CGRectGetMaxY(sepratorLine.frame)+10, 120, 20)];
#if defined YUCEDI || defined DONGGEQIU || defined CRAZYSPORTS
    lab.text=@"专家服务协议";
#else
    lab.text=@"365专家服务协议";
#endif
    lab.textColor=[UIColor blueColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=FONTTWENTY_FOUR;
    CGRect rect=lab.frame;
    [lab sizeToFit];
    [lab setBackgroundColor:[UIColor clearColor]];
    [lab setFrame:CGRectMake(MyWidth/2-rect.size.width/2, rect.origin.y, rect.size.width, rect.size.height)];
    [self.view addSubview:lab];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushCategory:)];
    lab.userInteractionEnabled=YES;
    [lab addGestureRecognizer:tap];
    
    UIImageView *kouImg=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(lab.frame)-18, CGRectGetMinY(lab.frame)+2, 16, 16)];
    kouImg.image=[UIImage imageNamed:@"注册-同意协议框"];
    [self.view addSubview:kouImg];
    
    UITapGestureRecognizer *kouImgTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sureOrNo:)];
    kouImg.userInteractionEnabled=YES;
    [kouImg addGestureRecognizer:kouImgTap];
    
    _duihaoImgV=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(lab.frame)-18, CGRectGetMinY(lab.frame)+2, 16, 16)];
    _duihaoImgV.image=[UIImage imageNamed:@"注册-同意协议"];
    _duihaoImgV.hidden=NO;
    [self.view addSubview:_duihaoImgV];
    
    agreement = YES;
    
    _applyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_applyBtn setFrame:CGRectMake(15, ORIGIN_Y(_ex_type_view)+50, 290, 40)];
    [_applyBtn setBackgroundImage:[UIImage imageNamed:@"通用-信息填写前"] forState:UIControlStateDisabled];
    [_applyBtn setBackgroundImage:[UIImage imageNamed:@"通用-信息填写后"] forState:UIControlStateNormal];
    [_applyBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [_applyBtn setTitle:@"提交申请" forState:UIControlStateHighlighted];
    [_applyBtn setTitleColor:TEXTWITER_COLOR forState:UIControlStateNormal];
    [_applyBtn addTarget:self action:@selector(submitApply:) forControlEvents:UIControlEventTouchUpInside];
    _applyBtn.enabled=NO;
    [self.view addSubview:_applyBtn];
}

- (void)sureOrNo:(UITapGestureRecognizer *)sender{
    _duihaoImgV.hidden=!_duihaoImgV.hidden;
    if (_duihaoImgV.hidden) {
        agreement = NO;
    }else{
        agreement = YES;
    }
    [self checkApplyBtnState];
}

-(void)dismissKeyBoard
{
    
    [self.view endEditing:YES];;
}

- (void)pushCategory:(id)sender{
    CommonProblemViewController * vc = [[CommonProblemViewController alloc]init];
    vc.sourceFrom=@"expertCategory";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)finishEdit:(id)sender{
    [_nickTxtView resignFirstResponder];
    [_ex_introd_view resignFirstResponder];
    [_ex_reason_view resignFirstResponder];
}

- (void)clickBtn:(UIButton *)sender{
    sender.selected=YES;
    UIView *view=[self.view viewWithTag:EXTYPE];
    UIButton *btn=(UIButton *)[view viewWithTag:2003-sender.tag];
    btn.selected=NO;
    if (sender.tag==1001) {
        _exTypeStr=@"001";
    }else if(sender.tag==1002){
        _exTypeStr=@"002";
    }
}

- (void)addHeadClick:(UIButton *)sender{
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
}

- (void)submitApply:(UIButton *)btn{
    NSString *alterStr=@"";
    if ([_exTypeStr isEqualToString:@""]||_exTypeStr==nil) {
        alterStr=@"请选择专家类型";
    }else if(!_headImgData){
        alterStr=@"请上传头像";
    }else if ([_exNickStr isEqualToString:@""]||_exNickStr==nil||[_exNickStr isEqualToString:@"请输入昵称"]){
        alterStr=@"请输入昵称";
    }else if ([_exIntrStr isEqualToString:@""]||_exIntrStr==nil||[_exIntrStr isEqualToString:@"请输入简介，30-100之间"]){
        alterStr=@"请输入专家简介";
    }else if ([_exResnStr isEqualToString:@""]||_exResnStr==nil||[_exResnStr isEqualToString:@"请输入申请理由"]){
        alterStr=@"请输入申请理由";
    }
    if (![alterStr isEqualToString:@""]) {
        ALERT(@"提示", alterStr, @"确定", nil);
        return;
    }
    if (_exIntrStr.length<30||_exIntrStr.length>100) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"请输入30~100字以内专家简介" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        return;
    }
    
    //    ALERT(@"提示", @"提交成功", @"确定", nil);
    
    loadview = [[UpLoadView alloc] init];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    
    [self uploadHeadImage:_headImgData];
}

- (void)uploadHeadImage:(NSData*)imageData {//图片上传
    
    NSString * userID = [[Info getInstance] userId];
    
    NSString * key = [NetURL EncryptWithMD5:[NSString stringWithFormat:@"sdkdiekdkdkdkdiwkxkspslmx%@",userID]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/servlet/upPicService?key=%@&userId=%@&version=%@",UPLOADHOST,key,userID,newVersionKey];
    
    NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc] init];
    [request2 setURL:[NSURL URLWithString:urlString]];
    [request2 setHTTPMethod:@"POST"];
    //
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request2 addValue:contentType forHTTPHeaderField: @"Content-Type"];
    //
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\"vim_go.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request2 setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
    
    NSString *returnStr = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSString * urlStr = @"";
    if (returnStr && returnStr.length) {
        urlStr = [[returnStr JSONValue] valueForKey:@"url"];
    }
    if (!returnStr || !urlStr) {
        if (loadview) {
            [loadview stopRemoveFromSuperview];
            loadview = nil;
        }
        
        CP_UIAlertView *alety = [[CP_UIAlertView alloc] initWithTitle:@"" message:@"图片上传失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alety show];
        
        return;
    }
    
    [self sendRequestImgeUrl:urlStr];
}

- (void)sendRequestImgeUrl:(NSString *)imageUrl
{
    NSMutableDictionary * dic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"zjtjExpertApply",@"parameters":@{@"expertClassCode":_exTypeStr,@"userName":[[Info getInstance] userName],@"expertNickName":_exNickStr,@"expertDesc":_exIntrStr,@"reason":_exResnStr,@"url":imageUrl}}];
    NSString  *parameterStr = [RequestEntity dictionaryToJson:dic];
    
    [self.applyRequest clearDelegatesAndCancel];
    self.applyRequest = [ASIHTTPRequest requestWithURL:[NetURL expertApplyByPicUrl:imageUrl parameterStr:parameterStr]];
    [applyRequest setTimeOutSeconds:20.0];
    [applyRequest setDidFinishSelector:@selector(applyFinish:)];
    [applyRequest setDidFailSelector:@selector(applyFail:)];
    [applyRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [applyRequest setDelegate:self];
    [applyRequest startAsynchronous];
}

- (void)applyFinish:(ASIHTTPRequest *)ssrequest {
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
    NSString *responseStr = [ssrequest responseString];
    NSDictionary * result = [responseStr JSONValue];
    if (result && [result valueForKey:@"resultCode"]) {
        if ([[result valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            UIAlertView *alert=alert= [[UIAlertView alloc]initWithTitle:nil message:@"您已经提交了专家申请我们将尽快为您审核" delegate:self cancelButtonTitle:@"知道啦" otherButtonTitles:nil];
            alert.tag=605;
            [alert show];
        }else{
            NSString * msg = @"专家申请失败";
            if ([result valueForKey:@"resultDesc"] && [[result valueForKey:@"resultDesc"] length]) {
                msg = [result valueForKey:@"resultDesc"];
            }
            UIAlertView *alert=alert= [[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"知道啦" otherButtonTitles:nil];
            [alert show];
        }
    }else{
        UIAlertView *alert=alert= [[UIAlertView alloc]initWithTitle:nil message:@"专家申请失败" delegate:nil cancelButtonTitle:@"知道啦" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)applyFail:(ASIHTTPRequest *)ssrequest {
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    UIAlertView *alert=alert= [[UIAlertView alloc]initWithTitle:nil message:@"专家申请失败" delegate:nil cancelButtonTitle:@"知道啦" otherButtonTitles:nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==605&&buttonIndex==0) {
        Info *info = [Info getInstance];
        NSString *nameSty=@"";
        if ([info.userId intValue]) {
            nameSty=[[Info getInstance] userName];
        }
        [DEFAULTS removeObjectForKey:@"resultDic"];
        [DEFAULTS setObject:[NSDictionary dictionary] forKey:@"resultDic"];
        NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"expertsName":nameSty}];
        NSMutableDictionary * bodyDic = [NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"expertService",@"methodName":@"getExpertBaseInfo",@"parameters":parameters}];
        [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id JSON ) {
            NSDictionary * resultDic  = [NSDictionary dictionary];
            if (![JSON[@"result"] isEqual:[NSNull null]]) {
                resultDic = JSON[@"result"];
            }
            [DEFAULTS setObject:resultDic forKey:@"resultDic"];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            
        }];
    }
}

//- (void)sendRequestImgeUrl:(NSString *)imageUrl
//{
//
//
//    [RequestEntity requestDatapartWithJsonBodyDic:dic success:^(id responseJSON) {
//        NSLog(@"responseJSON==%@",responseJSON);
//        if (loadview) {
//            [loadview stopRemoveFromSuperview];
//            loadview = nil;
//        }
//        if([responseJSON[@"resultCode"] isEqualToString:@"0000"]){
//            UIAlertView *alert=alert= [[UIAlertView alloc]initWithTitle:nil message:@"您已经提交了专家申请我们将尽快为您审核" delegate:nil cancelButtonTitle:@"知道啦" otherButtonTitles:nil];
//            [alert show];
//        }else{
//            UIAlertView *alert=alert= [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@",[responseJSON objectForKey:@"resultDesc"]] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
//            [alert show];
//
//            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"error===%@",error);
//        if (loadview) {
//            [loadview stopRemoveFromSuperview];
//            loadview = nil;
//        }
//        UIAlertView *alert=alert= [[UIAlertView alloc]initWithTitle:nil message:@"专家申请失败" delegate:nil cancelButtonTitle:@"知道啦" otherButtonTitles:nil];
//        [alert show];
//    }];
//
//}

/**
 *  UIAlertView自动消失处理代码
 */
-(void)dimissAlert:(UIAlertView *)Alert
{
    [Alert dismissWithClickedButtonIndex:[Alert cancelButtonIndex] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.firstOtherButtonIndex)
    {
        //使用内置的照相机拍摄图片
        if([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)])// 判断是否有摄像头
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            [picker setDelegate:self];
            [picker setSourceType:(UIImagePickerControllerSourceTypeCamera)];
            [self.navigationController presentViewController:picker animated:YES completion:^{}];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"不支持相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } else if( buttonIndex == 1) {
        //从现有的照片库中选择图像
        if([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypePhotoLibrary)])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            [picker setDelegate:self];
            [picker setSourceType:(UIImagePickerControllerSourceTypePhotoLibrary)];
            [self.navigationController presentViewController:picker animated:YES completion:^{}];
        }
    }
}

- (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^(){
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        _headImgView.hidden=NO;
        _headImgView.image=portraitImg;
        UIImage *sendImage = [self image:portraitImg rotation:portraitImg.imageOrientation];
        _headImgData = UIImageJPEGRepresentation(sendImage, 0.5);
        [self checkApplyBtnState];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil]; // 关闭摄像头或用户相册
}

#pragma mark -----UITextViewDelegate-----

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if((textView.tag==EXNICK&&[textView.text isEqualToString:@"请输入昵称"])||(textView.tag==EXINTROD&&[textView.text isEqualToString:@"请输入简介，30-100之间"])||(textView.tag==EXREASON&&[textView.text isEqualToString:@"请输入申请理由"])){
        textView.text=nil;
    }
    textView.textColor=[UIColor blackColor];
    
    if (textView==_ex_introd_view||textView==_ex_reason_view) {
        float textY = ORIGIN_Y(textView)+textView.superview.frame.origin.y;
        float bottomY = self.view.frame.size.height-textY;
        if(bottomY>=286){
            prewTag = -1;
            return;
        }
        prewTag = textView.tag;
        float moveY = 286-bottomY;
        prewMoveY = moveY;
        NSTimeInterval animationDuration = 0.30f;
        CGRect frame = self.view.frame;
        frame.origin.y -=moveY;
        frame.size.height +=moveY;
        self.view.frame = frame;
        [UIView beginAnimations:@"ResizeView" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.view.frame = frame;
        [UIView commitAnimations];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
    if(prewTag == -1){
        return;
    }
    float moveY;
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    if(prewTag == textView.tag){
        moveY =  prewMoveY;
        frame.origin.y +=moveY;
        frame.size. height -=moveY;
        self.view.frame = frame;
    }
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
    [textView resignFirstResponder];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSString *str=[textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (textView.tag==EXNICK) {
        _exNickStr=str;
    }
    if (textView.tag==EXINTROD) {
        _exIntrStr=str;
    }
    if (textView.tag==EXREASON) {
        _exResnStr=str;
    }
    [self checkApplyBtnState];

    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}

-(void)checkApplyBtnState
{
    if (![_exTypeStr isEqualToString:@""]&&_exTypeStr!=nil&&_headImgData&&![_exNickStr isEqualToString:@""]&&_exNickStr!=nil&&![_exNickStr isEqualToString:@"请输入昵称"]&&![_exIntrStr isEqualToString:@""]&&_exIntrStr!=nil&&![_exIntrStr isEqualToString:@"请输入简介，30-100之间"]&&![_exResnStr isEqualToString:@""]&&_exResnStr!=nil&&![_exResnStr isEqualToString:@"请输入申请理由"] && agreement) {
        _applyBtn.enabled=YES;
    }else{
        _applyBtn.enabled=NO;
    }
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    