//
//  PassTypeUtils.m
//  Lottery
//
//  Created by Jacob Chiang on 12-2-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GC_PassTypeUtils.h"

@implementation GC_PassTypeUtils


+(NSMutableArray*)lotteryId:(NSInteger)lotteryID GameCount:(NSInteger)gameCount{
    
    NSMutableArray *allPassTypelist = [NSMutableArray arrayWithObjects: @"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"8串8",@"8串9",@"8串28",@"8串56",@"8串70",@"8串247",nil];
    
     NSMutableArray *twolist = [NSMutableArray arrayWithObjects:@"2串1",nil];
    
     NSMutableArray *threelist = [NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"3串3",@"3串4",nil];
    
     NSMutableArray *fourlist = [NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"4串1",@"4串4",@"4串5",@"4串6",@"4串11",nil];
    
     NSMutableArray *fivelist = [NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"4串1",@"5串1",@"5串5",@"5串6",@"5串10",@"5串16",@"5串20",@"5串26",nil];
    
     NSMutableArray *sixlist =[NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"6串6",@"6串7",@"6串15",@"6串20",@"6串22",@"6串35",@"6串42",@"6串50",@"6串57",nil];
    
      NSMutableArray *sevenlist = [NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"7串7",@"7串8",@"7串21",@"7串35",@"7串120",nil];
    
    NSMutableArray *_arry = nil;
    
    if (lotteryID==1 || lotteryID == 11 || lotteryID == 12 || lotteryID == 14||lotteryID == 15 || lotteryID == 16 || lotteryID == 17|| lotteryID == 18 ) {
        switch (gameCount) {
            case 2:{
            // _arry = [NSMutableArray arrayWithCapacity:2];
                _arry = twolist;
                
            }
                break;
            case 3:{
            //    _arry = [NSMutableArray arrayWithCapacity:5];
                if (lotteryID == 17|| lotteryID == 18) {
                    NSMutableArray *threelist1 = [NSMutableArray arrayWithObjects:@"3串1",nil];
                     _arry = threelist1;
                }else{
                     _arry = threelist;
                }
               
                
            }
                break;
                
            case 4:{
            //    _arry = [NSMutableArray arrayWithCapacity:10];
//                _arry = fourlist;
                if (lotteryID == 17|| lotteryID == 18) {
                    NSMutableArray *fourlist1 = [NSMutableArray arrayWithObjects:@"4串1",nil];
                    _arry = fourlist1;
                }else{
                    _arry = fourlist;
                }
                
            }
                break;
                
            case 5:{
            //    _arry = [NSMutableArray arrayWithCapacity:17];
             
                if (lotteryID == 17|| lotteryID == 18) {
                    NSMutableArray *fivelist1 = [NSMutableArray arrayWithObjects:@"5串1",nil];
                    _arry = fivelist1;
                }else{
                    _arry = fivelist;
                }
                
            }
                break;
                
            case 6:{
            //    _arry = [NSMutableArray arrayWithCapacity:27];
                if (lotteryID == 17|| lotteryID == 18) {
                    NSMutableArray *sixlist1 = [NSMutableArray arrayWithObjects:@"6串1",nil];
                    _arry = sixlist1;
                }else{
                    _arry = sixlist;
                }
               
                
            }
                break;
                
            case 7:{
            //    _arry = [NSMutableArray arrayWithCapacity:33];
                if (lotteryID == 17|| lotteryID == 18) {
                    NSMutableArray *sevenlist1 = [NSMutableArray arrayWithObjects:@"7串1",nil];
                    _arry = sevenlist1;
                }else{
                    _arry = sevenlist;
                }
                
                
            }
                break;
            default:{
            //    _arry = [NSMutableArray arrayWithCapacity:40];
                if (lotteryID == 17|| lotteryID == 18) {
                    NSMutableArray *allPassTypelist1 = [NSMutableArray arrayWithObjects:@"8串1",nil];
                    _arry = allPassTypelist1;
                }else{
                    _arry = allPassTypelist;
                }
               
            }
                break;
        }
    }else if(lotteryID==2||lotteryID==4|| lotteryID == 20318){
    
        switch (gameCount) {
            case 2:{
             //   _arry = [NSMutableArray arrayWithCapacity:2];
//                if (lotteryID == 20318) {
//                     _arry = twolist;
//                }else{
                     _arry = twolist;
//                }
               
                
            }
                break;
            case 3:{
            //    _arry = [NSMutableArray arrayWithCapacity:5];
//                _arry = threelist;
                if (lotteryID == 20318) {
                    _arry = [NSMutableArray arrayWithObjects:@"3串1",nil];
                }else{
                    _arry = threelist;
                }

                
            }
                break;
            default:{
             //   _arry = [NSMutableArray arrayWithCapacity:10];
//                _arry = fourlist;
                if (lotteryID == 20318) {
                    _arry = [NSMutableArray arrayWithObjects:@"4串1",nil];
                }else{
                    _arry = fourlist;
                }

            }
                break;
        }

    }else if(lotteryID==3){
        
        switch (gameCount) {
            case 2:{
             //   _arry = [NSMutableArray arrayWithCapacity:2];
                _arry = twolist;
                
            }
                break;
            case 3:{
            //    _arry = [NSMutableArray arrayWithCapacity:5];
                _arry = threelist;
                
            }
                break;
            
            default:{
             //   _arry = [NSMutableArray arrayWithCapacity:27];
                _arry = fourlist;
            }
                break;
        }

    }else if(lotteryID == 5){
        switch (gameCount) {
            case 2:{
                //   _arry = [NSMutableArray arrayWithCapacity:2];
                _arry = twolist;
                
            }
                break;
            case 3:{
                //    _arry = [NSMutableArray arrayWithCapacity:5];
                _arry = threelist;
                
            }
                break;
                
           
            default:{
                //   _arry = [NSMutableArray arrayWithCapacity:27];
                _arry = fourlist;
            }
                break;
        }

        
    }else if(lotteryID == 6){
        switch (gameCount) {
            case 2:{
                //   _arry = [NSMutableArray arrayWithCapacity:2];
                _arry = twolist;
                
            }
                break;
            case 3:{
                //    _arry = [NSMutableArray arrayWithCapacity:5];
                _arry = threelist;
                
            }
                break;
                
            case 4: {
                //    _arry = [NSMutableArray arrayWithCapacity:10];
                _arry = fourlist;
                
            } 
                break;
            case 5:{
                //   _arry = [NSMutableArray arrayWithCapacity:17];
                _arry = fivelist;
            }
                break;
            default:{
                //   _arry = [NSMutableArray arrayWithCapacity:27];
                _arry = sixlist;
            }
                break;
        }
        
        
    }else if (lotteryID == 20019||lotteryID == 200191||lotteryID == 200192){
    
        if (lotteryID == 20019) {
            
            switch (gameCount) {
                case 2:{
                    
                    _arry = twolist;
                    
                }
                    break;
                case 3:{
                   
                    _arry = threelist;
                    
                }
                    break;
                    
                    
                default:{
                   
                    _arry = fourlist;
                }
                    break;
            }

            
        }else if (lotteryID == 200191){
            
            switch (gameCount) {
                case 2:{
                    
                    _arry = twolist;
                    
                }
                    break;
                case 3:{
                    
                    _arry = threelist;
                    
                }
                    break;
                case 4:{
                    
                    _arry = fourlist;
                    
                }
                    break;
                    
                case 5:{
                    
                    _arry = fivelist;
                    
                }
                    break;
                
                    
                default:{
                    
                    _arry = sixlist;
                }
                    break;
            }
        
        }else if (lotteryID == 200192){
            switch (gameCount) {
                case 2:{
                    
                    _arry = twolist;
                    
                }
                    break;
                case 3:{
                    
                    _arry = threelist;
                    
                }
                    break;
                case 4:{
                    
                    _arry = fourlist;
                    
                }
                    break;
                    
                case 5:{
                    
                    _arry = fivelist;
                    
                }
                    break;
                case 6:{
                    
                    _arry = sixlist;
                    
                }
                    break;
                case 7:{
                    
                    _arry = sevenlist;
                    
                }
                    break;
                default:{
                    
                    _arry = allPassTypelist;
                }
                    break;
            }
        }
    
    }

    return _arry;
}

+(NSMutableArray*)danLotteryId:(NSInteger)lotteryID GameCount:(NSInteger)gameCount{
    
    NSMutableArray *allDanlist = [NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1", nil];
    
    NSMutableArray *twolist  = [NSMutableArray arrayWithObjects:@"2串1", nil];
    
    NSMutableArray *threelist  = [NSMutableArray arrayWithObjects:@"2串1",@"3串1", nil];
    
    NSMutableArray *fourlist  = [NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"4串1", nil];
    
    NSMutableArray *fivelist  = [NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"4串1",@"5串1", nil];
    
    NSMutableArray *sixlist = [NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"4串1",@"5串1",@"6串1", nil];
    
    NSMutableArray *sevenlist = [NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"4串1",@"5串1",@"6串1", @"7串1", nil];
    
    NSMutableArray *danList;
    
    if (lotteryID == 20019) {
        switch (gameCount) {
            case 2:
                danList= twolist;
                break;
            case 3:
                danList= threelist;
                break;
            case 4:
                danList= fourlist;
                break;
            case 5:
                danList= fivelist;
                break;
            case 6:
                danList= sixlist;
                break;
            case 7:
                danList= sevenlist;
                break;
            default:
                
                danList =allDanlist;
                
                break;
        }
    }else if(lotteryID == 5 || lotteryID == 20318){
        switch (gameCount) {
            case 2:
                danList= twolist;  
                break;
            case 3:
                danList= threelist;  
                break;
            case 4:
                danList= fourlist;  
                break;
                
            default:
                
                danList =fourlist;
                
                break;
        }
        
    }else if(lotteryID == 6){
        switch (gameCount) {
            case 2:
                danList= twolist;  
                break;
            case 3:
                danList= threelist;  
                break;
            case 4:
                danList= fourlist;  
                break;
            case 5:
                danList= fivelist;  
                break;
                
            default:
                
                danList =sixlist;
                
                break;
        }
        
    }else if(lotteryID == 2){
        switch (gameCount) {
            case 2:
                danList= twolist;  
                break;
            case 3:
                danList= threelist;  
                break;
            case 4:
                danList= fourlist;  
                break;
          
            default:
                
                    danList =fourlist;
               
                break;
        }

    }else{
        switch (gameCount) {
            case 2:
                danList= twolist;  
                break;
            case 3:
                danList= threelist;  
                break;
            case 4:
                danList= fourlist;  
                break;
            case 5:{
                if (lotteryID==1||lotteryID==3 || lotteryID == 15|| lotteryID == 16|| lotteryID == 17|| lotteryID == 18)
                    danList= fivelist;  
                else
                    danList= fourlist;  
            } 
                break;
            case 6:{
                if (lotteryID==1||lotteryID==11 || lotteryID == 12 || lotteryID == 14|| lotteryID == 15|| lotteryID == 16|| lotteryID == 17|| lotteryID == 18)
                    danList= sixlist;  
                else
                    danList= fourlist;  
            } 
                break;
            case 7:{
                if (lotteryID==1||lotteryID==11 || lotteryID == 12 || lotteryID == 14|| lotteryID == 15 || lotteryID == 16|| lotteryID == 17|| lotteryID == 18)
                    danList= sevenlist;  
                else if(lotteryID==3)
                    danList= sixlist; 
                else
                    danList = fourlist;
            }
                break;
            default:
                if (lotteryID==2||lotteryID==4) {
                    danList =fourlist;
                } else if(lotteryID==1||lotteryID==11 || lotteryID == 12 || lotteryID == 14|| lotteryID == 15||lotteryID == 16|| lotteryID == 17|| lotteryID == 18)
                    danList = allDanlist;
                else
                    danList = sixlist;
                break;
        }

    }
    
        
    return danList;
}




+(NSString*)passTypeChange:(NSString*)passType{
    if (passType&&![passType isEqualToString:@"单关"]) {
        return  [passType stringByReplacingOccurrencesOfString:@"串" withString:@"x" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [passType length])];
    }
    return passType;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    