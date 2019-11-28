//
//  GC_shengfucell.m
//  caibo
//
//  Created by  on 12-5-17.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GC_shengfucell.h"

@implementation GC_shengfucell
@synthesize fenzhong;
@synthesize zuihoubool;
@synthesize row;
@synthesize huntouBool;
@synthesize cellType;



- (ChampionData *)championData{
    return championData;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView addSubview:[self returntabelviewcell]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (GC_shengfudata *)data{
    return data;
}

- (void)championDataInfo{

    qianlabel.text = data.jiancheng; //赛程
    youlabel.text = data.cuStr;//彩果
    if (cellType == guanjuncelltype) {
        
        leftlabel.text = data.leftStr;
    
    }else if (cellType == guanyajuncelltype){
        
        NSArray * comarr = [data.leftStr componentsSeparatedByString:@"—"];
        if ([comarr count] >= 2) {
            leftlabel.text = [comarr objectAtIndex:0];//主队
            cuLabel.text = [comarr objectAtIndex:1];//客队
        }
        
    }
    
    
    youlabel.frame = CGRectMake(171, 0.5, 78, 30);
    
    view.frame = self.bounds;
    bgimage.frame= view.bounds;
    cellimageview.frame = CGRectMake(12, 0, 250, 31);//labelSize.height+1);
    cellimageview.image = [UIImageGetImageFromName(@"XQCYHMTBG960.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    line1.frame = CGRectMake(54, 0, 1, 30);
    
    if (cellType == guanjuncelltype) {
        leftlabel.frame = CGRectMake(55, 0, 54+68, 30);
        line2.frame = CGRectMake(108, 0, 0, 0);
        line3.frame = CGRectMake(168, 0, 1, 30);
        cuLabel.frame = CGRectMake(0, 0, 0, 0);
    }else if (cellType == guanyajuncelltype){
        leftlabel.frame = CGRectMake(55, 0, 54, 30);
        line2.frame = CGRectMake(108, 0, 1, 30);
        line3.frame = CGRectMake(168, 0, 1, 30);
        cuLabel.frame = CGRectMake(109, 0, 60, 30);
    }
    
    if (row == 0&&data.zuihou == NO) {
        line4.frame = CGRectMake(277, (30+2)/2, 1, (30+2)/2);
    }else if(data.zuihou &&row != 0){
        line4.frame = CGRectMake(277, 0, 1, (30+2)/2);
    }else if(row == 0&&data.zuihou == YES){
        line4.frame = CGRectMake(277, (30+2)/2, 1, 0);
    
    }else{
        line4.frame = CGRectMake(277, 0, 1, 30+2);
    }
    
    if (data.dandan == NO) {
        rightimage.frame = CGRectMake(271.5, (30-12)/2, 12, 12);
        rightimage.image = UIImageGetImageFromName(@"TZFAXQZCQQ-960.png");
        danimageview.hidden = YES;
        rightimage.hidden = NO;
    }else{
        danimageview.hidden = NO;
        rightimage.hidden = YES;
        danimageview.frame = CGRectMake(265.5, (30-24)/2, 25, 24);
    }
}

- (void)setData:(GC_shengfudata *)_data{
    
    if (data != _data) {
        [data release];
        data = [_data retain];
    }
    
    if (cellType == guanyajuncelltype || cellType == guanjuncelltype) {
        
        [self championDataInfo];
        return;
    }
    
    
    if (_data.leftStr != nil) {
        NSArray * comarr = [_data.leftStr componentsSeparatedByString:@","];
//        NSString * string = [NSString stringWithFormat:@"%@VS%@", [comarr objectAtIndex:0], [comarr objectAtIndex:1]];
        leftlabel.text = [comarr objectAtIndex:0];//主队
        
        qianlabel.text = _data.jiancheng; //赛程
        
        if (huntouBool) {
            
            
            if ([leftlabel.text length] > 3) {
                leftlabel.text = [leftlabel.text substringToIndex:3];
            }
            if ([qianlabel.text length] > 4) {
                qianlabel.text = [qianlabel.text substringToIndex:4];
            }
            
            if([comarr count] > 1){
                if ([_data.cuStr rangeOfString:@"让球"].location != NSNotFound) {
                    NSLog(@"zhudui = %@", [NSString stringWithFormat:@"%@<%@>", leftlabel.text, [comarr objectAtIndex:2]]);
                    changciView.text = [NSString stringWithFormat:@"%@<%@>", leftlabel.text, [comarr objectAtIndex:2]];//[comarr objectAtIndex:2]
                    NSString * str33 = [NSString stringWithFormat:@"%@<%@", leftlabel.text, [comarr objectAtIndex:2]];
                    UIFont * font33 = [UIFont systemFontOfSize:10];
                    CGSize  size33 = CGSizeMake(54, 30);
                    CGSize labelSize33 = [str33 sizeWithFont:font33 constrainedToSize:size33 lineBreakMode:UILineBreakModeWordWrap];
                    
                     changciView.frame = CGRectMake(52+(60-labelSize33.width)/2, 10, labelSize33.width, labelSize33.height);
                    changciView.hidden = NO;
                    leftlabel.hidden = YES;
                }else
                {
                    changciView.text =   @"";
                    changciView.hidden = YES;
                    leftlabel.hidden = NO;
                }
                
            }else
            {
                changciView.text =   @"";
                
                leftlabel.hidden = NO;
            }
            
        }else
        {
            if ([leftlabel.text length] > 4) {
                leftlabel.text = [leftlabel.text substringToIndex:4];
            }
            if ([qianlabel.text length] > 4) {
                qianlabel.text = [qianlabel.text substringToIndex:4];
            }
        }
        
        cuLabel.text = [comarr objectAtIndex:1];//客队
        if ([cuLabel.text length] > 4) {
            cuLabel.text = [cuLabel.text substringToIndex:4];
        }
        youlabel.text = _data.cuStr;//彩果
        
        NSLog(@"leftstr = %@", _data.leftStr);
        //cuLabel.text = _data.cuStr;
        NSString * str = _data.cuStr;
        NSLog(@"str = %@", str);
        UIFont * font = [UIFont boldSystemFontOfSize:12];//[UIFont fontWithName:@"Arial" size:12];
        CGSize  size = CGSizeMake(78, 300);
        CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];

        
        youlabel.font = font;
        youlabel.text = str;
        youlabel.numberOfLines = 0;
        youlabel.textAlignment = NSTextAlignmentCenter;
        if (labelSize.height < 30) {
            labelSize.height = 30;
        }
        
        youlabel.frame = CGRectMake(171, 0.5, labelSize.width, labelSize.height);
        view.frame = CGRectMake(0, 0, 300, labelSize.height+4);
        view.frame = self.bounds;
        bgimage.frame= view.bounds;
        cellimageview.frame = CGRectMake(12, 0, 250, labelSize.height+1);//labelSize.height+1);
         cellimageview.image = [UIImageGetImageFromName(@"XQCYHMTBG960.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15];
        line1.frame = CGRectMake(54, 0, 1, labelSize.height);
        line2.frame = CGRectMake(108, 0, 1, labelSize.height);
        line3.frame = CGRectMake(168, 0, 1, labelSize.height);
//        line4.frame = CGRectMake(275, 0, 1, labelSize.height+2);
        if (row == 0) {
            line4.frame = CGRectMake(277, (labelSize.height+2)/2, 1, (labelSize.height+2)/2);
        }else if(_data.zuihou){
            line4.frame = CGRectMake(277, 0, 1, (labelSize.height+2)/2);
        }else{
            line4.frame = CGRectMake(277, 0, 1, labelSize.height+2);
        }
        
        if (_data.dandan == NO) {
            rightimage.frame = CGRectMake(271.5, (labelSize.height-12)/2, 12, 12);
            rightimage.image = UIImageGetImageFromName(@"TZFAXQZCQQ-960.png");
            danimageview.hidden = YES;
            rightimage.hidden = NO;
        }else{
            danimageview.hidden = NO;
            rightimage.hidden = YES;
            danimageview.frame = CGRectMake(265.5, (labelSize.height-24)/2, 25, 24);
        }
//        rightimage.image = _data.rightImage;
    }
    
    
    
        bgimage.image = UIImageGetImageFromName(@"XQCELlBG960.png");
    
    
    if (huntouBool) {
        qianlabel.font = [UIFont boldSystemFontOfSize:11];
        leftlabel.font = [UIFont systemFontOfSize:10];
        cuLabel.font = [UIFont systemFontOfSize:10];
        youlabel.font = [UIFont boldSystemFontOfSize:11];
    }else{
        qianlabel.font = [UIFont boldSystemFontOfSize:12];
        leftlabel.font = [UIFont systemFontOfSize:11];
        cuLabel.font = [UIFont systemFontOfSize:11];
        youlabel.font = [UIFont boldSystemFontOfSize:12];
    }
    
    
    
}


- (UIView *)returntabelviewcell{
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 34)];
    view.backgroundColor = [UIColor clearColor];
    bgimage = [[UIImageView alloc] initWithFrame:view.bounds];
    bgimage.backgroundColor = [UIColor clearColor];
    bgimage.image = UIImageGetImageFromName(@"XQCELlBG960.png");//[UIImageGetImageFromName(@"XQCELlBG960.png") stretchableImageWithLeftCapWidth:135 topCapHeight:15];//XQCYHMTBG960
//    [view addSubview:bgimage];
    
    cellimageview = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 250, 30)];
    cellimageview.image = [UIImageGetImageFromName(@"XQCYHMTBG960.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    cellimageview.backgroundColor = [UIColor clearColor];
    [view addSubview:cellimageview];
    [cellimageview release];
    
    qianlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 55, 30)];
    qianlabel.textAlignment = NSTextAlignmentCenter;
    qianlabel.backgroundColor = [UIColor clearColor];
    qianlabel.font = [UIFont boldSystemFontOfSize:12];
    qianlabel.textColor = [UIColor colorWithRed:25/255.0 green:122/255.0 blue:228/255.0 alpha:1];
    [cellimageview addSubview:qianlabel];
    [qianlabel release];
    
    
    
    
    line1 = [[UIImageView alloc] initWithFrame:CGRectMake(54, 0, 1, 30)];
    line1.backgroundColor = [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1];
    [cellimageview addSubview:line1];
    [line1 release];
    
    leftlabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, 54, 30)];
    leftlabel.textAlignment = NSTextAlignmentCenter;
    leftlabel.backgroundColor = [UIColor clearColor];
    leftlabel.font = [UIFont systemFontOfSize:11];
    leftlabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [cellimageview addSubview:leftlabel];
    
    changciView = [[ColorView alloc] init];
    changciView.font = [UIFont systemFontOfSize:9];
    changciView.colorfont = [UIFont systemFontOfSize:9];
    changciView.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    changciView.backgroundColor = [UIColor clearColor];
    changciView.frame = CGRectMake(52, 10, 60, 30);
    changciView.tag  = 300;
    changciView.textAlignment = NSTextAlignmentCenter;
    [cellimageview addSubview:changciView];
    changciView.changeColor = [UIColor redColor];
