#ifndef __c3_WECSim_Lib_h__
#define __c3_WECSim_Lib_h__

/* Include files */
#include "sf_runtime/sfc_sf.h"
#include "sf_runtime/sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#ifndef typedef_SFc3_WECSim_LibInstanceStruct
#define typedef_SFc3_WECSim_LibInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c3_sfEvent;
  boolean_T c3_isStable;
  boolean_T c3_doneDoubleBufferReInit;
  uint8_T c3_is_active_c3_WECSim_Lib;
  real_T c3_velocity[5154];
  boolean_T c3_velocity_not_empty;
  real_T c3_kkk;
  boolean_T c3_kkk_not_empty;
  real_T c3_inData[30924];
  real_T c3_u[30924];
  real_T c3_IRKB[30924];
  real_T *c3_check;
  real_T (*c3_v)[6];
  real_T (*c3_F_FM)[6];
  real_T (*c3_ZeroVel)[5154];
  real_T (*c3_b_IRKB)[30924];
  real_T (*c3_CTTime)[859];
} SFc3_WECSim_LibInstanceStruct;

#endif                                 /*typedef_SFc3_WECSim_LibInstanceStruct*/

/* Named Constants */

/* Variable Declarations */
extern struct SfDebugInstanceStruct *sfGlobalDebugInstanceStruct;

/* Variable Definitions */

/* Function Declarations */
extern const mxArray *sf_c3_WECSim_Lib_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c3_WECSim_Lib_get_check_sum(mxArray *plhs[]);
extern void c3_WECSim_Lib_method_dispatcher(SimStruct *S, int_T method, void
  *data);

#endif