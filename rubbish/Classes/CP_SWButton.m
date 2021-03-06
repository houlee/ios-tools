//
//   .m
//  iphone_control
//
//  Created by zhang on 12/5/12.
//  Copyright (c) 2012 yaofuyu. All rights reserved.
//

#import "CP_SWButton.h"

@implementation CP_SWButton
@synthesize buttonImage;
@synthesize on;
//@synthesize onImageName;
//@synthesize offImageName;

- (void)setOnImageName:(NSString *)_onImageName{
    
    if (onImageName != _onImageName) {
        [onImageName release];
        onImageName = [_onImageName retain];
    }
    
    if (self.selected == YES) {
        buttonImage.image = UIImageGetImageFromName(onImageName);
    }else{
        buttonImage.image = UIImageGetImageFromName(offImageName);
    }

}

- (NSString *)onImageName{
    
    return onImageName;
}


- (void)setOffImageName:(NSString *)_offImageName{
    if (offImageName != _offImageName) {
        [offImageName release];
        offImageName = [_offImageName retain];
    }
    if (self.selected == YES) {
        buttonImage.image = UIImageGetImageFromName(onImageName);
    }else{
        buttonImage.image = UIImageGetImageFromName(offImageName);
    }
}

- (NSString *)offImageName{
    return offImageName;
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (!buttonImage) {
            buttonImage = [[UIImageView alloc] init];
            buttonImage.frame = self.bounds;
            [self addSubview:buttonImage];
            [buttonImage release];
        }
        
        if (self.selected == YES) {
            buttonImage.image = UIImageGetImageFromName(onImageName);
        }else{
            buttonImage.image = UIImageGetImageFromName(offImageName);
        }
        [self addTarget:self action:@selector(setCP_Selecte) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    buttonImage.frame = self.bounds;
}

- (void)setCP_Selecte {
    
    self.selected = !self.selected;
    //NSArray *array = [self ]
    [self  sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    on = selected;
    if (self.selected == YES) {
        buttonImage.image = UIImageGetImageFromName(onImageName);
    }else{
        buttonImage.image = UIImageGetImageFromName(offImageName);
    }
}

- (void)setOn:(BOOL)_on {
    [self setSelected:_on];
}



- (void)dealloc{
    
    onImageName = nil;
    offImageName = nil;
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