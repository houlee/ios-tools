//
//  CP_XZButton.m
//  iphone_control
//
//  Created by zhang on 12/5/12.
//  Copyright (c) 2012 yaofuyu. All rights reserved.
//

#import "CP_XZButton.h"

@implementation CP_XZButton
@synthesize buttonImage;
@synthesize buttonName;
@synthesize iskuailepuke;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)loadButtonName:(NSString *)labeName{
    NSLog(@"labe = %@", labeName);
    if (!buttonImage) {
        buttonImage = [[UIImageView alloc] init];
        buttonImage.frame = self.bounds;
        //buttonImage.image = [buttonImage.image stretchableImageWithLeftCapWidth:23 topCapHeight:0];
        [self addSubview:buttonImage];
        [buttonImage release];
    }
    if (!buttonName) {
        buttonName = [[UILabel alloc] init];
        buttonName.textAlignment = NSTextAlignmentCenter;
        buttonName.backgroundColor = [UIColor clearColor];
        buttonName.frame = self.bounds;
        buttonName.font = [UIFont boldSystemFontOfSize:14];
        buttonName.textColor = [UIColor blackColor];
//        buttonName.shadowColor = [UIColor blackColor];
//        buttonName.shadowOffset = CGSizeMake(0, 1.0);
        [self addSubview:buttonName];
        [buttonName release];
    }

    buttonName.text = labeName;
//    if ([buttonName.text isEqualToString:@"二星组选胆拖"]) {
//        buttonName.frame = CGRectMake(25, 0, self.frame.size.width - 25, self.frame.size.height);
//        buttonName.textAlignment = NSTextAlignmentLeft;
//    }else{
        buttonName.frame = self.bounds;
        buttonName.textAlignment = NSTextAlignmentCenter;
//    }
//    CGSize sizeName = [buttonName.text sizeWithFont:buttonName.font constrainedToSize:CGSizeMake(buttonName.frame.size.width,buttonName.frame.size.height) lineBreakMode:NSLineBreakByWordWrapping];
//    
//    if (sizeName.width > (buttonName.frame.size.width/3)*2) {
//        buttonName.textAlignment = NSTextAlignmentRight;
//    }else{
//        buttonName.textAlignment = NSTextAlignmentCenter;
//    }
    
    [self addTarget:self action:@selector(setCP_Selecte) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.selected == YES) {
        
        if(iskuailepuke)
        {
            buttonImage.image = UIImageGetImageFromName(@"btn_pukewanfa_selected.png");
            buttonName.textColor = [UIColor colorWithRed:134/255.0 green:213/255.0 blue:235/255.0 alpha:1];
        }
        else
        {
            buttonImage.image = [UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7];
            buttonName.textColor = [UIColor whiteColor];
        }

        
    }else{
        if(iskuailepuke)
        {
            buttonImage.image = UIImageGetImageFromName(@"btn_pukewanfa_normal.png");
            
            buttonName.textColor = [UIColor colorWithRed:72/255.0 green:70/255.0 blue:64/255.0 alpha:1];
        }
        else
        {
            buttonImage.image = [UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7];
            
            buttonName.textColor = [UIColor colorWithRed:72/255.0 green:70/255.0 blue:64/255.0 alpha:1];
        }


    }
}

- (void)setCP_Selecte {
    self.selected = !self.selected;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (self.selected == YES) {
        
        if(iskuailepuke)
        {
            buttonImage.image = UIImageGetImageFromName(@"btn_pukewanfa_selected.png");
            buttonName.textColor = [UIColor colorWithRed:134/255.0 green:213/255.0 blue:235/255.0 alpha:1];
        }
        else
        {
            buttonImage.image = [UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7];
            buttonName.textColor = [UIColor whiteColor];
        }



    }else{

        if(iskuailepuke)
        {
            buttonImage.image = UIImageGetImageFromName(@"btn_pukewanfa_normal.png");
            
            buttonName.textColor = [UIColor colorWithRed:72/255.0 green:70/255.0 blue:64/255.0 alpha:1];
        
        }
        else
        {
            buttonImage.image = [UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7];
            
            buttonName.textColor = [UIColor colorWithRed:72/255.0 green:70/255.0 blue:64/255.0 alpha:1];
        }


    }
}

-(void)jiangjin
{
    

}
- (void)dealloc{

    [super dealloc];
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