//    changciView.text = self.changCiNum;
    [changciView release];
    
    line2 = [[UIImageView alloc] initWithFrame:CGRectMake(108, 0, 1, 30)];
    line2.backgroundColor = [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1];
    [cellimageview addSubview:line2];
    [line2 release];
    
    cuLabel = [[UILabel alloc] initWithFrame:CGRectMake(109, 0, 60, 30)];
    cuLabel.textAlignment = NSTextAlignmentCenter;
    cuLabel.backgroundColor = [UIColor clearColor];
    cuLabel.font = [UIFont systemFontOfSize:11];
    cuLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [cellimageview addSubview:cuLabel];
    
    line3 = [[UIImageView alloc] initWithFrame:CGRectMake(168, 0, 1, 30)];
    line3.backgroundColor = [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1];
    [cellimageview addSubview:line3];
    [line3 release];
    
    youlabel = [[UILabel alloc] initWithFrame:CGRectMake(171, 0.5, 78, 30)];
    youlabel.backgroundColor = [UIColor clearColor];
    youlabel.font = [UIFont boldSystemFontOfSize:12];
    youlabel.textAlignment = NSTextAlignmentCenter;
    youlabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [cellimageview addSubview:youlabel];
    [youlabel release];
    
    line4 = [[UIImageView alloc] initWithFrame:CGRectMake(260, 0, 0, 0)];
    line4.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:line4];
    [line4 release];
    
    rightimage = [[UIImageView alloc] initWithFrame:CGRectMake(275, 5, 12, 13)];
    rightimage.backgroundColor = [UIColor clearColor];
    [view addSubview:rightimage];
    
    danimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 24)];
    danimageview.backgroundColor = [UIColor clearColor];
    danimageview.image = UIImageGetImageFromName(@"TZFAXQZCLF-960.png");
    
    UILabel * danlabel = [[UILabel alloc] initWithFrame:danimageview.bounds];
    danlabel.backgroundColor = [UIColor clearColor];
    danlabel.textColor = [UIColor whiteColor];
    danlabel.textAlignment = NSTextAlignmentCenter;
    danlabel.text = @"胆";
    danlabel.font = [UIFont boldSystemFontOfSize:14];
    [danimageview addSubview:danlabel];
    [danlabel release];
    
    [view addSubview:danimageview];
    [danimageview release];

    return view;
}

- (void)dealloc{
    [championData release];
    [bgimage release];
    [rightimage release];
    [cuLabel release];
    [leftlabel release];
    [view release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    