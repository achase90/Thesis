#include "__cf_mainSim.h"
#ifndef RTW_HEADER_mainSim_acc_h_
#define RTW_HEADER_mainSim_acc_h_
#ifndef mainSim_acc_COMMON_INCLUDES_
#define mainSim_acc_COMMON_INCLUDES_
#include <stdlib.h>
#include <stddef.h>
#include <string.h>
#define S_FUNCTION_NAME simulink_only_sfcn 
#define S_FUNCTION_LEVEL 2
#define RTW_GENERATED_S_FUNCTION
#include "rtwtypes.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "mwmathutil.h"
#include "rt_defines.h"
#include "rt_nonfinite.h"
#endif
#include "mainSim_acc_types.h"
typedef struct { real_T B_3_2_0 [ 2 ] ; real_T B_3_5_0 ; real_T B_3_5_1 ;
real_T B_3_30_0 ; real_T B_3_35_0 ; real_T B_3_42_0 ; real_T B_3_44_0 ;
real_T B_3_49_0 ; real_T B_3_60_0 ; real_T B_3_62_0 ; real_T B_3_66_0 ;
real_T B_3_69_0 ; real_T B_3_72_0 ; real_T B_3_73_0 ; real_T B_3_76_0 ;
real_T B_3_80_0 ; real_T B_3_81_0 ; real_T B_3_82_0 ; real_T B_3_83_0 ;
real_T B_3_103_0 [ 3 ] ; real_T B_3_105_0 ; real_T B_3_108_0 ; real_T
B_3_109_0 ; real_T B_3_112_0 ; real_T B_3_113_0 ; real_T B_3_113_1 ; real_T
B_3_113_2 ; real_T B_3_113_3 ; real_T B_3_118_0 ; real_T B_3_120_0 ; real_T
B_3_121_0 ; real_T B_3_124_0 [ 15 ] ; real_T B_3_125_0 ; real_T B_3_127_0 ;
real_T B_3_128_0 [ 3 ] ; real_T B_3_135_0 ; real_T B_3_136_0 ; real_T
B_3_137_0 [ 9 ] ; real_T B_3_188_0 [ 3 ] ; real_T B_3_189_0 [ 3 ] ; real_T
B_3_191_0 ; real_T B_3_194_0 ; real_T B_3_195_0 [ 3 ] ; real_T B_3_196_0 [ 18
] ; real_T B_3_197_0 ; real_T B_3_198_0 ; real_T B_3_199_0 ; real_T B_3_201_0
; real_T B_3_202_0 ; real_T B_3_204_0 ; real_T B_3_206_0 ; real_T B_3_207_0 [
3 ] ; real_T B_3_208_0 ; real_T B_3_209_0 ; real_T B_3_211_0 ; real_T
B_3_212_0 [ 3 ] ; real_T B_3_213_0 [ 3 ] ; real_T B_3_222_0 ; real_T
B_3_235_0 ; real_T B_3_238_0 ; real_T B_3_245_0 ; real_T B_3_249_0 ; real_T
B_3_250_0 ; real_T B_3_251_0 ; real_T B_3_252_0 ; real_T B_3_254_0 [ 9 ] ;
real_T B_3_256_0 [ 9 ] ; real_T B_3_266_0 [ 9 ] ; real_T B_3_267_0 [ 3 ] ;
real_T B_3_275_0 [ 3 ] ; real_T B_3_277_0 [ 3 ] ; real_T B_3_290_0 [ 9 ] ;
real_T B_3_333_0 ; real_T B_3_334_0 ; real_T B_3_335_0 ; real_T B_3_336_0 ;
real_T B_3_402_0 ; real_T B_3_403_0 ; real_T B_3_404_0 ; real_T B_3_405_0 ;
real_T B_3_407_0 [ 9 ] ; real_T B_3_409_0 [ 9 ] ; real_T B_3_419_0 [ 9 ] ;
real_T B_3_420_0 [ 3 ] ; real_T B_3_433_0 [ 9 ] ; real_T B_3_436_0 [ 3 ] ;
real_T B_2_0_1 ; real_T B_2_0_2 ; real_T B_1_0_0 ; real_T B_1_1_0 ; real_T
B_0_0_0 ; real_T B_0_1_0 ; real_T B_0_2_0 ; real_T B_0_3_0 [ 6 ] ; real_T
B_0_4_0 [ 3 ] ; real_T B_0_5_0 [ 3 ] ; real_T B_0_6_0 [ 3 ] ; real_T B_0_7_0
; real_T B_0_8_0 ; real_T B_0_9_0 ; real_T B_0_10_0 [ 5 ] ; real_T B_0_11_0 [
3 ] ; real_T B_0_12_0 [ 3 ] ; real_T B_0_13_0 [ 3 ] ; real_T B_0_14_0 [ 3 ] ;
real_T B_0_15_0 [ 3 ] ; real_T B_0_16_0 [ 3 ] ; real_T B_3_203_0 ; real_T
B_3_205_0 ; real_T B_3_210_0 ; real_T B_3_216_0 [ 2 ] ; real_T B_3_223_0 [ 3
] ; real_T B_3_234_0 ; real_T B_3_117_0 [ 4 ] ; real_T B_3_193_0 ; real_T
B_3_241_0 [ 3 ] ; real32_T B_1_2_0 ; real32_T B_1_3_0 ; real32_T B_1_4_0 ;
uint8_T B_3_106_0 ; uint8_T B_3_107_0 ; uint8_T B_3_114_0 ; uint8_T B_3_115_0
; uint8_T B_3_236_0 ; uint8_T B_3_237_0 ; uint8_T B_1_5_0 [ 408 ] ; char
pad_B_1_5_0 [ 6 ] ; } BlockIO_mainSim ; typedef struct { real_T m_bpLambda [
3 ] ; real_T m_bpLambda_e [ 3 ] ; real_T Product2_DWORK1 [ 9 ] ; real_T
Product2_DWORK3 [ 9 ] ; real_T Product2_DWORK4 [ 9 ] ; real_T Product2_DWORK5
[ 9 ] ; real_T Product2_DWORK4_k [ 9 ] ; struct { void * LoggedData ; }
Distances_PWORK ; void * m_bpDataSet [ 3 ] ; struct { void * LoggedData ; }
Thrustscope_PWORK ; struct { void * LoggedData ; } aeroforcesinbody1_PWORK ;
void * Synthesized_Atomic_Subsystem_For_Alg_Loop_1_AlgLoopData ; struct {
void * LoggedData ; } aero_forces1_PWORK ; struct { void * LoggedData ; }
alphabeta_PWORK ; struct { void * LoggedData ; } bodyaccels1_PWORK ; struct {
void * LoggedData ; } bodyforces1_PWORK ; struct { void * LoggedData ; }
bodyspeeds_PWORK ; struct { void * LoggedData ; } deflectioms_PWORK ; struct
{ void * LoggedData ; } eulerangles_PWORK ; struct { void * LoggedData ; }
force_coeff_graph_PWORK ; void * m_bpDataSet_i [ 3 ] ; struct { void *
LoggedData ; } totalmoments_PWORK ; struct { void * LoggedData ; }
weightvector_PWORK ; struct { void * LoggedData ; } weight1_PWORK ; struct {
void * LoggedData ; } aeroforcesinbody_PWORK ; int32_T Product2_DWORK2 [ 3 ]
; uint32_T m_bpIndex [ 3 ] ; uint32_T m_bpIndex_h [ 3 ] ; struct { int_T
IcNeedsLoading ; } q0q1q2q3_IWORK ; struct { int_T IcNeedsLoading ; }
q0q1q2q3_IWORK_j ; int8_T sqrt_DWORK1 ; int8_T sqrt_DWORK1_n ; int8_T
sqrt_DWORK1_f ; int8_T sqrt_DWORK1_p ; int8_T sqrt_DWORK1_k ; int8_T
sqrt_DWORK1_b ; int8_T sqrt_DWORK1_e ; char pad_sqrt_DWORK1_e [ 5 ] ; }
D_Work_mainSim ; typedef struct { real_T xeyeze_CSTATE [ 3 ] ; real_T
q0q1q2q3_CSTATE [ 4 ] ; real_T v_CSTATE ; real_T alpha_CSTATE ; real_T
pqr_CSTATE [ 3 ] ; real_T beta_CSTATE ; real_T pqr_CSTATE_d [ 3 ] ; real_T
ubvbwb_CSTATE [ 3 ] ; real_T q0q1q2q3_CSTATE_j [ 4 ] ; real_T xeyeze_CSTATE_d
[ 3 ] ; } ContinuousStates_mainSim ; typedef struct { real_T xeyeze_CSTATE [
3 ] ; real_T q0q1q2q3_CSTATE [ 4 ] ; real_T v_CSTATE ; real_T alpha_CSTATE ;
real_T pqr_CSTATE [ 3 ] ; real_T beta_CSTATE ; real_T pqr_CSTATE_d [ 3 ] ;
real_T ubvbwb_CSTATE [ 3 ] ; real_T q0q1q2q3_CSTATE_j [ 4 ] ; real_T
xeyeze_CSTATE_d [ 3 ] ; } StateDerivatives_mainSim ; typedef struct {
boolean_T xeyeze_CSTATE [ 3 ] ; boolean_T q0q1q2q3_CSTATE [ 4 ] ; boolean_T
v_CSTATE ; boolean_T alpha_CSTATE ; boolean_T pqr_CSTATE [ 3 ] ; boolean_T
beta_CSTATE ; boolean_T pqr_CSTATE_d [ 3 ] ; boolean_T ubvbwb_CSTATE [ 3 ] ;
boolean_T q0q1q2q3_CSTATE_j [ 4 ] ; boolean_T xeyeze_CSTATE_d [ 3 ] ; }
StateDisabled_mainSim ; struct Parameters_mainSim_ { real_T P_0 ; real_T P_1
; real_T P_2 ; real_T P_3 ; real_T P_4 [ 2 ] ; real_T P_5 [ 4 ] ; real_T P_6
[ 2 ] ; real_T P_7 [ 2 ] ; real_T P_8 [ 2 ] ; real_T P_9 [ 3 ] ; real_T P_10
[ 2 ] ; real_T P_11 [ 3 ] ; real_T P_12 [ 2 ] ; real_T P_13 [ 3 ] ; real_T
P_14 [ 2 ] ; real_T P_15 [ 3 ] ; real_T P_16 [ 2 ] ; real_T P_17 [ 3 ] ;
real_T P_18 [ 2 ] ; real_T P_19 ; real_T P_20 [ 2 ] ; real_T P_21 ; real_T
P_22 [ 2 ] ; real_T P_23 ; real_T P_24 [ 2 ] ; real_T P_25 ; real_T P_26 [ 2
] ; real_T P_27 ; real_T P_28 [ 3 ] ; real_T P_29 [ 2 ] ; real_T P_30 ;
real_T P_31 ; real_T P_32 ; real_T P_33 ; real_T P_34 ; real_T P_35 ; real_T
P_36 ; real_T P_37 ; real_T P_38 ; real_T P_39 ; real_T P_40 ; real_T P_41 ;
real_T P_42 ; real_T P_43 ; real_T P_44 ; real_T P_45 ; real_T P_46 ; real_T
P_47 ; real_T P_48 ; real_T P_49 ; real_T P_50 ; real_T P_51 ; real_T P_52 ;
real_T P_53 ; real_T P_54 ; real_T P_55 ; real_T P_56 ; real_T P_57 [ 3 ] ;
real_T P_58 ; real_T P_59 ; real_T P_60 ; real_T P_61 ; real_T P_62 ; real_T
P_63 ; real_T P_64 [ 2 ] ; real_T P_65 ; real_T P_66 [ 2 ] ; real_T P_67 ;
real_T P_68 [ 2 ] ; real_T P_69 ; real_T P_70 [ 4 ] ; real_T P_71 ; real_T
P_72 [ 8000 ] ; real_T P_73 [ 20 ] ; real_T P_74 [ 20 ] ; real_T P_75 [ 20 ]
; real_T P_76 ; real_T P_77 [ 15 ] ; real_T P_78 ; real_T P_79 ; real_T P_80
; real_T P_81 [ 3 ] ; real_T P_82 ; real_T P_83 ; real_T P_84 ; real_T P_85 ;
real_T P_86 ; real_T P_87 ; real_T P_88 ; real_T P_89 [ 3 ] ; real_T P_90 ;
real_T P_91 ; real_T P_92 [ 3 ] ; real_T P_93 [ 18 ] ; real_T P_94 ; real_T
P_95 [ 3 ] ; real_T P_96 ; real_T P_97 ; real_T P_98 ; real_T P_99 ; real_T
P_100 ; real_T P_101 ; real_T P_102 [ 3 ] ; real_T P_103 ; real_T P_104 ;
real_T P_105 ; real_T P_106 ; real_T P_107 [ 3 ] ; real_T P_108 [ 3 ] ;
real_T P_109 ; real_T P_110 ; real_T P_111 [ 3 ] ; real_T P_112 ; real_T
P_113 ; real_T P_114 [ 8000 ] ; real_T P_115 [ 20 ] ; real_T P_116 [ 20 ] ;
real_T P_117 [ 20 ] ; real_T P_118 ; real_T P_119 ; real_T P_120 ; real_T
P_121 ; real_T P_122 ; real_T P_123 [ 18 ] ; real_T P_124 ; real_T P_125 [ 2
] ; real_T P_126 ; real_T P_127 [ 3 ] ; real_T P_128 ; real_T P_129 ; real_T
P_130 ; real_T P_131 [ 18 ] ; real_T P_132 ; real_T P_133 [ 3 ] ; uint32_T
P_134 [ 3 ] ; uint32_T P_135 [ 3 ] ; uint32_T P_136 [ 3 ] ; uint32_T P_137 [
3 ] ; uint8_T P_138 ; uint8_T P_139 ; uint8_T P_140 ; uint8_T P_141 ; uint8_T
P_142 ; uint8_T P_143 ; char pad_P_143 [ 2 ] ; } ; extern Parameters_mainSim
mainSim_rtDefaultParameters ;
#endif
