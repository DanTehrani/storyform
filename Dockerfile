FROM node:16

RUN curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH=/root/.cargo/bin:$PATH

WORKDIR /root
RUN git clone https://github.com/iden3/circom.git -b v2.0.6

WORKDIR /root/circom
RUN cargo build --release
RUN cargo install --path circom

ENV PATH=/root/.cargo/bin:$PATH

WORKDIR /root
RUN yarn
RUN yarn global add snarkjs
