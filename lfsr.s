    .data
seed:   .byte 0x58           # Semilla inicial ASCII de la letra en mayúscula
    .text
    .globl main

main:
    li s0, 100              # Número de iteraciones
    li s1, 0x100            # Dirección de inicio de memoria para almacenar resultados
    li t0, 0x43            # Valor inicial de la semilla
    li t1, 8                # Número de bits

loop:
    li t2, 0                # Inicializar bit de retroalimentación a 0
    li t3, 7                # Taps: posiciones 7, 5, 4, 3
    li t4, 5
    li t5, 4
    li t6, 3

    # XOR para tap en posición 7
    li a0, 1
    srl t3, t0, a0           # Desplazar semilla hacia la derecha para obtener bit de posición 7
    andi t3, t3, 1          # Aislar el bit de la posición 7
    xor t2, t2, t3          # XOR con el bit de feedback

    # XOR para tap en posición 5
    li a0, 3
    srl t4, t0, a0           # Desplazar semilla hacia la derecha para obtener bit de posición 5
    andi t4, t4, 1          # Aislar el bit de la posición 5
    xor t2, t2, t4          # XOR con el bit de feedback

    # XOR para tap en posición 4
    li a0, 4
    srl t5, t0, a0          # Desplazar semilla hacia la derecha para obtener bit de posición 4
    andi t5, t5, 1          # Aislar el bit de la posición 4
    xor t2, t2, t5          # XOR con el bit de feedback

    # XOR para tap en posición 3
    li a0, 5
    srl t6, t0, a0         # Desplazar semilla hacia la derecha para obtener bit de posición 3
    andi t6, t6, 1          # Aislar el bit de la posición 3
    xor t2, t2, t6          # XOR con el bit de feedback

    # Preparar el nuevo estado
    li a0, 1
    srl t0, t0, a0           # Desplazar semilla hacia la derecha
    li a0, 7
    sll t3, t2, a0           # Desplazar el bit de retroalimentación a la posición más significativa
    or t0, t0, t3           # Combinar bit de retroalimentación
    li a0, 0xFFFF           # Cargar la máscara de 16 bits en t7
    and t0, t0, a0          # Asegurar que el estado sea de 16 bits


    # Almacenar el nuevo estado en memoria
    sb t0, 0(s1)            # Almacenar el byte menos significativo del nuevo estado
    addi s1, s1, 4          # Incrementar la dirección de memoria

    # Decrementar el contador y verificar si continuar
    addi s0, s0, -1
    bnez s0, loop           # Si s0 no es 0, continuar el bucle

    # Finalizar el programa

