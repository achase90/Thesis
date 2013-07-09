/* Include files */

#include "blascompat32.h"
#include "mainSim_sfun.h"
#include "c1_mainSim.h"
#include "mwmathutil.h"
#define CHARTINSTANCE_CHARTNUMBER      (chartInstance->chartNumber)
#define CHARTINSTANCE_INSTANCENUMBER   (chartInstance->instanceNumber)
#include "mainSim_sfun_debug_macros.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static const char * c1_debug_family_names[30] = { "RE", "l", "v", "KK", "K",
  "C1", "PP", "TL", "PL", "RL", "AL", "ML", "BT", "H", "M1", "RR", "MU", "TS",
  "A", "P", "RM", "QM", "CF", "data", "nargin", "nargout", "Z", "k", "T", "R" };

/* Function Declarations */
static void initialize_c1_mainSim(SFc1_mainSimInstanceStruct *chartInstance);
static void initialize_params_c1_mainSim(SFc1_mainSimInstanceStruct
  *chartInstance);
static void enable_c1_mainSim(SFc1_mainSimInstanceStruct *chartInstance);
static void disable_c1_mainSim(SFc1_mainSimInstanceStruct *chartInstance);
static void c1_update_debugger_state_c1_mainSim(SFc1_mainSimInstanceStruct
  *chartInstance);
static const mxArray *get_sim_state_c1_mainSim(SFc1_mainSimInstanceStruct
  *chartInstance);
static void set_sim_state_c1_mainSim(SFc1_mainSimInstanceStruct *chartInstance,
  const mxArray *c1_st);
static void finalize_c1_mainSim(SFc1_mainSimInstanceStruct *chartInstance);
static void sf_c1_mainSim(SFc1_mainSimInstanceStruct *chartInstance);
static void c1_chartstep_c1_mainSim(SFc1_mainSimInstanceStruct *chartInstance);
static void initSimStructsc1_mainSim(SFc1_mainSimInstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber);
static const mxArray *c1_sf_marshallOut(void *chartInstanceVoid, void *c1_inData);
static real_T c1_emlrt_marshallIn(SFc1_mainSimInstanceStruct *chartInstance,
  const mxArray *c1_R, const char_T *c1_identifier);
