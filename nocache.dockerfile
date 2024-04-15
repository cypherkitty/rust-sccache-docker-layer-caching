FROM rust:1.77.2-bookworm

#https://hackmd.io/@kobzol/S17NS71bh
#https://www.lpalmieri.com/posts/fast-rust-docker-builds/

#https://github.com/mozilla/sccache/issues/1160
# Install sccache
#RUN cargo install sccache
#ENV RUSTC_WRAPPER=sccache
#ENV SCCACHE_DIR=/app/sccache
#RUN mkdir -p /app/sccache

# Cache project dependencies
# Download dependencied (I suspect this can be done with cargo chef as well)
COPY Cargo.toml /app/
WORKDIR /app/
# Create fake project which mocks the structure of the real project.
# We need it to cache dependencies and avoid rebuilding docker cache.
# This layer will be invalidated only if Cargo.toml changes.
RUN mkdir -p /app/src && echo "fn main() {}" > /app/src/lib.rs
RUN cargo build && cargo build --release && cargo clean

# copy app
COPY Cargo.toml /app/Cargo.toml
COPY src /app/src

# build app
RUN cargo build --release

#CMD cargo test --release
