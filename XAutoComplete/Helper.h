//
//  Helper.h
//  XAutoComplete
//
//  Created by Kael on 15/12/27.
//  Copyright © 2015年 Kael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XcodeMisc.h"
@interface Helper : NSObject

+ (instancetype)shardHelper;

- (IDEEditor *)currentEditor;
- (DVTSourceTextView *)currentSourceTextView;


@end