static real_T c1_b_emlrt_marshallIn(SFc1_mainSimInstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static const mxArray *c1_b_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static void c1_info_helper(c1_ResolvedFunctionInfo c1_info[32]);
static real_T c1_mrdivide(SFc1_mainSimInstanceStruct *chartInstance, real_T c1_A,
  real_T c1_B);
static real_T c1_mpower(SFc1_mainSimInstanceStruct *chartInstance, real_T c1_a);
static void c1_eml_scalar_eg(SFc1_mainSimInstanceStruct *chartInstance);
static void c1_eml_error(SFc1_mainSimInstanceStruct *chartInstance);
static real_T c1_b_mpower(SFc1_mainSimInstanceStruct *chartInstance, real_T c1_a);
static real_T c1_c_mpower(SFc1_mainSimInstanceStruct *chartInstance, real_T c1_a);
static real_T c1_d_mpower(SFc1_mainSimInstanceStruct *chartInstance, real_T c1_a);
static real_T c1_e_mpower(SFc1_mainSimInstanceStruct *chartInstance, real_T c1_a);
static real_T c1_sqrt(SFc1_mainSimInstanceStruct *chartInstance, real_T c1_x);
static void c1_b_eml_error(SFc1_mainSimInstanceStruct *chartInstance);
static real_T c1_f_mpower(SFc1_mainSimInstanceStruct *chartInstance, real_T c1_a);
static real_T c1_interp1(SFc1_mainSimInstanceStruct *chartInstance, real_T
  c1_varargin_1[8], real_T c1_varargin_2[8], real_T c1_varargin_3);
static void c1_c_eml_error(SFc1_mainSimInstanceStruct *chartInstance);
static void c1_d_eml_error(SFc1_mainSimInstanceStruct *chartInstance);
static void c1_e_eml_error(SFc1_mainSimInstanceStruct *chartInstance);
static const mxArray *c1_c_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static int32_T c1_c_emlrt_marshallIn(SFc1_mainSimInstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static uint8_T c1_d_emlrt_marshallIn(SFc1_mainSimInstanceStruct *chartInstance,
  const mxArray *c1_b_is_active_c1_mainSim, const char_T *c1_identifier);
static uint8_T c1_e_emlrt_marshallIn(SFc1_mainSimInstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_b_sqrt(SFc1_mainSimInstanceStruct *chartInstance, real_T *c1_x);
static void init_dsm_address_info(SFc1_mainSimInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c1_mainSim(SFc1_mainSimInstanceStruct *chartInstance)
{
  chartInstance->c1_sfEvent = CALL_EVENT;
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  chartInstance->c1_is_active_c1_mainSim = 0U;
}

static void initialize_params_c1_mainSim(SFc1_mainSimInstanceStruct
  *chartInstance)
{
}

static void enable_c1_mainSim(SFc1_mainSimInstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static void disable_c1_mainSim(SFc1_mainSimInstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static void c1_update_debugger_state_c1_mainSim(SFc1_mainSimInstanceStruct
  *chartInstance)
{
}

static const mxArray *get_sim_state_c1_mainSim(SFc1_mainSimInstanceStruct
  *chartInstance)
{
  const mxArray *c1_st;
  const mxArray *c1_y = NULL;
  real_T c1_hoistedGlobal;
  real_T c1_u;
  const mxArray *c1_b_y = NULL;
  real_T c1_b_hoistedGlobal;
  real_T c1_b_u;
  const mxArray *c1_c_y = NULL;
  uint8_T c1_c_hoistedGlobal;
  uint8_T c1_c_u;
  const mxArray *c1_d_y = NULL;
  real_T *c1_R;
  real_T *c1_T;
  c1_R = (real_T *)ssGetOutputPortSignal(chartInstance->S, 2);
  c1_T = (real_T *)ssGetOutputPortSignal(chartInstance->S, 1);
  c1_st = NULL;
  c1_st = NULL;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_createcellarray(3), FALSE);
  c1_hoistedGlobal = *c1_R;
  c1_u = c1_hoistedGlobal;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", &c1_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c1_y, 0, c1_b_y);
  c1_b_hoistedGlobal = *c1_T;
  c1_b_u = c1_b_hoistedGlobal;
  c1_c_y = NULL;
  sf_mex_assign(&c1_c_y, sf_mex_create("y", &c1_b_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c1_y, 1, c1_c_y);
  c1_c_hoistedGlobal = chartInstance->c1_is_active_c1_mainSim;
  c1_c_u = c1_c_hoistedGlobal;
  c1_d_y = NULL;
  sf_mex_assign(&c1_d_y, sf_mex_create("y", &c1_c_u, 3, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c1_y, 2, c1_d_y);
  sf_mex_assign(&c1_st, c1_y, FALSE);
  return c1_st;
}

static void set_sim_state_c1_mainSim(SFc1_mainSimInstanceStruct *chartInstance,
  const mxArray *c1_st)
{
  const mxArray *c1_u;
  real_T *c1_R;
  real_T *c1_T;
  c1_R = (real_T *)ssGetOutputPortSignal(chartInstance->S, 2);
  c1_T = (real_T *)ssGetOutputPortSignal(chartInstance->S, 1);
  chartInstance->c1_doneDoubleBufferReInit = TRUE;
  c1_u = sf_mex_dup(c1_st);
  *c1_R = c1_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c1_u, 0)),
    "R");
  *c1_T = c1_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c1_u, 1)),
    "T");
  chartInstance->c1_is_active_c1_mainSim = c1_d_emlrt_marshallIn(chartInstance,
    sf_mex_dup(sf_mex_getcell(c1_u, 2)), "is_active_c1_mainSim");
  sf_mex_destroy(&c1_u);
  c1_update_debugger_state_c1_mainSim(chartInstance);
  sf_mex_destroy(&c1_st);
}

static void finalize_c1_mainSim(SFc1_mainSimInstanceStruct *chartInstance)
{
}

static void sf_c1_mainSim(SFc1_mainSimInstanceStruct *chartInstance)
{
  real_T *c1_Z;
  real_T *c1_T;
  real_T *c1_k;
  real_T *c1_R;
  c1_R = (real_T *)ssGetOutputPortSignal(chartInstance->S, 2);
  c1_k = (real_T *)ssGetInputPortSignal(chartInstance->S, 1);
  c1_T = (real_T *)ssGetOutputPortSignal(chartInstance->S, 1);
  c1_Z = (real_T *)ssGetInputPortSignal(chartInstance->S, 0);
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  _SFD_DATA_RANGE_CHECK(*c1_Z, 0U);
  _SFD_DATA_RANGE_CHECK(*c1_T, 1U);
  _SFD_DATA_RANGE_CHECK(*c1_k, 2U);
  _SFD_DATA_RANGE_CHECK(*c1_R, 3U);
  chartInstance->c1_sfEvent = CALL_EVENT;
  c1_chartstep_c1_mainSim(chartInstance);
  sf_debug_check_for_state_inconsistency(_mainSimMachineNumber_,
    chartInstance->chartNumber, chartInstance->instanceNumber);
}

static void c1_chartstep_c1_mainSim(SFc1_mainSimInstanceStruct *chartInstance)
{
  real_T c1_hoistedGlobal;
  real_T c1_b_hoistedGlobal;
  real_T c1_Z;
  real_T c1_k;
  uint32_T c1_debug_family_var_map[30];
  real_T c1_RE;
  real_T c1_l;
  real_T c1_v;
  real_T c1_KK;
  real_T c1_K;
  real_T c1_C1;
  real_T c1_PP;
  real_T c1_TL;
  real_T c1_PL;
  real_T c1_RL;
  real_T c1_AL;
  real_T c1_ML;
  real_T c1_BT;
  real_T c1_H;
  real_T c1_M1;
  real_T c1_RR;
  real_T c1_MU;
  real_T c1_TS;
  real_T c1_A;
  real_T c1_P;
  real_T c1_RM;
  real_T c1_QM;
  real_T c1_CF;
  real_T c1_data[16];
  real_T c1_nargin = 2.0;
  real_T c1_nargout = 2.0;
  real_T c1_T;
  real_T c1_R;
  real_T c1_a;
  real_T c1_b;
  real_T c1_y;
  real_T c1_b_a;
  real_T c1_b_b;
  real_T c1_b_y;
  real_T c1_c_b;
  real_T c1_c_y;
  real_T c1_d_b;
  real_T c1_d_y;
  real_T c1_x;
  real_T c1_b_x;
  real_T c1_e_b;
  real_T c1_f_b;
  real_T c1_g_b;
  real_T c1_e_y;
  real_T c1_h_b;
  real_T c1_i_b;
  real_T c1_f_y;
  real_T c1_c_x;
  real_T c1_d_x;
  real_T c1_j_b;
  real_T c1_k_b;
  real_T c1_g_y;
  real_T c1_l_b;
  real_T c1_m_b;
  real_T c1_h_y;
  real_T c1_n_b;
  real_T c1_o_b;
  real_T c1_i_y;
  real_T c1_c_a;
  real_T c1_p_b;
  real_T c1_j_y;
  real_T c1_d_a;
  real_T c1_q_b;
  real_T c1_e_a;
  real_T c1_r_b;
  real_T c1_f_a;
  real_T c1_s_b;
  real_T c1_g_a;
  real_T c1_t_b;
  real_T c1_h_a;
  real_T c1_u_b;
  real_T c1_k_y;
  real_T c1_v_b;
  real_T c1_i_a;
  real_T c1_l_y;
  real_T c1_j_a;
  real_T c1_m_y;
  real_T c1_e_x;
  real_T c1_f_x;
  real_T c1_B;
  real_T c1_n_y;
  real_T c1_o_y;
  int32_T c1_i0;
  static real_T c1_dv0[16] = { 422063.0, 577204.0, 840371.0, 1.33005E+6,
    2.10505E+6, 3.69808E+6, 6.36246E+6, 1.0E+7, 0.0020475, 0.00224927,
    0.00252965, 0.00274647, 0.00294705, 0.00301711, 0.00305277,
    0.003003713133159 };

  int32_T c1_i1;
  static real_T c1_dv1[8] = { 422063.0, 577204.0, 840371.0, 1.33005E+6,
    2.10505E+6, 3.69808E+6, 6.36246E+6, 1.0E+7 };

  real_T c1_dv2[8];
  int32_T c1_i2;
  static real_T c1_dv3[8] = { 0.0020475, 0.00224927, 0.00252965, 0.00274647,
    0.00294705, 0.00301711, 0.00305277, 0.003003713133159 };

  real_T c1_dv4[8];
  real_T c1_g_x;
  real_T c1_h_x;
  real_T c1_k_a;
  real_T c1_l_a;
  real_T c1_ak;
  real_T c1_c;
  real_T c1_b_B;
  real_T c1_p_y;
  real_T c1_q_y;
  real_T *c1_b_R;
  real_T *c1_b_T;
  real_T *c1_b_k;
  real_T *c1_b_Z;
  c1_b_R = (real_T *)ssGetOutputPortSignal(chartInstance->S, 2);
  c1_b_k = (real_T *)ssGetInputPortSignal(chartInstance->S, 1);
  c1_b_T = (real_T *)ssGetOutputPortSignal(chartInstance->S, 1);
  c1_b_Z = (real_T *)ssGetInputPortSignal(chartInstance->S, 0);
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  c1_hoistedGlobal = *c1_b_Z;
  c1_b_hoistedGlobal = *c1_b_k;
  c1_Z = c1_hoistedGlobal;
  c1_k = c1_b_hoistedGlobal;
  sf_debug_symbol_scope_push_eml(0U, 30U, 30U, c1_debug_family_names,
    c1_debug_family_var_map);
  sf_debug_symbol_scope_add_eml_importable(&c1_RE, 0U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml(&c1_l, 1U, c1_sf_marshallOut);
  sf_debug_symbol_scope_add_eml(&c1_v, 2U, c1_sf_marshallOut);
  sf_debug_symbol_scope_add_eml_importable(&c1_KK, 3U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml(&c1_K, 4U, c1_sf_marshallOut);
  sf_debug_symbol_scope_add_eml_importable(&c1_C1, 5U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_PP, 6U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_TL, 7U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_PL, 8U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_RL, 9U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_AL, 10U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_ML, 11U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_BT, 12U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_H, 13U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_M1, 14U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_RR, 15U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_MU, 16U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_TS, 17U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_A, 18U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_P, 19U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_RM, 20U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_QM, 21U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_CF, 22U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml(c1_data, 23U, c1_b_sf_marshallOut);
  sf_debug_symbol_scope_add_eml_importable(&c1_nargin, 24U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_nargout, 25U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml(&c1_Z, 26U, c1_sf_marshallOut);
  sf_debug_symbol_scope_add_eml(&c1_k, 27U, c1_sf_marshallOut);
  sf_debug_symbol_scope_add_eml_importable(&c1_T, 28U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c1_R, 29U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 20);
  CV_EML_IF(0, 1, 0, TRUE);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 21);
  c1_RE = rtNaN;
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 22);
  c1_l = 0.0;
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 23);
  c1_v = rtNaN;
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 25);
  c1_KK = 0.0;
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 26);
  c1_K = 34.163195;
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 27);
  c1_C1 = 0.0003048;
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 28);
  c1_T = 1.0;
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 29);
  c1_PP = 0.0;
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 31);
  if (CV_EML_IF(0, 1, 1, c1_k == 0.0)) {
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 32);
    c1_TL = 288.15;
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 33);
    c1_PL = 101325.0;
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 34);
    c1_RL = 1.225;
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 35);
    c1_C1 = 0.001;
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 36);
    c1_AL = 340.294;
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 37);
    c1_ML = 1.7894E-5;
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 38);
    c1_BT = 1.458E-6;
  } else {
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 40);
    c1_TL = 518.67;
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 41);
    c1_PL = 2116.22;
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 42);
    c1_RL = 0.0023769;
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 43);
    c1_AL = 1116.45;
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 44);
    c1_ML = 3.7373E-7;
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 45);
    c1_BT = 3.0450963E-8;
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 48);
  c1_a = c1_C1;
  c1_b = c1_Z;
  c1_y = c1_a * c1_b;
  c1_b_a = c1_C1;
  c1_b_b = c1_Z;
  c1_b_y = c1_b_a * c1_b_b;
  c1_H = c1_mrdivide(chartInstance, c1_y, 1.0 + c1_mrdivide(chartInstance,
    c1_b_y, 6356.766));
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 50);
  if (CV_EML_IF(0, 1, 2, c1_H < 11.0)) {
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 51);
    c1_c_b = c1_H;
    c1_c_y = 6.5 * c1_c_b;
    c1_T = 288.15 - c1_c_y;
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 52);
    c1_PP = c1_mpower(chartInstance, c1_mrdivide(chartInstance, 288.15, c1_T));
  } else {
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 53);
    if (CV_EML_IF(0, 1, 3, c1_H < 20.0)) {
      _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 54);
      c1_T = 216.65;
      _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 55);
      c1_d_b = c1_H - 11.0;
      c1_d_y = -34.163195 * c1_d_b;
      c1_x = c1_mrdivide(chartInstance, c1_d_y, 216.65);
      c1_b_x = c1_x;
      c1_b_x = muDoubleScalarExp(c1_b_x);
      c1_e_b = c1_b_x;
      c1_PP = 0.22336 * c1_e_b;
    } else {
      _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 56);
      if (CV_EML_IF(0, 1, 4, c1_H < 32.0)) {
        _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 57);
        c1_T = 216.65 + (c1_H - 20.0);
        _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 58);
        c1_f_b = c1_b_mpower(chartInstance, c1_mrdivide(chartInstance, 216.65,
          c1_T));
        c1_PP = 0.054032 * c1_f_b;
      } else {
        _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 59);
        if (CV_EML_IF(0, 1, 5, c1_H < 47.0)) {
          _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 60);
          c1_g_b = c1_H - 32.0;
          c1_e_y = 2.8 * c1_g_b;
          c1_T = 228.65 + c1_e_y;
          _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 61);
          c1_h_b = c1_c_mpower(chartInstance, c1_mrdivide(chartInstance, 228.65,
            c1_T));
          c1_PP = 0.0085666 * c1_h_b;
        } else {
          _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 62);
          if (CV_EML_IF(0, 1, 6, c1_H < 51.0)) {
            _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 63);
            c1_T = 270.65;
            _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 64);
            c1_i_b = c1_H - 47.0;
            c1_f_y = -34.163195 * c1_i_b;
            c1_c_x = c1_mrdivide(chartInstance, c1_f_y, 270.65);
            c1_d_x = c1_c_x;
            c1_d_x = muDoubleScalarExp(c1_d_x);
            c1_j_b = c1_d_x;
            c1_PP = 0.0010945 * c1_j_b;
          } else {
            _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 65);
            if (CV_EML_IF(0, 1, 7, c1_H < 71.0)) {
              _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 66);
              c1_k_b = c1_H - 51.0;
              c1_g_y = 2.8 * c1_k_b;
              c1_T = 270.65 - c1_g_y;
              _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 67);
              c1_l_b = c1_d_mpower(chartInstance, c1_mrdivide(chartInstance,
                270.65, c1_T));
              c1_PP = 0.00066063 * c1_l_b;
            } else {
              _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 68);
              if (CV_EML_IF(0, 1, 8, c1_H < 84.852)) {
                _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 69);
                c1_m_b = c1_H - 71.0;
                c1_h_y = 2.0 * c1_m_b;
                c1_T = 214.65 - c1_h_y;
                _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 70);
                c1_n_b = c1_e_mpower(chartInstance, c1_mrdivide(chartInstance,
                  214.65, c1_T));
                c1_PP = 3.9046E-5 * c1_n_b;
              } else {
                _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 73);
                c1_KK = 1.0;
              }
            }
          }
        }
      }
    }
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 76);
  c1_o_b = c1_T;
  c1_i_y = 401.79999999999995 * c1_o_b;
  c1_M1 = c1_i_y;
  c1_b_sqrt(chartInstance, &c1_M1);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 77);
  c1_RR = c1_mrdivide(chartInstance, c1_PP, c1_mrdivide(chartInstance, c1_T,
    288.15));
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 78);
  c1_c_a = c1_BT;
  c1_p_b = c1_f_mpower(chartInstance, c1_T);
  c1_j_y = c1_c_a * c1_p_b;
  c1_MU = c1_mrdivide(chartInstance, c1_j_y, c1_T + 110.4);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 79);
  c1_TS = c1_mrdivide(chartInstance, c1_T, 288.15);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 80);
  c1_d_a = c1_AL;
  c1_q_b = c1_TS;
  c1_b_sqrt(chartInstance, &c1_q_b);
  c1_A = c1_d_a * c1_q_b;
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 81);
  c1_e_a = c1_TL;
  c1_r_b = c1_TS;
  c1_T = c1_e_a * c1_r_b;
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 82);
  c1_f_a = c1_RL;
  c1_s_b = c1_RR;
  c1_R = c1_f_a * c1_s_b;
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 83);
  c1_g_a = c1_PL;
  c1_t_b = c1_PP;
  c1_P = c1_g_a * c1_t_b;
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 84);
  c1_h_a = c1_R;
  c1_u_b = c1_A;
  c1_k_y = c1_h_a * c1_u_b;
  c1_RM = c1_mrdivide(chartInstance, c1_k_y, c1_MU);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 85);
  c1_v_b = c1_P;
  c1_QM = 0.7 * c1_v_b;
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 86);
  c1_i_a = c1_R;
  c1_l_y = c1_i_a * rtNaN;
  c1_j_a = c1_l_y;
  c1_m_y = c1_j_a * 0.0;
  c1_RE = c1_mrdivide(chartInstance, c1_m_y, c1_MU);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 87);
  if (CV_EML_IF(0, 1, 9, c1_RE == 0.0)) {
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 88);
    c1_CF = 0.0;
  } else {
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 89);
    if (CV_EML_IF(0, 1, 10, c1_RE < 527307.96034905966)) {
      _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 90);
      c1_e_x = c1_RE;
      c1_f_x = c1_e_x;
      if (c1_f_x < 0.0) {
        c1_b_eml_error(chartInstance);
      }

      c1_f_x = muDoubleScalarSqrt(c1_f_x);
      c1_B = c1_f_x;
      c1_n_y = c1_B;
      c1_o_y = c1_n_y;
      c1_CF = 1.328 / c1_o_y;
    } else {
      _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 91);
      if (CV_EML_IF(0, 1, 11, c1_RE < 1.0E+7)) {
        _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 92);
        for (c1_i0 = 0; c1_i0 < 16; c1_i0++) {
          c1_data[c1_i0] = c1_dv0[c1_i0];
        }

        _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 100);
        for (c1_i1 = 0; c1_i1 < 8; c1_i1++) {
          c1_dv2[c1_i1] = c1_dv1[c1_i1];
        }

        for (c1_i2 = 0; c1_i2 < 8; c1_i2++) {
          c1_dv4[c1_i2] = c1_dv3[c1_i2];
        }

        c1_CF = c1_interp1(chartInstance, c1_dv2, c1_dv4, c1_RE);
      } else {
        _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 103);
        c1_g_x = c1_RE;
        c1_h_x = c1_g_x;
        if (c1_h_x < 0.0) {
          c1_e_eml_error(chartInstance);
        }

        c1_h_x = muDoubleScalarLog10(c1_h_x);
        c1_k_a = c1_h_x;
        c1_l_a = c1_k_a;
        c1_eml_scalar_eg(chartInstance);
        c1_ak = c1_l_a;
        if (c1_ak < 0.0) {
          c1_eml_error(chartInstance);
        }

        c1_c = muDoubleScalarPower(c1_ak, 2.58);
        c1_b_B = c1_c;
        c1_p_y = c1_b_B;
        c1_q_y = c1_p_y;
        c1_CF = 0.455 / c1_q_y;
      }
    }
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, -103);
  sf_debug_symbol_scope_pop();
  *c1_b_T = c1_T;
  *c1_b_R = c1_R;
  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
}

