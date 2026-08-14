void LOGGER_init__(LOGGER *data__, BOOL retain) {
  __INIT_VAR(data__->EN,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->ENO,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->TRIG,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->MSG,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->LEVEL,LOGLEVEL__INFO,retain)
  __INIT_VAR(data__->TRIG0,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void LOGGER_body__(LOGGER *data__) {
  // Control execution
  if (!__GET_VAR(data__->EN)) {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(FALSE));
    return;
  }
  else {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(TRUE));
  }
  // Initialise TEMP variables

  if ((__GET_VAR(data__->TRIG,) && !(__GET_VAR(data__->TRIG0,)))) {
    #define GetFbVar(var,...) __GET_VAR(data__->var,__VA_ARGS__)
    #define SetFbVar(var,val,...) __SET_VAR(data__->,var,__VA_ARGS__,val)

   LogMessage(GetFbVar(LEVEL),(char*)GetFbVar(MSG, .body),GetFbVar(MSG, .len));
  
    #undef GetFbVar
    #undef SetFbVar
;
  };
  __SET_VAR(data__->,TRIG0,,__GET_VAR(data__->TRIG,));

  goto __end;

__end:
  return;
} // LOGGER_body__() 





void PROGRAM0_init__(PROGRAM0 *data__, BOOL retain) {
  __INIT_VAR(data__->AUTO,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->BPON,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->BPOFF,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->LED1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->LED2,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->LED3,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->LED4,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->DEMANDE_ARRET,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->INHIBITION_AUTO,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->VA1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->VA2,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->TOUT_ETEINT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->T8_DONE,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->TEMPO,__time_to_timespec(1, 500, 0, 0, 0, 0),retain)
  TON_init__(&data__->TON0,retain);
  TON_init__(&data__->TON1,retain);
  TON_init__(&data__->TON2,retain);
  TON_init__(&data__->TON3,retain);
  TON_init__(&data__->TON4,retain);
  TON_init__(&data__->TON5,retain);
  TON_init__(&data__->TON6,retain);
  TON_init__(&data__->TON7,retain);
  TON_init__(&data__->TON8,retain);
  F_TRIG_init__(&data__->F_TRIG1,retain);
  F_TRIG_init__(&data__->F_TRIG2,retain);
}

