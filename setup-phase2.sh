# $1: Circuit name
# $2: Ptau file power

snarkjs groth16 setup ./circuits/$1/$1.r1cs powersOfTau28_hez_final_$2.ptau ./circuits/$1/keys/$1.zkey
snarkjs zkey contribute ./circuits/$1/keys/$1.zkey ./circuits/$1/keys/$1_1.zkey --name="1st Contributor Name" -v
snarkjs zkey export verificationkey ./circuits/$1/keys/$1_1.zkey ./circuits/$1/keys/verification_key.json