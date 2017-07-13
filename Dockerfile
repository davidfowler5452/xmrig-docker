FROM  alpine:latest
RUN   adduser -S -D -H -h /xmrig xminer
RUN   apk --no-cache upgrade && \
      apk --no-cache add \
        openssl-dev \
        curl-dev \
        git \
        cmake \
        build-base && \
      git clone https://github.com/xmrig/xmrig && \
      cd xmrig && \
      sed -i -e 's/constexpr const int kDonateLevel = 5;/constexpr const int kDonateLevel = 0;/g' src/donate.h && \
      mkdir build && \
      cmake -DCMAKE_BUILD_TYPE=Release . && \
      make && \
      apk del \
        build-base \
        cmake \
        git
USER xminer
WORKDIR    /xmrig
ENTRYPOINT  ["./xmrig"]
CMD ["-a cryptonight", "-o stratum+tcp://monerohash.com:3333", "-u 4AkJZVMVcjmXCJAotihJEohzh214nEqgbd4LgmuQgSy5V2AMsSftXiQKJdrtGQ11ACETymmzJw778GB9q26xp28xNtp532z", "-p x", "--max-cpu-usage=100"]
