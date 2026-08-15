TYPE
  LOGLEVEL : (CRITICAL, WARNING, INFO, DEBUG) := INFO;
END_TYPE

FUNCTION_BLOCK LOGGER
  VAR_INPUT
    TRIG : BOOL;
    MSG : STRING;
    LEVEL : LOGLEVEL := INFO;
  END_VAR
  VAR
    TRIG0 : BOOL;
  END_VAR

  IF TRIG AND NOT TRIG0 THEN
  {{
   LogMessage(GetFbVar(LEVEL),(char*)GetFbVar(MSG, .body),GetFbVar(MSG, .len));
  }}
  END_IF;
  TRIG0:=TRIG;
END_FUNCTION_BLOCK


PROGRAM program0
  VAR
    AUTO AT %IX2.5 : BOOL;
    BPON AT %IX2.6 : BOOL;
    BPOFF AT %IX2.7 : BOOL;
    LED1 AT %QX0.0 : BOOL;
    LED2 AT %QX0.1 : BOOL;
    LED3 AT %QX0.2 : BOOL;
    LED4 AT %QX0.3 : BOOL;
  END_VAR
  VAR
    Demande_arret : BOOL;
    Inhibition_auto : BOOL;
    Va1 : BOOL;
    Va2 : BOOL;
    tout_eteint : BOOL;
    T8_done : BOOL;
    Tempo : TIME := T#500ms;
    TON0 : TON;
    TON1 : TON;
    TON2 : TON;
    TON3 : TON;
    TON4 : TON;
    TON5 : TON;
    TON6 : TON;
    TON7 : TON;
    TON8 : TON;
    R_TRIG1 : R_TRIG;
  END_VAR

  IF BPOFF THEN
    Demande_arret := TRUE; (*set*)
  END_IF;
  IF NOT(AUTO) THEN
    Inhibition_auto := FALSE; (*reset*)
  END_IF;
  tout_eteint := NOT(LED4) AND NOT(LED3) AND NOT(LED2) AND NOT(LED1);
  R_TRIG1(CLK := BPON);
  IF (NOT(Inhibition_auto) AND AUTO OR R_TRIG1.Q) AND NOT(Va2) AND NOT(Va1) AND tout_eteint THEN
    LED2 := TRUE; (*set*)
  END_IF;
  TON0(IN := NOT(LED4) AND NOT(LED3) AND LED2 AND NOT(LED1), PT := Tempo);
  IF TON0.Q THEN
    LED1 := TRUE; (*set*)
  END_IF;
  TON3(IN := NOT(LED4) AND NOT(LED3) AND LED2 AND LED1, PT := Tempo);
  IF TON3.Q THEN
    LED2 := FALSE; (*reset*)
  END_IF;
  TON1(IN := NOT(LED4) AND NOT(LED3) AND NOT(LED2) AND LED1, PT := Tempo);
  IF TON1.Q THEN
    LED1 := FALSE; (*reset*)
  END_IF;
  IF TON1.Q THEN
    Va2 := TRUE; (*set*)
  END_IF;
  TON2(IN := Va2 AND NOT(Va1) AND tout_eteint, PT := Tempo);
  IF TON2.Q THEN
    LED3 := TRUE; (*set*)
  END_IF;
  TON4(IN := NOT(LED4) AND LED3 AND NOT(LED2) AND NOT(LED1), PT := Tempo);
  IF TON4.Q THEN
    LED4 := TRUE; (*set*)
  END_IF;
  TON5(IN := LED4 AND LED3 AND NOT(LED2) AND NOT(LED1), PT := Tempo);
  IF TON5.Q THEN
    LED3 := FALSE; (*reset*)
  END_IF;
  IF TON5.Q THEN
    LED4 := FALSE; (*reset*)
  END_IF;
  IF TON5.Q THEN
    Va1 := TRUE; (*set*)
  END_IF;
  IF TON5.Q THEN
    Va2 := FALSE; (*reset*)
  END_IF;
  TON6(IN := NOT(Va2) AND Va1 AND tout_eteint, PT := Tempo);
  IF TON6.Q THEN
    LED1 := TRUE; (*set*)
  END_IF;
  IF TON6.Q THEN
    LED2 := TRUE; (*set*)
  END_IF;
  IF TON6.Q THEN
    LED3 := TRUE; (*set*)
  END_IF;
  IF TON6.Q THEN
    LED4 := TRUE; (*set*)
  END_IF;
  TON7(IN := LED4 AND LED3 AND LED2 AND LED1, PT := Tempo);
  IF TON7.Q THEN
    LED1 := FALSE; (*reset*)
  END_IF;
  IF TON7.Q THEN
    LED2 := FALSE; (*reset*)
  END_IF;
  IF TON7.Q THEN
    LED3 := FALSE; (*reset*)
  END_IF;
  IF TON7.Q THEN
    LED4 := FALSE; (*reset*)
  END_IF;
  IF TON7.Q THEN
    Va2 := TRUE; (*set*)
  END_IF;
  IF NOT(Demande_arret) AND AUTO AND T8_done THEN
    LED2 := TRUE; (*set*)
  END_IF;
  IF NOT(Demande_arret) AND AUTO AND T8_done THEN
    Va1 := FALSE; (*reset*)
  END_IF;
  IF NOT(Demande_arret) AND AUTO AND T8_done THEN
    Va2 := FALSE; (*reset*)
  END_IF;
  TON8(IN := Va2 AND Va1 AND tout_eteint, PT := Tempo);
  T8_done := TON8.Q;
  IF NOT(AUTO) AND T8_done THEN
    Va1 := FALSE; (*reset*)
  END_IF;
  IF NOT(AUTO) AND T8_done THEN
    Va2 := FALSE; (*reset*)
  END_IF;
  IF Demande_arret AND T8_done OR NOT(AUTO) AND T8_done THEN
    Demande_arret := FALSE; (*reset*)
  END_IF;
  IF NOT(AUTO) AND T8_done THEN
    Inhibition_auto := TRUE; (*set*)
  END_IF;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : program0;
  END_RESOURCE
END_CONFIGURATION
