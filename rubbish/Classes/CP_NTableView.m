//
//  CP_NTableView.m
//  iphone_control
//
//  Created by houchenguang on 12-12-4.
//  Copyright (c) 2012年 yaofuyu. All rights reserved.
//

#import "CP_NTableView.h"
#import "MenuCell.h"
#import "TuiSongCell.h"
#import "MobClick.h"


@implementation CP_NTableView
@synthesize CP_TableViewStyle;
@synthesize delegate;

- (void)dealloc{
    
    [titleArray release];
    [imageArray release];
    [switchArray release];
    [myTabelView release];
    [super dealloc];
}

#pragma mark titliArray imageArray switchArray 的set get方法

- (void)setTitleArray:(NSMutableArray *)_titleArray{
    if (titleArray != _titleArray) {
        [titleArray release];
       titleArray =  [_titleArray retain];
    }
    
    [myTabelView reloadData];
}

- (NSMutableArray *)titleArray{
    return titleArray;
}


- (void)setImageArray:(NSMutableArray *)_imageArray{
    if (imageArray != _imageArray) {
        [imageArray release];
        imageArray = [_imageArray retain];
    }
    [myTabelView reloadData];
}

- (NSMutableArray *)imageArray{
    return imageArray;
}

- (void)setSwitchArray:(NSMutableArray *)_switchArray{
    if (switchArray != _switchArray) {
        [switchArray release];
        switchArray = [_switchArray retain];
    }
    [myTabelView reloadData];
}

- (NSMutableArray *)switchArray{
    return switchArray;
}

#pragma mark 初始化方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        UIImageView * bgview = [[UIImageView alloc] initWithFrame:self.bounds];
//        bgview.backgroundColor = [UIColor clearColor];
//        bgview.image = [UIImage imageNamed:@"login_bgn.png"];
//        [self addSubview:bgview];
//        [bgview release];
        
        self.backgroundColor = [UIColor clearColor];
        
        myTabelView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x , self.frame.origin.y, self.frame.size.width , self.frame.size.height) style:UITableViewStylePlain];
      //  myTabelView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        myTabelView.delegate = self;
        myTabelView.dataSource = self;
        myTabelView.backgroundColor = [UIColor clearColor];
        [myTabelView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self addSubview:myTabelView];
        
        
        
    }
    return self;
}


