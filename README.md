# RiscV32i_ProcesadorMonociclo

En este repositorio, registramos el desarrollo del procesador Monociclo en VScode através de SystemVerilog. Al interior de las carpetas podrás encontrar, los módulos(src), los testbench de cada módulo(tb) y por último las simulaciones de cada uno de los módulos del procesador(sim).
El proyecto incluye:

Diseño e implementación en SystemVerilog
Todos los módulos fundamentales del datapath y control
Testbenches completos para simulación
Soporte para instrucciones RV32I básicas
Integración opcional con FPGA DE1-SoC (En la carpeta quartus con los cambios necesarios)
Visualización en LEDs y displays de 7 segmentos
Características principales
Arquitectura monociclo
Un solo ciclo por instrucción
Datapath completamente combinacional (excepto PC y memories)
Soporte de instrucciones
Incluye las familias:

R-type (ADD, SUB, SLL, SRL, AND, OR, XOR, SLT…)
I-type (ADDI, LW, JALR…)
S-type (SW)
B-type (BEQ, BNE, BLT, BGE…)
U-type (AUIPC)
J-type (JAL)
Componentes implementados
ALU y ALU Control
Unidad de control
Unidad de branch
Immediate generator
Register file
PC y PC Adder
Instruction Memory (inicializable con MIF)
Data Memory
MUXes requeridos (ALU, PC, WB)
Cómo simular
Requisitos
Icarus Verilog
Wavetrace
Simulación de la CPU completa
cd tb
iverilog -g2012 -o cpu_tb.vvp ../src/*.sv cpu_tb.sv
vvp cpu_tb.vvp 
Cómo usar en FPGA (DE1-SoC)
Abrir el proyecto en quartus

Importar los archivos SystemVerilog desde src/

Asignar pines:

CLOCK_50 → clock principal
LEDR[7:0] → PC actual
HEX0–HEX5 → instrucción o valor ALU
Compilar
Autores
Jesus David Villamil Angarita
Bernardo Castaño Silva
Alejandro Loaiza Palacio
