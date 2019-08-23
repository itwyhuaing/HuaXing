//
//  TodayNoteModel.m
//  HuaXing
//
//  Created by wangyinghua on 2019/8/18.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "TodayNoteModel.h"

@implementation TodayNoteModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.foldStatus = TRUE;
        self.itemID = [HXUtil md5HexDigest:@""];
    }
    return self;
}


-(void)setTime:(NSString *)time {
    _time = time;
    _itemID = [HXUtil md5HexDigest:time];
}

@end
