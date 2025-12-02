## Procesador RV32I Monociclo — SystemVerilog  
**Autores:** Jesús David Villamil Angarita - Bernardo Castaño Silva - Alejandro Loaiza Palacios 
**Curso:** Arquitectura de Computadores  
**Año:** 2025  

---

# 1. Introducción

Este documento describe el desarrollo del procesador RV32I monociclo, incluyendo decisiones de diseño, problemas encontrados, soluciones aplicadas y pruebas realizadas.

---

#  2. Filosofía del diseño

- Arquitectura monociclo  
- Todos los módulos son combinacionales excepto PC y memories  
- Diseño modular: cada componente tiene su propio testbench  

Ventajas: fácil depuración, claridad.  
Desventajas: Realizar pequeñas adaptaciones para quartus para su funcionalidad total en la FPGA. 

---

# 3. Módulos principales

## 3.1 Program Counter
- Registro síncrono  
- Next PC viene desde mux_pc

## 3.2 PC Adder
- Suma PC + 4  
- Combinacional

## 3.3 Instruction Memory
- Inicializada con archivo `.mif` por restricciones de Quartus  

## 3.4 Immediate Generator
- Soporta I, S, B, U y J  
- Hecho completamente con `assign` para evitar errores de Icarus

## 3.5 Registro (regunit)
- 32 registros  
- Lectura combinacional  
- Escritura síncrona  
- x0 siempre vale 0  

## 3.6 ALU
- ADD, SUB, AND, OR, XOR  
- SLL, SRL, SRA  
- SLT  

## 3.7 ALU Control
- Decodifica (ALUOp, funct3, funct7)  
- Necesario para R-type e I-type ALU ops  

## 3.8 Control Unit
- Decodifica opcode  
- Señales: RegWrite, ALUSrc, MemRead, MemWrite, MemToReg, Branch, ALUOp  

## 3.9 Branch Unit
- Comparaciones según funct3  
- Calcula branch_target = pc + imm  

## 3.10 Data Memory
- Lectura combinacional  
- Escritura síncrona  
- Inicializada con `.mif`  

## 3.11 Multiplexores
- ALU A: rs1 vs PC  
- ALU B: rs2 vs Imm  
- WB: ALU vs MEM vs PC+4  
- PCSrc: PC+4 vs branch vs jump  

---

# 4. Pruebas realizadas

Se hicieron testbenches para:

- ALU  
- ALU Control  
- ImmGen  
- Branch Unit  
- MUXes  
- Memories  
- PC y PC Adder  
- CPU completa  

Se verificaron:
- Casos de borde  
- Instrucciones reales  
- Saltos y branches  
- Señales en WaveTrace  

---

# 🛠 6. Problemas encontrados y soluciones

## ❌ Error: constant selects in always_*
   Solución: usar `assign`.

## ❌ Quartus no acepta $readmemh
   Solución: usar `(* ram_init_file = "archivo.mif" *)`.

## ❌ Loop combinacional en PCSrc
   Solución: defaults claros + always_comb bien estructurado.

## ❌ Señales no llegaban a FPGA
   Se creó wrapper `fpga_top`.

---

# 🟦 7. FPGA (DE1-SoC)

- PC mostrado en LEDs  
- Instrucción mostrada en HEX0–HEX5   

---

# 8. Mejoras futuras

- Pipeline (5 etapas)  
- Manejo de hazards  
- Caches  
- CSR + interrupciones  
- RV32M  

---

# 9. Conclusión

El procesador RV32I fue implementado completamente, probado por simulación y funcional en FPGA. El diseño modular permitió depuración clara y correcta integración final.