static void initSimStructsc1_mainSim(SFc1_mainSimInstanceStruct *chartInstance)
{
}

static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber)
{
}

static const mxArray *c1_sf_marshallOut(void *chartInstanceVoid, void *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  real_T c1_u;
  const mxArray *c1_y = NULL;
  SFc1_mainSimInstanceStruct *chartInstance;
  chartInstance = (SFc1_mainSimInstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_u = *(real_T *)c1_inData;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", &c1_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, FALSE);
  return c1_mxArrayOutData;
}

static real_T c1_emlrt_marshallIn(SFc1_mainSimInstanceStruct *chartInstance,
  const mxArray *c1_R, const char_T *c1_identifier)
{
  real_T c1_y;
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_y = c1_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_R), &c1_thisId);
  sf_mex_destroy(&c1_R);
  return c1_y;
}

static real_T c1_b_emlrt_marshallIn(SFc1_mainSimInstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  real_T c1_y;
  real_T c1_d0;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_d0, 1, 0, 0U, 0, 0U, 0);
  c1_y = c1_d0;
  sf_mex_destroy(&c1_u);
  return c1_y;
}

static void c1_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_R;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  real_T c1_y;
  SFc1_mainSimInstanceStruct *chartInstance;
  chartInstance = (SFc1_mainSimInstanceStruct *)chartInstanceVoid;
  c1_R = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_y = c1_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_R), &c1_thisId);
  sf_mex_destroy(&c1_R);
  *(real_T *)c1_outData = c1_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

static const mxArray *c1_b_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  int32_T c1_i3;
  int32_T c1_i4;
  int32_T c1_i5;
  real_T c1_b_inData[16];
  int32_T c1_i6;
  int32_T c1_i7;
  int32_T c1_i8;
  real_T c1_u[16];
  const mxArray *c1_y = NULL;
  SFc1_mainSimInstanceStruct *chartInstance;
  chartInstance = (SFc1_mainSimInstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_i3 = 0;
  for (c1_i4 = 0; c1_i4 < 2; c1_i4++) {
    for (c1_i5 = 0; c1_i5 < 8; c1_i5++) {
      c1_b_inData[c1_i5 + c1_i3] = (*(real_T (*)[16])c1_inData)[c1_i5 + c1_i3];
    }

    c1_i3 += 8;
  }

  c1_i6 = 0;
  for (c1_i7 = 0; c1_i7 < 2; c1_i7++) {
    for (c1_i8 = 0; c1_i8 < 8; c1_i8++) {
      c1_u[c1_i8 + c1_i6] = c1_b_inData[c1_i8 + c1_i6];
    }

    c1_i6 += 8;
  }

  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", c1_u, 0, 0U, 1U, 0U, 2, 8, 2), FALSE);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, FALSE);
  return c1_mxArrayOutData;
}

