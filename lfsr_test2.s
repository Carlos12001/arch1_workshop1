    .data
seed: .word 0x58       # Ejemplo con el valor ASCII para 'X' en hexadecimal

    .text
    .globl main

main:
    la t0, seed         # Cargar la dirección de la semilla
    lw t1, 0(t0)        # Cargar el valor de la semilla en t1
    li t2, 100          # Contador para generar 100 números
    li t3, 0x100        # Dirección inicial de almacenamiento en memoria
    sw t1, 0(t3)        # Guarda en memoria la semilla
    addi t3, t3, 4      # Incrementar la direccion de memoria
    addi t2, t2, -1     # Decrementar el contador

generate_loop:
    li t4, 0            # Inicializar new_bit a 0

    # XOR for x^8 + x^6 + x^5 + x^4 => 7,5,4,3
    srli t5, t1, 7      # Desplazar el bit 7 a la posición LSB
    andi t5, t5, 1      # Aislar el bit
    xor t4, t4, t5      # Realizar XOR y actualizar new_bit

    srli t5, t1, 5      # For
    andi t5, t5, 1
    xor t4, t4, t5

    srli t5, t1, 4      # Repetir para bit en posición 4
    andi t5, t5, 1
    xor t4, t4, t5

    srli t5, t1, 3      # Repetir para bit en posición 3
    andi t5, t5, 1
    xor t4, t4, t5

    # Desplazar y actualizar LFSR con el nuevo bit
    li a0, 1
    srl t1, t1, a0       # Desplazar el registro a la derecha
    li a0, 7
    sll t4, t4, a0       # Mover el new_bit a la posición MSB
    or t1, t1, t4       # Insertar el new_bit en el registro LFSR

    # Almacenar el número generado en memoria
    sw t1, 0(t3)        # Almacenar el valor actual del LFSR en memoria

    # Preparar para el siguiente número
    addi t3, t3, 4      # Incrementar la dirección de memoria
    addi t2, t2, -1     # Decrementar el contador
    bnez t2, generate_loop # Repetir si aún no hemos generado 100 números
