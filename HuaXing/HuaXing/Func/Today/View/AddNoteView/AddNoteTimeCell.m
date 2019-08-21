//
//  AddNoteTimeCell.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/20.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "AddNoteTimeCell.h"

@implementation AddNoteTimeCell

-(void)layoutSubviews {
    self.line.sd_resetLayout
    .leftSpaceToView(self.contentView, [UIAdapter lrGap])
    .rightSpaceToView(self.contentView, [UIAdapter lrGap])
    .bottomEqualToView(self.contentView)
    .heightIs(1.0);
}

@end