const mxArray *sf_c1_mainSim_get_eml_resolved_functions_info(void)
{
  const mxArray *c1_nameCaptureInfo;
  c1_ResolvedFunctionInfo c1_info[32];
  const mxArray *c1_m0 = NULL;
  int32_T c1_i9;
  c1_ResolvedFunctionInfo *c1_r0;
  c1_nameCaptureInfo = NULL;
  c1_nameCaptureInfo = NULL;
  c1_info_helper(c1_info);
  sf_mex_assign(&c1_m0, sf_mex_createstruct("nameCaptureInfo", 1, 32), FALSE);
  for (c1_i9 = 0; c1_i9 < 32; c1_i9++) {
    c1_r0 = &c1_info[c1_i9];
    sf_mex_addfield(c1_m0, sf_mex_create("nameCaptureInfo", c1_r0->context, 15,
      0U, 0U, 0U, 2, 1, strlen(c1_r0->context)), "context", "nameCaptureInfo",
                    c1_i9);
    sf_mex_addfield(c1_m0, sf_mex_create("nameCaptureInfo", c1_r0->name, 15, 0U,
      0U, 0U, 2, 1, strlen(c1_r0->name)), "name", "nameCaptureInfo", c1_i9);
    sf_mex_addfield(c1_m0, sf_mex_create("nameCaptureInfo", c1_r0->dominantType,
      15, 0U, 0U, 0U, 2, 1, strlen(c1_r0->dominantType)), "dominantType",
                    "nameCaptureInfo", c1_i9);
    sf_mex_addfield(c1_m0, sf_mex_create("nameCaptureInfo", c1_r0->resolved, 15,
      0U, 0U, 0U, 2, 1, strlen(c1_r0->resolved)), "resolved", "nameCaptureInfo",
                    c1_i9);
    sf_mex_addfield(c1_m0, sf_mex_create("nameCaptureInfo", &c1_r0->fileTimeLo,
      7, 0U, 0U, 0U, 0), "fileTimeLo", "nameCaptureInfo", c1_i9);
    sf_mex_addfield(c1_m0, sf_mex_create("nameCaptureInfo", &c1_r0->fileTimeHi,
      7, 0U, 0U, 0U, 0), "fileTimeHi", "nameCaptureInfo", c1_i9);
    sf_mex_addfield(c1_m0, sf_mex_create("nameCaptureInfo", &c1_r0->mFileTimeLo,
      7, 0U, 0U, 0U, 0), "mFileTimeLo", "nameCaptureInfo", c1_i9);
    sf_mex_addfield(c1_m0, sf_mex_create("nameCaptureInfo", &c1_r0->mFileTimeHi,
      7, 0U, 0U, 0U, 0), "mFileTimeHi", "nameCaptureInfo", c1_i9);
  }

  sf_mex_assign(&c1_nameCaptureInfo, c1_m0, FALSE);
  return c1_nameCaptureInfo;
}

