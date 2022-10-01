# $1: Circuit name
# $2: Ptau file power

yarn snarkjs groth16 setup ./circuits/$1.r1cs powersOfTau28_hez_final_$2.ptau ./circuits/keys/$1.zkey
yarn snarkjs zkey contribute ./circuits/keys/$1.zkey ./circuits/keys/$1_1.zkey --name="1st Contributor Name" -v
yarn snarkjs zkey export verificationkey ./circuits/keys/$1_1.zkey ./circuits/keys/verification_key.json