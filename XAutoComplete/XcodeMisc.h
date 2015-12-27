//
//  XcodeMisc.h
//
//
//  Created by Kael on 15/12/27.
//  Copyright © 2015年 Kael. All rights reserved.
//
//

#import <Cocoa/Cocoa.h>

@interface DVTViewController : NSViewController
+ (id)defaultViewNibBundle;
+ (id)defaultViewNibName;
+ (void)initialize;
//@property(retain, nonatomic) DVTExtension *representedExtension; // @synthesize representedExtension=_representedExtension;
@property BOOL isViewLoaded; // @synthesize isViewLoaded=_isViewLoaded;
- (void)primitiveInvalidate;
- (void)invalidate;
- (BOOL)commitEditingForAction:(int)arg1 errors:(id)arg2;
- (void)_willUninstallContentView:(id)arg1;
- (void)_didInstallContentView:(id)arg1;
- (void)viewWillUninstall;
- (void)viewDidInstall;
- (void)loadView;
//@property(retain) DVTControllerContentView *view;
- (void)separateKeyViewLoops;
- (BOOL)delegateFirstResponder;
- (id)supplementalMainViewController;
@property(readonly, copy) NSString *description;
- (BOOL)becomeFirstResponder;
- (id)initWithCoder:(id)arg1;
- (id)initWithNibName:(id)arg1 bundle:(id)arg2;
- (id)initUsingDefaultNib;
- (void)dvtViewController_commonInit;
@property(readonly) BOOL canBecomeMainViewController;

// Remaining properties
//@property(retain) DVTStackBacktrace *creationBacktrace;
@property(readonly, copy) NSString *debugDescription;
@property(readonly) unsigned long long hash;
//@property(readonly) DVTStackBacktrace *invalidationBacktrace;
@property(readonly) Class superclass;
@property(readonly, nonatomic, getter=isValid) BOOL valid;

@end

@interface IDEViewController : DVTViewController
@end
@interface IDEEditor : IDEViewController
@end

@interface IDEEditorContext : IDEViewController
@property(retain, nonatomic) IDEEditor *editor;
@end

@interface IDEEditorArea : IDEViewController
@property(retain, nonatomic) IDEEditorContext *lastActiveEditorContext; // @synthesize lastActiveEditorContext=_lastActiveEditorContext;
@end

@interface IDEWorkspaceWindowController : NSWindowController
@property(readonly) IDEEditorArea *editorArea;
@end

@interface DVTCompletingTextView : NSTextView
@end

@interface DVTSourceTextView : DVTCompletingTextView
@end
