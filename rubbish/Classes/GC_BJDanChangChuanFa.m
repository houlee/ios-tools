//
//  GC_BJDanChangChuanFa.m
//  caibo
//
//  Created by houchenguang on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GC_BJDanChangChuanFa.h"

@implementation GC_BJDanChangChuanFa


+(NSMutableArray*)lotteryId:(NSInteger)lotteryID GameCount:(NSInteger)gameCount type:(NSInteger)type{
    if (lotteryID == 11) {
        NSMutableArray *allPassTypelist = [NSMutableArray arrayWithObjects: @"3串1", @"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1", @"10串1", @"11串1", @"12串1", @"13串1", @"14串1", @"15串1",@"4串5",@"5串6",@"5串16",@"6串7",@"6串22",@"6串42", nil];
        
        NSMutableArray * onelist = [NSMutableArray arrayWithObjects:@"单关", nil];
        
        NSMutableArray *twolist = [NSMutableArray arrayWithObjects: @"单关", @"2串1", @"2串3",nil];
        
        NSMutableArray *threelist = [NSMutableArray arrayWithObjects: @"3串1",nil];
        
        NSMutableArray *fourlist = [NSMutableArray arrayWithObjects: @"3串1",@"4串1",@"4串5",nil];
        
        NSMutableArray *fivelist = [NSMutableArray arrayWithObjects:  @"3串1",@"4串1",@"5串1",@"4串5",@"5串6",@"5串16",nil];
        
        NSMutableArray *sixlist =[NSMutableArray arrayWithObjects: @"3串1",@"4串1",@"5串1",@"6串1",@"4串5",@"5串6",@"5串16",@"6串7",@"6串22",@"6串42",nil]; 
        
        NSMutableArray *sevenlist = [NSMutableArray arrayWithObjects: @"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"4串5",@"5串6",@"5串16",@"6串7",@"6串22",@"6串42",nil];
        
        NSMutableArray *eightlist = [NSMutableArray arrayWithObjects: @"3串1",@"4串1",@"5串1",@"6串1",@"7串1", @"8串1",@"4串5",@"5串6",@"5串16",@"6串7",@"6串22",@"6串42",nil];
        
        NSMutableArray *ninelist = [NSMutableArray arrayWithObjects: @"3串1",@"4串1",@"5串1",@"6串1",@"7串1", @"8串1",@"9串1",@"4串5",@"5串6",@"5串16",@"6串7",@"6串22",@"6串42",nil];
        
        
        NSMutableArray *tenlist = [NSMutableArray arrayWithObjects:  @"3串1",@"4串1",@"5串1",@"6串1",@"7串1", @"8串1",@"9串1",@"10串1",@"4串5",@"5串6",@"5串16",@"6串7",@"6串22",@"6串42", nil];
        
        NSMutableArray *elevenlist = [NSMutableArray arrayWithObjects: @"3串1",@"4串1",@"5串1",@"6串1",@"7串1", @"8串1",@"9串1",@"10串1",@"11串1",@"4串5",@"5串6",@"5串16",@"6串7",@"6串22",@"6串42",nil];
        
        NSMutableArray *twelvelist = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"5串1",@"6串1",@"7串1", @"8串1",@"9串1",@"10串1",@"11串1", @"12串1",@"4串5",@"5串6",@"5串16",@"6串7",@"6串22",@"6串42",nil];
        
        NSMutableArray *thirteenlist = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"5串1",@"6串1",@"7串1", @"8串1",@"9串1",@"10串1",@"11串1", @"12串1",@"13串1",@"4串5",@"5串6",@"5串16",@"6串7",@"6串22",@"6串42",nil];
        
        NSMutableArray *fourteenlist = [NSMutableArray arrayWithObjects: @"3串1",@"4串1",@"5串1",@"6串1",@"7串1", @"8串1",@"9串1",@"10串1",@"11串1", @"12串1",@"13串1", @"14串1",@"4串5",@"5串6",@"5串16",@"6串7",@"6串22",@"6串42", nil];
        
        // NSMutableArray *fifteenlist = [NSMutableArray arrayWithObjects: @"单关",@"2串1",@"2串3", @"3串1",@"3串4",@"3串7",@"4串1",@"4串5",@"4串11",@"4串15",@"5串1",@"5串6",@"5串16",@"5串26",@"5串31",@"6串1",@"6串7",@"6串22",@"6串42",@"6串57",@"6串63",@"7串1", @"8串1", @"9串1", @"10串1",@"11串1", @"12串1", @"13串1", @"14串1",@"15串1", nil];
        
        
        NSMutableArray *_arry = nil;
        
        if (lotteryID==11) {
            switch (gameCount) {
                case 1:{
//                    _arry = [NSMutableArray arrayWithCapacity:1];
                    _arry = onelist;
                    
                }
                    break;
                case 2:{
//                    _arry = [NSMutableArray arrayWithCapacity:2];
                    _arry = twolist;
                    
                }
                    break;
                case 3:{
//                    _arry = [NSMutableArray arrayWithCapacity:5];
                    _arry = threelist;
                    
                }
                    break;
                    
                case 4:{
//                    _arry = [NSMutableArray arrayWithCapacity:10];
                    _arry = fourlist;
                    
                }
                    break;
                    
                case 5:{
//                    _arry = [NSMutableArray arrayWithCapacity:17];
                    _arry = fivelist;
                    
                }
                    break;
                    
                case 6:{
//                    _arry = [NSMutableArray arrayWithCapacity:27];
                    _arry = sixlist;
                    
                }
                    break;
                    
                case 7:{
//                    _arry = [NSMutableArray arrayWithCapacity:33];
                    _arry = sevenlist;
                    
                }
                    break;
                case 8:{
//                    _arry = [NSMutableArray arrayWithCapacity:33];
                    _arry = eightlist;
                    
                }
                    break;
                    
                case 9:{
//                    _arry = [NSMutableArray arrayWithCapacity:33];
                    _arry = ninelist;
                    
                }
                    break;
                case 10:{
//                    _arry = [NSMutableArray arrayWithCapacity:33];
                    _arry = tenlist;
                    
                }
                    break;
                case 11:{
//                    _arry = [NSMutableArray arrayWithCapacity:33];
                    _arry = elevenlist;
                    
                }
                    break;
                case 12:{
//                    _arry = [NSMutableArray arrayWithCapacity:33];
                    _arry = twelvelist;
                    
                }
                    break;
                case 13:{
//                    _arry = [NSMutableArray arrayWithCapacity:33];
                    _arry = thirteenlist;
                    
                }
                    break;
                case 14:{
//                    _arry = [NSMutableArray arrayWithCapacity:33];
                    _arry = fourteenlist;
                    
                }
                    break;
                    
                default:{
//                    _arry = [NSMutableArray arrayWithCapacity:40];
                    _arry = allPassTypelist;
                }
                    break;
            }
        }
        return _arry;

    }else if(type == 6){
         NSMutableArray *allPassTypelist = [NSMutableArray arrayWithObjects: @"3串1", @"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1", @"10串1", @"11串1", @"12串1", @"13串1", @"14串1", @"15串1",@"4串5",@"5串6",@"5串16",@"6串7",@"6串22",@"6串42", nil];
        
        NSMutableArray *threelist  = [NSMutableArray arrayWithObjects:@"3串1", nil];
        
        NSMutableArray *fourlist  = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"4串5", nil];
        
        NSMutableArray *fivelist  = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"5串1",@"4串5",@"5串6",@"5串16", nil];
        
        NSMutableArray *sixlist = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"5串1",@"6串1", @"4串5",@"5串6",@"5串16",@"6串7", @"6串22", @"6串42", nil];
        
        NSMutableArray *sevenlist = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"5串1",@"6串1",@"7串1", @"4串5",@"5串6",@"5串16",@"6串7", @"6串22", @"6串42", nil];
        
        NSMutableArray *eightlist = [NSMutableArray arrayWithObjects: @"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"4串5",@"5串6",@"5串16",@"6串7", @"6串22", @"6串42",nil];
        
        NSMutableArray *ninelist = [NSMutableArray arrayWithObjects: @"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1",@"4串5",@"5串6",@"5串16",@"6串7", @"6串22", @"6串42",nil];
        
        
        NSMutableArray *tenlist = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1", @"10串1", @"4串5",@"5串6",@"5串16",@"6串7", @"6串22", @"6串42",nil];
        
        NSMutableArray *elevenlist = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1", @"10串1", @"11串1", @"4串5",@"5串6",@"5串16",@"6串7", @"6串22", @"6串42",nil];
        
        NSMutableArray *twelvelist = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1", @"10串1", @"11串1", @"12串1",@"4串5",@"5串6",@"5串16",@"6串7", @"6串22", @"6串42",nil];
        
        NSMutableArray *thirteenlist = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1", @"10串1", @"11串1", @"12串1", @"13串1",@"4串5",@"5串6",@"5串16",@"6串7", @"6串22", @"6串42",nil];
        
        NSMutableArray *fourteenlist = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1", @"10串1", @"11串1", @"12串1", @"13串1", @"14串1", @"4串5",@"5串6",@"5串16",@"6串7", @"6串22", @"6串42",nil];
        
        
        NSMutableArray *_arry = nil;
        
        switch (gameCount) {
                
                
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
            case 8:{
                
                _arry = eightlist;
                
            }
                break;
            case 9:{
                
                _arry = ninelist;
                
            }
                break;
            case 10:{
                
                _arry = tenlist;
                
            }
                break;
            case 11:{
                
                _arry = elevenlist;
                
            }
                break;
            case 12:{
                
                _arry = twelvelist;
                
            }
                break;
            case 13:{
                
                _arry = thirteenlist;
                
            }
                break;
            case 14:{
                
                _arry = fourteenlist;
                
            }
                break;
                
            default:{
                
                _arry = allPassTypelist;
                
                
            }
                break;
        }
        return _arry;
    
    } else{
        NSMutableArray *allPassTypelist = [NSMutableArray arrayWithObjects: @"单关",@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1", @"10串1", @"11串1", @"12串1", @"13串1", @"14串1", @"15串1",@"2串3",@"3串4",@"3串7", @"4串5",@"4串11",@"4串15", @"5串6",@"5串16",@"5串26",@"5串31",@"6串7",@"6串22",@"6串42",@"6串57",@"6串63", nil];
        
        NSMutableArray * onelist = [NSMutableArray arrayWithObjects:@"单关", nil];
        
        NSMutableArray *twolist = [NSMutableArray arrayWithObjects: @"单关", @"2串1", @"2串3",nil];
        
        NSMutableArray *threelist = [NSMutableArray arrayWithObjects: @"单关",@"2串1",@"3串1",@"2串3", @"3串4",@"3串7",nil];
        
        NSMutableArray *fourlist = [NSMutableArray arrayWithObjects: @"单关",@"2串1",@"3串1",@"4串1",@"2串3", @"3串4",@"3串7",@"4串5",@"4串11",@"4串15",nil];
        
        NSMutableArray *fivelist = [NSMutableArray arrayWithObjects: @"单关",@"2串1",@"3串1",@"4串1",@"5串1",@"2串3", @"3串4",@"3串7",@"4串5",@"4串11",@"4串15",@"5串6",@"5串16",@"5串26",@"5串31",nil];
        
        NSMutableArray *sixlist =[NSMutableArray arrayWithObjects: @"单关",@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"2串3", @"3串4",@"3串7",@"4串5",@"4串11",@"4串15",@"5串6",@"5串16",@"5串26",@"5串31",@"6串7",@"6串22",@"6串42",@"6串57",@"6串63",nil]; 
        
        NSMutableArray *sevenlist = [NSMutableArray arrayWithObjects: @"单关",@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"2串3", @"3串4",@"3串7",@"4串5",@"4串11",@"4串15",@"5串6",@"5串16",@"5串26",@"5串31",@"6串7",@"6串22",@"6串42",@"6串57",@"6串63",nil];
        
        NSMutableArray *eightlist = [NSMutableArray arrayWithObjects: @"单关",@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"2串3", @"3串4",@"3串7",@"4串5",@"4串11",@"4串15",@"5串6",@"5串16",@"5串26",@"5串31",@"6串7",@"6串22",@"6串42",@"6串57",@"6串63", nil];
        
        NSMutableArray *ninelist = [NSMutableArray arrayWithObjects: @"单关",@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1", @"9串1",@"2串3", @"3串4",@"3串7",@"4串5",@"4串11",@"4串15",@"5串6",@"5串16",@"5串26",@"5串31",@"6串7",@"6串22",@"6串42",@"6串57",@"6串63", nil];
        
        
        NSMutableArray *tenlist = [NSMutableArray arrayWithObjects: @"单关",@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1", @"9串1", @"10串1",@"2串3", @"3串4",@"3串7",@"4串5",@"4串11",@"4串15",@"5串6",@"5串16",@"5串26",@"5串31",@"6串7",@"6串22",@"6串42",@"6串57",@"6串63",  nil];
        
        NSMutableArray *elevenlist = [NSMutableArray arrayWithObjects: @"单关",@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1", @"9串1", @"10串1",@"11串1",@"2串3", @"3串4",@"3串7",@"4串5",@"4串11",@"4串15",@"5串6",@"5串16",@"5串26",@"5串31",@"6串7",@"6串22",@"6串42",@"6串57",@"6串63", nil];
        NSMutableArray *twelvelist = [NSMutableArray arrayWithObjects:@"单关",@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1", @"8串1", @"9串1", @"10串1",@"11串1", @"12串1",@"2串3", @"3串4",@"3串7",@"4串5",@"4串11",@"4串15",@"5串6",@"5串16",@"5串26",@"5串31",@"6串7",@"6串22",@"6串42",@"6串57",@"6串63",nil];
        
        NSMutableArray *thirteenlist = [NSMutableArray arrayWithObjects:@"单关",@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1", @"8串1", @"9串1", @"10串1",@"11串1", @"12串1", @"13串1",@"2串3", @"3串4",@"3串7",@"4串5",@"4串11",@"4串15",@"5串6",@"5串16",@"5串26",@"5串31",@"6串7",@"6串22",@"6串42",@"6串57",@"6串63",nil];
        
        NSMutableArray *fourteenlist = [NSMutableArray arrayWithObjects:@"单关",@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1", @"9串1", @"10串1",@"11串1", @"12串1", @"13串1", @"14串1",@"2串3", @"3串4",@"3串7",@"4串5",@"4串11",@"4串15",@"5串6",@"5串16",@"5串26",@"5串31",@"6串7",@"6串22",@"6串42",@"6串57",@"6串63",  nil];
        
        // NSMutableArray *fifteenlist = [NSMutableArray arrayWithObjects: @"单关",@"2串1",@"2串3", @"3串1",@"3串4",@"3串7",@"4串1",@"4串5",@"4串11",@"4串15",@"5串1",@"5串6",@"5串16",@"5串26",@"5串31",@"6串1",@"6串7",@"6串22",@"6串42",@"6串57",@"6串63",@"7串1", @"8串1", @"9串1", @"10串1",@"11串1", @"12串1", @"13串1", @"14串1",@"15串1", nil];
        
        
        NSMutableArray *_arry = nil;
        if (type == 4) { // 比分 未设胆
            switch (gameCount) {
                case 1:{
                    //                    _arry = [NSMutableArray arrayWithCapacity:1];
                    _arry = onelist;
                    
                }
                    break;
                case 2:{
                    //                    _arry = [NSMutableArray arrayWithCapacity:2];
                    _arry = twolist;
                    
                }
                    break;
                case 3:{
                    //                    _arry = [NSMutableArray arrayWithCapacity:5];
                    _arry = threelist;
                    
                }
                    break;
                default:{
                    //                    _arry = [NSMutableArray arrayWithCapacity:40];
                    
                    _arry = threelist;
                    
                }
                    break;
            }
            return _arry;
        }
        if (lotteryID==1) {
            switch (gameCount) {
                case 1:{
//                    _arry = [NSMutableArray arrayWithCapacity:1];
                    _arry = onelist;
                    
                }
                    break;
                case 2:{
//                    _arry = [NSMutableArray arrayWithCapacity:2];
                    _arry = twolist;
                    
                }
                    break;
                case 3:{
//                    _arry = [NSMutableArray arrayWithCapacity:5];
                    _arry = threelist;
                    
                }
                    break;
                    
                case 4:{
//                    _arry = [NSMutableArray arrayWithCapacity:10];
                    _arry = fourlist;
                    
                }
                    break;
                    
                case 5:{
//                    _arry = [NSMutableArray arrayWithCapacity:17];
                    _arry = fivelist;
                    
                }
                    break;
                    
                case 6:{
//                    _arry = [NSMutableArray arrayWithCapacity:27];
                    _arry = sixlist;
                    
                    
                }
                    break;
                    
                case 7:{
//                    _arry = [NSMutableArray arrayWithCapacity:33];
                    if (type == 1) {
                        _arry = sixlist;
                    }else{
                        _arry = sevenlist;
                    }
                    
                    
                }
                    break;
                case 8:{
//                    _arry = [NSMutableArray arrayWithCapacity:33];
                    
                    if (type == 1) {
                        _arry = sixlist;
                    }else{
                       _arry = eightlist;
                    }
                    
                }
                    break;
                    
                case 9:{
//                    _arry = [NSMutableArray arrayWithCapacity:33];
                    
                    if (type == 1) {
                        _arry = sixlist;
                    }else{
                       _arry = ninelist;
                    }
                    
                }
                    break;
                case 10:{
//                    _arry = [NSMutableArray arrayWithCapacity:33];
                    
                    if (type == 1) {
                        _arry = sixlist;
                    }else{
                        _arry = tenlist;
                    }
                    
                }
                    break;
                case 11:{
//                    _arry = [NSMutableArray arrayWithCapacity:33];
                    
                    if (type == 1) {
                        _arry = sixlist;
                    }else{
                       _arry = elevenlist;
                    }
                    
                }
                    break;
                case 12:{
//                    _arry = [NSMutableArray arrayWithCapacity:33];
                   
                    if (type == 1) {
                        _arry = sixlist;
                    }else{
                         _arry = twelvelist;
                    }

                    
                }
                    break;
                case 13:{
//                    _arry = [NSMutableArray arrayWithCapacity:33];
                    
                    if (type == 1) {
                        _arry = sixlist;
                    }else{
                       _arry = thirteenlist;
                    }
                    
                }
                    break;
                case 14:{
//                    _arry = [NSMutableArray arrayWithCapacity:33];
                    
                    if (type == 1) {
                        _arry = sixlist;
                    }else{
                       _arry = fourteenlist;
                    }
                    
                }
                    break;
                    
                default:{
//                    _arry = [NSMutableArray arrayWithCapacity:40];
                   
                    if (type == 1) {
                        _arry = sixlist;
                    }else{
                         _arry = allPassTypelist;
                    }
                }
                    break;
            }
        }
        return _arry;
    
    }
    return nil;
}

+(NSMutableArray*)danLotteryId:(NSInteger)lotteryID GameCount:(NSInteger)gameCount type:(NSInteger)type{
    
   
    if (type == 6) {
        
        NSMutableArray *threelist  = [NSMutableArray arrayWithObjects:@"3串1", nil];
        
        NSMutableArray *fourlist  = [NSMutableArray arrayWithObjects:@"3串1",@"4串1", nil];
        
        NSMutableArray *fivelist  = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"5串1", nil];
        
        NSMutableArray *sixlist = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"5串1",@"6串1", nil];
        
        NSMutableArray *sevenlist = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"5串1",@"6串1",@"7串1", nil];
        
        NSMutableArray *eightlist = [NSMutableArray arrayWithObjects: @"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",nil];
        
        NSMutableArray *ninelist = [NSMutableArray arrayWithObjects: @"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1",nil];
        
        
        NSMutableArray *tenlist = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1", @"10串1", nil];
        
        NSMutableArray *elevenlist = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1", @"10串1", @"11串1", nil];
        
        NSMutableArray *twelvelist = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1", @"10串1", @"11串1", @"12串1",nil];
        
        NSMutableArray *thirteenlist = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1", @"10串1", @"11串1", @"12串1", @"13串1",nil];
        
        NSMutableArray *fourteenlist = [NSMutableArray arrayWithObjects:@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1", @"10串1", @"11串1", @"12串1", @"13串1", @"14串1", nil];
        
            
        NSMutableArray *_arry = nil;
        
        switch (gameCount) {
                
                
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
            case 8:{
                
                _arry = eightlist;
                
            }
                break;
            case 9:{
                
                _arry = ninelist;
                
            }
                break;
            case 10:{
                
                _arry = tenlist;
                
            }
                break;
            case 11:{
                
                _arry = elevenlist;
                
            }
                break;
            case 12:{
                
                _arry = twelvelist;
                
            }
                break;
            case 13:{
                
                _arry = thirteenlist;
                
            }
                break;
                
            default:{
                
                _arry = fourteenlist;
                
                
            }
                break;
        }
        return _arry;
        

    }else{
        NSMutableArray *allDanlist = [NSMutableArray arrayWithObjects: @"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1", @"9串1",@"10串1",@"11串1",@"12串1",@"13串1",@"14串1",@"15串1",nil];
        
        //  NSMutableArray *onelist = [NSMutableArray arrayWithObjects:@"单关", nil];
        
        NSMutableArray *twolist  = [NSMutableArray arrayWithObjects:@"2串1", nil];
        
        NSMutableArray *threelist  = [NSMutableArray arrayWithObjects:@"2串1",@"3串1", nil];
        
        NSMutableArray *fourlist  = [NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"4串1", nil];
        
        NSMutableArray *fivelist  = [NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"4串1",@"5串1", nil];
        
        NSMutableArray *sixlist = [NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"4串1",@"5串1",@"6串1", nil];
        
        NSMutableArray *sevenlist = [NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1", nil];
        
        NSMutableArray *eightlist = [NSMutableArray arrayWithObjects: @"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",nil];
        
        NSMutableArray *ninelist = [NSMutableArray arrayWithObjects: @"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1",nil];
        
        
        NSMutableArray *tenlist = [NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1", @"10串1", nil];
        
        NSMutableArray *elevenlist = [NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1", @"10串1", @"11串1", nil];
        
        NSMutableArray *twelvelist = [NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1", @"10串1", @"11串1", @"12串1",nil];
        
        NSMutableArray *thirteenlist = [NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1", @"10串1", @"11串1", @"12串1", @"13串1",nil];
        
        NSMutableArray *fourteenlist = [NSMutableArray arrayWithObjects:@"2串1",@"3串1",@"4串1",@"5串1",@"6串1",@"7串1",@"8串1",@"9串1", @"10串1", @"11串1", @"12串1", @"13串1", @"14串1", nil];
        
        
        NSMutableArray *_arry = nil;
        if (type == 4) {//比分设胆
            switch (gameCount) {
                    
                case 2:{
                    
                    _arry = twolist;
                    
                }
                    break;
                case 3:{
                    //                _arry = [NSMutableArray arrayWithCapacity:5];
                    _arry = threelist;
                    
                }
                    break;
                default:{
                    //                _arry = [NSMutableArray arrayWithCapacity:40];
                    
                    
                    _arry = threelist;
                    
                    
                }
                    break;
            }
            return _arry;
            
        }
        if (lotteryID==1) {
            switch (gameCount) {
                    //            case 1:{
                    //                _arry = [NSMutableArray arrayWithCapacity:1];
                    //                _arry = onelist;
                    //
                    //            }
                    //                break;
                case 2:{
                    //                _arry = [NSMutableArray arrayWithCapacity:2];
                    _arry = twolist;
                    
                }
                    break;
                case 3:{
                    //                _arry = [NSMutableArray arrayWithCapacity:5];
                    _arry = threelist;
                    
                }
                    break;
                    
                case 4:{
                    //                _arry = [NSMutableArray arrayWithCapacity:10];
                    _arry = fourlist;
                    
                }
                    break;
                    
                case 5:{
                    //                _arry = [NSMutableArray arrayWithCapacity:17];
                    _arry = fivelist;
                    
                }
                    break;
                    
                case 6:{
                    //                _arry = [NSMutableArray arrayWithCapacity:27];
                    _arry = sixlist;
                    
                    
                }
                    break;
                    
                case 7:{
                    //                _arry = [NSMutableArray arrayWithCapacity:33];
                    
                    if (type == 1) {
                        _arry = sixlist;
                    }else{
                        _arry = sevenlist;
                    }
                    
                }
                    break;
                case 8:{
                    //                _arry = [NSMutableArray arrayWithCapacity:33];
                    
                    if (type == 1) {
                        _arry = sixlist;
                    }else{
                        _arry = eightlist;
                    }
                    
                }
                    break;
                    
                case 9:{
                    //                _arry = [NSMutableArray arrayWithCapacity:33];
                    
                    if (type == 1) {
                        _arry = sixlist;
                    }else{
                        _arry = ninelist;
                    }
                    
                }
                    break;
                case 10:{
                    //                _arry = [NSMutableArray arrayWithCapacity:33];
                    
                    if (type == 1) {
                        _arry = sixlist;
                    }else{
                        _arry = tenlist;
                    }
                    
                }
                    break;
                case 11:{
                    //                _arry = [NSMutableArray arrayWithCapacity:33];
                    
                    if (type == 1) {
                        _arry = sixlist;
                    }else{
                        _arry = elevenlist;
                    }
                    
                }
                    break;
                case 12:{
                    //                _arry = [NSMutableArray arrayWithCapacity:33];
                    
                    if (type == 1) {
                        _arry = sixlist;
                    }else{
                        _arry = twelvelist;
                    }
                    
                }
                    break;
                case 13:{
                    //                _arry = [NSMutableArray arrayWithCapacity:33];
                    
                    if (type == 1) {
                        _arry = sixlist;
                    }else{
                        _arry = thirteenlist;
                    }
                    
                }
                    break;
                case 14:{
                    //                _arry = [NSMutableArray arrayWithCapacity:33];
                    
                    if (type == 1) {
                        _arry = sixlist;
                    }else{
                        _arry = fourteenlist;
                    }
                    
                }
                    break;
                    
                default:{
                    //                _arry = [NSMutableArray arrayWithCapacity:40];
                    
                    if (type == 1) {
                        _arry = sixlist;
                    }else{
                        _arry = allDanlist;
                    }
                    
                }
                    break;
            }
        }
        return _arry;
    }
    return nil;
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