static void c1_info_helper(c1_ResolvedFunctionInfo c1_info[32])
{
  c1_info[0].context = "";
  c1_info[0].name = "mtimes";
  c1_info[0].dominantType = "double";
  c1_info[0].resolved = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c1_info[0].fileTimeLo = 1289552092U;
  c1_info[0].fileTimeHi = 0U;
  c1_info[0].mFileTimeLo = 0U;
  c1_info[0].mFileTimeHi = 0U;
  c1_info[1].context = "";
  c1_info[1].name = "mrdivide";
  c1_info[1].dominantType = "double";
  c1_info[1].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.p";
  c1_info[1].fileTimeLo = 1310169856U;
  c1_info[1].fileTimeHi = 0U;
  c1_info[1].mFileTimeLo = 1289552092U;
  c1_info[1].mFileTimeHi = 0U;
  c1_info[2].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.p";
  c1_info[2].name = "rdivide";
  c1_info[2].dominantType = "double";
  c1_info[2].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m";
  c1_info[2].fileTimeLo = 1286851244U;
  c1_info[2].fileTimeHi = 0U;
  c1_info[2].mFileTimeLo = 0U;
  c1_info[2].mFileTimeHi = 0U;
  c1_info[3].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m";
  c1_info[3].name = "eml_div";
  c1_info[3].dominantType = "double";
  c1_info[3].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_div.m";
  c1_info[3].fileTimeLo = 1305350400U;
  c1_info[3].fileTimeHi = 0U;
  c1_info[3].mFileTimeLo = 0U;
  c1_info[3].mFileTimeHi = 0U;
  c1_info[4].context = "";
  c1_info[4].name = "mpower";
  c1_info[4].dominantType = "double";
  c1_info[4].resolved = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mpower.m";
  c1_info[4].fileTimeLo = 1286851242U;
  c1_info[4].fileTimeHi = 0U;
  c1_info[4].mFileTimeLo = 0U;
  c1_info[4].mFileTimeHi = 0U;
  c1_info[5].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mpower.m";
  c1_info[5].name = "power";
  c1_info[5].dominantType = "double";
  c1_info[5].resolved = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m";
  c1_info[5].fileTimeLo = 1294100344U;
  c1_info[5].fileTimeHi = 0U;
  c1_info[5].mFileTimeLo = 0U;
  c1_info[5].mFileTimeHi = 0U;
  c1_info[6].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m";
  c1_info[6].name = "eml_scalar_eg";
  c1_info[6].dominantType = "double";
  c1_info[6].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m";
  c1_info[6].fileTimeLo = 1286851196U;
  c1_info[6].fileTimeHi = 0U;
  c1_info[6].mFileTimeLo = 0U;
  c1_info[6].mFileTimeHi = 0U;
  c1_info[7].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m";
  c1_info[7].name = "eml_scalexp_alloc";
  c1_info[7].dominantType = "double";
  c1_info[7].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalexp_alloc.m";
  c1_info[7].fileTimeLo = 1286851196U;
  c1_info[7].fileTimeHi = 0U;
  c1_info[7].mFileTimeLo = 0U;
  c1_info[7].mFileTimeHi = 0U;
  c1_info[8].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m";
  c1_info[8].name = "eml_scalar_floor";
  c1_info[8].dominantType = "double";
  c1_info[8].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_floor.m";
  c1_info[8].fileTimeLo = 1286851126U;
  c1_info[8].fileTimeHi = 0U;
  c1_info[8].mFileTimeLo = 0U;
  c1_info[8].mFileTimeHi = 0U;
  c1_info[9].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m";
  c1_info[9].name = "eml_error";
  c1_info[9].dominantType = "char";
  c1_info[9].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_error.m";
  c1_info[9].fileTimeLo = 1305350400U;
  c1_info[9].fileTimeHi = 0U;
  c1_info[9].mFileTimeLo = 0U;
  c1_info[9].mFileTimeHi = 0U;
  c1_info[10].context = "";
  c1_info[10].name = "exp";
  c1_info[10].dominantType = "double";
  c1_info[10].resolved = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/exp.m";
  c1_info[10].fileTimeLo = 1286851140U;
  c1_info[10].fileTimeHi = 0U;
  c1_info[10].mFileTimeLo = 0U;
  c1_info[10].mFileTimeHi = 0U;
  c1_info[11].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/exp.m";
  c1_info[11].name = "eml_scalar_exp";
  c1_info[11].dominantType = "double";
  c1_info[11].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_exp.m";
  c1_info[11].fileTimeLo = 1301360864U;
  c1_info[11].fileTimeHi = 0U;
  c1_info[11].mFileTimeLo = 0U;
  c1_info[11].mFileTimeHi = 0U;
  c1_info[12].context = "";
  c1_info[12].name = "sqrt";
  c1_info[12].dominantType = "double";
  c1_info[12].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sqrt.m";
  c1_info[12].fileTimeLo = 1286851152U;
  c1_info[12].fileTimeHi = 0U;
  c1_info[12].mFileTimeLo = 0U;
  c1_info[12].mFileTimeHi = 0U;
  c1_info[13].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sqrt.m";
  c1_info[13].name = "eml_scalar_sqrt";
  c1_info[13].dominantType = "double";
  c1_info[13].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_sqrt.m";
  c1_info[13].fileTimeLo = 1286851138U;
  c1_info[13].fileTimeHi = 0U;
  c1_info[13].mFileTimeLo = 0U;
  c1_info[13].mFileTimeHi = 0U;
  c1_info[14].context = "";
  c1_info[14].name = "interp1";
  c1_info[14].dominantType = "double";
  c1_info[14].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/polyfun/interp1.m";
  c1_info[14].fileTimeLo = 1289552090U;
  c1_info[14].fileTimeHi = 0U;
  c1_info[14].mFileTimeLo = 0U;
  c1_info[14].mFileTimeHi = 0U;
  c1_info[15].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/polyfun/interp1.m";
  c1_info[15].name = "eml_guarded_nan";
  c1_info[15].dominantType = "";
  c1_info[15].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_guarded_nan.m";
  c1_info[15].fileTimeLo = 1286851176U;
  c1_info[15].fileTimeHi = 0U;
  c1_info[15].mFileTimeLo = 0U;
  c1_info[15].mFileTimeHi = 0U;
  c1_info[16].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/polyfun/interp1.m!interp1_work";
  c1_info[16].name = "eml_index_class";
  c1_info[16].dominantType = "";
  c1_info[16].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_index_class.m";
  c1_info[16].fileTimeLo = 1286851178U;
  c1_info[16].fileTimeHi = 0U;
  c1_info[16].mFileTimeLo = 0U;
  c1_info[16].mFileTimeHi = 0U;
  c1_info[17].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/polyfun/interp1.m!interp1_work";
  c1_info[17].name = "eml_size_prod";
  c1_info[17].dominantType = "int32";
  c1_info[17].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_size_prod.m";
  c1_info[17].fileTimeLo = 1286851198U;
  c1_info[17].fileTimeHi = 0U;
  c1_info[17].mFileTimeLo = 0U;
  c1_info[17].mFileTimeHi = 0U;
  c1_info[18].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_size_prod.m";
  c1_info[18].name = "eml_index_times";
  c1_info[18].dominantType = "int32";
  c1_info[18].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_index_times.m";
  c1_info[18].fileTimeLo = 1286851180U;
  c1_info[18].fileTimeHi = 0U;
  c1_info[18].mFileTimeLo = 0U;
  c1_info[18].mFileTimeHi = 0U;
  c1_info[19].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/polyfun/interp1.m!interp1_work";
  c1_info[19].name = "isnan";
  c1_info[19].dominantType = "double";
  c1_info[19].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/isnan.m";
  c1_info[19].fileTimeLo = 1286851160U;
  c1_info[19].fileTimeHi = 0U;
  c1_info[19].mFileTimeLo = 0U;
  c1_info[19].mFileTimeHi = 0U;
  c1_info[20].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/polyfun/interp1.m!interp1_work";
  c1_info[20].name = "flipdim";
  c1_info[20].dominantType = "double";
  c1_info[20].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/flipdim.m";
  c1_info[20].fileTimeLo = 1286851088U;
  c1_info[20].fileTimeHi = 0U;
  c1_info[20].mFileTimeLo = 0U;
  c1_info[20].mFileTimeHi = 0U;
  c1_info[21].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/flipdim.m";
  c1_info[21].name = "eml_assert_valid_dim";
  c1_info[21].dominantType = "double";
  c1_info[21].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_assert_valid_dim.m";
  c1_info[21].fileTimeLo = 1286851094U;
  c1_info[21].fileTimeHi = 0U;
  c1_info[21].mFileTimeLo = 0U;
  c1_info[21].mFileTimeHi = 0U;
  c1_info[22].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_assert_valid_dim.m";
  c1_info[22].name = "intmax";
  c1_info[22].dominantType = "char";
  c1_info[22].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/intmax.m";
  c1_info[22].fileTimeLo = 1286851156U;
  c1_info[22].fileTimeHi = 0U;
  c1_info[22].mFileTimeLo = 0U;
  c1_info[22].mFileTimeHi = 0U;
  c1_info[23].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/flipdim.m";
  c1_info[23].name = "eml_matrix_vstride";
  c1_info[23].dominantType = "double";
  c1_info[23].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_matrix_vstride.m";
  c1_info[23].fileTimeLo = 1286851188U;
  c1_info[23].fileTimeHi = 0U;
  c1_info[23].mFileTimeLo = 0U;
  c1_info[23].mFileTimeHi = 0U;
  c1_info[24].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_matrix_vstride.m";
  c1_info[24].name = "eml_index_minus";
  c1_info[24].dominantType = "double";
  c1_info[24].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_index_minus.m";
  c1_info[24].fileTimeLo = 1286851178U;
  c1_info[24].fileTimeHi = 0U;
  c1_info[24].mFileTimeLo = 0U;
  c1_info[24].mFileTimeHi = 0U;
  c1_info[25].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/flipdim.m";
  c1_info[25].name = "eml_matrix_npages";
  c1_info[25].dominantType = "double";
  c1_info[25].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_matrix_npages.m";
  c1_info[25].fileTimeLo = 1286851186U;
  c1_info[25].fileTimeHi = 0U;
  c1_info[25].mFileTimeLo = 0U;
  c1_info[25].mFileTimeHi = 0U;
  c1_info[26].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_matrix_npages.m";
  c1_info[26].name = "eml_index_plus";
  c1_info[26].dominantType = "double";
  c1_info[26].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_index_plus.m";
  c1_info[26].fileTimeLo = 1286851178U;
  c1_info[26].fileTimeHi = 0U;
  c1_info[26].mFileTimeLo = 0U;
  c1_info[26].mFileTimeHi = 0U;
  c1_info[27].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/polyfun/interp1.m!interp1_work";
  c1_info[27].name = "eml_bsearch";
  c1_info[27].dominantType = "double";
  c1_info[27].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_bsearch.m";
  c1_info[27].fileTimeLo = 1286851096U;
  c1_info[27].fileTimeHi = 0U;
  c1_info[27].mFileTimeLo = 0U;
  c1_info[27].mFileTimeHi = 0U;
  c1_info[28].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_bsearch.m";
  c1_info[28].name = "eml_unsigned_class";
  c1_info[28].dominantType = "char";
  c1_info[28].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_unsigned_class.m";
  c1_info[28].fileTimeLo = 1286851200U;
  c1_info[28].fileTimeHi = 0U;
  c1_info[28].mFileTimeLo = 0U;
  c1_info[28].mFileTimeHi = 0U;
  c1_info[29].context = "";
  c1_info[29].name = "log10";
  c1_info[29].dominantType = "double";
  c1_info[29].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/log10.m";
  c1_info[29].fileTimeLo = 1286851144U;
  c1_info[29].fileTimeHi = 0U;
  c1_info[29].mFileTimeLo = 0U;
  c1_info[29].mFileTimeHi = 0U;
  c1_info[30].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/log10.m";
  c1_info[30].name = "eml_scalar_log10";
  c1_info[30].dominantType = "double";
  c1_info[30].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_log10.m";
  c1_info[30].fileTimeLo = 1286851128U;
  c1_info[30].fileTimeHi = 0U;
  c1_info[30].mFileTimeLo = 0U;
  c1_info[30].mFileTimeHi = 0U;
  c1_info[31].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_log10.m";
  c1_info[31].name = "realmax";
  c1_info[31].dominantType = "char";
  c1_info[31].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/realmax.m";
  c1_info[31].fileTimeLo = 1286851166U;
  c1_info[31].fileTimeHi = 0U;
  c1_info[31].mFileTimeLo = 0U;
  c1_info[31].mFileTimeHi = 0U;
}

static real_T c1_mrdivide(SFc1_mainSimInstanceStruct *chartInstance, real_T c1_A,
  real_T c1_B)
{
  real_T c1_x;
  real_T c1_b_y;
  real_T c1_b_x;
  real_T c1_c_y;
  c1_x = c1_A;
  c1_b_y = c1_B;
  c1_b_x = c1_x;
  c1_c_y = c1_b_y;
  return c1_b_x / c1_c_y;
}

static real_T c1_mpower(SFc1_mainSimInstanceStruct *chartInstance, real_T c1_a)
{
  real_T c1_b_a;
  real_T c1_ak;
  c1_b_a = c1_a;
  c1_eml_scalar_eg(chartInstance);
  c1_ak = c1_b_a;
  if (c1_ak < 0.0) {
    c1_eml_error(chartInstance);
  }

  return muDoubleScalarPower(c1_ak, -5.2558761538461543);
}

static void c1_eml_scalar_eg(SFc1_mainSimInstanceStruct *chartInstance)
{
}

static void c1_eml_error(SFc1_mainSimInstanceStruct *chartInstance)
{
  int32_T c1_i10;
  static char_T c1_varargin_1[31] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o',
    'o', 'l', 'b', 'o', 'x', ':', 'p', 'o', 'w', 'e', 'r', '_', 'd', 'o', 'm',
    'a', 'i', 'n', 'E', 'r', 'r', 'o', 'r' };

  char_T c1_u[31];
  const mxArray *c1_y = NULL;
  for (c1_i10 = 0; c1_i10 < 31; c1_i10++) {
    c1_u[c1_i10] = c1_varargin_1[c1_i10];
  }

  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", c1_u, 10, 0U, 1U, 0U, 2, 1, 31), FALSE);
  sf_mex_call_debug("error", 0U, 1U, 14, sf_mex_call_debug("message", 1U, 1U, 14,
    c1_y));
}

static real_T c1_b_mpower(SFc1_mainSimInstanceStruct *chartInstance, real_T c1_a)
{
  real_T c1_b_a;
  real_T c1_ak;
  c1_b_a = c1_a;
  c1_eml_scalar_eg(chartInstance);
  c1_ak = c1_b_a;
  if (c1_ak < 0.0) {
    c1_eml_error(chartInstance);
  }

  return muDoubleScalarPower(c1_ak, 34.163195);
}

