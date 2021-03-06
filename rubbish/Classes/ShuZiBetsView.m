//
//  ShuZiBetsView.m
//  caibo
//
//  Created by GongHe on 14-10-23.
//
//

#import "ShuZiBetsView.h"
#import "SharedDefine.h"

#import "GifButton.h"

@implementation ShuZiBetsView

@synthesize titleImage;
@synthesize trashCanButton;
@synthesize louImageView;
@synthesize delegate;

- (void)dealloc
{
    [titleImage release];
    [trashCanButton release];
    [louImageView release];

    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame controller:(id)controller numberOfBalls:(int)balls numberOfColumns:(int)columns title:(NSString *)title description:(NSString *)description showYiLouImage:(BOOL)showYiLouImage firstNumber:(int)firstNumber hasZero:(BOOL)hasZero lineSpace:(float)lineSpace ballType:(GCBallViewColorType)ballType ballFrame:(CGRect)ballFrame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (title && [title length]) {
            titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 54, 22)];
            titleImage.backgroundColor=[UIColor clearColor];
            titleImage.image = [UIImage imageNamed:BETSVIEW_TITLE_IMAGENAME_RED];
            titleImage.tag = betsView_titleImageTag;
            [self addSubview:titleImage];
        }
        
        if (title && [title length]) {
            UILabel * titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(14, 0, titleImage.frame.size.width - 14, titleImage.frame.size.height)] autorelease];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.font = BETSVIEW_TITLE_FONT;
            titleLabel.textColor = BETSVIEW_TITLE_COLOR;
            titleLabel.text = title;
            titleLabel.tag = betsView_titleLabelTag;
            [self addSubview:titleLabel];
        }
        
        if (description && [description length]) {
            UILabel * descriptionLabel = [[[UILabel alloc] init] autorelease];
            CGSize desSize = [description sizeWithFont:descriptionLabel.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX)];
            descriptionLabel.frame = CGRectMake(ORIGIN_X(titleImage) + 3, titleImage.frame.origin.y, desSize.width, titleImage.frame.size.height);
            descriptionLabel.backgroundColor = [UIColor clearColor];
            descriptionLabel.text = description;
            descriptionLabel.font = BETSVIEW_DESCRIPTION_FONT;
            descriptionLabel.textColor = BETSVIEW_DESCRIPTION_COLOR;
            descriptionLabel.tag = betsView_descriptionLabelTag;
            [self addSubview:descriptionLabel];
        }
        
        GCBallView * lastBallView;
        CGRect ballRect;

        for (int i = 0; i < balls; i++) {
            int column = i%columns;
            int line = i/columns;
            
            NSString * ballNum = [NSString stringWithFormat:@"%d", i + firstNumber];
            if (i + firstNumber < 10 && hasZero) {
                ballNum = [NSString stringWithFormat:@"0%d", i + 1];
            }
            
            float myLineSpace = lineSpace;
            if (!lineSpace) {
                myLineSpace = BETSVIEW_BALLVIEW_SPACE_HIDDEN;
            }
            
            float finalY = BETSVIEW_BALLVIEW_Y;
            if ((!title || ![title length]) && (!description || ![description length])) {
                if (ballFrame.origin.y) {
                    finalY = ballFrame.origin.y;
                }else{
                    finalY = 0;
                }
            }

            if (ballFrame.size.width && ballFrame.size.height) {
                ballRect = CGRectMake(column * ((self.frame.size.width - ballFrame.origin.x * 2 - columns * ballFrame.size.width)/(columns - 1) + ballFrame.size.width) + ballFrame.origin.x, line * (ballFrame.size.height + myLineSpace) + finalY, ballFrame.size.width, ballFrame.size.height);
            }else{
                ballRect = CGRectMake(column * (BETSVIEW_BALLVIEW_SPACE(columns) + BETSVIEW_BALLVIEW_WIDTH) + BETSVIEW_BALLVIEW_X, line * (BETSVIEW_BALLVIEW_WIDTH + myLineSpace) + finalY, BETSVIEW_BALLVIEW_WIDTH, BETSVIEW_BALLVIEW_WIDTH);
            }
            
            
            GCBallView * ballView = [[GCBallView alloc] initWithFrame:ballRect Num:ballNum ColorType:ballType];
//            ballView.isBlack = YES;
            [self addSubview:ballView];
            ballView.tag = i;
            ballView.gcballDelegate = controller;
            
            if (SWITCH_ON) {
                if (!lineSpace) {
                    ballView.frame = CGRectMake(ballRect.origin.x, line * (BETSVIEW_BALLVIEW_WIDTH + (ORIGIN_Y(ballView.ylLable) - ballView.ylLable.frame.origin.y) * 2) + finalY, ballRect.size.width, ballRect.size.height);
                }
                
                ballView.ylLable.hidden = NO;
                
            }else{
                ballView.ylLable.hidden = YES;
                
                if (lineSpace) {
                    ballView.frame = CGRectMake(ballRect.origin.x, line * (BETSVIEW_BALLVIEW_WIDTH + ORIGIN_Y(ballView.ylLable) - ballView.ylLable.frame.origin.y + BETSVIEW_BALLVIEW_SPACE_HIDDEN) + finalY, ballRect.size.width, ballRect.size.height);
                }
            }
            
            if (!(balls%columns) && line == balls/columns - 1 && column) {
                
            }else{
                lastBallView = ballView;
            }
            [ballView release];
            
            if (i == 0 && showYiLouImage) {
                 louImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(titleImage) + 14 + 36 + 1.5, 18, 14)];
                louImageView.image = UIImageGetImageFromName(@"LeftTitleYilou.png");
                louImageView.tag = betsView_yiLouImageTag;
                [self addSubview:louImageView];
                if (!SWITCH_ON) {
                    louImageView.hidden = YES;
                }
                
                UILabel * louLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, louImageView.frame.size.width, louImageView.frame.size.height)] autorelease];
                louLabel.backgroundColor = [UIColor clearColor];
                louLabel.font = [UIFont systemFontOfSize:11];
                louLabel.textAlignment = 1;
                louLabel.tag = betsView_louLabelTag;
                louLabel.textColor = [UIColor whiteColor];
                [louImageView addSubview:louLabel];
                louLabel.text = @"漏";
            }

        }
        
        trashCanButton = [[GifButton alloc] initTrashCanWithFrame:CGRectMake(ORIGIN_X(lastBallView) + BETSVIEW_BALLVIEW_SPACE(columns), lastBallView.frame.origin.y, 0, 0)];
        if (!(balls%columns)) {
            trashCanButton.frame = CGRectMake(lastBallView.frame.origin.x, ORIGIN_Y(lastBallView) + ORIGIN_Y(lastBallView.ylLable) - lastBallView.ylLable.frame.origin.y - 1, 0, 0);
        }
        trashCanButton.tag = TrashCanTag;
        trashCanButton.delegate = controller;
        [self addSubview:trashCanButton];

    }
    return self;
}

-(void)clearSelectedBallView
{
    for (GCBallView * selectedBallView in self.subviews) {
        if ([selectedBallView isKindOfClass:[GCBallView class]] && selectedBallView.selected) {
            selectedBallView.selected = NO;
        }
    }
    if (delegate && [delegate respondsToSelector:@selector(clearFinished)]) {
        [delegate clearFinished];
    }
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    