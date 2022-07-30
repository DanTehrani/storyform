include "../../node_modules/circomlib/circuits/pedersen.circom";

template Hahser(preImageSize) {
    signal input preImage;
    signal input hash;

    component preImageBits = Num2Bits(preImageSize);
    preImageBits.in <== preImage;
    component pedersen = Pedersen(preImageSize);

    for (var k = 0; k < preImageSize; k++) {
        pedersen.in[k] <== preImageBits.out[k];
    }

    log(pedersen.out[0]);
    log(pedersen.out[1]);

    assert(hash == pedersen.out[0]);
}

component main{ public [hash]} = Hahser(256);