static real_T c1_c_mpower(SFc1_mainSimInstanceStruct *chartInstance, real_T c1_a)
{
  real_T c1_b_a;
  real_T c1_ak;
  c1_b_a = c1_a;
  c1_eml_scalar_eg(chartInstance);
  c1_ak = c1_b_a;
  if (c1_ak < 0.0) {
    c1_eml_error(chartInstance);
  }

  return muDoubleScalarPower(c1_ak, 12.201141071428573);
}

static real_T c1_d_mpower(SFc1_mainSimInstanceStruct *chartInstance, real_T c1_a)
{
  real_T c1_b_a;
  real_T c1_ak;
  c1_b_a = c1_a;
  c1_eml_scalar_eg(chartInstance);
  c1_ak = c1_b_a;
  if (c1_ak < 0.0) {
    c1_eml_error(chartInstance);
  }

  return muDoubleScalarPower(c1_ak, -12.201141071428573);
}

static real_T c1_e_mpower(SFc1_mainSimInstanceStruct *chartInstance, real_T c1_a)
{
  real_T c1_b_a;
  real_T c1_ak;
  c1_b_a = c1_a;
  c1_eml_scalar_eg(chartInstance);
  c1_ak = c1_b_a;
  if (c1_ak < 0.0) {
    c1_eml_error(chartInstance);
  }

  return muDoubleScalarPower(c1_ak, -17.0815975);
}

static real_T c1_sqrt(SFc1_mainSimInstanceStruct *chartInstance, real_T c1_x)
{
  real_T c1_b_x;
  c1_b_x = c1_x;
  c1_b_sqrt(chartInstance, &c1_b_x);
  return c1_b_x;
}

static void c1_b_eml_error(SFc1_mainSimInstanceStruct *chartInstance)
{
  int32_T c1_i11;
  static char_T c1_varargin_1[30] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o',
    'o', 'l', 'b', 'o', 'x', ':', 's', 'q', 'r', 't', '_', 'd', 'o', 'm', 'a',
    'i', 'n', 'E', 'r', 'r', 'o', 'r' };

  char_T c1_u[30];
  const mxArray *c1_y = NULL;
  for (c1_i11 = 0; c1_i11 < 30; c1_i11++) {
    c1_u[c1_i11] = c1_varargin_1[c1_i11];
  }

  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", c1_u, 10, 0U, 1U, 0U, 2, 1, 30), FALSE);
  sf_mex_call_debug("error", 0U, 1U, 14, sf_mex_call_debug("message", 1U, 1U, 14,
    c1_y));
}

static real_T c1_f_mpower(SFc1_mainSimInstanceStruct *chartInstance, real_T c1_a)
{
  real_T c1_b_a;
  real_T c1_ak;
  c1_b_a = c1_a;
  c1_eml_scalar_eg(chartInstance);
  c1_ak = c1_b_a;
  if (c1_ak < 0.0) {
    c1_eml_error(chartInstance);
  }

  return muDoubleScalarPower(c1_ak, 1.5);
}

static real_T c1_interp1(SFc1_mainSimInstanceStruct *chartInstance, real_T
  c1_varargin_1[8], real_T c1_varargin_2[8], real_T c1_varargin_3)
{
  real_T c1_yi;
  int32_T c1_i12;
  real_T c1_y[8];
  real_T c1_xi;
  int32_T c1_i13;
  real_T c1_x[8];
  int32_T c1_k;
  int32_T c1_b_k;
  real_T c1_b_x;
  boolean_T c1_b;
  int32_T c1_i14;
  real_T c1_c_x[8];
  int32_T c1_i15;
  int32_T c1_ixleft;
  int32_T c1_ixright;
  real_T c1_tmp;
  int32_T c1_a;
  int32_T c1_b_a;
  int32_T c1_c_k;
  int32_T c1_q0;
  int32_T c1_q1;
  int32_T c1_qY;
  real_T c1_xlo;
  real_T c1_xhi;
  int32_T c1_n;
  real_T c1_b_xi;
  uint32_T c1_low_i;
  uint32_T c1_low_ip1;
  uint32_T c1_high_i;
  uint32_T c1_b_low_i;
  uint32_T c1_b_high_i;
  uint32_T c1_mid_i;
  uint32_T c1_u0;
  real_T c1_xn;
  int32_T c1_c_a;
  int32_T c1_c;
  real_T c1_r;
  int32_T c1_iy;
  int32_T c1_d_a;
  int32_T c1_b_c;
  real_T c1_e_a;
  real_T c1_b_b;
  real_T c1_b_y;
  int32_T exitg1;
  for (c1_i12 = 0; c1_i12 < 8; c1_i12++) {
    c1_y[c1_i12] = c1_varargin_2[c1_i12];
  }

  c1_xi = c1_varargin_3;
  for (c1_i13 = 0; c1_i13 < 8; c1_i13++) {
    c1_x[c1_i13] = c1_varargin_1[c1_i13];
  }

  c1_yi = rtNaN;
  c1_k = 1;
  do {
    exitg1 = 0U;
    if (c1_k < 9) {
      c1_b_k = c1_k;
      c1_b_x = c1_x[_SFD_EML_ARRAY_BOUNDS_CHECK("", (int32_T)_SFD_INTEGER_CHECK(
        "", (real_T)c1_b_k), 1, 8, 1, 0) - 1];
      c1_b = muDoubleScalarIsNaN(c1_b_x);
      if (c1_b) {
        c1_c_eml_error(chartInstance);
        exitg1 = 1U;
      } else {
        c1_k++;
      }
    } else {
      if (c1_x[1] < c1_x[0]) {
        for (c1_i14 = 0; c1_i14 < 8; c1_i14++) {
          c1_c_x[c1_i14] = c1_x[7 - c1_i14];
        }

        for (c1_i15 = 0; c1_i15 < 8; c1_i15++) {
          c1_x[c1_i15] = c1_c_x[c1_i15];
        }

        c1_ixleft = 1;
        c1_ixright = 8;
        while (c1_ixleft < c1_ixright) {
          c1_tmp = c1_y[_SFD_EML_ARRAY_BOUNDS_CHECK("", (int32_T)
            _SFD_INTEGER_CHECK("", (real_T)c1_ixleft), 1, 8, 1, 0) - 1];
          c1_y[_SFD_EML_ARRAY_BOUNDS_CHECK("", (int32_T)_SFD_INTEGER_CHECK("",
            (real_T)c1_ixleft), 1, 8, 1, 0) - 1] =
            c1_y[_SFD_EML_ARRAY_BOUNDS_CHECK("", (int32_T)_SFD_INTEGER_CHECK("",
            (real_T)c1_ixright), 1, 8, 1, 0) - 1];
          c1_y[_SFD_EML_ARRAY_BOUNDS_CHECK("", (int32_T)_SFD_INTEGER_CHECK("",
            (real_T)c1_ixright), 1, 8, 1, 0) - 1] = c1_tmp;
          c1_a = c1_ixleft + 1;
          c1_ixleft = c1_a;
          c1_b_a = c1_ixright - 1;
          c1_ixright = c1_b_a;
        }
      }

      for (c1_c_k = 2; c1_c_k < 9; c1_c_k++) {
        c1_b_k = c1_c_k;
        c1_q0 = c1_b_k;
        c1_q1 = 1;
        c1_qY = c1_q0 - c1_q1;
        if ((c1_q0 < 0) && ((c1_q1 >= 0) && (c1_qY >= 0))) {
          c1_qY = MIN_int32_T;
        } else {
          if ((c1_q0 >= 0) && ((c1_q1 < 0) && (c1_qY < 0))) {
            c1_qY = MAX_int32_T;
          }
        }

        if (c1_x[_SFD_EML_ARRAY_BOUNDS_CHECK("", (int32_T)_SFD_INTEGER_CHECK("",
              (real_T)c1_b_k), 1, 8, 1, 0) - 1] <=
            c1_x[_SFD_EML_ARRAY_BOUNDS_CHECK("", (int32_T)_SFD_INTEGER_CHECK("",
              (real_T)c1_qY), 1, 8, 1, 0) - 1]) {
          c1_d_eml_error(chartInstance);
        }
      }

      c1_xlo = c1_x[0];
      c1_xhi = c1_x[7];
      c1_n = 0;
      if (c1_xi > c1_xhi) {
      } else if (c1_xi < c1_xlo) {
      } else {
        c1_b_xi = c1_xi;
        c1_low_i = 1U;
        c1_low_ip1 = 1U;
        c1_high_i = 8U;
        while (c1_high_i > c1_low_ip1 + 1U) {
          c1_b_low_i = c1_low_i;
          c1_b_high_i = c1_high_i;
          c1_mid_i = (c1_b_low_i + c1_b_high_i) >> 1U;
          if (c1_b_xi >= c1_x[(int32_T)(uint32_T)_SFD_EML_ARRAY_BOUNDS_CHECK("",
               (int32_T)(uint32_T)_SFD_INTEGER_CHECK("", (real_T)c1_mid_i), 1, 8,
               1, 0) - 1]) {
            c1_low_i = c1_mid_i;
            c1_low_ip1 = c1_low_i;
          } else {
            c1_high_i = c1_mid_i;
          }
        }

        c1_u0 = c1_low_i;
        if (c1_u0 > 2147483647U) {
          c1_u0 = 2147483647U;
        }

        c1_n = (int32_T)c1_u0;
        c1_xn = c1_x[_SFD_EML_ARRAY_BOUNDS_CHECK("", (int32_T)_SFD_INTEGER_CHECK
          ("", (real_T)c1_n), 1, 8, 1, 0) - 1];
        c1_c_a = c1_n;
        c1_c = c1_c_a;
        c1_r = (c1_xi - c1_xn) / (c1_x[_SFD_EML_ARRAY_BOUNDS_CHECK("", (int32_T)
          _SFD_INTEGER_CHECK("", (real_T)(c1_c + 1)), 1, 8, 1, 0) - 1] - c1_xn);
      }

      if (c1_n > 0) {
        c1_iy = c1_n;
        c1_d_a = c1_iy;
        c1_b_c = c1_d_a;
        c1_e_a = c1_r;
        c1_b_b = c1_y[_SFD_EML_ARRAY_BOUNDS_CHECK("", (int32_T)
          _SFD_INTEGER_CHECK("", (real_T)(c1_b_c + 1)), 1, 8, 1, 0) - 1] -
          c1_y[_SFD_EML_ARRAY_BOUNDS_CHECK("", (int32_T)_SFD_INTEGER_CHECK("",
          (real_T)c1_iy), 1, 8, 1, 0) - 1];
        c1_b_y = c1_e_a * c1_b_b;
        c1_yi = c1_y[_SFD_EML_ARRAY_BOUNDS_CHECK("", (int32_T)_SFD_INTEGER_CHECK
          ("", (real_T)c1_iy), 1, 8, 1, 0) - 1] + c1_b_y;
      }

      exitg1 = 1U;
    }
  } while (exitg1 == 0U);

  return c1_yi;
}

