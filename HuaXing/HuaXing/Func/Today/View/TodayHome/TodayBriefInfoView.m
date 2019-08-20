//
//  TodayBriefInfoView.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/16.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "TodayBriefInfoView.h"


@interface TodayBriefInfoView ()

@property (nonatomic,strong) UILabel *cntLabel;

@end

@implementation TodayBriefInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.cntLabel];
    self.cntLabel.sd_layout
    .topEqualToView(self)
    .bottomEqualToView(self)
    .leftSpaceToView(self, 15.0)
    .rightSpaceToView(self, 15.0);
}


-(void)setCnts:(NSArray<NSString *> *)cnts {
    if (cnts) {
        _cnts = cnts;
        self.cntLabel.attributedText = [self generateAttributedStringWithString:[self generateTextWithData:cnts]];
    }
}

- (NSString *)generateTextWithData:(NSArray<NSString *> *)data {
    NSMutableString *rlt = [[NSMutableString alloc] initWithString:@""];
    if (data) {
        for (NSInteger cou = 0; cou < data.count; cou ++) {
            NSString *curItem = data[cou];
            [rlt appendString:curItem];
            if (![curItem isEqualToString:[data lastObject]]) {
                [rlt appendString:@"\n"];
            }
        }
    }
    return rlt;
}

- (NSAttributedString *)generateAttributedStringWithString:(NSString *)string {
    NSMutableAttributedString *rlt = [[NSMutableAttributedString alloc] initWithString:@""];
    if (string) {
        [rlt appendAttributedString:[[NSMutableAttributedString alloc] initWithString:string]];
    }
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10.0];
    [rlt addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, rlt.length)];
    return rlt;
}

+(CGFloat)minHeight {
    return 60.0 * [UIAdapter Scale47Width];
}

-(UILabel *)cntLabel {
    if (!_cntLabel) {
        _cntLabel = [UILabel new];
        _cntLabel.textAlignment = NSTextAlignmentCenter;
        _cntLabel.numberOfLines = 0;
        _cntLabel.textColor = [UIAdapter lightTintBlack];
        _cntLabel.font = [UIAdapter font15];
    }
    return _cntLabel;
}

@end
