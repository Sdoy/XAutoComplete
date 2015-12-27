//
//  XAutoComplete.m
//  XAutoComplete
//
//  Created by Kael on 15/12/27.
//  Copyright © 2015年 Kael. All rights reserved.
//

#import "XAutoComplete.h"
#import "ACInitialization.h"

@interface XAutoComplete()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation XAutoComplete

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (menuItem) {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"XAutoComplete" action:nil keyEquivalent:@""];
        [[menuItem submenu] addItem:actionMenuItem];
        
        NSMenu *menu=[[NSMenu alloc]init];
        NSMenuItem *initializationMenuItem=[[NSMenuItem alloc]initWithTitle:@"Initialization" action:@selector(doMenuAction) keyEquivalent:@""];
        [initializationMenuItem setTarget:self];
        [menu addItem:initializationMenuItem];
        [actionMenuItem setSubmenu:menu];
    }
}


- (void)doMenuAction
{
    [ACInitialization doACInitialization];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