static void c1_c_eml_error(SFc1_mainSimInstanceStruct *chartInstance)
{
  int32_T c1_i16;
  static char_T c1_varargin_1[21] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 'i',
    'n', 't', 'e', 'r', 'p', '1', ':', 'N', 'a', 'N', 'i', 'n', 'X' };

  char_T c1_u[21];
  const mxArray *c1_y = NULL;
  for (c1_i16 = 0; c1_i16 < 21; c1_i16++) {
    c1_u[c1_i16] = c1_varargin_1[c1_i16];
  }

  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", c1_u, 10, 0U, 1U, 0U, 2, 1, 21), FALSE);
  sf_mex_call_debug("error", 0U, 1U, 14, sf_mex_call_debug("message", 1U, 1U, 14,
    c1_y));
}

static void c1_d_eml_error(SFc1_mainSimInstanceStruct *chartInstance)
{
  int32_T c1_i17;
  static char_T c1_varargin_1[35] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o',
    'o', 'l', 'b', 'o', 'x', ':', 'i', 'n', 't', 'e', 'r', 'p', '1', '_', 'n',
    'o', 'n', 'M', 'o', 'n', 'o', 't', 'o', 'n', 'i', 'c', 'X' };

  char_T c1_u[35];
  const mxArray *c1_y = NULL;
  for (c1_i17 = 0; c1_i17 < 35; c1_i17++) {
    c1_u[c1_i17] = c1_varargin_1[c1_i17];
  }

  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", c1_u, 10, 0U, 1U, 0U, 2, 1, 35), FALSE);
  sf_mex_call_debug("error", 0U, 1U, 14, sf_mex_call_debug("message", 1U, 1U, 14,
    c1_y));
}

static void c1_e_eml_error(SFc1_mainSimInstanceStruct *chartInstance)
{
  int32_T c1_i18;
  static char_T c1_varargin_1[31] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o',
    'o', 'l', 'b', 'o', 'x', ':', 'l', 'o', 'g', '1', '0', '_', 'd', 'o', 'm',
    'a', 'i', 'n', 'E', 'r', 'r', 'o', 'r' };

  char_T c1_u[31];
  const mxArray *c1_y = NULL;
  for (c1_i18 = 0; c1_i18 < 31; c1_i18++) {
    c1_u[c1_i18] = c1_varargin_1[c1_i18];
  }

  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", c1_u, 10, 0U, 1U, 0U, 2, 1, 31), FALSE);
  sf_mex_call_debug("error", 0U, 1U, 14, sf_mex_call_debug("message", 1U, 1U, 14,
    c1_y));
}

static const mxArray *c1_c_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  int32_T c1_u;
  const mxArray *c1_y = NULL;
  SFc1_mainSimInstanceStruct *chartInstance;
  chartInstance = (SFc1_mainSimInstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_u = *(int32_T *)c1_inData;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", &c1_u, 6, 0U, 0U, 0U, 0), FALSE);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, FALSE);
  return c1_mxArrayOutData;
}

static int32_T c1_c_emlrt_marshallIn(SFc1_mainSimInstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  int32_T c1_y;
  int32_T c1_i19;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_i19, 1, 6, 0U, 0, 0U, 0);
  c1_y = c1_i19;
  sf_mex_destroy(&c1_u);
  return c1_y;
}

static void c1_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_b_sfEvent;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  int32_T c1_y;
  SFc1_mainSimInstanceStruct *chartInstance;
  chartInstance = (SFc1_mainSimInstanceStruct *)chartInstanceVoid;
  c1_b_sfEvent = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_y = c1_c_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_sfEvent),
    &c1_thisId);
  sf_mex_destroy(&c1_b_sfEvent);
  *(int32_T *)c1_outData = c1_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

static uint8_T c1_d_emlrt_marshallIn(SFc1_mainSimInstanceStruct *chartInstance,
  const mxArray *c1_b_is_active_c1_mainSim, const char_T *c1_identifier)
{
  uint8_T c1_y;
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_y = c1_e_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c1_b_is_active_c1_mainSim), &c1_thisId);
  sf_mex_destroy(&c1_b_is_active_c1_mainSim);
  return c1_y;
}

static uint8_T c1_e_emlrt_marshallIn(SFc1_mainSimInstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  uint8_T c1_y;
  uint8_T c1_u1;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_u1, 1, 3, 0U, 0, 0U, 0);
  c1_y = c1_u1;
  sf_mex_destroy(&c1_u);
  return c1_y;
}

static void c1_b_sqrt(SFc1_mainSimInstanceStruct *chartInstance, real_T *c1_x)
{
  if (*c1_x < 0.0) {
    c1_b_eml_error(chartInstance);
  }

  *c1_x = muDoubleScalarSqrt(*c1_x);
}

static void init_dsm_address_info(SFc1_mainSimInstanceStruct *chartInstance)
{
}

/* SFunction Glue Code */
void sf_c1_mainSim_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(3358494541U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(1653164709U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(740848990U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(985385213U);
}

mxArray *sf_c1_mainSim_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1,1,5,
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("r1ApdqiX5MmMJYylemjznG");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,2,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,1,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,1,"type",mxType);
    }

    mxSetField(mxData,1,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"inputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"parameters",mxCreateDoubleMatrix(0,0,
                mxREAL));
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,2,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,1,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,1,"type",mxType);
    }

    mxSetField(mxData,1,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"locals",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  return(mxAutoinheritanceInfo);
}

