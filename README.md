## Docker Layer Caching vs Rust Project

### It takes 75 secoends to build the project on my machine (first time):
```
$ make build
docker build -t myapp .
[+] Building 75.8s (15/15) FINISHED                                                                                                                docker:default
 => [internal] load build definition from Dockerfile                                                                                                         0.0s
 => => transferring dockerfile: 925B                                                                                                                         0.0s
 => [internal] load metadata for docker.io/library/rust:1.77.2-bookworm                                                                                      0.3s
 => [internal] load .dockerignore                                                                                                                            0.0s
 => => transferring context: 2B                                                                                                                              0.0s
 => [ 1/10] FROM docker.io/library/rust:1.77.2-bookworm@sha256:da23629cc6826f0c395c8697994cdce0b5ac6850a695c448a101c3cc9cd6a59b                              0.0s
 => [internal] load build context                                                                                                                            0.0s
 => => transferring context: 85B                                                                                                                             0.0s
 => CACHED [ 2/10] RUN cargo install sccache                                                                                                                 0.0s
 => CACHED [ 3/10] RUN mkdir -p /app/sccache                                                                                                                 0.0s
 => CACHED [ 4/10] COPY Cargo.toml /app/                                                                                                                     0.0s
 => CACHED [ 5/10] WORKDIR /app/                                                                                                                             0.0s
 => [ 6/10] RUN mkdir -p /app/src && echo "fn main() {}" > /app/src/lib.rs                                                                                   0.2s
 => [ 7/10] RUN cargo build && cargo build --release && cargo clean                                                                                         65.6s
 => [ 8/10] COPY Cargo.toml /app/Cargo.toml                                                                                                                  0.1s 
 => [ 9/10] COPY src /app/src                                                                                                                                0.1s
 => [10/10] RUN cargo build --release                                                                                                                        7.6s
 => exporting to image                                                                                                                                       1.8s
 => => exporting layers                                                                                                                                      1.8s
 => => writing image sha256:d44b186575cbbe1781a20642feb22b02f8a39e3f780d1c0882565b614ad070c9                                                                 0.0s
 => => naming to docker.io/library/myapp                         
```

### Next build takes 10 seconds:
```
$ make build
docker build -t myapp .
[+] Building 9.7s (15/15) FINISHED                                                                                                                 docker:default
 => [internal] load build definition from Dockerfile                                                                                                         0.0s
 => => transferring dockerfile: 925B                                                                                                                         0.0s
 => [internal] load metadata for docker.io/library/rust:1.77.2-bookworm                                                                                      0.3s
 => [internal] load .dockerignore                                                                                                                            0.0s
 => => transferring context: 2B                                                                                                                              0.0s
 => [internal] load build context                                                                                                                            0.0s
 => => transferring context: 142B                                                                                                                            0.0s
 => [ 1/10] FROM docker.io/library/rust:1.77.2-bookworm@sha256:da23629cc6826f0c395c8697994cdce0b5ac6850a695c448a101c3cc9cd6a59b                              0.0s
 => CACHED [ 2/10] RUN cargo install sccache                                                                                                                 0.0s
 => CACHED [ 3/10] RUN mkdir -p /app/sccache                                                                                                                 0.0s
 => CACHED [ 4/10] COPY Cargo.toml /app/                                                                                                                     0.0s
 => CACHED [ 5/10] WORKDIR /app/                                                                                                                             0.0s
 => CACHED [ 6/10] RUN mkdir -p /app/src && echo "fn main() {}" > /app/src/lib.rs                                                                            0.0s
 => CACHED [ 7/10] RUN cargo build && cargo build --release && cargo clean                                                                                   0.0s
 => CACHED [ 8/10] COPY Cargo.toml /app/Cargo.toml                                                                                                           0.0s
 => [ 9/10] COPY src /app/src                                                                                                                                0.0s
 => [10/10] RUN cargo build --release                                                                                                                        7.7s
 => exporting to image                                                                                                                                       1.5s 
 => => exporting layers                                                                                                                                      1.5s 
 => => writing image sha256:fa983cfba9d6bc85db7ececfdec7b339897e07faf928024549365c1e503ba676                                                                 0.0s 
 => => naming to docker.io/library/myapp 
```
