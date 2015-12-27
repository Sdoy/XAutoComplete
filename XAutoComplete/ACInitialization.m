//
//  ACInitialization.m
//  XAutoComplete
//
//  Created by Kael on 15/12/27.
//  Copyright © 2015年 Kael. All rights reserved.
//

#import "ACInitialization.h"
#import "Helper.h"
@implementation ACInitialization

+(void)doACInitialization;
{
    DVTSourceTextView *textView=[[Helper shardHelper] currentSourceTextView];
    NSString *string=textView.textStorage.string;
    string=[self ACInterface:string];
    string=[self ACImplementation:string];
    textView.string=string;
}


+(NSString *)ACInterface:(NSString *)string
{
    NSString *shapePattern=@"@interface\\s+([a-zA-Z0-9_]+)\\s*:\\s*([a-zA-Z0-9_]+)\\s*@end";
    NSRegularExpression *shapeRegex = [NSRegularExpression regularExpressionWithPattern:shapePattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *shapeResults = [shapeRegex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    if (shapeResults.count!=0) {
        for (NSTextCheckingResult *result in shapeResults) {
            NSString *shapeStr=[string substringWithRange:result.range];
            NSLog(@"shapeStr-%@",shapeStr);
            NSString *classPattern=@"([a-zA-Z0-9_]+)(?=\\s+:)";
            NSRegularExpression *classRegex = [NSRegularExpression regularExpressionWithPattern:classPattern options:NSRegularExpressionCaseInsensitive error:nil];
            NSArray *classResults = [classRegex matchesInString:shapeStr options:0 range:NSMakeRange(0, shapeStr.length)];
            
            if (classResults.count!=0) {
                NSTextCheckingResult *classResult =classResults[0];
                
                NSString *classStr=[shapeStr substringWithRange:classResult.range];
                
                NSInteger length=MIN(2, classStr.length);
                NSString *lowCase=[[classStr substringWithRange:NSMakeRange(0, length)] lowercaseString];
                lowCase=[lowCase stringByAppendingString:[classStr substringWithRange:NSMakeRange(length, classStr.length-length)]];
                
                NSString *insertString=[NSString stringWithFormat:@"\n\n+ (instancetype)%@;\n",lowCase];

                NSMutableString *mutableString=string.mutableCopy;
                [mutableString insertString:insertString atIndex:result.range.location+[shapeStr rangeOfString:@"\n"].location];
                return mutableString.copy;
            }
            
        }
    }
    return string;
}


+(NSString *)ACImplementation:(NSString *)string
{
    NSString *shapePattern=@"@implementation\\s+([a-zA-Z0-9_]+)\\s*@end";
    NSRegularExpression *shapeRegex = [NSRegularExpression regularExpressionWithPattern:shapePattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *shapeResults = [shapeRegex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    if (shapeResults.count!=0) {
        NSMutableString *mutableString=string.mutableCopy;
        for (NSInteger i=shapeResults.count-1;i>=0;i--) {
            NSTextCheckingResult *result=shapeResults[i];
            NSString *shapeStr=[string substringWithRange:result.range];
            NSLog(@"shapeStr-%@",shapeStr);
            NSString *classPattern=@"(?<=@implementation\\s)([a-zA-Z0-9_]+)";
            NSRegularExpression *classRegex = [NSRegularExpression regularExpressionWithPattern:classPattern options:NSRegularExpressionCaseInsensitive error:nil];
            NSArray *classResults = [classRegex matchesInString:shapeStr options:0 range:NSMakeRange(0, shapeStr.length)];
            
            if (classResults.count!=0) {
                NSTextCheckingResult *classResult =classResults[0];
                
                NSString *classStr=[shapeStr substringWithRange:classResult.range];
                
                NSInteger length=MIN(2, classStr.length);
                NSString *lowCase=[[classStr substringWithRange:NSMakeRange(0, length)] lowercaseString];
                lowCase=[lowCase stringByAppendingString:[classStr substringWithRange:NSMakeRange(length, classStr.length-length)]];
                
                NSString *insertString=[NSString stringWithFormat:@"\n\n+ (instancetype)%@\n{\n    return [[self alloc] init];\n}\n\n- (instancetype)init\n{\n    self = [super init];\n    if (self) {\n      <#statements#>\n    }\n    return self;\n}\n",lowCase];
                
                
                [mutableString insertString:insertString atIndex:result.range.location+[shapeStr rangeOfString:@"\n"].location];   
            }
        }
        return mutableString.copy;
    }
    return string;
}


@end
