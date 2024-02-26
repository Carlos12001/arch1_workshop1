    .data
seed: .word 0x43
# Polinomic LFSR: x8 + x6 + x5 + x4 + 1
taps: .word 7, 6, 4, 3
length: .word 4

    .text
    
new_bit:
    
lfsr:
    

    .globl main
main:
    # Load the seed to register
    la t0, seed
    lh t1, 0(t0)
    
    # Save on Memory seed on position 0x100 
    li a2, 0x100
    sw t1, 0(a2)