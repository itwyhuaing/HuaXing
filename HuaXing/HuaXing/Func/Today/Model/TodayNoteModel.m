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
        _time = @"10:59";
        _briefInfo = @"中国ETC服务平台正式上线运营";
        _detailInfo = @"中国ETC服务平台于8月18日正式上线提供服务，车主可通过国务院客户端小程序ETC服务专区或交通运输部官方微信ETC服务平台免费在线申办ETC。";
        _showInfo = @"";
        _foldImageName = @"today_unfold";
    }
    return self;
}

@end