static const mxArray *sf_get_sim_state_info_c1_mainSim(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S1x3'type','srcId','name','auxInfo'{{M[1],M[9],T\"R\",},{M[1],M[5],T\"T\",},{M[8],M[0],T\"is_active_c1_mainSim\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 3, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c1_mainSim_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc1_mainSimInstanceStruct *chartInstance;
    chartInstance = (SFc1_mainSimInstanceStruct *) ((ChartInfoStruct *)
      (ssGetUserData(S)))->chartInstance;
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart(_mainSimMachineNumber_,
          1,
          1,
          1,
          4,
          0,
          0,
          0,
          0,
          0,
          &(chartInstance->chartNumber),
          &(chartInstance->instanceNumber),
          ssGetPath(S),
          (void *)S);
        if (chartAlreadyPresent==0) {
          /* this is the first instance */
          init_script_number_translation(_mainSimMachineNumber_,
            chartInstance->chartNumber);
          sf_debug_set_chart_disable_implicit_casting(_mainSimMachineNumber_,
            chartInstance->chartNumber,1);
          sf_debug_set_chart_event_thresholds(_mainSimMachineNumber_,
            chartInstance->chartNumber,
            0,
            0,
            0);
          _SFD_SET_DATA_PROPS(0,1,1,0,"Z");
          _SFD_SET_DATA_PROPS(1,2,0,1,"T");
          _SFD_SET_DATA_PROPS(2,1,1,0,"k");
          _SFD_SET_DATA_PROPS(3,2,0,1,"R");
          _SFD_STATE_INFO(0,0,2);
          _SFD_CH_SUBSTATE_COUNT(0);
          _SFD_CH_SUBSTATE_DECOMP(0);
        }

        _SFD_CV_INIT_CHART(0,0,0,0);

        {
          _SFD_CV_INIT_STATE(0,0,0,0,0,0,NULL,NULL);
        }

        _SFD_CV_INIT_TRANS(0,0,NULL,NULL,0,NULL);

        /* Initialization of MATLAB Function Model Coverage */
        _SFD_CV_INIT_EML(0,1,1,12,0,0,0,0,0,0);
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",0,-1,2142);
        _SFD_CV_INIT_EML_IF(0,1,0,642,653,-1,689);
        _SFD_CV_INIT_EML_IF(0,1,1,744,753,877,1001);
        _SFD_CV_INIT_EML_IF(0,1,2,1034,1043,1098,1611);
        _SFD_CV_INIT_EML_IF(0,1,3,1098,1111,1168,1611);
        _SFD_CV_INIT_EML_IF(0,1,4,1168,1181,1239,1611);
        _SFD_CV_INIT_EML_IF(0,1,5,1239,1252,1321,1611);
        _SFD_CV_INIT_EML_IF(0,1,6,1321,1334,1393,1611);
        _SFD_CV_INIT_EML_IF(0,1,7,1393,1406,1477,1611);
        _SFD_CV_INIT_EML_IF(0,1,8,1477,1494,1560,1611);
        _SFD_CV_INIT_EML_IF(0,1,9,1783,1791,1803,2142);
        _SFD_CV_INIT_EML_IF(0,1,10,1803,1835,1859,2142);
        _SFD_CV_INIT_EML_IF(0,1,11,1859,1872,2104,2142);
        _SFD_TRANS_COV_WTS(0,0,0,1,0);
        if (chartAlreadyPresent==0) {
          _SFD_TRANS_COV_MAPS(0,
                              0,NULL,NULL,
                              0,NULL,NULL,
                              1,NULL,NULL,
                              0,NULL,NULL);
        }

        _SFD_SET_DATA_COMPILED_PROPS(0,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)NULL);
        _SFD_SET_DATA_COMPILED_PROPS(1,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)c1_sf_marshallIn);
        _SFD_SET_DATA_COMPILED_PROPS(2,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)NULL);
        _SFD_SET_DATA_COMPILED_PROPS(3,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)c1_sf_marshallIn);

        {
          real_T *c1_Z;
          real_T *c1_T;
          real_T *c1_k;
          real_T *c1_R;
          c1_R = (real_T *)ssGetOutputPortSignal(chartInstance->S, 2);
          c1_k = (real_T *)ssGetInputPortSignal(chartInstance->S, 1);
          c1_T = (real_T *)ssGetOutputPortSignal(chartInstance->S, 1);
          c1_Z = (real_T *)ssGetInputPortSignal(chartInstance->S, 0);
          _SFD_SET_DATA_VALUE_PTR(0U, c1_Z);
          _SFD_SET_DATA_VALUE_PTR(1U, c1_T);
          _SFD_SET_DATA_VALUE_PTR(2U, c1_k);
          _SFD_SET_DATA_VALUE_PTR(3U, c1_R);
        }
      }
    } else {
      sf_debug_reset_current_state_configuration(_mainSimMachineNumber_,
        chartInstance->chartNumber,chartInstance->instanceNumber);
    }
  }
}

static void sf_opaque_initialize_c1_mainSim(void *chartInstanceVar)
{
  chart_debug_initialization(((SFc1_mainSimInstanceStruct*) chartInstanceVar)->S,
    0);
  initialize_params_c1_mainSim((SFc1_mainSimInstanceStruct*) chartInstanceVar);
  initialize_c1_mainSim((SFc1_mainSimInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c1_mainSim(void *chartInstanceVar)
{
  enable_c1_mainSim((SFc1_mainSimInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c1_mainSim(void *chartInstanceVar)
{
  disable_c1_mainSim((SFc1_mainSimInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c1_mainSim(void *chartInstanceVar)
{
  sf_c1_mainSim((SFc1_mainSimInstanceStruct*) chartInstanceVar);
}

extern const mxArray* sf_internal_get_sim_state_c1_mainSim(SimStruct* S)
{
  ChartInfoStruct *chartInfo = (ChartInfoStruct*) ssGetUserData(S);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_raw2high");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = (mxArray*) get_sim_state_c1_mainSim((SFc1_mainSimInstanceStruct*)
    chartInfo->chartInstance);         /* raw sim ctx */
  prhs[3] = (mxArray*) sf_get_sim_state_info_c1_mainSim();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 4, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  mxDestroyArray(prhs[3]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_raw2high'.\n");
  }

  return plhs[0];
}

extern void sf_internal_set_sim_state_c1_mainSim(SimStruct* S, const mxArray *st)
{
  ChartInfoStruct *chartInfo = (ChartInfoStruct*) ssGetUserData(S);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_high2raw");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = mxDuplicateArray(st);      /* high level simctx */
  prhs[3] = (mxArray*) sf_get_sim_state_info_c1_mainSim();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 4, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  mxDestroyArray(prhs[3]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_high2raw'.\n");
  }

  set_sim_state_c1_mainSim((SFc1_mainSimInstanceStruct*)chartInfo->chartInstance,
    mxDuplicateArray(plhs[0]));
  mxDestroyArray(plhs[0]);
}

static const mxArray* sf_opaque_get_sim_state_c1_mainSim(SimStruct* S)
{
  return sf_internal_get_sim_state_c1_mainSim(S);
}

static void sf_opaque_set_sim_state_c1_mainSim(SimStruct* S, const mxArray *st)
{
  sf_internal_set_sim_state_c1_mainSim(S, st);
}

static void sf_opaque_terminate_c1_mainSim(void *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc1_mainSimInstanceStruct*) chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
    }

    finalize_c1_mainSim((SFc1_mainSimInstanceStruct*) chartInstanceVar);
    free((void *)chartInstanceVar);
    ssSetUserData(S,NULL);
  }

  unload_mainSim_optimization_info();
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc1_mainSim((SFc1_mainSimInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c1_mainSim(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c1_mainSim((SFc1_mainSimInstanceStruct*)(((ChartInfoStruct
      *)ssGetUserData(S))->chartInstance));
  }
}

static void mdlSetWorkWidths_c1_mainSim(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct = load_mainSim_optimization_info();
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(S,infoStruct,1);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,sf_rtw_info_uint_prop(S,infoStruct,1,"RTWCG"));
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop(S,infoStruct,1,
      "gatewayCannotBeInlinedMultipleTimes"));
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 1, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,infoStruct,1,2);
      sf_mark_chart_reusable_outputs(S,infoStruct,1,2);
    }

    sf_set_rtw_dwork_info(S,infoStruct,1);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(1619504923U));
  ssSetChecksum1(S,(4063287953U));
  ssSetChecksum2(S,(65459114U));
  ssSetChecksum3(S,(2600239449U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
}

static void mdlRTW_c1_mainSim(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c1_mainSim(SimStruct *S)
{
  SFc1_mainSimInstanceStruct *chartInstance;
  chartInstance = (SFc1_mainSimInstanceStruct *)malloc(sizeof
    (SFc1_mainSimInstanceStruct));
  memset(chartInstance, 0, sizeof(SFc1_mainSimInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway = sf_opaque_gateway_c1_mainSim;
  chartInstance->chartInfo.initializeChart = sf_opaque_initialize_c1_mainSim;
  chartInstance->chartInfo.terminateChart = sf_opaque_terminate_c1_mainSim;
  chartInstance->chartInfo.enableChart = sf_opaque_enable_c1_mainSim;
  chartInstance->chartInfo.disableChart = sf_opaque_disable_c1_mainSim;
  chartInstance->chartInfo.getSimState = sf_opaque_get_sim_state_c1_mainSim;
  chartInstance->chartInfo.setSimState = sf_opaque_set_sim_state_c1_mainSim;
  chartInstance->chartInfo.getSimStateInfo = sf_get_sim_state_info_c1_mainSim;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c1_mainSim;
  chartInstance->chartInfo.mdlStart = mdlStart_c1_mainSim;
  chartInstance->chartInfo.mdlSetWorkWidths = mdlSetWorkWidths_c1_mainSim;
  chartInstance->chartInfo.extModeExec = NULL;
  chartInstance->chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.storeCurrentConfiguration = NULL;
  chartInstance->S = S;
  ssSetUserData(S,(void *)(&(chartInstance->chartInfo)));/* register the chart instance with simstruct */
  init_dsm_address_info(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  sf_opaque_init_subchart_simstructs(chartInstance->chartInfo.chartInstance);
  chart_debug_initialization(S,1);
}

void c1_mainSim_method_dispatcher(SimStruct *S, int_T method, void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c1_mainSim(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c1_mainSim(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c1_mainSim(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c1_mainSim_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
