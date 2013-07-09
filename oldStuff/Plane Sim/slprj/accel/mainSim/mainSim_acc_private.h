#include "__cf_mainSim.h"
#ifndef RTW_HEADER_mainSim_acc_private_h_
#define RTW_HEADER_mainSim_acc_private_h_
#include "rtwtypes.h"
#ifndef RTW_COMMON_DEFINES_
#define RTW_COMMON_DEFINES_
#define rt_VALIDATE_MEMORY(S, ptr)   if(!(ptr)) {\
  ssSetErrorStatus(S, RT_MEMORY_ALLOCATION_ERROR);\
  }
#if !defined(_WIN32)
#define rt_FREE(ptr)   if((ptr) != (NULL)) {\
  free((ptr));\
  (ptr) = (NULL);\
  }
#else
#define rt_FREE(ptr)   if((ptr) != (NULL)) {\
  free((void *)(ptr));\
  (ptr) = (NULL);\
  }
#endif
#endif
#ifndef __RTWTYPES_H__
#error This file requires rtwtypes.h to be included
#else
#ifdef TMWTYPES_PREVIOUSLY_INCLUDED
#error This file requires rtwtypes.h to be included before tmwtypes.h
#else
#ifndef RTWTYPES_ID_C08S16I32L32N32F1
#error This code was generated with a different "rtwtypes.h" than the file included
#endif
#endif
#endif
extern void rt_mrdivide_U1d1x3_U2d3x3_Yd1x3_snf ( const real_T u0 [ 3 ] ,
const real_T u1 [ 9 ] , real_T y [ 3 ] ) ; extern real_T look3_sbinlxpw (
real_T u0 , real_T u1 , real_T u2 , void * bpDataSet [ ] , const real_T table
[ ] , const uint32_T maxIndex [ ] , const uint32_T stride [ ] ) ; extern
uint32_T plook_binx ( real_T u , const real_T bp [ ] , uint32_T maxIndex ,
real_T * fraction ) ; extern real_T intrp3d_l_pw ( const uint32_T bpIndex [ ]
, const real_T frac [ ] , const real_T table [ ] , const uint32_T stride [ ]
) ; extern uint32_T binsearch_u32d ( real_T u , const real_T bp [ ] ,
uint32_T startIndex , uint32_T maxIndex ) ; void
mainSim_Synthesized_Atomic_Subsystem_For_Alg_Loop_1 ( SimStruct * const S ) ;
#endif