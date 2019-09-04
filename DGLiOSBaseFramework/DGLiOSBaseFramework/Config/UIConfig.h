//
//  UIConfig.h
//  DGLiOSBaseFramework
//
//  Created by 陈剑 on 2019/9/4.
//  Copyright © 2019 陈剑. All rights reserved.
//

#ifndef UIConfig_h
#define UIConfig_h


/**************** 改变坐标 ****************/
#define ChangeViewX(view,x) [view setFrame:CGRectMake(x, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
#define ChangeViewY(view,y) [view setFrame:CGRectMake(view.frame.origin.x, y, view.frame.size.width, view.frame.size.height)];
#define ChangeViewW(view,w) [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, w, view.frame.size.height)];
#define ChangeViewH(view,h) [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, h)];
#define ChangeViewYH(view,y,h) [view setFrame:CGRectMake(view.frame.origin.x, y, view.frame.size.width, h)];
#define ChangeViewXW(view,x,w) [view setFrame:CGRectMake(x, view.frame.origin.y, w, view.frame.size.height)];
#define ChangeViewXY(view,x,y) [view setFrame:CGRectMake(x, y, view.frame.size.width, view.frame.size.height)];
#define ChangeViewXYWH(view,x,y,w,h) [view setFrame:CGRectMake(x, y, w, h)];


/**************** 屏幕宽高 ****************/
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上

#define SCREEN_BOUNDS   [UIScreen mainScreen].bounds
#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define SCREEN_BOUNDS   [UIScreen mainScreen].bounds
#define SCREEN_SIZE     [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#endif

#pragma mark - 判断是否是刘海屏
/**************** iPhoneX ****************/
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828,1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXSMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2688), [[UIScreen mainScreen] currentMode].size) : NO)
///判断是否是刘海屏
#define isBangsScreen (iPhoneX || iPhoneXR  || iPhoneXS  || iPhoneXSMax)

/**************** 导航栏相关 ****************/
#define StatusWithNavigationHeight (TopSeaScreen ? 88 : 64)
#define TabbarHeight (TopSeaScreen ? 83 : 49)
#define StatusBarHeight  (TopSeaScreen ? 44 : 20)


#endif /* UIConfig_h */
