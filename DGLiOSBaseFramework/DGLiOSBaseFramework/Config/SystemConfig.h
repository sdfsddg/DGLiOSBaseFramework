//
//  SystemConfig.h
//  DGLiOSBaseFramework
//
//  Created by 陈剑 on 2019/9/4.
//  Copyright © 2019 陈剑. All rights reserved.
//

#ifndef SystemConfig_h
#define SystemConfig_h


/**************** 打印日志 ****************/
#ifdef DEBUG
#define DRLog(format, ...) printf("\n✈ -----------------------DEBUG BEGIN --------------------- ✈\nclass: <%p %s:(%d) > method: %s \n%s\n✈ -----------------------DEBUG END --------------------- ✈\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define DRLog(...)
#endif

#endif /* SystemConfig_h */
