//
//  GC_JingCaiCell.m
//  caibo
//
//  Created by cp365dev on 14-7-8.
//
//

#import "GC_JingCaiCell.h"

@implementation GC_JingCaiCell
@synthesize zuihoubool;
@synthesize row;
@synthesize huntouBool;
@synthesize cellType;




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

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (ChampionData *)championData{
    return championData;
}

- (GC_shengfudata *)data{
    return data;
}


-(void)setData:(GC_shengfudata *)_data
{
    if(data != _data)
    {
        [data release];
        data = [_data retain];
    }
    
    if(_data.leftStr != nil)
    {
        NSArray * comarr = [_data.leftStr componentsSeparatedByString:@","];
        
        leftlabel.text = [comarr objectAtIndex:0];//主队
        
        qianlabel.text = _data.jiancheng;  //赛程
        
        
        if(huntouBool)
        {
            if(leftlabel.text.length > 4)
            {
                leftlabel.text = [leftlabel.text substringToIndex:4];
            }
            if(qianlabel.text.length > 4)
            {
                qianlabel.text = [qianlabel.text substringToIndex:4];
            }
            
            
            if([comarr count] > 1)
            {
                if ([_data.cuStr rangeOfString:@"让球"].location != NSNotFound) {
                    NSLog(@"zhudui = %@", [NSString stringWithFormat:@"%@<%@>", leftlabel.text, [comarr objectAtIndex:2]]);
                    rangqiuLabel.text =[comarr objectAtIndex:2];
                    rangqiuLabel.hidden = NO;
                    if([rangqiuLabel.text hasPrefix:@"-"]){
                        rangqiuLabel.textColor =[UIColor colorWithRed:74/255.0 green:126/255.0 blue:18/255.0 alpha:1];

                    }
                    if([rangqiuLabel.text hasPrefix:@"+"]){
                        rangqiuLabel.textColor =[UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1];

                    }

                }

                
                NSString * str33 = leftlabel.text;
                UIFont * font33 = [UIFont systemFontOfSize:12];
                CGSize  size33 = CGSizeMake(90, 30);
                CGSize labelSize33 = [str33 sizeWithFont:font33 constrainedToSize:size33];
                
                leftlabel.frame = CGRectMake(5, 0, labelSize33.width, 30);
                
                if ([_data.cuStr rangeOfString:@"让球"].location == NSNotFound)
                {
                    leftlabel.frame = CGRectMake(5, 0, labelSize33.width, 30);
                    rangqiuLabel.hidden = YES;
                    
                }
                rangqiuLabel.frame = CGRectMake(leftlabel.frame.origin.x+leftlabel.frame.size.width+2.5, rangqiuLabel.frame.origin.y, 18, 9);

            }

        }
        else
        {
            if(leftlabel.text.length > 4)
            {
                leftlabel.text = [leftlabel.text substringToIndex:4];
            }
            if(qianlabel.text.length > 4)
            {
                qianlabel.text = [qianlabel.text substringToIndex:4];
            }
        }
        
        rightlabel.text = [comarr objectAtIndex:1];
        
        if(rightlabel.text.length > 4)
        {
            rightlabel.text = [rightlabel.text substringToIndex:4];
        }
        
        resultLabel.text = _data.cuStr;
        
        NSString * str33 = resultLabel.text;
        UIFont * font33 = [UIFont systemFontOfSize:12];
        CGSize  size33 = CGSizeMake(70, 300);
        CGSize labelSize33 = [str33 sizeWithFont:font33 constrainedToSize:size33];
        
        int height = 18+ 12 * labelSize33.height/12.0;

        resultLabel.frame = CGRectMake(187, 0, 70, height);
        
        cellimageview.frame = CGRectMake(15, 0, 260, height);
        
        if (_data.dandan == NO)
        {
            danImage.hidden = YES;
        }
        else
        {
            danImage.hidden = NO;
        }
        

    }
    
    
}


- (UIView *)returntabelviewcell
{
    
    cellimageview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 260, 30)];
    cellimageview.image = [UIImageGetImageFromName(@"jingcaiCell_kuang.png") stretchableImageWithLeftCapWidth:80 topCapHeight:16];
    cellimageview.backgroundColor = [UIColor clearColor];

    
    //主队
    leftlabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 70, 30)];
    leftlabel.backgroundColor = [UIColor clearColor];
    leftlabel.font = [UIFont systemFontOfSize:12];
    leftlabel.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    [cellimageview addSubview:leftlabel];
    
    //让球
    rangqiuLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftlabel.frame.origin.x+leftlabel.frame.size.width+2.5, 5, 0, 8)];
    rangqiuLabel.textAlignment = NSTextAlignmentLeft;
    rangqiuLabel.backgroundColor = [UIColor clearColor];
    rangqiuLabel.textColor =[UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1];
    rangqiuLabel.font = [UIFont systemFontOfSize:9];
    [cellimageview addSubview:rangqiuLabel];
    
    //赛事名称
    qianlabel = [[UILabel alloc] initWithFrame:CGRectMake(leftlabel.frame.origin.x+leftlabel.frame.size.width, 0, 42, 30)];
    qianlabel.backgroundColor = [UIColor clearColor];
    qianlabel.font = [UIFont boldSystemFontOfSize:9];
    qianlabel.textColor = [UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1];
    [cellimageview addSubview:qianlabel];
    [qianlabel release];
    
    
    //客队
    rightlabel = [[UILabel alloc] initWithFrame:CGRectMake(qianlabel.frame.origin.x+qianlabel.frame.size.width, 0, 66, 30)];
    rightlabel.backgroundColor = [UIColor clearColor];
    rightlabel.font = [UIFont systemFontOfSize:12];
    rightlabel.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    [cellimageview addSubview:rightlabel];
    
    
    //胆
    danImage = [[UIImageView alloc] initWithFrame:CGRectMake(cellimageview.frame.origin.x+cellimageview.frame.size.width+5, 2, 25, 25)];
    danImage.backgroundColor = [UIColor clearColor];
    danImage.image = UIImageGetImageFromName(@"dan_info.png");
    [self.contentView addSubview:danImage];
    
    
    
    //彩果
    
    resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(187, 0, 70, 30)];
    resultLabel.lineBreakMode = NSLineBreakByCharWrapping;
    resultLabel.numberOfLines = 0;
    resultLabel.textAlignment = NSTextAlignmentCenter;
    resultLabel.backgroundColor = [UIColor clearColor];
    resultLabel.font = [UIFont systemFontOfSize:12];
    resultLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [cellimageview addSubview:resultLabel];
    
    
    return cellimageview;
}

-(void)dealloc
{
    [cellimageview release];
    [rangqiuLabel release];
    [leftlabel release];
    [rightlabel release];
    [danImage release];
    [resultLabel release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    