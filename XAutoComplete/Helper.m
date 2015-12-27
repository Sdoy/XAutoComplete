//
//  Helper.m
//  XAutoComplete
//
//  Created by Kael on 15/12/27.
//  Copyright © 2015年 Kael. All rights reserved.
//

#import "Helper.h"

@implementation Helper

static Helper *_instance;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)shardHelper
{
    if (_instance == nil) {
        _instance = [[Helper alloc] init];
    }
    return _instance; 
}


- (IDEEditor *)currentEditor
{
    NSWindowController *mainWindowController = [[NSApp mainWindow] windowController];
    if ([mainWindowController isKindOfClass:NSClassFromString(@"IDEWorkspaceWindowController")])
    {
        IDEWorkspaceWindowController *workspaceController = (IDEWorkspaceWindowController *)mainWindowController;
        IDEEditorArea *editorArea = [workspaceController editorArea];
        IDEEditorContext *editorContext = [editorArea lastActiveEditorContext];
        return [editorContext editor];
    }
    return nil;
}

- (DVTSourceTextView *)currentSourceTextView
{
    IDEEditor *currentEditor = [self currentEditor];
    
    if ([currentEditor isKindOfClass:NSClassFromString(@"IDESourceCodeEditor")])
        return (DVTSourceTextView *)[(id)currentEditor textView];
    
    if ([currentEditor isKindOfClass:NSClassFromString(@"IDESourceCodeComparisonEditor")])
        return [(id)currentEditor performSelector:NSSelectorFromString(@"keyTextView")];
    
    return nil;
}



@end
