#include "beremiz.h"
#ifndef __POUS_H
#define __POUS_H

#include "accessor.h"
#include "iec_std_lib.h"

__DECLARE_ENUMERATED_TYPE(LOGLEVEL,
  LOGLEVEL__CRITICAL,
  LOGLEVEL__WARNING,
  LOGLEVEL__INFO,
  LOGLEVEL__DEBUG
)
// FUNCTION_BLOCK LOGGER
// Data part
typedef struct {
  // FB Interface - IN, OUT, IN_OUT variables
  __DECLARE_VAR(BOOL,EN)
  __DECLARE_VAR(BOOL,ENO)
  __DECLARE_VAR(BOOL,TRIG)
  __DECLARE_VAR(STRING,MSG)
  __DECLARE_VAR(LOGLEVEL,LEVEL)

  // FB private variables - TEMP, private and located variables
  __DECLARE_VAR(BOOL,TRIG0)

} LOGGER;

void LOGGER_init__(LOGGER *data__, BOOL retain);
// Code part
void LOGGER_body__(LOGGER *data__);
// PROGRAM PROGRAM0
// Data part
typedef struct {
  // PROGRAM Interface - IN, OUT, IN_OUT variables

  // PROGRAM private variables - TEMP, private and located variables
  __DECLARE_VAR(BOOL,AUTO)
  __DECLARE_VAR(BOOL,BPON)
  __DECLARE_VAR(BOOL,BPOFF)
  __DECLARE_VAR(BOOL,LED1)
  __DECLARE_VAR(BOOL,LED2)
  __DECLARE_VAR(BOOL,LED3)
  __DECLARE_VAR(BOOL,LED4)
  __DECLARE_VAR(BOOL,DEMANDE_ARRET)
  __DECLARE_VAR(BOOL,INHIBITION_AUTO)
  __DECLARE_VAR(BOOL,VA1)
  __DECLARE_VAR(BOOL,VA2)
  __DECLARE_VAR(BOOL,TOUT_ETEINT)
  __DECLARE_VAR(BOOL,T8_DONE)
  __DECLARE_VAR(TIME,TEMPO)
  TON TON0;
  TON TON1;
  TON TON2;
  TON TON3;
  TON TON4;
  TON TON5;
  TON TON6;
  TON TON7;
  TON TON8;
  F_TRIG F_TRIG1;
  F_TRIG F_TRIG2;

} PROGRAM0;

void PROGRAM0_init__(PROGRAM0 *data__, BOOL retain);
// Code part
void PROGRAM0_body__(PROGRAM0 *data__);
#endif //__POUS_H
