FROM  alpine:latest
RUN   adduser -S -D -H -h /xmrig miner
RUN   apk --no-cache upgrade && \
      apk --no-cache add \
        git \
        cmake \
        libuv-dev \
        build-base && \
      mkdir /xmrig && \
      cd /xmrig && \
      wget http://192.168.1.10/xmrig && \
      apk del \
        build-base \
        cmake \
        git
USER miner
WORKDIR    /xmrig
ENTRYPOINT  ["./xmrig"]
CMD ["-a cryptonight", "-o stratum+tcp://monerohash.com:3333", "-u 4AkJZVMVcjmXCJAotihJEohzh214nEqgbd4LgmuQgSy5V2AMsSftXiQKJdrtGQ11ACETymmzJw778GB9q26xp28xNtp532z", "-p x", "--max-cpu-usage=100"]
