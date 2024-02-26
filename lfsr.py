def lfsr(seed, taps, n_bits=8, n=100):
    state = seed
    lfsr_sequence = []
    
    for _ in range(n):
        feedback_bit = 0
        for t in taps:
            feedback_bit ^= (state >> (n_bits - (t + 1))) & 1   
        state = (state >> 1) | (feedback_bit << (n_bits - 1))
        state &= (1 << n_bits) - 1  
        lfsr_sequence.append(state)
    
    return lfsr_sequence


lfsr_sequence = lfsr(0x58, [7, 5, 4, 3])
print(lfsr_sequence)
