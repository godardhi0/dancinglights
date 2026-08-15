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

(*DBG:char md5[] = "d45a43e1a39e990d4a16e3eabbb7408b";*)
(*DBG:/**)
(*DBG: * This file is part of OpenPLC Runtime*)
(*DBG: **)
(*DBG: * Copyright (C) 2023 Autonomy, GP Orcullo*)
(*DBG: * Based on the work by GP Orcullo on Beremiz for uC*)
(*DBG: **)
(*DBG: * This program is free software; you can redistribute it and/or*)
(*DBG: * modify it under the terms of the GNU General Public License*)
(*DBG: * as published by the Free Software Foundation; either version 2*)
(*DBG: * of the License, or (at your option) any later version.*)
(*DBG: **)
(*DBG: * This program is distributed in the hope that it will be useful,*)
(*DBG: * but WITHOUT ANY WARRANTY; without even the implied warranty of*)
(*DBG: * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the*)
(*DBG: * GNU General Public License for more details.*)
(*DBG: **)
(*DBG: * You should have received a copy of the GNU General Public License*)
(*DBG: * along with this program; If not, see <http://www.gnu.org/licenses/>.*)
(*DBG: **)
(*DBG: */*)
(*DBG:*)
(*DBG:#include <stdbool.h>*)
(*DBG:*)
(*DBG:#include "iec_types_all.h"*)
(*DBG:#include "POUS.h"*)
(*DBG:*)
(*DBG:#define SAME_ENDIANNESS      0*)
(*DBG:#define REVERSE_ENDIANNESS   1*)
(*DBG:*)
(*DBG:uint8_t endianness;*)
(*DBG:*)
(*DBG:*)
(*DBG:extern PROGRAM0 RES0__INSTANCE0;*)
(*DBG:*)
(*DBG:static const struct {*)
(*DBG:    void *ptr;*)
(*DBG:    __IEC_types_enum type;*)
(*DBG:} debug_vars[] = {*)
(*DBG:    {&(RES0__INSTANCE0.AUTO), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.BPON), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.BPOFF), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.LED1), BOOL_O_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.LED2), BOOL_O_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.LED3), BOOL_O_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.LED4), BOOL_O_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.DEMANDE_ARRET), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.INHIBITION_AUTO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.VA1), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.VA2), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TOUT_ETEINT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.T8_DONE), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TEMPO), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON0.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON0.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON0.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON0.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON0.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON0.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON0.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON0.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON0.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON0.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON1.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON1.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON1.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON1.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON1.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON1.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON1.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON1.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON1.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON1.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON2.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON2.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON2.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON2.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON2.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON2.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON2.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON2.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON2.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON2.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON3.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON3.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON3.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON3.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON3.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON3.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON3.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON3.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON3.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON3.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON4.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON4.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON4.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON4.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON4.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON4.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON4.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON4.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON4.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON4.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON5.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON5.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON5.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON5.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON5.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON5.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON5.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON5.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON5.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON5.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON6.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON6.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON6.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON6.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON6.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON6.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON6.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON6.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON6.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON6.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON7.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON7.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON7.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON7.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON7.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON7.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON7.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON7.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON7.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON7.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON8.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON8.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON8.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON8.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON8.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON8.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON8.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON8.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON8.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TON8.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.M), BOOL_ENUM},*)
(*DBG:};*)
(*DBG:*)
(*DBG:#define VAR_COUNT               109*)
(*DBG:*)
(*DBG:uint16_t get_var_count(void)*)
(*DBG:{*)
(*DBG:    return VAR_COUNT;*)
(*DBG:}*)
(*DBG:*)
(*DBG:size_t get_var_size(size_t idx)*)
(*DBG:{*)
(*DBG:    if (idx >= VAR_COUNT)*)
(*DBG:    {*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:    switch (debug_vars[idx].type) {*)
(*DBG:    case SINT_ENUM:*)
(*DBG:        return sizeof(SINT);*)
(*DBG:    case TIME_ENUM:*)
(*DBG:        return sizeof(TIME);*)
(*DBG:    case BOOL_ENUM:*)
(*DBG:    case BOOL_O_ENUM:*)
(*DBG:    case BOOL_P_ENUM:*)
(*DBG:        return sizeof(BOOL);*)
(*DBG:    default:*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void *get_var_addr(size_t idx)*)
(*DBG:{*)
(*DBG:    void *ptr = debug_vars[idx].ptr;*)
(*DBG:*)
(*DBG:    switch (debug_vars[idx].type) {*)
(*DBG:    case SINT_ENUM:*)
(*DBG:        return (void *)&((__IEC_SINT_t *) ptr)->value;*)
(*DBG:    case TIME_ENUM:*)
(*DBG:        return (void *)&((__IEC_TIME_t *) ptr)->value;*)
(*DBG:    case BOOL_ENUM:*)
(*DBG:        return (void *)&((__IEC_BOOL_t *) ptr)->value;*)
(*DBG:    case BOOL_O_ENUM:*)
(*DBG:    case BOOL_P_ENUM:*)
(*DBG:        return (void *)((((__IEC_BOOL_p *) ptr)->flags & __IEC_FORCE_FLAG) *)
(*DBG:                        ? &(((__IEC_BOOL_p *) ptr)->fvalue) *)
(*DBG:                        : ((__IEC_BOOL_p *) ptr)->value);*)
(*DBG:    default:*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void force_var(size_t idx, bool forced, void *val)*)
(*DBG:{*)
(*DBG:    void *ptr = debug_vars[idx].ptr;*)
(*DBG:*)
(*DBG:    if (forced) {*)
(*DBG:        size_t var_size = get_var_size(idx);*)
(*DBG:        switch (debug_vars[idx].type) {*)
(*DBG:        case SINT_ENUM: {*)
(*DBG:            memcpy(&((__IEC_SINT_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_SINT_t *) ptr)->value = *((SINT *) val);*)
(*DBG:            ((__IEC_SINT_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case TIME_ENUM: {*)
(*DBG:            memcpy(&((__IEC_TIME_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_TIME_t *) ptr)->value = *((TIME *) val);*)
(*DBG:            ((__IEC_TIME_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case BOOL_ENUM: {*)
(*DBG:            memcpy(&((__IEC_BOOL_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_BOOL_t *) ptr)->value = *((BOOL *) val);*)
(*DBG:            ((__IEC_BOOL_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case BOOL_O_ENUM: {*)
(*DBG:            memcpy((((__IEC_BOOL_p *) ptr)->value), val, var_size);*)
(*DBG:            //*(((__IEC_BOOL_p *) ptr)->value) = *((BOOL *) val);*)
(*DBG:            ((__IEC_BOOL_p *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case BOOL_P_ENUM: {*)
(*DBG:            memcpy(&((__IEC_BOOL_p *) ptr)->fvalue, val, var_size);*)
(*DBG:            //((__IEC_BOOL_p *) ptr)->fvalue = *((BOOL *) val);*)
(*DBG:            ((__IEC_BOOL_p *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        default:*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:    } else {*)
(*DBG:        switch (debug_vars[idx].type) {*)
(*DBG:        case SINT_ENUM:*)
(*DBG:            ((__IEC_SINT_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case TIME_ENUM:*)
(*DBG:            ((__IEC_TIME_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case BOOL_ENUM:*)
(*DBG:            ((__IEC_BOOL_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case BOOL_O_ENUM:*)
(*DBG:        case BOOL_P_ENUM:*)
(*DBG:            ((__IEC_BOOL_p *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        default:*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void swap_bytes(void *ptr, size_t size) *)
(*DBG:{*)
(*DBG:    uint8_t *bytePtr = (uint8_t *)ptr;*)
(*DBG:    size_t i;*)
(*DBG:    for (i = 0; i < size / 2; ++i) *)
(*DBG:    {*)
(*DBG:        uint8_t temp = bytePtr[i];*)
(*DBG:        bytePtr[i] = bytePtr[size - 1 - i];*)
(*DBG:        bytePtr[size - 1 - i] = temp;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void trace_reset(void)*)
(*DBG:{*)
(*DBG:    for (size_t i=0; i < VAR_COUNT; i++) *)
(*DBG:    {*)
(*DBG:        force_var(i, false, 0);*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void set_trace(size_t idx, bool forced, void *val)*)
(*DBG:{*)
(*DBG:    if (idx >= 0 && idx < VAR_COUNT) *)
(*DBG:    {*)
(*DBG:        if (endianness == REVERSE_ENDIANNESS)*)
(*DBG:        {*)
(*DBG:            // Aaaaarghhhh... Stupid AVR is Big Endian.*)
(*DBG:            swap_bytes(val, get_var_size(idx));*)
(*DBG:        }*)
(*DBG:*)
(*DBG:        force_var(idx, forced, val);*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void set_endianness(uint8_t value)*)
(*DBG:{*)
(*DBG:    if (value == SAME_ENDIANNESS || value == REVERSE_ENDIANNESS)*)
(*DBG:    {*)
(*DBG:        endianness = value;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)