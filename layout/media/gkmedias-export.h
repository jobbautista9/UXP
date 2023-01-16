#ifndef UXP_GKMEDIAS_SYMEXPORT_H_
#define UXP_GKMEDIAS_SYMEXPORT_H_

#if !defined(OS_WIN) && defined(GKMEDIAS_SHARED_LIBRARY)
#define UXP_GKMEDIAS_EXPORT(attr) __attribute__ ((visibility ("default")))
#else
#define UXP_GKMEDIAS_EXPORT(attr) attr
#endif

#endif /* UXP_GKMEDIAS_SYMEXPORT_H_ */
