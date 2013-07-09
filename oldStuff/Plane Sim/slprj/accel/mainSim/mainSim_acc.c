#include "__cf_mainSim.h"
#include <math.h>
#include "mainSim_acc.h"
#include "mainSim_acc_private.h"
#include <stdio.h>
#include "simstruc.h"
#include "fixedpoint.h"
#define CodeFormat S-Function
#define AccDefine1 Accelerator_S-Function
real_T look3_sbinlxpw ( real_T u0 , real_T u1 , real_T u2 , void * bpDataSet
[ ] , const real_T table [ ] , const uint32_T maxIndex [ ] , const uint32_T
stride [ ] ) { uint32_T bpIdx ; real_T frac ; uint32_T bpIndices [ 3 ] ;
real_T fractions [ 3 ] ; bpIdx = plook_binx ( u0 , ( real_T * ) bpDataSet [
0U ] , maxIndex [ 0U ] , & frac ) ; fractions [ 0U ] = frac ; bpIndices [ 0U
] = bpIdx ; bpIdx = plook_binx ( u1 , ( real_T * ) bpDataSet [ 1U ] ,
maxIndex [ 1U ] , & frac ) ; fractions [ 1U ] = frac ; bpIndices [ 1U ] =
bpIdx ; bpIdx = plook_binx ( u2 , ( real_T * ) bpDataSet [ 2U ] , maxIndex [
2U ] , & frac ) ; fractions [ 2U ] = frac ; bpIndices [ 2U ] = bpIdx ; return
intrp3d_l_pw ( bpIndices , fractions , table , stride ) ; } uint32_T
plook_binx ( real_T u , const real_T bp [ ] , uint32_T maxIndex , real_T *
fraction ) { uint32_T bpIndex ; if ( u <= bp [ 0U ] ) { bpIndex = 0U ; *
fraction = ( u - bp [ 0U ] ) / ( bp [ 1U ] - bp [ 0U ] ) ; } else if ( u < bp
[ maxIndex ] ) { bpIndex = binsearch_u32d ( u , bp , ( uint32_T ) ( ( int32_T
) maxIndex >> 1U ) , maxIndex ) ; * fraction = ( u - bp [ bpIndex ] ) / ( bp
[ bpIndex + 1U ] - bp [ bpIndex ] ) ; } else { bpIndex = maxIndex - 1U ; *
fraction = ( u - bp [ maxIndex - 1U ] ) / ( bp [ maxIndex ] - bp [ maxIndex -
1U ] ) ; } return bpIndex ; } real_T intrp3d_l_pw ( const uint32_T bpIndex [
] , const real_T frac [ ] , const real_T table [ ] , const uint32_T stride [
] ) { real_T yL_2d ; uint32_T offset_2d ; real_T yL_1d ; uint32_T offset_0d ;
offset_2d = ( bpIndex [ 2U ] * stride [ 2U ] + bpIndex [ 1U ] * stride [ 1U ]
) + bpIndex [ 0U ] ; yL_1d = ( table [ offset_2d + 1U ] - table [ offset_2d ]
) * frac [ 0U ] + table [ offset_2d ] ; offset_0d = offset_2d + stride [ 1U ]
; yL_2d = ( ( ( table [ offset_0d + 1U ] - table [ offset_0d ] ) * frac [ 0U
] + table [ offset_0d ] ) - yL_1d ) * frac [ 1U ] + yL_1d ; offset_2d +=
stride [ 2U ] ; yL_1d = ( table [ offset_2d + 1U ] - table [ offset_2d ] ) *
frac [ 0U ] + table [ offset_2d ] ; offset_0d = offset_2d + stride [ 1U ] ;
return ( ( ( ( ( table [ offset_0d + 1U ] - table [ offset_0d ] ) * frac [ 0U
] + table [ offset_0d ] ) - yL_1d ) * frac [ 1U ] + yL_1d ) - yL_2d ) * frac
[ 2U ] + yL_2d ; } uint32_T binsearch_u32d ( real_T u , const real_T bp [ ] ,
uint32_T startIndex , uint32_T maxIndex ) { uint32_T iRght ; uint32_T iLeft ;
uint32_T bpIdx ; bpIdx = startIndex ; iLeft = 0U ; iRght = maxIndex ; while (
iRght - iLeft > 1U ) { if ( u < bp [ bpIdx ] ) { iRght = bpIdx ; } else {
iLeft = bpIdx ; } bpIdx = ( uint32_T ) ( ( int32_T ) ( iRght + iLeft ) >> 1U
) ; } return iLeft ; } void
mainSim_Synthesized_Atomic_Subsystem_For_Alg_Loop_1 ( SimStruct * const S ) {
ssCallAccelRunBlock ( S , 3 , 214 , SS_CALL_MDL_OUTPUTS ) ; } void
rt_mrdivide_U1d1x3_U2d3x3_Yd1x3_snf ( const real_T u0 [ 3 ] , const real_T u1
[ 9 ] , real_T y [ 3 ] ) { real_T A [ 9 ] ; real_T A_0 [ 9 ] ; int32_T TWO ;
int32_T THREE ; int32_T r ; int32_T r_0 ; real_T maxval ; real_T a ; for (
THREE = 0 ; THREE < 3 ; THREE ++ ) { A [ 3 * THREE ] = u1 [ THREE ] ; A [ 1 +
3 * THREE ] = u1 [ THREE + 3 ] ; A [ 2 + 3 * THREE ] = u1 [ THREE + 6 ] ; }
memcpy ( ( void * ) & A_0 [ 0 ] , ( void * ) & A [ 0 ] , 9U * sizeof ( real_T
) ) ; THREE = 3 ; r = 1 ; r_0 = 2 ; maxval = muDoubleScalarAbs ( A [ 0 ] ) ;
a = muDoubleScalarAbs ( A [ 1 ] ) ; if ( a > maxval ) { maxval = a ; r = 2 ;
r_0 = 1 ; } if ( muDoubleScalarAbs ( A [ 2 ] ) > maxval ) { r = 3 ; r_0 = 2 ;
THREE = 1 ; } A_0 [ r_0 - 1 ] = A [ r_0 - 1 ] / A [ r - 1 ] ; A_0 [ THREE - 1
] /= A_0 [ r - 1 ] ; A_0 [ r_0 + 2 ] -= A_0 [ r_0 - 1 ] * A_0 [ r + 2 ] ; A_0
[ THREE + 2 ] -= A_0 [ THREE - 1 ] * A_0 [ r + 2 ] ; A_0 [ r_0 + 5 ] -= A_0 [
r_0 - 1 ] * A_0 [ r + 5 ] ; A_0 [ THREE + 5 ] -= A_0 [ THREE - 1 ] * A_0 [ r
+ 5 ] ; if ( muDoubleScalarAbs ( A_0 [ THREE + 2 ] ) > muDoubleScalarAbs (
A_0 [ r_0 + 2 ] ) ) { TWO = r_0 ; r_0 = THREE ; THREE = TWO ; } A_0 [ THREE +
2 ] /= A_0 [ r_0 + 2 ] ; A_0 [ THREE + 5 ] -= A_0 [ THREE + 2 ] * A_0 [ r_0 +
5 ] ; maxval = u0 [ r_0 - 1 ] - u0 [ r - 1 ] * A_0 [ r_0 - 1 ] ; a = ( ( u0 [
THREE - 1 ] - u0 [ r - 1 ] * A_0 [ THREE - 1 ] ) - A_0 [ THREE + 2 ] * maxval
) / A_0 [ THREE + 5 ] ; maxval -= A_0 [ r_0 + 5 ] * a ; maxval /= A_0 [ r_0 +
2 ] ; y [ 0 ] = ( ( u0 [ r - 1 ] - A_0 [ r + 5 ] * a ) - A_0 [ r + 2 ] *
maxval ) / A_0 [ r - 1 ] ; y [ 1 ] = maxval ; y [ 2 ] = a ; } static void
mdlOutputs ( SimStruct * S , int_T tid ) { real_T B_3_437_0 [ 3 ] ; real_T
B_3_200_0 [ 3 ] ; real_T B_3_337_0 [ 4 ] ; real_T B_3_226_0 [ 3 ] ; real_T
B_3_126_0 ; real_T B_3_133_0 ; real_T B_3_9_0 ; real_T B_3_6_0 ; real_T
B_3_7_0 ; real_T B_3_25_0 ; real_T B_3_23_0 ; real_T B_3_330_0 ; real_T
B_3_329_0 ; real_T B_3_327_0 ; real_T B_3_332_0 [ 3 ] ; real_T B_3_187_0 [ 9
] ; real_T B_3_325_0 [ 9 ] ; real_T B_3_326_0 [ 9 ] ; real_T B_3_406_0 [ 18 ]
; int32_T i ; real_T tmp [ 3 ] ; real_T tmp_0 [ 3 ] ; int32_T i_0 ; real_T
B_3_292_0_idx ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_241_0 [
0 ] = ( ( ContinuousStates_mainSim * ) ssGetContStates ( S ) ) ->
xeyeze_CSTATE [ 0 ] ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_241_0 [ 1 ] = ( ( ContinuousStates_mainSim * ) ssGetContStates ( S ) ) ->
xeyeze_CSTATE [ 1 ] ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_241_0 [ 2 ] = ( ( ContinuousStates_mainSim * ) ssGetContStates ( S ) ) ->
xeyeze_CSTATE [ 2 ] ; ssCallAccelRunBlock ( S , 3 , 1 , SS_CALL_MDL_OUTPUTS )
; if ( ssIsSampleHit ( S , 1 , 0 ) ) { ( ( BlockIO_mainSim * ) _ssGetBlockIO
( S ) ) -> B_3_2_0 [ 0 ] = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S )
) -> P_29 [ 0 ] ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_2_0 [
1 ] = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_29 [ 1 ] ;
muDoubleScalarSinCos ( ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) )
-> P_31 * ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_30 , &
B_3_330_0 , & B_3_327_0 ) ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_5_1 = B_3_327_0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_5_0 = B_3_330_0 ; } B_3_6_0 = ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S )
) -> B_3_241_0 [ 0 ] * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_5_1 ; B_3_7_0 = ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_241_0 [ 1 ] * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_5_0 ;
if ( ssIsSampleHit ( S , 1 , 0 ) ) { B_3_9_0 = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_32 ; B_3_25_0 = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_33 ; B_3_23_0 = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_34 ; B_3_329_0 = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_37 - ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_36 ; B_3_330_0 = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_35 - B_3_329_0 * B_3_329_0 ; if (
ssIsMajorTimeStep ( S ) ) { if ( ( ( D_Work_mainSim * ) ssGetRootDWork ( S )
) -> sqrt_DWORK1 != 0 ) { ssSetSolverNeedsReset ( S ) ; ( ( D_Work_mainSim *
) ssGetRootDWork ( S ) ) -> sqrt_DWORK1 = 0 ; } B_3_330_0 =
muDoubleScalarSqrt ( B_3_330_0 ) ; } else { B_3_330_0 = B_3_330_0 < 0.0 ? -
muDoubleScalarSqrt ( muDoubleScalarAbs ( B_3_330_0 ) ) : muDoubleScalarSqrt (
B_3_330_0 ) ; ( ( D_Work_mainSim * ) ssGetRootDWork ( S ) ) -> sqrt_DWORK1 =
1 ; } B_3_327_0 = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) ->
P_39 * ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_38 ;
B_3_329_0 = muDoubleScalarSin ( B_3_327_0 ) ; B_3_23_0 -= B_3_330_0 *
B_3_330_0 * B_3_329_0 * B_3_329_0 ; if ( ssIsMajorTimeStep ( S ) ) { if ( ( (
D_Work_mainSim * ) ssGetRootDWork ( S ) ) -> sqrt_DWORK1_n != 0 ) {
ssSetSolverNeedsReset ( S ) ; ( ( D_Work_mainSim * ) ssGetRootDWork ( S ) )
-> sqrt_DWORK1_n = 0 ; } B_3_329_0 = muDoubleScalarSqrt ( B_3_23_0 ) ; } else
{ B_3_329_0 = B_3_23_0 < 0.0 ? - muDoubleScalarSqrt ( muDoubleScalarAbs (
B_3_23_0 ) ) : muDoubleScalarSqrt ( B_3_23_0 ) ; ( ( D_Work_mainSim * )
ssGetRootDWork ( S ) ) -> sqrt_DWORK1_n = 1 ; } B_3_25_0 /= B_3_329_0 ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_30_0 = muDoubleScalarAtan2 (
B_3_9_0 , ( ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_40 -
B_3_330_0 * B_3_330_0 ) * B_3_25_0 / B_3_23_0 ) ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_35_0 = muDoubleScalarAtan2 ( ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_41 , B_3_25_0 *
muDoubleScalarCos ( B_3_327_0 ) ) ; } B_3_330_0 = ( ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_241_0 [ 0 ] * ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_5_0 + ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S
) ) -> B_3_241_0 [ 1 ] * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_5_1 ) * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_35_0 * ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_42 + ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_2_0 [ 1 ] ; if (
ssIsSampleHit ( S , 1 , 0 ) ) { ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) )
-> B_3_42_0 = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_43 ;
} B_3_6_0 = muDoubleScalarRem ( ( B_3_6_0 - B_3_7_0 ) * ( ( BlockIO_mainSim *
) _ssGetBlockIO ( S ) ) -> B_3_30_0 * ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_42 + ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S
) ) -> B_3_2_0 [ 0 ] , ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_42_0 ) ; if ( ssIsSampleHit ( S , 1 , 0 ) ) { ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_44_0 = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_44 ; } B_3_327_0 = B_3_6_0 / ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_44_0 ; B_3_6_0 -= (
B_3_327_0 < 0.0 ? muDoubleScalarCeil ( B_3_327_0 ) : muDoubleScalarFloor (
B_3_327_0 ) ) * ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_45
; if ( ssIsSampleHit ( S , 1 , 0 ) ) { ( ( BlockIO_mainSim * ) _ssGetBlockIO
( S ) ) -> B_3_49_0 = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) ->
P_46 ; } B_3_7_0 = B_3_6_0 / ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_49_0 ; B_3_133_0 = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) )
-> P_47 * B_3_7_0 ; B_3_133_0 *= B_3_133_0 ; if ( ssIsMajorTimeStep ( S ) ) {
if ( ( ( D_Work_mainSim * ) ssGetRootDWork ( S ) ) -> sqrt_DWORK1_f != 0 ) {
ssSetSolverNeedsReset ( S ) ; ( ( D_Work_mainSim * ) ssGetRootDWork ( S ) )
-> sqrt_DWORK1_f = 0 ; } B_3_133_0 = muDoubleScalarSqrt ( B_3_133_0 ) ; }
else { B_3_133_0 = B_3_133_0 < 0.0 ? - muDoubleScalarSqrt ( muDoubleScalarAbs
( B_3_133_0 ) ) : muDoubleScalarSqrt ( B_3_133_0 ) ; ( ( D_Work_mainSim * )
ssGetRootDWork ( S ) ) -> sqrt_DWORK1_f = 1 ; } B_3_133_0 = B_3_133_0 < 0.0 ?
muDoubleScalarCeil ( B_3_133_0 ) : muDoubleScalarFloor ( B_3_133_0 ) ;
B_3_133_0 *= ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_48 ;
if ( ssIsSampleHit ( S , 1 , 0 ) ) { ( ( BlockIO_mainSim * ) _ssGetBlockIO (
S ) ) -> B_3_60_0 = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) ->
P_50 ; } B_3_23_0 = muDoubleScalarRem ( ( real_T ) ( B_3_133_0 != 0.0 ) * ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_49 + B_3_330_0 , ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_60_0 ) ; if ( ssIsSampleHit
( S , 1 , 0 ) ) { ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_62_0 =
( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_51 ; } B_3_327_0 =
B_3_23_0 / ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_62_0 ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_66_0 = B_3_23_0 - (
B_3_327_0 < 0.0 ? muDoubleScalarCeil ( B_3_327_0 ) : muDoubleScalarFloor (
B_3_327_0 ) ) * ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_52
; B_3_7_0 = B_3_7_0 < 0.0 ? muDoubleScalarCeil ( B_3_7_0 ) :
muDoubleScalarFloor ( B_3_7_0 ) ; if ( ssIsSampleHit ( S , 1 , 0 ) ) { ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_69_0 = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_54 ; } ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_72_0 = ( B_3_6_0 - ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_53 * B_3_7_0 ) -
B_3_133_0 * muDoubleScalarRem ( B_3_6_0 , ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_69_0 ) ; if ( ssIsSampleHit ( S , 1 , 0 ) ) { (
( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_73_0 = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_55 ; } ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_76_0 = ( - ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_241_0 [ 2 ] - ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_73_0 ) * ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_56 ; if ( ssIsSampleHit
( S , 1 , 0 ) ) { B_3_332_0 [ 0 ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_58 * ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_57 [ 2 ] ; B_3_332_0 [ 1 ] = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_58 * ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_57 [ 1 ] ; B_3_332_0 [
2 ] = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_58 * ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_57 [ 0 ] ;
muDoubleScalarSinCos ( B_3_332_0 [ 0 ] , & B_3_6_0 , & B_3_7_0 ) ; B_3_327_0
= B_3_7_0 ; B_3_332_0 [ 0 ] = B_3_6_0 ; muDoubleScalarSinCos ( B_3_332_0 [ 1
] , & B_3_6_0 , & B_3_7_0 ) ; B_3_330_0 = B_3_7_0 ; B_3_332_0 [ 1 ] = B_3_6_0
; muDoubleScalarSinCos ( B_3_332_0 [ 2 ] , & B_3_6_0 , & B_3_7_0 ) ;
B_3_332_0 [ 2 ] = B_3_6_0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_80_0 = B_3_327_0 * B_3_330_0 * B_3_7_0 + B_3_332_0 [ 0 ] * B_3_332_0 [ 1
] * B_3_332_0 [ 2 ] ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_81_0 = B_3_327_0 * B_3_330_0 * B_3_332_0 [ 2 ] - B_3_332_0 [ 0 ] *
B_3_332_0 [ 1 ] * B_3_7_0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_82_0 = B_3_327_0 * B_3_332_0 [ 1 ] * B_3_7_0 + B_3_332_0 [ 0 ] *
B_3_330_0 * B_3_332_0 [ 2 ] ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) )
-> B_3_83_0 = B_3_332_0 [ 0 ] * B_3_330_0 * B_3_7_0 - B_3_327_0 * B_3_332_0 [
1 ] * B_3_332_0 [ 2 ] ; } if ( ( ( D_Work_mainSim * ) ssGetRootDWork ( S ) )
-> q0q1q2q3_IWORK . IcNeedsLoading ) { ( ( ContinuousStates_mainSim * )
ssGetContStates ( S ) ) -> q0q1q2q3_CSTATE [ 0 ] = ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_80_0 ; ( ( ContinuousStates_mainSim * )
ssGetContStates ( S ) ) -> q0q1q2q3_CSTATE [ 1 ] = ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_81_0 ; ( ( ContinuousStates_mainSim * )
ssGetContStates ( S ) ) -> q0q1q2q3_CSTATE [ 2 ] = ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_82_0 ; ( ( ContinuousStates_mainSim * )
ssGetContStates ( S ) ) -> q0q1q2q3_CSTATE [ 3 ] = ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_83_0 ; ( ( D_Work_mainSim * ) ssGetRootDWork ( S
) ) -> q0q1q2q3_IWORK . IcNeedsLoading = 0 ; } B_3_337_0 [ 0 ] = ( (
ContinuousStates_mainSim * ) ssGetContStates ( S ) ) -> q0q1q2q3_CSTATE [ 0 ]
; B_3_337_0 [ 1 ] = ( ( ContinuousStates_mainSim * ) ssGetContStates ( S ) )
-> q0q1q2q3_CSTATE [ 1 ] ; B_3_337_0 [ 2 ] = ( ( ContinuousStates_mainSim * )
ssGetContStates ( S ) ) -> q0q1q2q3_CSTATE [ 2 ] ; B_3_337_0 [ 3 ] = ( (
ContinuousStates_mainSim * ) ssGetContStates ( S ) ) -> q0q1q2q3_CSTATE [ 3 ]
; B_3_329_0 = ( ( B_3_337_0 [ 0 ] * B_3_337_0 [ 0 ] + B_3_337_0 [ 1 ] *
B_3_337_0 [ 1 ] ) + B_3_337_0 [ 2 ] * B_3_337_0 [ 2 ] ) + B_3_337_0 [ 3 ] *
B_3_337_0 [ 3 ] ; if ( ssIsMajorTimeStep ( S ) ) { if ( ( ( D_Work_mainSim *
) ssGetRootDWork ( S ) ) -> sqrt_DWORK1_p != 0 ) { ssSetSolverNeedsReset ( S
) ; ( ( D_Work_mainSim * ) ssGetRootDWork ( S ) ) -> sqrt_DWORK1_p = 0 ; }
B_3_329_0 = muDoubleScalarSqrt ( B_3_329_0 ) ; } else { B_3_329_0 = B_3_329_0
< 0.0 ? - muDoubleScalarSqrt ( muDoubleScalarAbs ( B_3_329_0 ) ) :
muDoubleScalarSqrt ( B_3_329_0 ) ; ( ( D_Work_mainSim * ) ssGetRootDWork ( S
) ) -> sqrt_DWORK1_p = 1 ; } B_3_23_0 = B_3_337_0 [ 0 ] / B_3_329_0 ;
B_3_133_0 = B_3_337_0 [ 1 ] / B_3_329_0 ; B_3_6_0 = B_3_337_0 [ 2 ] /
B_3_329_0 ; B_3_329_0 = B_3_337_0 [ 3 ] / B_3_329_0 ; B_3_126_0 = ( (
B_3_23_0 * B_3_23_0 + B_3_133_0 * B_3_133_0 ) - B_3_6_0 * B_3_6_0 ) -
B_3_329_0 * B_3_329_0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_103_0 [ 0 ] = muDoubleScalarAtan2 ( ( B_3_133_0 * B_3_6_0 + B_3_23_0 *
B_3_329_0 ) * 2.0 , B_3_126_0 ) ; B_3_126_0 = ( B_3_133_0 * B_3_329_0 -
B_3_23_0 * B_3_6_0 ) * - 2.0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) )
-> B_3_103_0 [ 1 ] = muDoubleScalarAsin ( B_3_126_0 >= 1.0 ? 1.0 : B_3_126_0
<= - 1.0 ? - 1.0 : B_3_126_0 ) ; B_3_126_0 = ( B_3_6_0 * B_3_329_0 + B_3_23_0
* B_3_133_0 ) * 2.0 ; B_3_23_0 = ( ( B_3_23_0 * B_3_23_0 - B_3_133_0 *
B_3_133_0 ) - B_3_6_0 * B_3_6_0 ) + B_3_329_0 * B_3_329_0 ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_103_0 [ 2 ] =
muDoubleScalarAtan2 ( B_3_126_0 , B_3_23_0 ) ; if ( ssIsSampleHit ( S , 2 , 0
) ) { ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_1_0_0 = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_2 * ( ( BlockIO_mainSim
* ) _ssGetBlockIO ( S ) ) -> B_3_66_0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO
( S ) ) -> B_1_1_0 = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) ->
P_3 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_72_0 ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_1_2_0 = ( real32_T ) ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_103_0 [ 2 ] ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_1_3_0 = ( real32_T ) ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_103_0 [ 1 ] ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_1_4_0 = ( real32_T ) ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_103_0 [ 0 ] ;
ssCallAccelRunBlock ( S , 1 , 5 , SS_CALL_MDL_OUTPUTS ) ; ssCallAccelRunBlock
( S , 1 , 6 , SS_CALL_MDL_OUTPUTS ) ; ssCallAccelRunBlock ( S , 1 , 7 ,
SS_CALL_MDL_OUTPUTS ) ; } if ( ssIsSampleHit ( S , 1 , 0 ) ) { ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_105_0 = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_59 ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_106_0 = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_138 ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_107_0 = ( ( BlockIO_mainSim
* ) _ssGetBlockIO ( S ) ) -> B_3_106_0 ; } ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_108_0 = ( ( ContinuousStates_mainSim * )
ssGetContStates ( S ) ) -> v_CSTATE ; if ( ssIsSampleHit ( S , 1 , 0 ) ) { (
( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_109_0 = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_61 ; } ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_223_0 [ 0 ] = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_62 * ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_108_0 ; ( ( BlockIO_mainSim
* ) _ssGetBlockIO ( S ) ) -> B_3_223_0 [ 1 ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_62 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S
) ) -> B_3_109_0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_223_0
[ 2 ] = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_62 * ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_109_0 ; ssCallAccelRunBlock
( S , 3 , 111 , SS_CALL_MDL_OUTPUTS ) ; ( ( BlockIO_mainSim * ) _ssGetBlockIO
( S ) ) -> B_3_112_0 = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) )
-> P_63 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_241_0 [ 2 ] ;
if ( ssIsSampleHit ( S , 2 , 0 ) ) { ssCallAccelRunBlock ( S , 3 , 113 ,
SS_CALL_MDL_OUTPUTS ) ; } if ( ssIsSampleHit ( S , 1 , 0 ) ) { ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_114_0 = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_139 ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_115_0 = ( ( BlockIO_mainSim
* ) _ssGetBlockIO ( S ) ) -> B_3_114_0 ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_117_0 [ 0 ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_70 [ 0 ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_117_0 [ 1 ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_70 [ 1 ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_117_0 [ 2 ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_70 [ 2 ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_117_0 [ 3 ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_70 [ 3 ] ; ssCallAccelRunBlock ( S , 3 , 117 ,
SS_CALL_MDL_OUTPUTS ) ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_118_0 = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_71 * (
( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_117_0 [ 3 ] ; } ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_193_0 = look3_sbinlxpw ( ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_234_0 , ( ( BlockIO_mainSim
* ) _ssGetBlockIO ( S ) ) -> B_3_112_0 , ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_118_0 , ( ( D_Work_mainSim * ) ssGetRootDWork (
S ) ) -> m_bpDataSet , ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) )
-> P_72 , ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_134 , ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_135 ) ;
ssCallAccelRunBlock ( S , 3 , 120 , SS_CALL_MDL_OUTPUTS ) ; if (
ssIsSampleHit ( S , 1 , 0 ) ) { ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) )
-> B_3_121_0 = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_76 ;
} ssCallAccelRunBlock ( S , 3 , 122 , SS_CALL_MDL_OUTPUTS ) ;
ssCallAccelRunBlock ( S , 3 , 123 , SS_CALL_MDL_OUTPUTS ) ; if (
ssIsSampleHit ( S , 1 , 0 ) ) { memcpy ( ( void * ) ( & ( ( BlockIO_mainSim *
) _ssGetBlockIO ( S ) ) -> B_3_124_0 [ 0 ] ) , ( void * ) ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_77 , 15U * sizeof (
real_T ) ) ; } ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_125_0 = (
( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_78 * ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_223_0 [ 0 ] ; B_3_126_0 = (
( ContinuousStates_mainSim * ) ssGetContStates ( S ) ) -> alpha_CSTATE ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_127_0 = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_80 * B_3_126_0 ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 0 ] = ( (
ContinuousStates_mainSim * ) ssGetContStates ( S ) ) -> pqr_CSTATE [ 0 ] ; (
( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 1 ] = ( (
ContinuousStates_mainSim * ) ssGetContStates ( S ) ) -> pqr_CSTATE [ 1 ] ; (
( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 2 ] = ( (
ContinuousStates_mainSim * ) ssGetContStates ( S ) ) -> pqr_CSTATE [ 2 ] ;
muDoubleScalarSinCos ( B_3_126_0 , & B_3_329_0 , & B_3_23_0 ) ; B_3_6_0 = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 0 ] * B_3_23_0 ;
B_3_7_0 = ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 2 ] *
B_3_329_0 ; B_3_133_0 = ( ( ContinuousStates_mainSim * ) ssGetContStates ( S
) ) -> beta_CSTATE ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_135_0 = ( B_3_6_0 + B_3_7_0 ) * muDoubleScalarTan ( B_3_133_0 ) ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_136_0 = muDoubleScalarCos (
B_3_133_0 ) ; for ( i = 0 ; i < 9 ; i ++ ) { ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_137_0 [ i ] = 0.0 ; } B_3_6_0 = ( ( B_3_337_0 [
0 ] * B_3_337_0 [ 0 ] + B_3_337_0 [ 1 ] * B_3_337_0 [ 1 ] ) + B_3_337_0 [ 2 ]
* B_3_337_0 [ 2 ] ) + B_3_337_0 [ 3 ] * B_3_337_0 [ 3 ] ; if (
ssIsMajorTimeStep ( S ) ) { if ( ( ( D_Work_mainSim * ) ssGetRootDWork ( S )
) -> sqrt_DWORK1_k != 0 ) { ssSetSolverNeedsReset ( S ) ; ( ( D_Work_mainSim
* ) ssGetRootDWork ( S ) ) -> sqrt_DWORK1_k = 0 ; } B_3_6_0 =
muDoubleScalarSqrt ( B_3_6_0 ) ; } else { B_3_6_0 = B_3_6_0 < 0.0 ? -
muDoubleScalarSqrt ( muDoubleScalarAbs ( B_3_6_0 ) ) : muDoubleScalarSqrt (
B_3_6_0 ) ; ( ( D_Work_mainSim * ) ssGetRootDWork ( S ) ) -> sqrt_DWORK1_k =
1 ; } B_3_7_0 = B_3_337_0 [ 0 ] / B_3_6_0 ; B_3_9_0 = B_3_337_0 [ 1 ] /
B_3_6_0 ; B_3_25_0 = B_3_337_0 [ 2 ] / B_3_6_0 ; B_3_6_0 = B_3_337_0 [ 3 ] /
B_3_6_0 ; B_3_187_0 [ 0 ] = ( ( B_3_7_0 * B_3_7_0 + B_3_9_0 * B_3_9_0 ) -
B_3_25_0 * B_3_25_0 ) - B_3_6_0 * B_3_6_0 ; B_3_187_0 [ 1 ] = ( B_3_9_0 *
B_3_25_0 - B_3_6_0 * B_3_7_0 ) * ( ( Parameters_mainSim * ) ssGetDefaultParam
( S ) ) -> P_83 ; B_3_187_0 [ 2 ] = ( B_3_7_0 * B_3_25_0 + B_3_9_0 * B_3_6_0
) * ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_84 ; B_3_187_0
[ 3 ] = ( B_3_6_0 * B_3_7_0 + B_3_9_0 * B_3_25_0 ) * ( ( Parameters_mainSim *
) ssGetDefaultParam ( S ) ) -> P_85 ; B_3_187_0 [ 4 ] = ( ( B_3_7_0 * B_3_7_0
- B_3_9_0 * B_3_9_0 ) + B_3_25_0 * B_3_25_0 ) - B_3_6_0 * B_3_6_0 ; B_3_187_0
[ 5 ] = ( B_3_25_0 * B_3_6_0 - B_3_7_0 * B_3_9_0 ) * ( ( Parameters_mainSim *
) ssGetDefaultParam ( S ) ) -> P_86 ; B_3_187_0 [ 6 ] = ( B_3_9_0 * B_3_6_0 -
B_3_7_0 * B_3_25_0 ) * ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) )
-> P_87 ; B_3_187_0 [ 7 ] = ( B_3_7_0 * B_3_9_0 + B_3_25_0 * B_3_6_0 ) * ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_88 ; B_3_187_0 [ 8 ] =
( ( B_3_7_0 * B_3_7_0 - B_3_9_0 * B_3_9_0 ) - B_3_25_0 * B_3_25_0 ) + B_3_6_0
* B_3_6_0 ; if ( ssIsSampleHit ( S , 1 , 0 ) ) { ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_188_0 [ 0 ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_89 [ 0 ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_188_0 [ 1 ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_89 [ 1 ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_188_0 [ 2 ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_89 [ 2 ] ; } for ( i = 0 ; i < 3 ; i ++ ) { (
( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_189_0 [ i ] = 0.0 ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_189_0 [ i ] = B_3_187_0 [ i
] * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_188_0 [ 0 ] + ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_189_0 [ i ] ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_189_0 [ i ] = B_3_187_0 [ i
+ 3 ] * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_188_0 [ 1 ] + (
( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_189_0 [ i ] ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_189_0 [ i ] = B_3_187_0 [ i
+ 6 ] * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_188_0 [ 2 ] + (
( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_189_0 [ i ] ; } B_3_6_0 =
( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_234_0 * ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_234_0 ; if ( ssIsSampleHit (
S , 1 , 0 ) ) { ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_191_0 =
( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_90 ; }
ssCallAccelRunBlock ( S , 2 , 0 , SS_CALL_MDL_OUTPUTS ) ; ( ( BlockIO_mainSim
* ) _ssGetBlockIO ( S ) ) -> B_3_193_0 = B_3_6_0 * ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_2_0_2 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S
) ) -> B_3_194_0 = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) ->
P_91 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_193_0 ; if (
ssIsSampleHit ( S , 1 , 0 ) ) { ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) )
-> B_3_195_0 [ 0 ] = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) ->
P_92 [ 0 ] ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_195_0 [ 1 ]
= ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_92 [ 1 ] ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_195_0 [ 2 ] = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_92 [ 2 ] ; memcpy ( (
void * ) ( & ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_196_0 [ 0 ]
) , ( void * ) ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_93 ,
18U * sizeof ( real_T ) ) ; } ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) )
-> B_3_197_0 = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_94 *
B_3_133_0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_198_0 = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 0 ] * B_3_329_0 ; (
( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_199_0 = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 2 ] * B_3_23_0 ;
B_3_200_0 [ 0 ] = ( ( ContinuousStates_mainSim * ) ssGetContStates ( S ) ) ->
pqr_CSTATE_d [ 0 ] ; B_3_200_0 [ 1 ] = ( ( ContinuousStates_mainSim * )
ssGetContStates ( S ) ) -> pqr_CSTATE_d [ 1 ] ; B_3_200_0 [ 2 ] = ( (
ContinuousStates_mainSim * ) ssGetContStates ( S ) ) -> pqr_CSTATE_d [ 2 ] ;
( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_201_0 = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_96 * B_3_200_0 [ 0 ] ;
( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_202_0 = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_97 * B_3_200_0 [ 2 ] ;
if ( ssIsSampleHit ( S , 1 , 0 ) ) { ( ( BlockIO_mainSim * ) _ssGetBlockIO (
S ) ) -> B_3_203_0 = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) ->
P_98 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_117_0 [ 1 ] ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_204_0 = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_99 * ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_203_0 ; ( ( BlockIO_mainSim
* ) _ssGetBlockIO ( S ) ) -> B_3_205_0 = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_100 * ( ( BlockIO_mainSim * ) _ssGetBlockIO (
S ) ) -> B_3_117_0 [ 2 ] ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_206_0 = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_101 * (
( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_205_0 ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_207_0 [ 0 ] = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_102 [ 0 ] ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_207_0 [ 1 ] = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_102 [ 1 ] ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_207_0 [ 2 ] = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_102 [ 2 ] ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_208_0 = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_103 ; } ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_209_0 = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_104 * B_3_200_0 [ 1 ] ;
if ( ssIsSampleHit ( S , 1 , 0 ) ) { ( ( BlockIO_mainSim * ) _ssGetBlockIO (
S ) ) -> B_3_210_0 = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) ->
P_105 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_117_0 [ 0 ] ; (
( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_211_0 = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_106 * ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_210_0 ; ( ( BlockIO_mainSim
* ) _ssGetBlockIO ( S ) ) -> B_3_212_0 [ 0 ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_107 [ 0 ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_212_0 [ 1 ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_107 [ 1 ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_212_0 [ 2 ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_107 [ 2 ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_213_0 [ 0 ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_108 [ 0 ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_213_0 [ 1 ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_108 [ 1 ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_213_0 [ 2 ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_108 [ 2 ] ; }
mainSim_Synthesized_Atomic_Subsystem_For_Alg_Loop_1 ( S ) ;
ssCallAccelRunBlock ( S , 3 , 215 , SS_CALL_MDL_OUTPUTS ) ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_216_0 [ 0 ] = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_109 * B_3_126_0 ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_216_0 [ 1 ] = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_109 * B_3_133_0 ;
ssCallAccelRunBlock ( S , 3 , 217 , SS_CALL_MDL_OUTPUTS ) ;
ssCallAccelRunBlock ( S , 3 , 218 , SS_CALL_MDL_OUTPUTS ) ;
ssCallAccelRunBlock ( S , 3 , 219 , SS_CALL_MDL_OUTPUTS ) ;
ssCallAccelRunBlock ( S , 3 , 220 , SS_CALL_MDL_OUTPUTS ) ; B_3_226_0 [ 0 ] =
( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_0_14_0 [ 0 ] ; B_3_226_0 [
1 ] = ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_0_14_0 [ 1 ] ;
B_3_226_0 [ 2 ] = ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_0_14_0 [
2 ] ; if ( ssIsSampleHit ( S , 1 , 0 ) ) { ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_222_0 = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_110 ; } ( ( BlockIO_mainSim * ) _ssGetBlockIO
( S ) ) -> B_3_223_0 [ 0 ] = B_3_226_0 [ 0 ] / ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_222_0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO (
S ) ) -> B_3_223_0 [ 1 ] = B_3_226_0 [ 1 ] / ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_222_0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO (
S ) ) -> B_3_223_0 [ 2 ] = B_3_226_0 [ 2 ] / ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_222_0 ; ssCallAccelRunBlock ( S , 3 , 224 ,
SS_CALL_MDL_OUTPUTS ) ; ssCallAccelRunBlock ( S , 3 , 225 ,
SS_CALL_MDL_OUTPUTS ) ; B_3_226_0 [ 0 ] = ( ( ContinuousStates_mainSim * )
ssGetContStates ( S ) ) -> ubvbwb_CSTATE [ 0 ] ; B_3_226_0 [ 1 ] = ( (
ContinuousStates_mainSim * ) ssGetContStates ( S ) ) -> ubvbwb_CSTATE [ 1 ] ;
B_3_226_0 [ 2 ] = ( ( ContinuousStates_mainSim * ) ssGetContStates ( S ) ) ->
ubvbwb_CSTATE [ 2 ] ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_241_0 [ 0 ] = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) ->
P_112 * B_3_226_0 [ 0 ] ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_241_0 [ 1 ] = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) ->
P_112 * B_3_226_0 [ 1 ] ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_241_0 [ 2 ] = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) ->
P_112 * B_3_226_0 [ 2 ] ; ssCallAccelRunBlock ( S , 3 , 228 ,
SS_CALL_MDL_OUTPUTS ) ; if ( ssIsSampleHit ( S , 1 , 0 ) ) {
ssCallAccelRunBlock ( S , 3 , 229 , SS_CALL_MDL_OUTPUTS ) ; } ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_241_0 [ 0 ] = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_113 * ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_103_0 [ 2 ] ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_241_0 [ 1 ] = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_113 * ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_103_0 [ 1 ] ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_241_0 [ 2 ] = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_113 * ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_103_0 [ 0 ] ;
ssCallAccelRunBlock ( S , 3 , 231 , SS_CALL_MDL_OUTPUTS ) ;
ssCallAccelRunBlock ( S , 3 , 232 , SS_CALL_MDL_OUTPUTS ) ;
ssCallAccelRunBlock ( S , 3 , 233 , SS_CALL_MDL_OUTPUTS ) ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_234_0 = look3_sbinlxpw ( ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_234_0 , ( ( BlockIO_mainSim
* ) _ssGetBlockIO ( S ) ) -> B_3_112_0 , ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_118_0 , ( ( D_Work_mainSim * ) ssGetRootDWork (
S ) ) -> m_bpDataSet_i , ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) )
-> P_114 , ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_136 , (
( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_137 ) ; if (
ssIsSampleHit ( S , 1 , 0 ) ) { ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) )
-> B_3_235_0 = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_118
; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_236_0 = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_142 ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_237_0 = ( ( BlockIO_mainSim
* ) _ssGetBlockIO ( S ) ) -> B_3_236_0 ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_238_0 = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_119 ; } ssCallAccelRunBlock ( S , 3 , 239 ,
SS_CALL_MDL_OUTPUTS ) ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_241_0 [ 0 ] = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) ->
P_120 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_241_0 [ 0 ] + (
( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_0_6_0 [ 1 ] ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_241_0 [ 1 ] = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_120 * ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_241_0 [ 1 ] + ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_0_13_0 [ 2 ] ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_241_0 [ 2 ] = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_120 * ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_241_0 [ 2 ] + ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_0_6_0 [ 2 ] ;
ssCallAccelRunBlock ( S , 3 , 242 , SS_CALL_MDL_OUTPUTS ) ;
ssCallAccelRunBlock ( S , 3 , 243 , SS_CALL_MDL_OUTPUTS ) ;
ssCallAccelRunBlock ( S , 3 , 244 , SS_CALL_MDL_OUTPUTS ) ; if (
ssIsSampleHit ( S , 1 , 0 ) ) { ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) )
-> B_3_245_0 = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_121
; } B_3_25_0 = ( ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_245_0 -
( ( ( B_3_337_0 [ 0 ] * B_3_337_0 [ 0 ] + B_3_337_0 [ 1 ] * B_3_337_0 [ 1 ] )
+ B_3_337_0 [ 2 ] * B_3_337_0 [ 2 ] ) + B_3_337_0 [ 3 ] * B_3_337_0 [ 3 ] ) )
* ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_122 ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_249_0 = ( ( B_3_337_0 [ 1 ]
* B_3_200_0 [ 0 ] + B_3_337_0 [ 2 ] * B_3_200_0 [ 1 ] ) + B_3_337_0 [ 3 ] *
B_3_200_0 [ 2 ] ) * - 0.5 + B_3_25_0 * B_3_337_0 [ 0 ] ; ( ( BlockIO_mainSim
* ) _ssGetBlockIO ( S ) ) -> B_3_250_0 = ( ( B_3_337_0 [ 0 ] * B_3_200_0 [ 0
] + B_3_337_0 [ 2 ] * B_3_200_0 [ 2 ] ) - B_3_337_0 [ 3 ] * B_3_200_0 [ 1 ] )
* 0.5 + B_3_25_0 * B_3_337_0 [ 1 ] ; ( ( BlockIO_mainSim * ) _ssGetBlockIO (
S ) ) -> B_3_251_0 = ( ( B_3_337_0 [ 0 ] * B_3_200_0 [ 1 ] + B_3_337_0 [ 3 ]
* B_3_200_0 [ 0 ] ) - B_3_337_0 [ 1 ] * B_3_200_0 [ 2 ] ) * 0.5 + B_3_25_0 *
B_3_337_0 [ 2 ] ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_252_0
= ( ( B_3_337_0 [ 0 ] * B_3_200_0 [ 2 ] + B_3_337_0 [ 1 ] * B_3_200_0 [ 1 ] )
- B_3_337_0 [ 2 ] * B_3_200_0 [ 0 ] ) * 0.5 + B_3_25_0 * B_3_337_0 [ 3 ] ; if
( ssIsSampleHit ( S , 1 , 0 ) ) { memcpy ( ( void * ) & B_3_406_0 [ 0 ] , (
void * ) ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_123 , 18U
* sizeof ( real_T ) ) ; for ( i = 0 ; i < 3 ; i ++ ) { ( ( BlockIO_mainSim *
) _ssGetBlockIO ( S ) ) -> B_3_254_0 [ 3 * i ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_123 [ 6 * i ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_254_0 [ 1 + 3 * i ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_123 [ 6 * i + 1 ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_254_0 [ 2 + 3 * i ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_123 [ 6 * i + 2 ] ; } } for ( i = 0 ; i < 3 ;
i ++ ) { B_3_332_0 [ i ] = ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_254_0 [ i + 6 ] * B_3_200_0 [ 2 ] + ( ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_254_0 [ i + 3 ] * B_3_200_0 [ 1 ] + ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_254_0 [ i ] * B_3_200_0 [ 0
] ) ; } if ( ssIsSampleHit ( S , 1 , 0 ) ) { for ( i = 0 ; i < 3 ; i ++ ) { (
( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_256_0 [ 3 * i ] =
B_3_406_0 [ 6 * i + 3 ] ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_256_0 [ 1 + 3 * i ] = B_3_406_0 [ 6 * i + 4 ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_256_0 [ 2 + 3 * i ] = B_3_406_0 [ 6 * i + 5 ] ;
} for ( i = 0 ; i < 3 ; i ++ ) { ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S )
) -> B_3_266_0 [ 3 * i ] = B_3_406_0 [ 6 * i ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_266_0 [ 1 + 3 * i ] = B_3_406_0 [ 6 * i + 1 ] ;
( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_266_0 [ 2 + 3 * i ] =
B_3_406_0 [ 6 * i + 2 ] ; } } for ( i = 0 ; i < 3 ; i ++ ) { tmp_0 [ i ] = (
( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_256_0 [ i + 6 ] *
B_3_200_0 [ 2 ] + ( ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_256_0 [ i + 3 ] * B_3_200_0 [ 1 ] + ( ( BlockIO_mainSim * ) _ssGetBlockIO
( S ) ) -> B_3_256_0 [ i ] * B_3_200_0 [ 0 ] ) ; } tmp [ 0 ] = ( ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_241_0 [ 0 ] - tmp_0 [ 0 ] )
- ( B_3_200_0 [ 1 ] * B_3_332_0 [ 2 ] - B_3_200_0 [ 2 ] * B_3_332_0 [ 1 ] ) ;
tmp [ 1 ] = ( ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_241_0 [ 1
] - tmp_0 [ 1 ] ) - ( B_3_200_0 [ 2 ] * B_3_332_0 [ 0 ] - B_3_200_0 [ 0 ] *
B_3_332_0 [ 2 ] ) ; tmp [ 2 ] = ( ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S )
) -> B_3_241_0 [ 2 ] - tmp_0 [ 2 ] ) - ( B_3_200_0 [ 0 ] * B_3_332_0 [ 1 ] -
B_3_200_0 [ 1 ] * B_3_332_0 [ 0 ] ) ; rt_mrdivide_U1d1x3_U2d3x3_Yd1x3_snf (
tmp , & ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_266_0 [ 0 ] , &
( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_267_0 [ 0 ] ) ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_275_0 [ 0 ] = ( B_3_226_0 [
1 ] * B_3_200_0 [ 2 ] - B_3_226_0 [ 2 ] * B_3_200_0 [ 1 ] ) + ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_223_0 [ 0 ] ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_275_0 [ 1 ] = ( B_3_226_0 [
2 ] * B_3_200_0 [ 0 ] - B_3_226_0 [ 0 ] * B_3_200_0 [ 2 ] ) + ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_223_0 [ 1 ] ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_275_0 [ 2 ] = ( B_3_226_0 [
0 ] * B_3_200_0 [ 1 ] - B_3_226_0 [ 1 ] * B_3_200_0 [ 0 ] ) + ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_223_0 [ 2 ] ; for ( i = 0 ;
i < 3 ; i ++ ) { ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_277_0 [
i ] = 0.0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_277_0 [ i ]
= B_3_187_0 [ 3 * i ] * B_3_226_0 [ 0 ] + ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_277_0 [ i ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_277_0 [ i ] = B_3_187_0 [ 3 * i + 1 ] *
B_3_226_0 [ 1 ] + ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_277_0
[ i ] ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_277_0 [ i ] =
B_3_187_0 [ 3 * i + 2 ] * B_3_226_0 [ 2 ] + ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_277_0 [ i ] ; } muDoubleScalarSinCos ( B_3_126_0
, & B_3_6_0 , & B_3_7_0 ) ; B_3_330_0 = B_3_6_0 ; B_3_327_0 = B_3_7_0 ;
muDoubleScalarSinCos ( B_3_133_0 , & B_3_6_0 , & B_3_7_0 ) ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_290_0 [ 0 ] = B_3_327_0 *
B_3_7_0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_290_0 [ 6 ] =
B_3_330_0 * B_3_7_0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_290_0 [ 1 ] = - ( B_3_6_0 * B_3_327_0 ) ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_290_0 [ 7 ] = - ( B_3_330_0 * B_3_6_0 ) ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_290_0 [ 2 ] = - B_3_330_0 ;
if ( ssIsSampleHit ( S , 1 , 0 ) ) { ( ( BlockIO_mainSim * ) _ssGetBlockIO (
S ) ) -> B_3_290_0 [ 5 ] = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S )
) -> P_124 ; } ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_290_0 [ 3
] = B_3_6_0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_290_0 [ 4
] = B_3_7_0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_290_0 [ 8
] = B_3_327_0 ; if ( ssIsSampleHit ( S , 1 , 0 ) ) { B_3_330_0 = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_125 [ 1 ] ;
muDoubleScalarSinCos ( ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) )
-> P_125 [ 0 ] , & B_3_6_0 , & B_3_7_0 ) ; B_3_327_0 = B_3_7_0 ;
B_3_292_0_idx = B_3_6_0 ; muDoubleScalarSinCos ( B_3_330_0 , & B_3_6_0 , &
B_3_7_0 ) ; B_3_187_0 [ 0 ] = B_3_327_0 * B_3_7_0 ; B_3_187_0 [ 1 ] = - (
B_3_6_0 * B_3_327_0 ) ; B_3_187_0 [ 2 ] = - B_3_292_0_idx ; B_3_187_0 [ 3 ] =
B_3_6_0 ; B_3_187_0 [ 4 ] = B_3_7_0 ; B_3_187_0 [ 5 ] = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_126 ; B_3_187_0 [ 6 ] =
B_3_292_0_idx * B_3_7_0 ; B_3_187_0 [ 7 ] = - ( B_3_292_0_idx * B_3_6_0 ) ;
B_3_187_0 [ 8 ] = B_3_327_0 ; B_3_332_0 [ 0 ] = ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_127 [ 0 ] ; B_3_332_0 [ 1 ] = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_127 [ 1 ] ; B_3_332_0 [
2 ] = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_127 [ 2 ] ;
muDoubleScalarSinCos ( B_3_332_0 [ 0 ] , & B_3_6_0 , & B_3_7_0 ) ; B_3_327_0
= B_3_7_0 ; B_3_332_0 [ 0 ] = B_3_6_0 ; muDoubleScalarSinCos ( B_3_332_0 [ 1
] , & B_3_6_0 , & B_3_7_0 ) ; B_3_330_0 = B_3_7_0 ; B_3_332_0 [ 1 ] = B_3_6_0
; muDoubleScalarSinCos ( B_3_332_0 [ 2 ] , & B_3_6_0 , & B_3_7_0 ) ;
B_3_332_0 [ 2 ] = B_3_6_0 ; B_3_325_0 [ 0 ] = B_3_330_0 * B_3_7_0 ; B_3_325_0
[ 1 ] = B_3_7_0 * B_3_332_0 [ 0 ] * B_3_332_0 [ 1 ] - B_3_332_0 [ 2 ] *
B_3_327_0 ; B_3_325_0 [ 2 ] = B_3_332_0 [ 1 ] * B_3_327_0 * B_3_7_0 +
B_3_332_0 [ 0 ] * B_3_332_0 [ 2 ] ; B_3_325_0 [ 3 ] = B_3_332_0 [ 2 ] *
B_3_330_0 ; B_3_325_0 [ 4 ] = B_3_332_0 [ 0 ] * B_3_332_0 [ 1 ] * B_3_332_0 [
2 ] + B_3_327_0 * B_3_7_0 ; B_3_325_0 [ 5 ] = B_3_332_0 [ 1 ] * B_3_332_0 [ 2
] * B_3_327_0 - B_3_332_0 [ 0 ] * B_3_7_0 ; B_3_325_0 [ 6 ] = - B_3_332_0 [ 1
] ; B_3_325_0 [ 7 ] = B_3_332_0 [ 0 ] * B_3_330_0 ; B_3_325_0 [ 8 ] =
B_3_327_0 * B_3_330_0 ; for ( i = 0 ; i < 3 ; i ++ ) { for ( i_0 = 0 ; i_0 <
3 ; i_0 ++ ) { B_3_326_0 [ i + 3 * i_0 ] = 0.0 ; B_3_326_0 [ i + 3 * i_0 ] =
B_3_326_0 [ 3 * i_0 + i ] + B_3_187_0 [ 3 * i ] * B_3_325_0 [ 3 * i_0 ] ;
B_3_326_0 [ i + 3 * i_0 ] = B_3_187_0 [ 3 * i + 1 ] * B_3_325_0 [ 3 * i_0 + 1
] + B_3_326_0 [ 3 * i_0 + i ] ; B_3_326_0 [ i + 3 * i_0 ] = B_3_187_0 [ 3 * i
+ 2 ] * B_3_325_0 [ 3 * i_0 + 2 ] + B_3_326_0 [ 3 * i_0 + i ] ; } } B_3_332_0
[ 0 ] = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_129 *
muDoubleScalarAtan2 ( B_3_326_0 [ 3 ] , B_3_326_0 [ 0 ] ) ; B_3_292_0_idx = (
( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_128 * B_3_326_0 [ 6 ]
; B_3_332_0 [ 1 ] = muDoubleScalarAsin ( B_3_292_0_idx >= 1.0 ? 1.0 :
B_3_292_0_idx <= - 1.0 ? - 1.0 : B_3_292_0_idx ) * ( ( Parameters_mainSim * )
ssGetDefaultParam ( S ) ) -> P_129 ; B_3_332_0 [ 2 ] = ( ( Parameters_mainSim
* ) ssGetDefaultParam ( S ) ) -> P_129 * muDoubleScalarAtan2 ( B_3_326_0 [ 7
] , B_3_326_0 [ 8 ] ) ; muDoubleScalarSinCos ( B_3_332_0 [ 0 ] , & B_3_6_0 ,
& B_3_7_0 ) ; B_3_327_0 = B_3_7_0 ; B_3_332_0 [ 0 ] = B_3_6_0 ;
muDoubleScalarSinCos ( B_3_332_0 [ 1 ] , & B_3_6_0 , & B_3_7_0 ) ; B_3_330_0
= B_3_7_0 ; B_3_332_0 [ 1 ] = B_3_6_0 ; muDoubleScalarSinCos ( B_3_332_0 [ 2
] , & B_3_6_0 , & B_3_7_0 ) ; B_3_332_0 [ 2 ] = B_3_6_0 ; ( ( BlockIO_mainSim
* ) _ssGetBlockIO ( S ) ) -> B_3_333_0 = B_3_327_0 * B_3_330_0 * B_3_7_0 +
B_3_332_0 [ 0 ] * B_3_332_0 [ 1 ] * B_3_332_0 [ 2 ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_334_0 = B_3_327_0 * B_3_330_0 * B_3_332_0 [ 2 ]
- B_3_332_0 [ 0 ] * B_3_332_0 [ 1 ] * B_3_7_0 ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_335_0 = B_3_327_0 * B_3_332_0 [ 1 ] * B_3_7_0 +
B_3_332_0 [ 0 ] * B_3_330_0 * B_3_332_0 [ 2 ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_336_0 = B_3_332_0 [ 0 ] * B_3_330_0 * B_3_7_0 -
B_3_327_0 * B_3_332_0 [ 1 ] * B_3_332_0 [ 2 ] ; } if ( ( ( D_Work_mainSim * )
ssGetRootDWork ( S ) ) -> q0q1q2q3_IWORK_j . IcNeedsLoading ) { ( (
ContinuousStates_mainSim * ) ssGetContStates ( S ) ) -> q0q1q2q3_CSTATE_j [ 0
] = ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_333_0 ; ( (
ContinuousStates_mainSim * ) ssGetContStates ( S ) ) -> q0q1q2q3_CSTATE_j [ 1
] = ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_334_0 ; ( (
ContinuousStates_mainSim * ) ssGetContStates ( S ) ) -> q0q1q2q3_CSTATE_j [ 2
] = ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_335_0 ; ( (
ContinuousStates_mainSim * ) ssGetContStates ( S ) ) -> q0q1q2q3_CSTATE_j [ 3
] = ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_336_0 ; ( (
D_Work_mainSim * ) ssGetRootDWork ( S ) ) -> q0q1q2q3_IWORK_j .
IcNeedsLoading = 0 ; } B_3_337_0 [ 0 ] = ( ( ContinuousStates_mainSim * )
ssGetContStates ( S ) ) -> q0q1q2q3_CSTATE_j [ 0 ] ; B_3_337_0 [ 1 ] = ( (
ContinuousStates_mainSim * ) ssGetContStates ( S ) ) -> q0q1q2q3_CSTATE_j [ 1
] ; B_3_337_0 [ 2 ] = ( ( ContinuousStates_mainSim * ) ssGetContStates ( S )
) -> q0q1q2q3_CSTATE_j [ 2 ] ; B_3_337_0 [ 3 ] = ( ( ContinuousStates_mainSim
* ) ssGetContStates ( S ) ) -> q0q1q2q3_CSTATE_j [ 3 ] ; B_3_25_0 = ( (
B_3_337_0 [ 0 ] * B_3_337_0 [ 0 ] + B_3_337_0 [ 1 ] * B_3_337_0 [ 1 ] ) +
B_3_337_0 [ 2 ] * B_3_337_0 [ 2 ] ) + B_3_337_0 [ 3 ] * B_3_337_0 [ 3 ] ; if
( ssIsMajorTimeStep ( S ) ) { if ( ( ( D_Work_mainSim * ) ssGetRootDWork ( S
) ) -> sqrt_DWORK1_b != 0 ) { ssSetSolverNeedsReset ( S ) ; ( (
D_Work_mainSim * ) ssGetRootDWork ( S ) ) -> sqrt_DWORK1_b = 0 ; } B_3_25_0 =
muDoubleScalarSqrt ( B_3_25_0 ) ; } else { B_3_25_0 = B_3_25_0 < 0.0 ? -
muDoubleScalarSqrt ( muDoubleScalarAbs ( B_3_25_0 ) ) : muDoubleScalarSqrt (
B_3_25_0 ) ; ( ( D_Work_mainSim * ) ssGetRootDWork ( S ) ) -> sqrt_DWORK1_b =
1 ; } B_3_9_0 = B_3_337_0 [ 0 ] / B_3_25_0 ; B_3_329_0 = B_3_337_0 [ 1 ] /
B_3_25_0 ; B_3_23_0 = B_3_337_0 [ 2 ] / B_3_25_0 ; B_3_25_0 = B_3_337_0 [ 3 ]
/ B_3_25_0 ; B_3_332_0 [ 0 ] = muDoubleScalarAtan2 ( ( B_3_329_0 * B_3_23_0 +
B_3_9_0 * B_3_25_0 ) * 2.0 , ( ( B_3_9_0 * B_3_9_0 + B_3_329_0 * B_3_329_0 )
- B_3_23_0 * B_3_23_0 ) - B_3_25_0 * B_3_25_0 ) ; B_3_292_0_idx = ( B_3_329_0
* B_3_25_0 - B_3_9_0 * B_3_23_0 ) * - 2.0 ; B_3_332_0 [ 1 ] =
muDoubleScalarAsin ( B_3_292_0_idx >= 1.0 ? 1.0 : B_3_292_0_idx <= - 1.0 ? -
1.0 : B_3_292_0_idx ) ; B_3_6_0 = ( B_3_23_0 * B_3_25_0 + B_3_9_0 * B_3_329_0
) * 2.0 ; B_3_9_0 = ( ( B_3_9_0 * B_3_9_0 - B_3_329_0 * B_3_329_0 ) -
B_3_23_0 * B_3_23_0 ) + B_3_25_0 * B_3_25_0 ; B_3_332_0 [ 2 ] =
muDoubleScalarAtan2 ( B_3_6_0 , B_3_9_0 ) ; muDoubleScalarSinCos ( B_3_332_0
[ 0 ] , & B_3_6_0 , & B_3_7_0 ) ; B_3_327_0 = B_3_7_0 ; B_3_332_0 [ 0 ] =
B_3_6_0 ; muDoubleScalarSinCos ( B_3_332_0 [ 1 ] , & B_3_6_0 , & B_3_7_0 ) ;
B_3_330_0 = B_3_7_0 ; B_3_332_0 [ 1 ] = B_3_6_0 ; muDoubleScalarSinCos (
B_3_332_0 [ 2 ] , & B_3_6_0 , & B_3_7_0 ) ; B_3_332_0 [ 2 ] = B_3_6_0 ;
B_3_187_0 [ 0 ] = B_3_330_0 * B_3_327_0 ; B_3_187_0 [ 1 ] = B_3_332_0 [ 2 ] *
B_3_332_0 [ 1 ] * B_3_327_0 - B_3_7_0 * B_3_332_0 [ 0 ] ; B_3_187_0 [ 2 ] =
B_3_7_0 * B_3_332_0 [ 1 ] * B_3_327_0 + B_3_332_0 [ 2 ] * B_3_332_0 [ 0 ] ;
B_3_187_0 [ 3 ] = B_3_330_0 * B_3_332_0 [ 0 ] ; B_3_187_0 [ 4 ] = B_3_332_0 [
2 ] * B_3_332_0 [ 1 ] * B_3_332_0 [ 0 ] + B_3_7_0 * B_3_327_0 ; B_3_187_0 [ 5
] = B_3_7_0 * B_3_332_0 [ 1 ] * B_3_332_0 [ 0 ] - B_3_332_0 [ 2 ] * B_3_327_0
; B_3_187_0 [ 6 ] = - B_3_332_0 [ 1 ] ; B_3_187_0 [ 7 ] = B_3_332_0 [ 2 ] *
B_3_330_0 ; B_3_187_0 [ 8 ] = B_3_7_0 * B_3_330_0 ; for ( i = 0 ; i < 3 ; i
++ ) { for ( i_0 = 0 ; i_0 < 3 ; i_0 ++ ) { B_3_325_0 [ i + 3 * i_0 ] = 0.0 ;
B_3_325_0 [ i + 3 * i_0 ] = B_3_325_0 [ 3 * i_0 + i ] + B_3_187_0 [ 3 * i_0 ]
* ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_290_0 [ i ] ;
B_3_325_0 [ i + 3 * i_0 ] = B_3_187_0 [ 3 * i_0 + 1 ] * ( ( BlockIO_mainSim *
) _ssGetBlockIO ( S ) ) -> B_3_290_0 [ i + 3 ] + B_3_325_0 [ 3 * i_0 + i ] ;
B_3_325_0 [ i + 3 * i_0 ] = B_3_187_0 [ 3 * i_0 + 2 ] * ( ( BlockIO_mainSim *
) _ssGetBlockIO ( S ) ) -> B_3_290_0 [ i + 6 ] + B_3_325_0 [ 3 * i_0 + i ] ;
} } B_3_292_0_idx = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S ) ) ->
P_130 * B_3_325_0 [ 6 ] ; muDoubleScalarSinCos ( muDoubleScalarAtan2 (
B_3_325_0 [ 7 ] , B_3_325_0 [ 8 ] ) , & B_3_6_0 , & B_3_7_0 ) ; B_3_332_0 [ 0
] = B_3_6_0 ; B_3_327_0 = B_3_7_0 ; muDoubleScalarSinCos ( muDoubleScalarAsin
( B_3_292_0_idx >= 1.0 ? 1.0 : B_3_292_0_idx <= - 1.0 ? - 1.0 : B_3_292_0_idx
) , & B_3_6_0 , & B_3_7_0 ) ; B_3_332_0 [ 1 ] = B_3_6_0 ; B_3_330_0 = B_3_7_0
; muDoubleScalarSinCos ( muDoubleScalarAtan2 ( B_3_325_0 [ 3 ] , B_3_325_0 [
0 ] ) , & B_3_6_0 , & B_3_7_0 ) ; B_3_332_0 [ 2 ] = B_3_6_0 ; B_3_187_0 [ 0 ]
= B_3_330_0 * B_3_7_0 ; B_3_187_0 [ 3 ] = B_3_332_0 [ 2 ] * B_3_330_0 ;
B_3_187_0 [ 6 ] = - B_3_332_0 [ 1 ] ; B_3_187_0 [ 1 ] = B_3_7_0 * B_3_332_0 [
0 ] * B_3_332_0 [ 1 ] - B_3_332_0 [ 2 ] * B_3_327_0 ; B_3_187_0 [ 4 ] =
B_3_332_0 [ 0 ] * B_3_332_0 [ 1 ] * B_3_332_0 [ 2 ] + B_3_327_0 * B_3_7_0 ;
B_3_187_0 [ 7 ] = B_3_332_0 [ 0 ] * B_3_330_0 ; B_3_187_0 [ 2 ] = B_3_332_0 [
1 ] * B_3_327_0 * B_3_7_0 + B_3_332_0 [ 0 ] * B_3_332_0 [ 2 ] ; B_3_187_0 [ 5
] = B_3_332_0 [ 1 ] * B_3_332_0 [ 2 ] * B_3_327_0 - B_3_332_0 [ 0 ] * B_3_7_0
; B_3_187_0 [ 8 ] = B_3_327_0 * B_3_330_0 ; B_3_25_0 = ( ( B_3_337_0 [ 0 ] *
B_3_337_0 [ 0 ] + B_3_337_0 [ 1 ] * B_3_337_0 [ 1 ] ) + B_3_337_0 [ 2 ] *
B_3_337_0 [ 2 ] ) + B_3_337_0 [ 3 ] * B_3_337_0 [ 3 ] ; if (
ssIsMajorTimeStep ( S ) ) { if ( ( ( D_Work_mainSim * ) ssGetRootDWork ( S )
) -> sqrt_DWORK1_e != 0 ) { ssSetSolverNeedsReset ( S ) ; ( ( D_Work_mainSim
* ) ssGetRootDWork ( S ) ) -> sqrt_DWORK1_e = 0 ; } B_3_25_0 =
muDoubleScalarSqrt ( B_3_25_0 ) ; } else { B_3_25_0 = B_3_25_0 < 0.0 ? -
muDoubleScalarSqrt ( muDoubleScalarAbs ( B_3_25_0 ) ) : muDoubleScalarSqrt (
B_3_25_0 ) ; ( ( D_Work_mainSim * ) ssGetRootDWork ( S ) ) -> sqrt_DWORK1_e =
1 ; } B_3_9_0 = B_3_337_0 [ 0 ] / B_3_25_0 ; B_3_329_0 = B_3_337_0 [ 1 ] /
B_3_25_0 ; B_3_23_0 = B_3_337_0 [ 2 ] / B_3_25_0 ; B_3_25_0 = B_3_337_0 [ 3 ]
/ B_3_25_0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_402_0 = ( (
B_3_329_0 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 0 ]
+ B_3_23_0 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 1 ]
) + B_3_25_0 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 2
] ) * - 0.5 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_403_0 = (
( B_3_9_0 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 0 ]
+ B_3_23_0 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 2 ]
) - B_3_25_0 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 1
] ) * 0.5 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_404_0 = ( (
B_3_9_0 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 1 ] +
B_3_25_0 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 0 ] )
- B_3_329_0 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 2
] ) * 0.5 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_405_0 = ( (
B_3_9_0 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 2 ] +
B_3_329_0 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 1 ]
) - B_3_23_0 * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 0
] ) * 0.5 ; if ( ssIsSampleHit ( S , 1 , 0 ) ) { memcpy ( ( void * ) &
B_3_406_0 [ 0 ] , ( void * ) ( ( Parameters_mainSim * ) ssGetDefaultParam ( S
) ) -> P_131 , 18U * sizeof ( real_T ) ) ; for ( i = 0 ; i < 3 ; i ++ ) { ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_407_0 [ 3 * i ] = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_131 [ 6 * i ] ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_407_0 [ 1 + 3 * i ] = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_131 [ 6 * i + 1 ] ; ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_407_0 [ 2 + 3 * i ] = ( (
Parameters_mainSim * ) ssGetDefaultParam ( S ) ) -> P_131 [ 6 * i + 2 ] ; } }
for ( i = 0 ; i < 3 ; i ++ ) { B_3_332_0 [ i ] = ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_407_0 [ i + 6 ] * ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_128_0 [ 2 ] + ( ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_407_0 [ i + 3 ] * ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_128_0 [ 1 ] + ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_407_0 [ i ] * ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_128_0 [ 0 ] ) ; } if ( ssIsSampleHit ( S , 1 , 0
) ) { for ( i = 0 ; i < 3 ; i ++ ) { ( ( BlockIO_mainSim * ) _ssGetBlockIO (
S ) ) -> B_3_409_0 [ 3 * i ] = B_3_406_0 [ 6 * i + 3 ] ; ( ( BlockIO_mainSim
* ) _ssGetBlockIO ( S ) ) -> B_3_409_0 [ 1 + 3 * i ] = B_3_406_0 [ 6 * i + 4
] ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_409_0 [ 2 + 3 * i ]
= B_3_406_0 [ 6 * i + 5 ] ; } for ( i = 0 ; i < 3 ; i ++ ) { ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_419_0 [ 3 * i ] = B_3_406_0
[ 6 * i ] ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_419_0 [ 1 +
3 * i ] = B_3_406_0 [ 6 * i + 1 ] ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S
) ) -> B_3_419_0 [ 2 + 3 * i ] = B_3_406_0 [ 6 * i + 2 ] ; } } for ( i = 0 ;
i < 3 ; i ++ ) { tmp_0 [ i ] = ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) )
-> B_3_409_0 [ i + 6 ] * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_128_0 [ 2 ] + ( ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_409_0 [ i + 3 ] * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_128_0 [ 1 ] + ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_409_0
[ i ] * ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 0 ] ) ;
} tmp [ 0 ] = ( ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_241_0 [
0 ] - tmp_0 [ 0 ] ) - ( ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_128_0 [ 1 ] * B_3_332_0 [ 2 ] - ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S
) ) -> B_3_128_0 [ 2 ] * B_3_332_0 [ 1 ] ) ; tmp [ 1 ] = ( ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_241_0 [ 1 ] - tmp_0 [ 1 ] )
- ( ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 2 ] *
B_3_332_0 [ 0 ] - ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0
[ 0 ] * B_3_332_0 [ 2 ] ) ; tmp [ 2 ] = ( ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_241_0 [ 2 ] - tmp_0 [ 2 ] ) - ( ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 0 ] * B_3_332_0 [ 1
] - ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_128_0 [ 1 ] *
B_3_332_0 [ 0 ] ) ; rt_mrdivide_U1d1x3_U2d3x3_Yd1x3_snf ( tmp , & ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_419_0 [ 0 ] , & ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_420_0 [ 0 ] ) ;
muDoubleScalarSinCos ( B_3_126_0 , & B_3_6_0 , & B_3_7_0 ) ; B_3_327_0 =
B_3_6_0 ; B_3_330_0 = B_3_7_0 ; muDoubleScalarSinCos ( B_3_133_0 , & B_3_6_0
, & B_3_7_0 ) ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_433_0 [
0 ] = B_3_330_0 * B_3_7_0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_433_0 [ 6 ] = B_3_327_0 * B_3_7_0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO
( S ) ) -> B_3_433_0 [ 1 ] = - ( B_3_6_0 * B_3_330_0 ) ; ( ( BlockIO_mainSim
* ) _ssGetBlockIO ( S ) ) -> B_3_433_0 [ 7 ] = - ( B_3_327_0 * B_3_6_0 ) ; (
( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_433_0 [ 2 ] = - B_3_327_0
; if ( ssIsSampleHit ( S , 1 , 0 ) ) { ( ( BlockIO_mainSim * ) _ssGetBlockIO
( S ) ) -> B_3_433_0 [ 5 ] = ( ( Parameters_mainSim * ) ssGetDefaultParam ( S
) ) -> P_132 ; } ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_433_0 [
3 ] = B_3_6_0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_433_0 [
4 ] = B_3_7_0 ; ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_433_0 [
8 ] = B_3_330_0 ; for ( i = 0 ; i < 3 ; i ++ ) { ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_436_0 [ i ] = 0.0 ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_436_0 [ i ] = B_3_187_0 [ 3 * i ] * ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_108_0 + ( ( BlockIO_mainSim
* ) _ssGetBlockIO ( S ) ) -> B_3_436_0 [ i ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_436_0 [ i ] = B_3_187_0 [ 3 * i + 1 ] * ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_109_0 + ( ( BlockIO_mainSim
* ) _ssGetBlockIO ( S ) ) -> B_3_436_0 [ i ] ; ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_436_0 [ i ] = B_3_187_0 [ 3 * i + 2 ] * ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_109_0 + ( ( BlockIO_mainSim
* ) _ssGetBlockIO ( S ) ) -> B_3_436_0 [ i ] ; } B_3_437_0 [ 0 ] = ( (
ContinuousStates_mainSim * ) ssGetContStates ( S ) ) -> xeyeze_CSTATE_d [ 0 ]
; B_3_437_0 [ 1 ] = ( ( ContinuousStates_mainSim * ) ssGetContStates ( S ) )
-> xeyeze_CSTATE_d [ 1 ] ; B_3_437_0 [ 2 ] = ( ( ContinuousStates_mainSim * )
ssGetContStates ( S ) ) -> xeyeze_CSTATE_d [ 2 ] ; if ( ssIsSampleHit ( S , 1
, 0 ) ) { ssCallAccelRunBlock ( S , 3 , 438 , SS_CALL_MDL_OUTPUTS ) ; }
UNUSED_PARAMETER ( tid ) ; }
#define MDL_UPDATE
static void mdlUpdate ( SimStruct * S , int_T tid ) { UNUSED_PARAMETER ( tid
) ; }
#define MDL_DERIVATIVES
static void mdlDerivatives ( SimStruct * S ) { { ( ( StateDerivatives_mainSim
* ) ssGetdX ( S ) ) -> xeyeze_CSTATE [ 0 ] = ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_277_0 [ 0 ] ; ( ( StateDerivatives_mainSim * )
ssGetdX ( S ) ) -> xeyeze_CSTATE [ 1 ] = ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_277_0 [ 1 ] ; ( ( StateDerivatives_mainSim * )
ssGetdX ( S ) ) -> xeyeze_CSTATE [ 2 ] = ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_277_0 [ 2 ] ; } { ( ( StateDerivatives_mainSim *
) ssGetdX ( S ) ) -> q0q1q2q3_CSTATE [ 0 ] = ( ( BlockIO_mainSim * )
_ssGetBlockIO ( S ) ) -> B_3_249_0 ; ( ( StateDerivatives_mainSim * ) ssGetdX
( S ) ) -> q0q1q2q3_CSTATE [ 1 ] = ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S
) ) -> B_3_250_0 ; ( ( StateDerivatives_mainSim * ) ssGetdX ( S ) ) ->
q0q1q2q3_CSTATE [ 2 ] = ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_251_0 ; ( ( StateDerivatives_mainSim * ) ssGetdX ( S ) ) ->
q0q1q2q3_CSTATE [ 3 ] = ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) ->
B_3_252_0 ; } { ( ( StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> v_CSTATE
= ( ( BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_0_16_0 [ 0 ] ; } { ( (
StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> alpha_CSTATE = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_0_8_0 ; } { ( (
StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> pqr_CSTATE [ 0 ] = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_420_0 [ 0 ] ; ( (
StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> pqr_CSTATE [ 1 ] = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_420_0 [ 1 ] ; ( (
StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> pqr_CSTATE [ 2 ] = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_420_0 [ 2 ] ; } { ( (
StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> beta_CSTATE = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_0_1_0 ; } { ( (
StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> pqr_CSTATE_d [ 0 ] = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_267_0 [ 0 ] ; ( (
StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> pqr_CSTATE_d [ 1 ] = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_267_0 [ 1 ] ; ( (
StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> pqr_CSTATE_d [ 2 ] = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_267_0 [ 2 ] ; } { ( (
StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> ubvbwb_CSTATE [ 0 ] = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_275_0 [ 0 ] ; ( (
StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> ubvbwb_CSTATE [ 1 ] = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_275_0 [ 1 ] ; ( (
StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> ubvbwb_CSTATE [ 2 ] = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_275_0 [ 2 ] ; } { ( (
StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> q0q1q2q3_CSTATE_j [ 0 ] = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_402_0 ; ( (
StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> q0q1q2q3_CSTATE_j [ 1 ] = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_403_0 ; ( (
StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> q0q1q2q3_CSTATE_j [ 2 ] = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_404_0 ; ( (
StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> q0q1q2q3_CSTATE_j [ 3 ] = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_405_0 ; } { ( (
StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> xeyeze_CSTATE_d [ 0 ] = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_436_0 [ 0 ] ; ( (
StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> xeyeze_CSTATE_d [ 1 ] = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_436_0 [ 1 ] ; ( (
StateDerivatives_mainSim * ) ssGetdX ( S ) ) -> xeyeze_CSTATE_d [ 2 ] = ( (
BlockIO_mainSim * ) _ssGetBlockIO ( S ) ) -> B_3_436_0 [ 2 ] ; } } static
void mdlInitializeSizes ( SimStruct * S ) { ssSetChecksumVal ( S , 0 ,
1568874855U ) ; ssSetChecksumVal ( S , 1 , 2085161494U ) ; ssSetChecksumVal (
S , 2 , 647468961U ) ; ssSetChecksumVal ( S , 3 , 1152390439U ) ; { mxArray *
slVerStructMat = NULL ; mxArray * slStrMat = mxCreateString ( "simulink" ) ;
char slVerChar [ 10 ] ; int status = mexCallMATLAB ( 1 , & slVerStructMat , 1
, & slStrMat , "ver" ) ; if ( status == 0 ) { mxArray * slVerMat = mxGetField
( slVerStructMat , 0 , "Version" ) ; if ( slVerMat == NULL ) { status = 1 ; }
else { status = mxGetString ( slVerMat , slVerChar , 10 ) ; } }
mxDestroyArray ( slStrMat ) ; mxDestroyArray ( slVerStructMat ) ; if ( (
status == 1 ) || ( strcmp ( slVerChar , "7.8" ) != 0 ) ) { return ; } }
ssSetOptions ( S , SS_OPTION_EXCEPTION_FREE_CODE ) ; if ( ssGetSizeofDWork (
S ) != sizeof ( D_Work_mainSim ) ) { ssSetErrorStatus ( S ,
"Unexpected error: Internal DWork sizes do "
"not match for accelerator mex file." ) ; } if ( ssGetSizeofGlobalBlockIO ( S
) != sizeof ( BlockIO_mainSim ) ) { ssSetErrorStatus ( S ,
"Unexpected error: Internal BlockIO sizes do "
"not match for accelerator mex file." ) ; } { int ssSizeofParams ;
ssGetSizeofParams ( S , & ssSizeofParams ) ; if ( ssSizeofParams != sizeof (
Parameters_mainSim ) ) { static char msg [ 256 ] ; sprintf ( msg ,
"Unexpected error: Internal Parameters sizes do "
"not match for accelerator mex file." ) ; } } _ssSetDefaultParam ( S , (
real_T * ) & mainSim_rtDefaultParameters ) ; rt_InitInfAndNaN ( sizeof (
real_T ) ) ; } static void mdlInitializeSampleTimes ( SimStruct * S ) { {
SimStruct * childS ; SysOutputFcn * callSysFcns ; childS = ssGetSFunction ( S
, 3 ) ; callSysFcns = ssGetCallSystemOutputFcnList ( childS ) ; callSysFcns [
3 + 0 ] = ( SysOutputFcn ) ( NULL ) ; } } static void mdlTerminate (
SimStruct * S ) { }
#include "simulink.c"
