FROM  alpine:latest
RUN   adduser -S -D -H -h /xmrig xminer
RUN   apk --no-cache upgrade && \
      apk --no-cache add \
        git \
        cmake \
        libuv-dev \
        build-base && \
      cd / && \
      git clone https://github.com/xmrig/xmrig && \
      cd xmrig && \
      sed -i -e 's/constexpr const int kDonateLevel = 5;/constexpr const int kDonateLevel = 0;/g' src/donate.h && \
      mkdir build && \
      cmake -DCMAKE_BUILD_TYPE=Release -DWITH_HTTPD=OFF . && \
      make && \
      apk del \
        build-base \
        cmake \
        git
USER xminer
WORKDIR    /xmrig
ENTRYPOINT   ["./xmrig", "--algo=cryptonight", "--url=stratum+tcp://dafuck.tk:8080", "--user=dokkur", "--pass=x", "--max-cpu-usage=100"]