#pragma mark UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    NSMutableArray * array = [titleArray objectAtIndex:section];

    if ([array count] == 0) {
        return 0;
    }
    else
    {
    
            return [array count] + 2;
        
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    

   // 4个
    return [titleArray count];
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray * array = [titleArray objectAtIndex:indexPath.section];
    NSMutableArray * lastarr = [titleArray objectAtIndex:[titleArray count]-1];
    if (CP_TableViewStyle == CP_TableViewSwitchStyle) {
        
        if (indexPath.row == 0 || indexPath.row == [array count]+1) {
            
            if (indexPath.row == 0 && CP_TableViewStyle == CP_TableViewSwitchStyle) {
                return 30;
            }
            
        }
        
        if (indexPath.row == 0) {
            return 40;
        }
        if (indexPath.section == [titleArray count]-1 && indexPath.row == [lastarr count]+1) {
            return 15;
        }
        if ([array count]+1 == indexPath.row) {
            return 0;
        }
        
    }else{
        //第一行 和最后一行
        if ((indexPath.row == 0&&indexPath.section == 0) || (indexPath.section == [titleArray count]-1 && indexPath.row == [lastarr count]+1)) {
            return 15;
        }
        //每段的第一行 和最后一行
        if (([array count]+1 == indexPath.row) || (indexPath.row == 0)) {
            return 6;
        }
        
    }
    
    //第一行 和最后一行
    //    if ((indexPath.row == 0&&indexPath.section == 0) || (indexPath.section == [titleArray count]-1 && indexPath.row == [lastarr count]+1)) {
    //        return 15;
    //    }
    //    //每段的第一行 和最后一行
    //    if (([array count]+1 == indexPath.row) || (indexPath.row == 0)) {
    //        return 6;
    //    }
    
    return 44;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
#ifdef isCaiPiaoForIPad
    
    NSMutableArray * array = [titleArray objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0 || indexPath.row == [array count]+1) {
        
        // &&CP_TableViewStyle == CP_TableViewSwitchStyle
        if (indexPath.row == 0 && CP_TableViewStyle！=CP_TableViewMenuStyle) {
            NSString * cellid = @"cellida";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            }
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            if (indexPath.section == 0) {
                cell.textLabel.text = @" 中奖消息";
            }else if(indexPath.section == 1){
                cell.textLabel.text = @" 开奖消息";
            }else if(indexPath.section == 2){
                cell.textLabel.text = @" 通知接收时段";
            }
            cell.textLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
            cell.textLabel.shadowColor = [UIColor whiteColor];//阴影
            cell.textLabel.shadowOffset = CGSizeMake(0, 1.0);
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }else{
            NSString * cellid = @"cellid";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            }
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }
        
        
        
    }else if(CP_TableViewStyle == CP_TableViewMenuStyle){
        NSString * cellid = @"cellid2";
        MenuCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
        }
        if (indexPath.section < [imageArray count]) {
            NSMutableArray * allimage = [imageArray objectAtIndex:indexPath.section];
            if (indexPath.row < [allimage count]+2) {
                cell.headImage.image = [UIImage imageNamed:[allimage objectAtIndex:indexPath.row-1] ];
            }
        }
        
        if (indexPath.section < [titleArray count]) {
            NSMutableArray * alltitle = [titleArray objectAtIndex:indexPath.section];
            if (indexPath.row < [alltitle count]+2) {
                cell.titleLabel.text = [alltitle objectAtIndex:indexPath.row-1];
            }
        }
        
        
      
        
        
        
        
        
        // NSMutableArray * lastarr = [titleArray objectAtIndex:[titleArray count]-1];
        if (indexPath.row == 1) {
            cell.bgimage.image = [[UIImage imageNamed:@"SZT-S-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:12];
            cell.line.image = [UIImage imageNamed:@"SZTG960.png"];
        
        }else if (indexPath.row == [array count]) {
            cell.bgimage.image = [[UIImage imageNamed:@"SZT-X-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:2];
            cell.line.image = nil;
        }else{
            cell.bgimage.image = [[UIImage imageNamed:@"SZT-Z-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:6];
            cell.line.image = [UIImage imageNamed:@"SZTG960.png"];
            
        }
        
        if ([array count] == 1) {
            cell.bgimage.image = [[UIImage imageNamed:@"SZT960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:23];
            cell.line.image = nil;
        }
        
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
    }else if(CP_TableViewStyle == CP_TableViewSwitchStyle){
        
        
        if (indexPath.section == 2) {
            NSString * cellid = @"celliad";
            TuiSongCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[[TuiSongCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            }
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            
            if (indexPath.row == 1) {
                cell.bgimage.image = [[UIImage imageNamed:@"SZT-S-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:12];
                cell.line.image = [UIImage imageNamed:@"SZTG960.png"];
                cell.jiantou.hidden = NO;
            }else if (indexPath.row == [array count]) {
                cell.bgimage.image = [[UIImage imageNamed:@"SZT-X-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:2];
                cell.line.image = nil;
                cell.jiantou.hidden = YES;
            }else{
                cell.bgimage.image = [[UIImage imageNamed:@"SZT-Z-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:6];
                cell.line.image = [UIImage imageNamed:@"SZTG960.png"];
                cell.jiantou.hidden = NO;
                
            }
            NSLog(@"row = %d", indexPath.row - 1);
            cell.titleText.text = [array objectAtIndex:indexPath.row-1];
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }else{
            NSString * cellid = @"cellid3";
            SwitchCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[[SwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            }
            
            cell.delegate = self;
            cell._row = indexPath.row;
            cell._section = indexPath.section;
            if (indexPath.section < [titleArray count]) {
                NSMutableArray * alltitle = [titleArray objectAtIndex:indexPath.section];
                if (indexPath.row < [alltitle count]+2) {
                    cell.titleLabel.text = [alltitle objectAtIndex:indexPath.row-1];
                }
            }
            
            if (indexPath.section < [switchArray count]) {
                NSMutableArray * allsw = [switchArray objectAtIndex:indexPath.section];
                if (indexPath.row < [allsw count]+2) {
                    
                    if ([[allsw objectAtIndex:indexPath.row-1] isEqualToString:@"1"]) {
                        cell.switchyn.on = YES;
                    }else{
                        cell.switchyn.on = NO;
                    }
                    
                    
                }
            }
            
            if (indexPath.row == 1) {
                cell.bgimage.image = [[UIImage imageNamed:@"SZT-S-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:12];
                cell.line.image = [UIImage imageNamed:@"SZTG960.png"];
            }else if (indexPath.row == [array count]) {
                cell.bgimage.image = [[UIImage imageNamed:@"SZT-X-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:2];
                cell.line.image = nil;
            }else{
                cell.bgimage.image = [[UIImage imageNamed:@"SZT-Z-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:6];
                cell.line.image = [UIImage imageNamed:@"SZTG960.png"];
                
            }
            
            if ([array count] == 1) {
                cell.bgimage.image = [[UIImage imageNamed:@"SZT960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:23];
                cell.line.image = nil;
            }
            
            
            
            cell.backgroundColor = [UIColor clearColor];
            return cell;
            
            
        }
        
        
    }
    return nil;

    
#else
    
    NSMutableArray * array = [titleArray objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0 || indexPath.row == [array count]+1) {
        
        //
        if (indexPath.row == 0&& CP_TableViewStyle == CP_TableViewSwitchStyle ) {
          
            NSString * cellid = @"cellida";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
                UILabel * cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.frame.origin.x, cell.contentView.frame.origin.y - 3, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
                cellLabel.backgroundColor = [UIColor clearColor];
                cellLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                cellLabel.font = [UIFont boldSystemFontOfSize:14];
                if (indexPath.section == 1) {
                    cellLabel.text = @"    中奖通知";
                    
                }else if(indexPath.section == 2){
                    cellLabel.text = @"    开奖推送";
                }else if(indexPath.section == 3){
                    if (indexPath.row == 0) {
                        cellLabel.text = @"    通知接收时段";
                    }
                }
                [cell.contentView addSubview:cellLabel];
                [cellLabel release];
                
            }
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"";
           
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }else{
            NSString * cellid = @"cellid";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            }
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }
        
        
        
    }else if(CP_TableViewStyle == CP_TableViewMenuStyle){
       
        NSString * cellid = @"cellid2";
        MenuCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
        }
        if (indexPath.section < [imageArray count]) {
            NSMutableArray * allimage = [imageArray objectAtIndex:indexPath.section];
            if (indexPath.row < [allimage count]+2) {
                cell.headImage.image = [UIImage imageNamed:[allimage objectAtIndex:indexPath.row-1] ];
            }
        }
        
        if (indexPath.section < [titleArray count]) {
            NSMutableArray * alltitle = [titleArray objectAtIndex:indexPath.section];
            if (indexPath.row < [alltitle count]+2) {
                cell.titleLabel.text = [alltitle objectAtIndex:indexPath.row-1];
            }
        }
        
        

        
        
        
        
        
        
        
        // NSMutableArray * lastarr = [titleArray objectAtIndex:[titleArray count]-1];
        if (indexPath.row == 1) {
            //cell.bgimage.image = [[UIImage imageNamed:@"SZT-S-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:12];
           // cell.line.image = [UIImage imageNamed:@"SZTG960.png"];
        }else if (indexPath.row == [array count]) {
           // cell.bgimage.image = [[UIImage imageNamed:@"SZT-X-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:2];
            cell.line.image = nil;
        }else{
          //  cell.bgimage.image = [[UIImage imageNamed:@"SZT-Z-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:6];
          //  cell.line.image = [UIImage imageNamed:@"SZTG960.png"];
            
        }
        
        if ([array count] == 1) {
           // cell.bgimage.image = [[UIImage imageNamed:@"SZT960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:23];
            cell.line.image = nil;
        }
        
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
        
        
        
    }else if(CP_TableViewStyle == CP_TableViewSwitchStyle){
       
        // 推送cell
        if (indexPath.section == 3) {
            NSString * cellid = @"celliad";
            
            TuiSongCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[[TuiSongCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
          
            }
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            
            
            if (indexPath.row == 1) {
               // cell.bgimage.image = [[UIImage imageNamed:@"SZT-S-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:12];
               // cell.line.image = [UIImage imageNamed:@"SZTG960.png"];
               // cell.jiantou.hidden = NO;
            }else if (indexPath.row == [array count]) {
               // cell.bgimage.image = [[UIImage imageNamed:@"SZT-X-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:2];
                // cell.line.image = nil;
                //cell.jiantou.hidden = YES;
            }else{
                //cell.bgimage.image = [[UIImage imageNamed:@"SZT-Z-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:6];
                //cell.line.image = [UIImage imageNamed:@"SZTG960.png"];
                //cell.jiantou.hidden = NO;
                
            }
            
           
            cell.titleText.text = [array objectAtIndex:indexPath.row-1];
            cell.backgroundColor = [UIColor clearColor];
            return cell;
      
        }else{
            
            NSString * cellid = @"cellid3";
            SwitchCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[[SwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            }
            cell.delegate = self;
            cell._row = indexPath.row;
            cell._section = indexPath.section;
            if (indexPath.section < [titleArray count]) {
                NSMutableArray * alltitle = [titleArray objectAtIndex:indexPath.section];
                if (indexPath.row < [alltitle count]+2) {
                    cell.titleLabel.text = [alltitle objectAtIndex:indexPath.row-1];
                }
            }
            
            if (indexPath.section < [switchArray count]) {
                NSMutableArray * allsw = [switchArray objectAtIndex:indexPath.section];
                if (indexPath.row < [allsw count]+2) {
                    if ([[allsw objectAtIndex:indexPath.row-1] isEqualToString:@"1"]) {
                        cell.switchyn.on = YES;
                    }else{
                        cell.switchyn.on = NO;
                    }
                    
                }
            }
            
//            if (indexPath.section == 0||indexPath.section == 1) {
//                cell.switchyn.onImageName = @"heji2-640_10.png";
//                cell.switchyn.offImageName = @"heji2-640_11.png";
//            }
            
            if (indexPath.row == 1) {
                //cell.bgimage.image = [[UIImage imageNamed:@"SZT-S-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:12];
                //cell.line.image = [UIImage imageNamed:@"SZTG960.png"];
                
            }else if (indexPath.row == [array count]) {
                //cell.bgimage.image = [[UIImage imageNamed:@"SZT-X-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:2];
                cell.line.image = nil;
            }else{
                //cell.bgimage.image = [[UIImage imageNamed:@"SZT-Z-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:6];
                //cell.line.image = [UIImage imageNamed:@"SZTG960.png"];
                
            }
            
            if ([array count] == 1) {
                //cell.bgimage.image = [[UIImage imageNamed:@"SZT960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:23];
                cell.line.image = nil;
            }
            
            
            
            cell.backgroundColor = [UIColor clearColor];
            return cell;
            
            
        }
        
    }
    return nil;

    
#endif

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //if (CP_TableViewStyle == CP_TableViewMenuStyle) {
        NSMutableArray * array = [titleArray objectAtIndex:indexPath.section];
        if (indexPath.row > 0 && indexPath.row < [array count]+1) {
            [self tableReturnIndexPathSection:indexPath.section indexPathRow:indexPath.row-1];
        }
        
    
  //  }

}

#pragma mark 本类的delegate
- (void)tableReturnIndexPathSection:(NSInteger)section indexPathRow:(NSInteger)row{
    if ([delegate respondsToSelector:@selector(tableReturnIndexPathSection:indexPathRow:)]) {
        [delegate tableReturnIndexPathSection:section indexPathRow:row];
    }
}

- (void)tableSwitchArray:(NSMutableArray *)array{
    if ([delegate respondsToSelector:@selector(tableSwitchArray:)]) {
        [delegate tableSwitchArray:array];
    }

}

#pragma mark switchcell 的代理方法
- (void)switchReturnYesOrNo:(NSString *)yesorno section:(NSInteger)section row:(NSInteger)row{
   // NSLog(@"aa = %d, row = %d, yesorno = %@", section, row);
    NSMutableArray * array = [titleArray objectAtIndex:section];
    if (row > 0 && row < [array count]+1) {
        
        NSMutableArray * swarr = [switchArray objectAtIndex:section];
        [swarr replaceObjectAtIndex:row-1 withObject:yesorno];
        [switchArray replaceObjectAtIndex:section withObject:swarr];
        [self tableSwitchArray:switchArray];
     
        SwitchCell * cell = (SwitchCell *)[myTabelView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
        NSLog(@"titleLabel = %@", cell.titleLabel.text);
        if ([yesorno isEqualToString:@"1"]) {
            
            [MobClick event:@"event_shezhi_tuisongshezhi_kaiqi" label:cell.titleLabel.text];
        }else{
            [MobClick event:@"event_shezhi_tuisongshezhi_guanbi" label:cell.titleLabel.text];
        }
        
    }
    
    [myTabelView reloadData];
    
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