import random

def encode_binary(x, num_bits):
    x_in_scale = x / 10.0
    binary_string = bin(int(x_in_scale * 2**num_bits))[2:].zfill(num_bits)
    if len(binary_string) > num_bits:
        return '1'*num_bits
    return binary_string

def decode_binary(binary_string, num_bits):
    dec_val = int(binary_string, 2)
    return dec_val / 2**num_bits * 10.0




num_bits = 8
x = 1

binary_string = encode_binary(x, num_bits)
decoded_solution = decode_binary(binary_string, num_bits)

print("Reprezentacja binarna x:", binary_string)
print("Zdekodowana wartość x:", decoded_solution)
