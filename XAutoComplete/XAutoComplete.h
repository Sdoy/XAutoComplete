//
//  XAutoComplete.h
//  XAutoComplete
//
//  Created by Kael on 15/12/27.
//  Copyright © 2015年 Kael. All rights reserved.
//

#import <AppKit/AppKit.h>

@class XAutoComplete;

static XAutoComplete *sharedPlugin;

@interface XAutoComplete : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end