// Code part
void PROGRAM0_body__(PROGRAM0 *data__) {
  // Initialise TEMP variables

  __SET_VAR(data__->F_TRIG1.,CLK,,__GET_VAR(data__->BPOFF,));
  F_TRIG_body__(&data__->F_TRIG1);
  if (__GET_VAR(data__->F_TRIG1.Q,)) {
    __SET_VAR(data__->,DEMANDE_ARRET,,__BOOL_LITERAL(TRUE));
  };
  if (!(__GET_VAR(data__->AUTO,))) {
    __SET_VAR(data__->,INHIBITION_AUTO,,__BOOL_LITERAL(FALSE));
  };
  __SET_VAR(data__->,TOUT_ETEINT,,(((!(__GET_VAR(data__->LED4,)) && !(__GET_VAR(data__->LED3,))) && !(__GET_VAR(data__->LED2,))) && !(__GET_VAR(data__->LED1,))));
  __SET_VAR(data__->F_TRIG2.,CLK,,__GET_VAR(data__->BPON,));
  F_TRIG_body__(&data__->F_TRIG2);
  if ((((__GET_VAR(data__->F_TRIG2.Q,) && !(__GET_VAR(data__->VA2,))) && !(__GET_VAR(data__->VA1,))) && __GET_VAR(data__->TOUT_ETEINT,))) {
    __SET_VAR(data__->,LED2,,__BOOL_LITERAL(TRUE));
  };
  __SET_VAR(data__->TON0.,IN,,(((!(__GET_VAR(data__->LED4,)) && !(__GET_VAR(data__->LED3,))) && __GET_VAR(data__->LED2,)) && !(__GET_VAR(data__->LED1,))));
  __SET_VAR(data__->TON0.,PT,,__GET_VAR(data__->TEMPO,));
  TON_body__(&data__->TON0);
  if (__GET_VAR(data__->TON0.Q,)) {
    __SET_VAR(data__->,LED1,,__BOOL_LITERAL(TRUE));
  };
  __SET_VAR(data__->TON3.,IN,,(((!(__GET_VAR(data__->LED4,)) && !(__GET_VAR(data__->LED3,))) && __GET_VAR(data__->LED2,)) && __GET_VAR(data__->LED1,)));
  __SET_VAR(data__->TON3.,PT,,__GET_VAR(data__->TEMPO,));
  TON_body__(&data__->TON3);
  if (__GET_VAR(data__->TON3.Q,)) {
    __SET_VAR(data__->,LED2,,__BOOL_LITERAL(FALSE));
  };
  __SET_VAR(data__->TON1.,IN,,(((!(__GET_VAR(data__->LED4,)) && !(__GET_VAR(data__->LED3,))) && !(__GET_VAR(data__->LED2,))) && __GET_VAR(data__->LED1,)));
  __SET_VAR(data__->TON1.,PT,,__GET_VAR(data__->TEMPO,));
  TON_body__(&data__->TON1);
  if (__GET_VAR(data__->TON1.Q,)) {
    __SET_VAR(data__->,LED1,,__BOOL_LITERAL(FALSE));
  };
  if (__GET_VAR(data__->TON1.Q,)) {
    __SET_VAR(data__->,VA2,,__BOOL_LITERAL(TRUE));
  };
  __SET_VAR(data__->TON2.,IN,,((__GET_VAR(data__->VA2,) && !(__GET_VAR(data__->VA1,))) && __GET_VAR(data__->TOUT_ETEINT,)));
  __SET_VAR(data__->TON2.,PT,,__GET_VAR(data__->TEMPO,));
  TON_body__(&data__->TON2);
  if (__GET_VAR(data__->TON2.Q,)) {
    __SET_VAR(data__->,LED3,,__BOOL_LITERAL(TRUE));
  };
  __SET_VAR(data__->TON4.,IN,,(((!(__GET_VAR(data__->LED4,)) && __GET_VAR(data__->LED3,)) && !(__GET_VAR(data__->LED2,))) && !(__GET_VAR(data__->LED1,))));
  __SET_VAR(data__->TON4.,PT,,__GET_VAR(data__->TEMPO,));
  TON_body__(&data__->TON4);
  if (__GET_VAR(data__->TON4.Q,)) {
    __SET_VAR(data__->,LED4,,__BOOL_LITERAL(TRUE));
  };
  __SET_VAR(data__->TON5.,IN,,(((__GET_VAR(data__->LED4,) && __GET_VAR(data__->LED3,)) && !(__GET_VAR(data__->LED2,))) && !(__GET_VAR(data__->LED1,))));
  __SET_VAR(data__->TON5.,PT,,__GET_VAR(data__->TEMPO,));
  TON_body__(&data__->TON5);
  if (__GET_VAR(data__->TON5.Q,)) {
    __SET_VAR(data__->,LED3,,__BOOL_LITERAL(FALSE));
  };
  if (__GET_VAR(data__->TON5.Q,)) {
    __SET_VAR(data__->,LED4,,__BOOL_LITERAL(FALSE));
  };
  if (__GET_VAR(data__->TON5.Q,)) {
    __SET_VAR(data__->,VA1,,__BOOL_LITERAL(TRUE));
  };
  if (__GET_VAR(data__->TON5.Q,)) {
    __SET_VAR(data__->,VA2,,__BOOL_LITERAL(FALSE));
  };
  __SET_VAR(data__->TON6.,IN,,((!(__GET_VAR(data__->VA2,)) && __GET_VAR(data__->VA1,)) && __GET_VAR(data__->TOUT_ETEINT,)));
  __SET_VAR(data__->TON6.,PT,,__GET_VAR(data__->TEMPO,));
  TON_body__(&data__->TON6);
  if (__GET_VAR(data__->TON6.Q,)) {
    __SET_VAR(data__->,LED1,,__BOOL_LITERAL(TRUE));
  };
  if (__GET_VAR(data__->TON6.Q,)) {
    __SET_VAR(data__->,LED2,,__BOOL_LITERAL(TRUE));
  };
  if (__GET_VAR(data__->TON6.Q,)) {
    __SET_VAR(data__->,LED3,,__BOOL_LITERAL(TRUE));
  };
  if (__GET_VAR(data__->TON6.Q,)) {
    __SET_VAR(data__->,LED4,,__BOOL_LITERAL(TRUE));
  };
  __SET_VAR(data__->TON7.,IN,,(((__GET_VAR(data__->LED4,) && __GET_VAR(data__->LED3,)) && __GET_VAR(data__->LED2,)) && __GET_VAR(data__->LED1,)));
  __SET_VAR(data__->TON7.,PT,,__GET_VAR(data__->TEMPO,));
  TON_body__(&data__->TON7);
  if (__GET_VAR(data__->TON7.Q,)) {
    __SET_VAR(data__->,LED1,,__BOOL_LITERAL(FALSE));
  };
  if (__GET_VAR(data__->TON7.Q,)) {
    __SET_VAR(data__->,LED2,,__BOOL_LITERAL(FALSE));
  };
  if (__GET_VAR(data__->TON7.Q,)) {
    __SET_VAR(data__->,LED3,,__BOOL_LITERAL(FALSE));
  };
  if (__GET_VAR(data__->TON7.Q,)) {
    __SET_VAR(data__->,LED4,,__BOOL_LITERAL(FALSE));
  };
  if (__GET_VAR(data__->TON7.Q,)) {
    __SET_VAR(data__->,VA2,,__BOOL_LITERAL(TRUE));
  };
  if (((!(__GET_VAR(data__->DEMANDE_ARRET,)) && __GET_VAR(data__->AUTO,)) && __GET_VAR(data__->T8_DONE,))) {
    __SET_VAR(data__->,LED2,,__BOOL_LITERAL(TRUE));
  };
  if (((!(__GET_VAR(data__->DEMANDE_ARRET,)) && __GET_VAR(data__->AUTO,)) && __GET_VAR(data__->T8_DONE,))) {
    __SET_VAR(data__->,VA1,,__BOOL_LITERAL(FALSE));
  };
  if (((!(__GET_VAR(data__->DEMANDE_ARRET,)) && __GET_VAR(data__->AUTO,)) && __GET_VAR(data__->T8_DONE,))) {
    __SET_VAR(data__->,VA2,,__BOOL_LITERAL(FALSE));
  };
  __SET_VAR(data__->TON8.,IN,,((__GET_VAR(data__->VA2,) && __GET_VAR(data__->VA1,)) && __GET_VAR(data__->TOUT_ETEINT,)));
  __SET_VAR(data__->TON8.,PT,,__GET_VAR(data__->TEMPO,));
  TON_body__(&data__->TON8);
  __SET_VAR(data__->,T8_DONE,,__GET_VAR(data__->TON8.Q,));
  if (((__GET_VAR(data__->DEMANDE_ARRET,) || !(__GET_VAR(data__->AUTO,))) && __GET_VAR(data__->T8_DONE,))) {
    __SET_VAR(data__->,VA1,,__BOOL_LITERAL(FALSE));
  };
  if ((!(__GET_VAR(data__->AUTO,)) && __GET_VAR(data__->T8_DONE,))) {
    __SET_VAR(data__->,VA2,,__BOOL_LITERAL(FALSE));
  };
  if ((!(__GET_VAR(data__->AUTO,)) && __GET_VAR(data__->T8_DONE,))) {
    __SET_VAR(data__->,DEMANDE_ARRET,,__BOOL_LITERAL(FALSE));
  };
  if ((!(__GET_VAR(data__->AUTO,)) && __GET_VAR(data__->T8_DONE,))) {
    __SET_VAR(data__->,INHIBITION_AUTO,,__BOOL_LITERAL(TRUE));
  };

  goto __end;

__end:
  return;
} // PROGRAM0_body__() 





