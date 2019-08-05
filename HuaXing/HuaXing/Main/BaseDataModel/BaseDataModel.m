//
//  BaseDataModel.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/5.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "BaseDataModel.h"
#import <objc/runtime.h>

@implementation BaseDataModel

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (NSInteger index = 0; index < count; index ++) {
            Ivar ivar = ivars[index];
            const char *keyName = ivar_getName(ivar);
            NSString *keyNameString = [NSString stringWithCString:keyName encoding:NSUTF8StringEncoding];
            id value = [aDecoder decodeObjectForKey:keyNameString];
            [self setValue:value forKey:keyNameString];
        }
        free(ivars);
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (NSInteger index = 0; index < count; index ++) {
        Ivar ivar = ivars[index];
        const char *keyName = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSString *typeString = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        NSString *keyNameString = [NSString stringWithCString:keyName encoding:NSUTF8StringEncoding];
        id value = [self valueForKey:keyNameString];
        [aCoder encodeObject:value forKey:keyNameString];
    }
    free(ivars);
}


@end
