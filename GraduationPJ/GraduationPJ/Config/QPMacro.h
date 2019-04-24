//
//  QPMacro.h
//  GraduationPJ
//
//  Created by Mac on 2019/4/24.
//  Copyright © 2019 WTU. All rights reserved.
//

#ifndef QPMacro_h
#define QPMacro_h

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width

#ifndef weakify
#if __has_feature(objc_arc)
#define weakify(object) __weak __typeof__(object) weak##object = object;
#else
#define weakify(object) __block __typeof__(object) block##object = object;
#endif
#endif
#ifndef strongify
#if __has_feature(objc_arc)
#define strongify(object) __typeof__(object) object = weak##object;
#else
#define strongify(object) __typeof__(object) object = block##object;
#endif
#endif

#endif /* QPMacro_h */
